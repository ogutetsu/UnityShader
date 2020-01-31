Shader "Custom/BasicBlinn"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        _SpecColor("Color", Color) = (1,1,1,1)
        _Spec("Specular", Range(0,1)) = 0.5
        _Gloss("Gloss", Range(0,1)) = 0.5
    }
    SubShader
    {
        Tags { "Queue"="Geometry" }
        LOD 200

        CGPROGRAM
        // Physically based Standard lighting model, and enable shadows on all light types
        #pragma surface surf BasicBlinn

        // Use shader model 3.0 target, to get nicer looking lighting
        #pragma target 3.0


        half4 LightingBasicBlinn(SurfaceOutput s, half3 lightDir, half3 viewDir, half atten)
        {
            half3 h = normalize(lightDir + viewDir);
            half diff = max(0, dot(s.Normal, lightDir));
            float nh = max(0, dot(s.Normal, h));
            float spec = pow(nh, 48.0);

            half4 c;
            c.rgb = (s.Albedo * _LightColor0.rgb * diff + _LightColor0.rgb * spec) * atten;
            c.a = s.Alpha;
            return c;

        }


        struct Input
        {
            float2 uv_MainTex;
        };

        
        fixed4 _Color;
        //fixed4 _SpecColor;
        half _Spec;
        fixed _Gloss;

        // Add instancing support for this shader. You need to check 'Enable Instancing' on materials that use the shader.
        // See https://docs.unity3d.com/Manual/GPUInstancing.html for more information about instancing.
        // #pragma instancing_options assumeuniformscaling
        UNITY_INSTANCING_BUFFER_START(Props)
            // put more per-instance properties here
        UNITY_INSTANCING_BUFFER_END(Props)

            void surf(Input IN, inout SurfaceOutput o)
        {
            o.Albedo = _Color.rgb;
            //o.Specular = _Spec;
            //o.Gloss = _Gloss;
        
        }
        ENDCG
    }
    FallBack "Diffuse"
}
