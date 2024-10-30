# Cat and Mouse Shaders

Washing Machine

![image](https://github.com/user-attachments/assets/37318901-61c1-422d-ad90-1a27adf4c259)

We applied simple specular lighting to the washing machine because they have metal surfaces that are reflective and tend to produce shiny highlights. The specular lighting simulates how light would reflect off the surface at an angle equal to the angle of incidence, creating that characteristic bright spot where the light hits.

Simple Specular Code

![image](https://github.com/user-attachments/assets/2ffbf699-100a-4d45-9778-19245a8c188c)

Specular: Calculates a specular highlight using the halfway vector, which is the normalized direction between the light and view direction. The dot product of this vector with the surface normal is raised to the power of 48, which sharpens the highlight, creating a shiny effect.

Diffuse: Uses the dot product between the surface normal and the light direction to calculate the amount of light hitting the surface. This gives the basic light intensity on the surface.

Walls

![image](https://github.com/user-attachments/assets/a811b058-539e-4405-83fa-9cea436de7c0)

We applied simple diffuse lighting to the wall because walls generally have a non-reflective surface. Diffuse lighting spreads light evenly across the surface, creating a soft and natural look without any shiny highlights. This approach makes sense for walls, as they usually absorb light rather than reflecting it sharply.

Diffuse Code

![image](https://github.com/user-attachments/assets/7859a940-aeeb-4e26-b880-f97c9a85b116)

LightingSimpleLambert function calculates the light intensity using the dot product between the surface normal and the light direction . This dot product represents how much light hits the surface directly, giving a consistent lighting effect across the surfaces with gradual shading

The color is determined by multiplying the texture color with the light color and adjusting for light intensity and distance.

Mattress

![image](https://github.com/user-attachments/assets/7d681869-1220-4bd6-8702-af661455af98)

We Applied both diffuse and ambient lighting to a mattress because we thought these lighting models helped create a soft, even illumination that suits the fabric and cushiony texture of a mattress.

Diffuse and Ambient Lighting Code

![image](https://github.com/user-attachments/assets/2daf4111-8363-4bff-969c-f3933a32d8d5)
![image](https://github.com/user-attachments/assets/74f92031-a513-4f0f-afdb-eefe8474937e)

This shader applies basic lighting with texture sampling, ambient light, and diffuse light
includes _LightColor and _LightPosition for customizable light effects.
Vertex Function transforms the vertex position and normal to world space, preparing them for lighting calculations in the fragment shader.
Adds a basic ambient light based on _LightColor and _AmbientIntensity.
Calculates the diffuse factor using the light direction (from _LightPosition to each pixel) and the surface normal. The intensity is scaled by _DiffuseIntensity.
Combines ambient and diffuse lighting with the texture color for the final color output, using texture alpha.

Clay Molds

![image](https://github.com/user-attachments/assets/374f8145-3c44-48a4-b548-b0da388f789a)

We chose to use a Lambert reflection shader for representing the old, dried-up clay molds. Since Lambert shading provides a diffuse, matte look without shiny highlights, it effectively mimics the appearance of materials that are rough and absorb light rather than reflecting it. This shader keeps the surface looking natural and subdued, which aligns well with the dry, unpolished surface texture of aged clay.

Lambert Code

![image](https://github.com/user-attachments/assets/39fcfad7-d18c-4c20-a3c8-ce1d98b03980)
![image](https://github.com/user-attachments/assets/bda25138-14ab-4f21-81d6-60d299505c97)

This shader creates a simple matte appearance by calculating diffuse lighting in the vertex function, giving a basic, non-shiny look to the surface.

Calculates the light direction and the surface normal direction.

Computes diffuse reflection by taking the dot product of the light direction and normal, multiplied by Light Color and Color.

Sets the final color based on this diffuse reflection and prepares the vertex position for rendering.

LUTs

Cold LUT

![image](https://github.com/user-attachments/assets/52649900-0b8c-44b9-89ed-e8a4909914d5)

For color grading we went with a cool color correction LUT to make the basement feel more abandoned by adding this cold atmosphere.

[Custom] Dark LUT

![image](https://github.com/user-attachments/assets/4af82003-7c43-45a1-bd0c-34adbbfd3b27)

 we also added a Custom dark themed LUT to make the game feel more eerie.

Cat

 ![image](https://github.com/user-attachments/assets/56e6f055-e722-4fa3-8e76-e1c02480744d)

One of the shaders we applied was a hologram effect to the playable character our cat to give it the ghost spirit soul feeling.

Hologram Code

![image](https://github.com/user-attachments/assets/e43a9197-4cd8-4f66-9285-8f7ff7405904)

This shader creates a hologram effect with a glowing rim
Defines _RimColor for the glow color and _RimPower to control the intensity of the rim effect.
Sets the render queue to "Transparent" for proper layering
It uses Lambert shading with alpha blending.
Calculates a rim glow based on the angle between the view direction and the surface normal. The rim intensity is controlled by _RimPower.
Sets Emission for the glow color and adjusts Alpha for transparency.

Mouse

![image](https://github.com/user-attachments/assets/2291a9a2-5e12-4021-8322-24019b9e7186)

Another shader effect we did was rim lighting for the mouse. We implemented this because rim lighting helps make the mouse more visible which is important for the player since finding these mouse are the point of the game.

Rim Lighting Code

![image](https://github.com/user-attachments/assets/054921fc-90cd-47cd-aa05-22165362291c)

_RimColor for the color of the rim lighting, and _RimPower to control the rim intensity.
Uses Lambert shading for a basic diffuse effect.
Surf Function Samples the texture and applies it as the object's base color.
Calculates the rim lighting based on the angle between the view direction and the surface normal. This effect is controlled by _RimPower.
Sets Emission to add the rim color, giving the object an outer glow or highlighted edge.
_RimColor for the color of the rim lighting, and _RimPower to control the rim intensity.
Uses Lambert shading for a basic diffuse effect.
Surf Function Samples the texture and applies it as the object's base color.
Calculates the rim lighting based on the angle between the view direction and the surface normal. This effect is controlled by _RimPower.
Sets Emission to add the rim color, giving the object an outer glow or highlighted edge.

Floor

![image](https://github.com/user-attachments/assets/c778c96f-dea4-4c42-881f-18cbc6778dda)

Lastly, we applied bump mapping to the ground to make it feel rougher and more realistic for a carpet.

Bump Diffuse Code

![image](https://github.com/user-attachments/assets/d95fed11-76a1-4759-a2cc-0f093bb6374d)

_myBump for the bump map (normal map), and _mySlider to control the intensity of the bump effect.
Uses Lambert shading for basic diffuse lighting.
Samples the diffuse texture and applies it as the base color.
Unpacks the normal from the bump texture (_myBump) using UnpackNormal, then scales it by _mySlider to adjust the bump intensity.
Modifies Normal to include the bump effect, giving the surface a more textured, 3D look.

References:

The floor texture used for bump mapping: https://everytexture.com/everytexture-com-stock-pavement-concrete-texture-00010/

All other 3D models were made by our Artist and Textures were all photographed by us and edited with photo editing software.
