Shader "Custom/BlendTest"
{
    Properties
    {
        _MainTex ("Albedo (RGB)", 2D) = "black" {}
    }
    SubShader
    {
        Tags { "Queue"="Transparent" }
        //Blend One One
        //Blend SrcAlpha OneMinusSrcAlpha
        Blend DstColor Zero
        Pass {
            SetTexture [_MainTex] { combine texture }
        }
        
    }
    FallBack "Diffuse"
}
