Shader "Custom/RoomWall"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        _Diffuse("Diffuse Texture", 2D) = "white" {}
        _Bump("Bump Texture", 2D) = "bump" {}
        _Slider("Bump Amount", Range(0,10)) = 1

        _SRef("Stencil Ref", Float) = 1
        [Enum(UnityEngine.Rendering.CompareFunction)] _SComp("Stencil Comp", Float) = 8
        [Enum(UnityEngine.Rendering.StencilOp)] _SOp("Stencil Op", Float) = 2
    }
    SubShader
    {
        
        Stencil
        {
            Ref[_SRef]
            Comp[_SComp]
            Pass[_SOp]
        }

        LOD 200

        CGPROGRAM
        // Physically based Standard lighting model, and enable shadows on all light types
        #pragma surface surf Lambert

        // Use shader model 3.0 target, to get nicer looking lighting
        #pragma target 3.0

        sampler2D _Diffuse;
        sampler2D _Bump;
        half _Slider;
        float4 _Color;

        struct Input
        {
            float2 uv_Diffuse;
            float2 uv_Bump;
        };


        // Add instancing support for this shader. You need to check 'Enable Instancing' on materials that use the shader.
        // See https://docs.unity3d.com/Manual/GPUInstancing.html for more information about instancing.
        // #pragma instancing_options assumeuniformscaling
        UNITY_INSTANCING_BUFFER_START(Props)
            // put more per-instance properties here
        UNITY_INSTANCING_BUFFER_END(Props)

        void surf (Input IN, inout SurfaceOutput o)
        {
            o.Albedo = tex2D(_Diffuse, IN.uv_Diffuse).rgb * _Color.rgb;
            o.Normal = UnpackNormal(tex2D(_Bump, IN.uv_Bump));
            o.Normal *= float3(_Slider, _Slider, 1);
        }
        ENDCG
    }
    FallBack "Diffuse"
}
