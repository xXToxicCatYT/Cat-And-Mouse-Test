Shader "Custom/ColourGrading"
{
    Properties
    { 
        _MainTex ("Texture", 2D) = "white" {}
        _LUT("LUT", 2D) = "white" {}
        _Contribution("Contribution", Range(0, 1)) = 1
    }

    SubShader
    {
        Cull Off ZWrite Off ZTest Always

        Pass
        { 
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            #define COLORS 32.0

            struct appdata
            { 
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            { 
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
            };

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                return o;
            }

            sampler2D _MainTex;
            sampler2D _LUT;
            float _Contribution;

            fixed4 frag (v2f i) : SV_Target
            {
                float maxColor = COLORS - 1.0;

                // Sample the main texture color
                fixed4 col = saturate(tex2D(_MainTex, i.uv));

                // Calculate texel size for the LUT
                float2 lutTexelSize = 1.0 / float2(COLORS, COLORS);

                // Calculate LUT position
                float cell = floor(col.b * maxColor);
                float xOffset = col.r * lutTexelSize.x;
                float yOffset = col.g * lutTexelSize.y;

                float2 lutPos = float2(cell / COLORS + xOffset, yOffset);

                // Sample the LUT color
                float4 gradedCol = tex2D(_LUT, lutPos);

                // Blend the original color with the graded color based on Contribution
                return lerp(col, gradedCol, _Contribution);
            }
            ENDCG 
        } 
    }
    FallBack "Diffuse" // Optional fallback shader
}
