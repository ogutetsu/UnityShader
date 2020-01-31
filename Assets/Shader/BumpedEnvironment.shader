Shader "Custom/BumpedEnvironment"
{
    Properties
    {
        _Diffuse("Diffuse", 2D) = "white" {}
        _Bump("Bump", 2D) = "bump" {}
        _Slider("Bump Amount", Range(0,10)) = 1
        _Bright("Brightness", Range(0,10)) = 1
        _Cube("CubeMap", CUBE) = "white" {}
    }
        SubShader
        {
            Tags { "RenderType" = "Opaque" }
            LOD 200

            CGPROGRAM
            // Physically based Standard lighting model, and enable shadows on all light types
            #pragma surface surf Lambert

            // Use shader model 3.0 target, to get nicer looking lighting
            #pragma target 3.0

            sampler2D _Diffuse;
            sampler2D _Bump;
            half _Slider;
            half _Bright;
            samplerCUBE _Cube;

            struct Input
            {
                float2 uv_Diffuse;
                float2 uv_Bump;
                float3 worldRefl; INTERNAL_DATA
            };


            // Add instancing support for this shader. You need to check 'Enable Instancing' on materials that use the shader.
            // See https://docs.unity3d.com/Manual/GPUInstancing.html for more information about instancing.
            // #pragma instancing_options assumeuniformscaling
            UNITY_INSTANCING_BUFFER_START(Props)
                // put more per-instance properties here
            UNITY_INSTANCING_BUFFER_END(Props)

            void surf(Input IN, inout SurfaceOutput o)
            {
                o.Albedo = tex2D(_Diffuse, IN.uv_Diffuse).rgb;
                o.Normal = UnpackNormal(tex2D(_Bump, IN.uv_Bump));
                o.Normal *= float3(_Slider, _Slider, 1);
                o.Emission = texCUBE(_Cube, WorldReflectionVector(IN, o.Normal)).rgb;
            }
            ENDCG
        }
            FallBack "Diffuse"
}
