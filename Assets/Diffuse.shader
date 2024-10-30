Shader "Custom/Diffuse"
{
    Properties {
        // The main texture of the object, defaulting to white.
        _MainTex ("Texture", 2D) = "white" {}
    }
    
    SubShader {
        // Tag to specify the render type as opaque.
        Tags { "RenderType" = "Opaque" }

        CGPROGRAM
        // Use a surface shader with SimpleLambert lighting model.
        #pragma surface surf SimpleLambert

        // Custom lighting function for Lambertian reflection.
        half4 LightingSimpleLambert (SurfaceOutput s, half3 lightDir, half atten) {
            // Calculate the dot product of the normal and light direction.
            half NdotL = dot(s.Normal, lightDir);

            // Initialize the color output variable.
            half4 c;

            // Calculate the color using the Lambertian reflectance model.
            c.rgb = s.Albedo * _LightColor0.rgb * (NdotL * atten); // Combine Albedo, light color, and attenuation.
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
