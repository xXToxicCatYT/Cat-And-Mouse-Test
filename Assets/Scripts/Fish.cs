using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Fish : MonoBehaviour
{
    public Timer timer;

    public Vector3 rotation;

    public int speed;

    public AudioSource pickedUp;

    // Update is called once per frame
    void Update()
    {
        transform.Rotate(rotation * speed * Time.deltaTime);
    }

    private void OnTriggerEnter(Collider other)
    {
        if (other.gameObject.tag == "Player")
        {
            timer.timeLeft += 30;
            pickedUp.Play();
            Destroy(gameObject);
        }
    }
}
