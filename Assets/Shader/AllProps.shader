Shader "Custom/AllProps"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        _Range ("Range", Range(0,5)) = 1
        _Tex ("Texture", 2D) = "white" {}
        _Cube ("Cube", CUBE) = ""{}
        _Float ("Float", Float) = 0.5
        _Vector ("Vector", Vector) = (0.5,1,1,1)
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 200

        CGPROGRAM
        // Physically based Standard lighting model, and enable shadows on all light types
        #pragma surface surf Lambert

        // Use shader model 3.0 target, to get nicer looking lighting
        #pragma target 3.0

        fixed4 _Color;
        half _Range;
        sampler2D _Tex;
        samplerCUBE _Cube;
        float _Float;
        float4 _Vector;

        struct Input
        {
            float2 uv_Tex;
            float3 worldRefl;
        };

        
        // Add instancing support for this shader. You need to check 'Enable Instancing' on materials that use the shader.
        // See https://docs.unity3d.com/Manual/GPUInstancing.html for more information about instancing.
        // #pragma instancing_options assumeuniformscaling
        UNITY_INSTANCING_BUFFER_START(Props)
            // put more per-instance properties here
        UNITY_INSTANCING_BUFFER_END(Props)

        void surf (Input IN, inout SurfaceOutput o)
        {
            o.Albedo = (tex2D(_Tex, IN.uv_Tex) * _Range).rgb;
            o.Emission = texCUBE(_Cube, IN.worldRefl).rgb;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
