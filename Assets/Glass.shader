Shader "Custom/GlassWithFog"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _BumpMap ("Normalmap", 2D) = "bump" {}
        _ScaleUV ("Scale", Range(1,20)) = 1
        _Transparency ("Transparency", Range(0,1)) = 0.5 // Transparency level
    }

    SubShader
    {
        Tags { "Queue" = "Overlay" "RenderType" = "Transparent" }

        Pass
        {
            Blend SrcAlpha OneMinusSrcAlpha
            ZWrite Off

            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"

            // Custom properties
            sampler2D _MainTex;
            sampler2D _BumpMap;
            float _ScaleUV;
            float _Transparency;

            // Surface shader structure for input
            struct Input
            {
                float2 uv_MainTex;
                float2 uv_BumpMap;
            };

            // Vertex shader data
            struct appdata_t
            {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float4 pos : SV_POSITION;
                float3 normal : TEXCOORD1;
                float2 uv : TEXCOORD2;
                float3 worldPos : TEXCOORD3;  // Store world position for fog
            };

            // Vertex shader function
            v2f vert(appdata_t v)
            {
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.normal = mul((float3x3)unity_ObjectToWorld, v.normal); // Transform normal to world space
                o.uv = v.uv;
                o.worldPos = mul(unity_ObjectToWorld, v.vertex).xyz; // World space position for fog calculation
                return o;
            }

            // Fragment shader function
            half4 frag(v2f i) : SV_Target
            {
                // Sample base texture color
                half4 texColor = tex2D(_MainTex, i.uv);

                // Compute fog factor based on distance from the camera
                float fogDensity = 1; // Fog density, adjust as needed
                float3 fogColor = float3(0.5, 0.5, 0.5); // Darker fog color (dark gray)
                float dist = length(i.worldPos - _WorldSpaceCameraPos.xyz); // Distance from camera
                float fogFactor = exp(-fogDensity * dist); // Exponential fog effect
                fogFactor = clamp(fogFactor, 0.0, 1.0); // Clamp the fog factor to [0, 1]

                // Lerp between the texture color and the fog color
                texColor.rgb = lerp(texColor.rgb, fogColor, 1.0 - fogFactor);

                // Apply transparency
                texColor.a = texColor.a * _Transparency;

                return texColor;
            }
            ENDCG
        }
    }

    Fallback "Diffuse"
}
