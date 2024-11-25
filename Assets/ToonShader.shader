Shader "Custom/ToonShader"
{
    Properties
    {
        _BaseColor ("Base Color", Color) = (1, 1, 1, 1)
        _MiddleColor ("Middle Color", Color) = (0.75, 0.75, 0.75, 1)
        _ShadowColor ("Shadow Color", Color) = (0.5, 0.5, 0.5, 1)
        _Threshold1 ("Threshold Light to Middle", Range(0, 1)) = 0.5
        _Threshold2 ("Threshold Middle to Shadow", Range(0, 1)) = 0.25
    }
    SubShader
    {
        Tags { "RenderType" = "Opaque" }
        LOD 200

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            struct appdata_t
            {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
            };

            struct v2f
            {
                float4 pos : SV_POSITION;
                float3 normal : NORMAL;
            };

            float4 _BaseColor;
            float4 _MiddleColor;
            float4 _ShadowColor;
            float _Threshold1;
            float _Threshold2;

            v2f vert(appdata_t v)
            {
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.normal = normalize(v.normal);
                return o;
            }

            fixed4 frag(v2f i) : SV_Target
            {
                // Light direction (customize as needed)
                float3 lightDir = normalize(float3(1, 1, -1)); // Example light direction
                float intensity = max(dot(i.normal, lightDir), 0.0);

                // Determine color based on intensity
                fixed4 color;
                if (intensity > _Threshold1)
                {
                    color = _BaseColor; // Lit area
                }
                else if (intensity > _Threshold2)
                {
                    color = _MiddleColor; // Middle area
                }
                else
                {
                    color = _ShadowColor; // Shadowed area
                }

                return color;
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
}
