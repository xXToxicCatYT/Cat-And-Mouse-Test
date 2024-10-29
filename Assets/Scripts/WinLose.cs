using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;

public class WinLose : MonoBehaviour
{
    private float timeSwitchScene;

    // Update is called once per frame
    void Update()
    {
        timeSwitchScene += Time.deltaTime;
        GetTime(timeSwitchScene);
    }

    void GetTime(float time)
    {
        int seconds = Mathf.FloorToInt(time % 60);

        if (seconds == 5)
        {
            SceneManager.LoadScene(0);
        }
    }
}
