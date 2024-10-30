Shader "Custom/SimpleSpecular"
{
    Properties {
        // The main texture of the object, defaulting to white.
        _MainTex ("Texture", 2D) = "white" {}
    }
    
    SubShader {
        // Tag to specify the render type as opaque.
        Tags { "RenderType" = "Opaque" }
        
        CGPROGRAM
        // Use a surface shader with SimpleSpecular lighting model.
        #pragma surface surf SimpleSpecular

        // Custom lighting function for specular reflection.
        half4 LightingSimpleSpecular (SurfaceOutput s, half3 lightDir, half3 viewDir, half atten) {
            // Calculate the halfway vector between the light direction and the view direction.
            half3 h = normalize(lightDir + viewDir);

            // Calculate the diffuse component using the Lambertian reflection model.
            half diff = max(0, dot(s.Normal, lightDir));

            // Calculate the specular component using the Blinn-Phong reflection model.
            float nh = max(0, dot(s.Normal, h));
            float spec = pow(nh, 48.0); // Raise to a high power for a sharp specular highlight.

            // Combine the diffuse and specular components.
            half4 c;
            c.rgb = (s.Albedo * _LightColor0.rgb * diff + _LightColor0.rgb * spec) * atten; // Scale by light color and attenuation.
            c.a = s.Alpha; // Set the alpha value from the surface output.
            return c; // Return the final color.
        }

        // Input structure to hold UV coordinates.
        struct Input {
            float2 uv_MainTex; // UV coordinates for the main texture.
        };
    
        sampler2D _MainTex; // Texture sampler for the main texture.
    
        // Surface shader function to calculate the output color.
        void surf (Input IN, inout SurfaceOutput o) {
            // Sample the main texture to get the base color.
            o.Albedo = tex2D(_MainTex, IN.uv_MainTex).rgb; // Set the Albedo from the texture.
        }
        ENDCG
    }
    
    // Fallback shader if this shader fails to compile.
    Fallback "Diffuse"
}
