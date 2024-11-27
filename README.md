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

------------------------------------- UPDATE 1 -------------------------------------

IMPROVEMENTS:

Lighting Model Change (Toon Ramp):

Previous: Lambert Shading

![image](https://github.com/user-attachments/assets/89c2ba28-ff71-4b0a-bab9-b62120cf8bbd)

Present: Toon Ramp

![image](https://github.com/user-attachments/assets/46fa3250-9b2d-4d03-b9e3-817b915e92c7)

Toon Ramp Implementation

![image](https://github.com/user-attachments/assets/19cfbf94-ec38-4a41-9209-1e1d0a0963ae)

This toon ramp shader calculates lighting intensity using the dot product between the surface normal and a fixed light direction. Based on this intensity, the shader compares the value against two thresholds (_Threshold1 and _Threshold2) to assign one of three colors (_BaseColor, _MiddleColor, or _ShadowColor). The key functionality lies in the if statements in the fragment shader, which segment the light intensity into discrete bands, creating the toon shading effect.

Texture Fixes:

Old Shelf

![image](https://github.com/user-attachments/assets/3aceda14-9aee-4442-82aa-74427a8d5284)

New Shelf

![image](https://github.com/user-attachments/assets/79bfb4fc-f93e-4e1e-a161-0e9dfd289276)

Old Safe

![image](https://github.com/user-attachments/assets/673bb5eb-357f-46e4-99d3-335bf5322b97)

New Safe

![image](https://github.com/user-attachments/assets/646e03a6-8334-4268-a736-a3a60577643c)

Old Wall

![image](https://github.com/user-attachments/assets/c30f6482-f4bf-4e37-9708-1012598ace05)

New Wall

![image](https://github.com/user-attachments/assets/2babc127-a714-4f6c-9ef7-d25a7bb73640)

UV Maps For Textures

![image](https://github.com/user-attachments/assets/6eb2485a-1255-465c-8ac8-9cbd89469976)

![image](https://github.com/user-attachments/assets/7a720970-cd97-4eb1-a125-271219d9c2c9)

![image](https://github.com/user-attachments/assets/15ba4d49-308e-43db-bc62-db85837981f7)

![image](https://github.com/user-attachments/assets/0dbce042-68fd-489f-bba3-46f10a61d99f)

Visual Effects:

Glass

![image](https://github.com/user-attachments/assets/38189745-6d57-487a-a2ac-5fc1207f7fa9)

![image](https://github.com/user-attachments/assets/e068c9b4-68df-4278-9b33-90e8c2d49634)

This glass shader creates a refractive effect by using the GrabPass to capture the screen behind the object. The fragment shader offsets the UV coordinates of the grabbed texture based on the normal map (_BumpMap) and a scaling factor (_ScaleUV). The critical effect comes from the bump offset applied to UV grab in the fragment shader, which creates the illusion of a warped, glass-like surface.

Glass Code

![image](https://github.com/user-attachments/assets/266c1c5d-9ff5-406b-a6ea-019c5fb6ba16)

![image](https://github.com/user-attachments/assets/519a69e8-0bc9-46f4-bb7c-3d0039672059)

![image](https://github.com/user-attachments/assets/fc139b16-45ad-4a96-9a32-f837f50cf800)


Particles

![image](https://github.com/user-attachments/assets/d33d1495-1ad9-4882-8d37-d3bc90d430ba)

To enhance the visual appeal and make the power-up more noticeable, we added particle effects to it. These effects also help make the power-up stand out in the environment. The particles radiate vibrant colors and subtle motion, creating a sense of energy and allure that draws the player’s attention. This not only improves the aesthetics but also makes the power-up’s presence more engaging and rewarding to interact with.

Eye Trail VFX

![image](https://github.com/user-attachments/assets/747e7311-27c9-490a-8787-874261b0bd13)

To emphasize the predatory nature of the cat in the game, we added an eye trail effect. This subtle yet striking visual creates the impression of focused intensity, mimicking the sharp gaze of a predator locked onto its prey. The trail adds an air of stealth and danger, enhancing the cat’s characterization and making its movements feel deliberate and menacing. Also, we chose to make it red as a symbol of a predator needing to sate its blood lust.

Dusty Environmental Visual Effect

![image](https://github.com/user-attachments/assets/876ec012-84c9-41d8-a921-1e189b0239c7)

We added a dust effect in our game to enhance the immersive atmosphere of the abandoned basement setting. As the player controls the cat, the subtle clouds of dust stirred up by movement create a sense of realism, emphasizing the neglected and eerie environment. The dust also serves a gameplay purpose, as it makes it harder to spot the mouse increasing the game's difficulty. This effect helps players feel more connected to the cat's perspective, as they navigate through the cluttered space in search of the mouse.

Video Demo: https://youtu.be/6qpGHknSRMQ

References:

The floor texture used for bump mapping: https://everytexture.com/everytexture-com-stock-pavement-concrete-texture-00010/

All other 3D models were made by our Artist and Textures were all photographed by us and edited with photo editing software.
