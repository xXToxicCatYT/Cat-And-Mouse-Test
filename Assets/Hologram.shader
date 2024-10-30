Shader "Custom/Hologram"
{
    Properties
    {
        // The color of the rim (outer glow) of the hologram
        _RimColor ("Rim Color", Color) = (0, 0.5, 0.5, 0.0)
        
        // The intensity/power of the rim effect. Higher values create sharper rims.
        _RimPower ("Rim Power", Range(0.5, 8.0)) = 3.0
    }

    SubShader
    {
        // Set the rendering queue for transparent objects to ensure proper layering.
        Tags{"Queue" = "Transparent"}

        Pass
        {
            // Enable writing to the depth buffer for correct rendering.
            ZWrite On
            
            // Disable color writing to create a masked effect, focusing only on the rim.
            ColorMask 0
        }

        CGPROGRAM
        // Use a surface shader with Lambert lighting model and alpha blending.
        #pragma surface surf Lambert alpha:fade
        
        // Input structure to hold the view direction for rim lighting calculations.
        struct Input
        {
            float3 viewDir; // Direction from the pixel to the camera/viewer.
        };

        // Hologram rim color and power parameters.
        float4 _RimColor; // The color of the rim emitted by the hologram.
        float _RimPower;  // Controls how sharp the rim effect appears.

        // Surface function that calculates the final output color for each pixel.
        void surf (Input IN, inout SurfaceOutput o)
        {
            // Calculate the rim lighting factor by finding the angle between the view direction and the normal.
            half rim = 1.0 - saturate(dot(normalize(IN.viewDir), o.Normal));
            
            // The rim's emission color is determined by the rim factor raised to the power specified, multiplied by the rim color.
            o.Emission = _RimColor.rgb * pow(rim, _RimPower);
            
            // Set the alpha value based on the rim factor to control the transparency.
            o.Alpha = pow(rim, _RimPower);
        }
        ENDCG
    }
    
    // Optional fallback shader if this one fails to compile.
    FallBack "Diffuse"
}
