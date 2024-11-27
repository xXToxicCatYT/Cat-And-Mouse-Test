using System.Collections.Generic;
using UnityEditor;
using UnityEngine;

public class MapTextureToggler : MonoBehaviour
{
    private Material[] allMaterials; // Array to store all materials in the scene
    private Texture[][] originalTextures; // Array to store all original textures for each material
    private bool texturesEnabled = true;

    void Start()
    {
        // Get all renderers in the scene
        Renderer[] renderers = FindObjectsOfType<Renderer>();

        // Extract all materials from the renderers
        allMaterials = GetAllMaterials(renderers);

        // Store original textures for all materials
        originalTextures = new Texture[allMaterials.Length][];

        for (int i = 0; i < allMaterials.Length; i++)
        {
            Material mat = allMaterials[i];
            if (mat != null)
            {
                int textureCount = ShaderUtil.GetPropertyCount(mat.shader);
                originalTextures[i] = new Texture[textureCount];

                for (int j = 0; j < textureCount; j++)
                {
                    if (ShaderUtil.GetPropertyType(mat.shader, j) == ShaderUtil.ShaderPropertyType.TexEnv)
                    {
                        string propertyName = ShaderUtil.GetPropertyName(mat.shader, j);
                        originalTextures[i][j] = mat.GetTexture(propertyName);
                    }
                }
            }
        }
    }

    void Update()
    {
        // Toggle textures when the "2" key is pressed
        if (Input.GetKeyDown(KeyCode.Alpha2))
        {
            texturesEnabled = !texturesEnabled;

            for (int i = 0; i < allMaterials.Length; i++)
            {
                Material mat = allMaterials[i];
                if (mat != null)
                {
                    int textureCount = ShaderUtil.GetPropertyCount(mat.shader);

                    for (int j = 0; j < textureCount; j++)
                    {
                        if (ShaderUtil.GetPropertyType(mat.shader, j) == ShaderUtil.ShaderPropertyType.TexEnv)
                        {
                            string propertyName = ShaderUtil.GetPropertyName(mat.shader, j);

                            if (texturesEnabled)
                            {
                                // Restore original texture
                                mat.SetTexture(propertyName, originalTextures[i][j]);
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
