Shader "Custom/ScreenSpaceAmbientOcclusion"
{
    Properties
    {
        _BaseColor ("Base Color", Color) = (1, 1, 1, 1)
        _AOColor ("AO Color", Color) = (0.0, 0.0, 0.0, 1)   // The color of ambient occlusion (usually dark)
        _AOStrength ("AO Strength", Range(0, 1)) = 0.5        // Controls how strong the AO effect is
        _Radius ("AO Radius", Range(0.0, 1.0)) = 0.5          // Controls how far the AO effect spreads
        _MainTex ("Main Texture", 2D) = "white" {}
    }

    SubShader
    {
        Tags { "RenderType" = "Opaque" }
        
        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"

            // Properties
            float4 _BaseColor;
            float4 _AOColor;
            float _AOStrength;
            float _Radius;
            sampler2D _MainTex;

            struct appdata
            {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float4 pos : SV_POSITION;
                float2 uv : TEXCOORD0;
                float3 normal : TEXCOORD1;
            };

            // Vertex Shader
            v2f vert(appdata v)
            {
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                o.normal = normalize(mul((float3x3)unity_ObjectToWorld, v.normal)); // Transform normal to world space
                return o;
            }

            // Fragment Shader
            half4 frag(v2f i) : SV_Target
            {
                // Sample the base texture
                half4 texColor = tex2D(_MainTex, i.uv) * _BaseColor;

                // Compute AO effect
                float3 ao = float3(0.0, 0.0, 0.0);

                // Sample surrounding pixels in a simple way (screen-space sampling)
                for (int x = -1; x <= 1; ++x)
                {
                    for (int y = -1; y <= 1; ++y)
                    {
                        // Offset UVs by the screen-space radius
                        float2 offset = float2(x, y) * _Radius;
                        float3 neighborNormal = tex2D(_MainTex, i.uv + offset).rgb;

                        // Calculate how much the normal differs from the current one
                        float diff = max(dot(i.normal, neighborNormal), 0.0);

                        // Accumulate the AO value
                        ao += (1.0 - diff);
                    }
                }

                // Average the AO results
                ao /= 9.0;  // Since we have 9 samples (3x3 grid)

                // Apply AO effect, modulate with AO strength and the AO color
                half4 aoEffect = half4(_AOColor.rgb * ao * _AOStrength, 1.0);

                // Final color, blend AO effect with base texture
                return texColor * (1.0 - aoEffect) + aoEffect;
            }
            ENDCG
        }
    }

    Fallback "Diffuse"
}
