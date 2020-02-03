Shader "Custom/StencilWindow"
{
    Properties
    {
        _Color("Color", Color) = (1,1,1,1)
        _SRef("Stencil Ref", Float) = 1
        [Enum(UnityEngine.Rendering.CompareFunction)] _SComp("Stencil Comp", Float) = 8
        [Enum(UnityEngine.Rendering.StencilOp)] _SOp("Stencil Op", Float) = 2

    }
        SubShader
    {
        Tags { "Queue" = "Geometry-1" }

        ZWrite off
        ColorMask 0

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

        sampler2D _myDiffuse;

        struct Input {
            float2 uv_myDiffuse;
        };

        // Add instancing support for this shader. You need to check 'Enable Instancing' on materials that use the shader.
        // See https://docs.unity3d.com/Manual/GPUInstancing.html for more information about instancing.
        // #pragma instancing_options assumeuniformscaling
        UNITY_INSTANCING_BUFFER_START(Props)
            // put more per-instance properties here
        UNITY_INSTANCING_BUFFER_END(Props)

        void surf (Input IN, inout SurfaceOutput o)
        {
            o.Albedo = tex2D(_myDiffuse, IN.uv_myDiffuse).rgb;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
