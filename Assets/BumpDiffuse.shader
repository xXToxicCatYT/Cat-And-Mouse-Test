Shader "Custom/BumpDiffuse"
{
    Properties 
    {
        // The diffuse texture for the surface, defaulting to white.
        _myDiffuse ("Diffuse Texture", 2D) = "white" {}
        // The bump texture to simulate surface normals, defaulting to a bump texture.
        _myBump ("Bump Texture", 2D) = "bump" {}
        // Slider to control the amount of bump effect applied, ranged from 0 to 10.
        _mySlider ("Bump Amount", Range(0,10)) = 1
    }

    SubShader 
    {
        // Specify that we are using a Lambert lighting model.
        CGPROGRAM
        #pragma surface surf Lambert

        // Texture samplers for diffuse and bump maps.
        sampler2D _myDiffuse; // Sampler for the diffuse texture.
        sampler2D _myBump;    // Sampler for the bump map (normal map).
        half _mySlider;        // Amount of bump effect to apply.

        // Input structure for passing texture UV coordinates.
        struct Input 
        {
            float2 uv_myDiffuse; // UV coordinates for the diffuse texture.
            float2 uv_myBump;    // UV coordinates for the bump texture.
        };

        // Surface shader function to compute surface properties.
        void surf (Input IN, inout SurfaceOutput o) 
        {
            // Sample the diffuse texture and set it as the albedo color.
            o.Albedo = tex2D(_myDiffuse, IN.uv_myDiffuse).rgb;

            // Sample the bump texture and unpack it into a normal vector.
            o.Normal = UnpackNormal(tex2D(_myBump, IN.uv_myBump));

            // Scale the normal by the specified bump amount to enhance the effect.
            o.Normal *= float3(_mySlider, _mySlider, 1);
        }
        ENDCG
    }

    // Fallback shader if this shader fails to compile.
    FallBack "Diffuse"
}
