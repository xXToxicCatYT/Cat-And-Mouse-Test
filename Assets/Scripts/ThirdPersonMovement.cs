using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.InputSystem;

public class ThirdPersonMovement : MonoBehaviour
{
    public float walkSpeed = 5f;
    public float jumpPower = 5f;

    Vector2 moveInput;
    Rigidbody rb;

    public Transform playerBody;
    public Transform cam;
    public Transform lookLight;

    bool isGrounded = true;

    // Start is called before the first frame update
    void Start()
    {
        rb = GetComponent<Rigidbody>();
    }

    // Update is called once per frame
    void Update()
    {
        Run();
        if (Input.GetButtonDown("Jump") && isGrounded == true)
        {
            Jump();
        }
        LockCursor();
        RotatePlayerCam();
    }
    void OnMove(InputValue value)
    {
        moveInput = value.Get<Vector2>();
    }

    void Run()
    {
        Vector3 playerVelocity = new Vector3(moveInput.x * walkSpeed, rb.velocity.y, moveInput.y * walkSpeed);
        rb.velocity = transform.TransformDirection(playerVelocity);
    }

    void Jump()
    {
        rb.AddForce(new Vector3(0, jumpPower, 0), ForceMode.Impulse);
        isGrounded = false;
    }

    private void OnCollisionEnter(Collision collision)
    {
        if (collision.gameObject.tag == "Grounded")
        {
            isGrounded = true;
        }
    }

    void LockCursor()
    {
        Cursor.lockState = CursorLockMode.Locked;

        Cursor.visible = false;
    }

    void RotatePlayerCam()
    {
        playerBody.transform.rotation = Quaternion.Euler(0, cam.eulerAngles.y, 0);
    }

    void RotateLightCam()
    {
        lookLight.transform.rotation = Quaternion.Euler(cam.eulerAngles.x, 0, 0);
    }
}
