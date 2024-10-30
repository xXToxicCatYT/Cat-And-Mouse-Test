Shader "Custom/SimpleLightingShaderWithTexture"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _Color ("Object Color", Color) = (1,1,1,1)
        _AmbientIntensity ("Ambient Intensity", Range(0, 1)) = 0.2
        _DiffuseIntensity ("Diffuse Intensity", Range(0, 1)) = 0.8
        _LightColor ("Light Color", Color) = (1,1,1,1)
        _LightPosition ("Light Position", Vector) = (0, 10, 0, 1)
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 200

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            struct appdata
            {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float4 pos : SV_POSITION;
                float3 normal : TEXCOORD0;
                float3 worldPos : TEXCOORD1;
                float2 uv : TEXCOORD2;
            };

            // Shader properties
            sampler2D _MainTex;
            float4 _Color;
            float _AmbientIntensity;
            float _DiffuseIntensity;
            float4 _LightColor;
            float4 _LightPosition;

            v2f vert (appdata v)
            {
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.normal = normalize(mul(v.normal, (float3x3)unity_WorldToObject));
                o.worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
                o.uv = v.uv;
                return o;
            }

            float4 frag (v2f i) : SV_Target
            {
                // Sample the texture
                float4 texColor = tex2D(_MainTex, i.uv) * _Color;

                // Ambient Lighting
                float3 ambient = _LightColor.rgb * _AmbientIntensity;

                // Diffuse Lighting
                float3 lightDir = normalize(_LightPosition.xyz - i.worldPos);
                float diffuseFactor = max(dot(i.normal, lightDir), 0.0);
                float3 diffuse = _LightColor.rgb * _DiffuseIntensity * diffuseFactor;

                // Combine texture color with lighting
                float3 finalColor = texColor.rgb * (ambient + diffuse);
                return float4(finalColor, texColor.a); // Use texture alpha
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
}
