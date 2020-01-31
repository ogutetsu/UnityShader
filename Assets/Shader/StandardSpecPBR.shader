Shader "Custom/StandardSpecPBR"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        _MetallicTex("Metallic (R)", 2D) = "white" {}
        _SpecColor("Specular", Color) = (1,1,1,1)
    }
    SubShader
    {
        Tags { "Queue"="Geometry" }
        LOD 200

        CGPROGRAM
        // Physically based Standard lighting model, and enable shadows on all light types
        #pragma surface surf StandardSpecular

        // Use shader model 3.0 target, to get nicer looking lighting
        #pragma target 3.0

        sampler2D _MetallicTex;
        fixed4 _Color;

        struct Input
        {
            float2 uv_MetallicTex;
        };

        // Add instancing support for this shader. You need to check 'Enable Instancing' on materials that use the shader.
        // See https://docs.unity3d.com/Manual/GPUInstancing.html for more information about instancing.
        // #pragma instancing_options assumeuniformscaling
        UNITY_INSTANCING_BUFFER_START(Props)
            // put more per-instance properties here
        UNITY_INSTANCING_BUFFER_END(Props)

        void surf (Input IN, inout SurfaceOutputStandardSpecular o)
        {
            o.Albedo = _Color.rgb;
            o.Specular = _SpecColor.rgb;
            o.Smoothness = tex2D(_MetallicTex, IN.uv_MetallicTex).r;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
