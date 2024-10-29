using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class MouseSound : MonoBehaviour
{
    public AudioSource mouseAudio;
    public AudioClip[] mouseLaughs;

    private AudioClip activeSound;

    private float timeTillSound = 0;

    // Update is called once per frame
    void Update()
    {
        timeTillSound += Time.deltaTime;
        GetTime(timeTillSound);
    }

    void GetTime(float time)
    {
        int seconds = Mathf.FloorToInt(time % 60);

        if (seconds == 20)
        {
            activeSound = mouseLaughs[Random.Range(0, mouseLaughs.Length)];
            mouseAudio.PlayOneShot(activeSound);
            timeTillSound = 0;
        }
    }
}
