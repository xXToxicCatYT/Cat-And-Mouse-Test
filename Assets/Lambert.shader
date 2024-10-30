Shader "Custom/Lambert"
{
    Properties
    {
        // The color property for the shader, defaulting to white (1, 1, 1).
        _Color("Color", Color) = (1.0, 1.0, 1.0)
    }

    SubShader
    {
        // Tag to specify that this shader is intended for forward rendering.
        Tags {"LightMode" = "ForwardBase"}

        Pass
        {
            CGPROGRAM
            // Specify that we will be using a vertex shader and a fragment shader.
            #pragma vertex vert
            #pragma fragment frag

            // User-defined variable for the color.
            uniform float4 _Color;

            // Unity-defined variable for the first light's color.
            uniform float4 _LightColor0;

            // Input structure for vertex data.
            struct vertexInput
            {
                float4 vertex : POSITION; // Vertex position in object space.
                float3 normal : NORMAL;   // Vertex normal in object space.
            };

            // Output structure for vertex shader results.
            struct vertexOutput
            {
                float4 pos : SV_POSITION; // Vertex position in clip space for rasterization.
                float4 col : COLOR;       // Color output to the fragment shader.
            };

            // Vertex shader function to transform the vertex and calculate lighting.
            vertexOutput vert(vertexInput v)
            {
                vertexOutput o;

                // Normalize the vertex normal, transforming it from object space to world space.
                float3 normalDirection = normalize(mul(float4(v.normal, 0.0), unity_WorldToObject).xyz);
                
                // Initialize variables for light direction and attenuation (light falloff).
                float3 lightDirection;
                float atten = 1.0; // Attenuation is constant in this simple example.

                // Calculate the direction to the light in world space.
                lightDirection = normalize(_WorldSpaceLightPos0.xyz);

                // Calculate the diffuse reflection using the Lambertian reflection model.
                float3 diffuseReflection = atten * _LightColor0.xyz * _Color.rgb * max(0.0, dot(normalDirection, lightDirection));

                // Set the color output of the vertex shader.
                o.col = float4(diffuseReflection, 1.0); // The alpha channel is set to 1 for opaque.
                
                // Transform the vertex position to clip space.
                o.pos = UnityObjectToClipPos(v.vertex);
                return o; // Return the output structure.
            }

            // Fragment shader function to output the final color.
            float4 frag(vertexOutput i) : COLOR
            {
                return i.col; // Simply pass through the color calculated in the vertex shader.
            }
            ENDCG
        }
    }

    // Fallback shader if this shader fails to compile.
    FallBack "Diffuse"
}
