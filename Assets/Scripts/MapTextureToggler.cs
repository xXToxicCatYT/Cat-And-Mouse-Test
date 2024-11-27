using System.Collections.Generic;
using UnityEngine;

public class MapTextureToggler : MonoBehaviour
{
    private Material[] allMaterials; // Array to store all materials in the scene
    private Dictionary<Material, Dictionary<string, Texture>> originalTextures = new Dictionary<Material, Dictionary<string, Texture>>();
    private bool texturesEnabled = true;

    void Start()
    {
        // Get all renderers in the scene
        Renderer[] renderers = FindObjectsOfType<Renderer>();

        // Extract all materials from the renderers
        allMaterials = GetAllMaterials(renderers);

        // Store original textures for all materials
        foreach (Material mat in allMaterials)
        {
            if (mat != null)
            {
                var textureDictionary = new Dictionary<string, Texture>();

                // Find all texture properties in the material
                int propertyCount = ShaderUtilRuntime.GetTexturePropertyCount(mat.shader);
                for (int i = 0; i < propertyCount; i++)
                {
                    string propertyName = ShaderUtilRuntime.GetTexturePropertyName(mat.shader, i);
                    textureDictionary[propertyName] = mat.GetTexture(propertyName);
                }

                originalTextures[mat] = textureDictionary;
            }
        }
    }

    void Update()
    {
        // Toggle textures when the "2" key is pressed
        if (Input.GetKeyDown(KeyCode.Alpha2))
        {
            texturesEnabled = !texturesEnabled;

            foreach (Material mat in allMaterials)
            {
                if (mat != null && originalTextures.ContainsKey(mat))
                {
                    foreach (var texturePair in originalTextures[mat])
                    {
                        string propertyName = texturePair.Key;

                        if (texturesEnabled)
                        {
                            // Restore original texture
                            mat.SetTexture(propertyName, texturePair.Value);
                        }
                        else
                        {
                            // Disable texture
                            mat.SetTexture(propertyName, null);
                        }
                    }
                }
            }
        }
    }

    private Material[] GetAllMaterials(Renderer[] renderers)
    {
        // Collect all materials from renderers, accounting for shared materials
        HashSet<Material> materialSet = new HashSet<Material>();

        foreach (Renderer renderer in renderers)
        {
            if (renderer != null)
            {
                foreach (Material mat in renderer.sharedMaterials)
                {
                    if (mat != null)
                        materialSet.Add(mat);
                }
            }
        }

        return new List<Material>(materialSet).ToArray();
    }
}

public static class ShaderUtilRuntime
{
    public static int GetTexturePropertyCount(Shader shader)
    {
        int count = 0;

        // Loop through all shader properties and count textures
        for (int i = 0; i < shader.GetPropertyCount(); i++)
        {
            if (shader.GetPropertyType(i) == UnityEngine.Rendering.ShaderPropertyType.Texture)
            {
                count++;
            }
        }

        return count;
    }

    public static string GetTexturePropertyName(Shader shader, int index)
    {
        int texIndex = 0;

        // Loop through all shader properties and find the correct texture name
        for (int i = 0; i < shader.GetPropertyCount(); i++)
        {
            if (shader.GetPropertyType(i) == UnityEngine.Rendering.ShaderPropertyType.Texture)
            {
                if (texIndex == index)
                {
                    return shader.GetPropertyName(i);
                }

                texIndex++;
            }
        }

        return null;
    }
}
