using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.InputSystem;

public class Destroy : MonoBehaviour
{
    public Counter counter;

    public AudioSource biteSound;

    private void OnCollisionStay(Collision collision)
    {
        if (collision.gameObject.tag == "Player" && Input.GetMouseButton(0))
        {
            Destroy(gameObject);
            counter.mouses++;
            biteSound.Play();
        }
    }
}
