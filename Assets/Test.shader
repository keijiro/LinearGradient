Shader "Gradient Test"
{
    CGINCLUDE

    #include "UnityCG.cginc"
    #include "Packages/jp.keijiro.klak.lineargradient/Shader/LinearGradient.hlsl"

    LinearGradient _Gradient1;

    void Vertex(float4 vertex : POSITION,
                float2 uv : TEXCOORD,
                out float4 outVertex : SV_Position,
                out float2 outUV : TEXCOORD)
    {
        outVertex = UnityObjectToClipPos(vertex);
        outUV = uv;
    }

    float4 Fragment(float4 vertex : SV_Position,
                    float2 uv : TEXCOORD) : SV_Target
    {
        float4 s = SampleLinearGradient(_Gradient1, uv.x);
        return float4(GammaToLinearSpace(s.rgb * s.a), s.a);
    }

    ENDCG

    SubShader
    {
        Tags { "RenderType"="Opaque" }

        Pass
        {
            CGPROGRAM
            #pragma vertex Vertex
            #pragma fragment Fragment
            ENDCG
        }
    }
}
