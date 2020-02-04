using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Drive : MonoBehaviour
{

    public float speed = 10.0f;
    public float rotationSpeed = 100.0f;

    

    // Update is called once per frame
    void Update()
    {
        float translation = Input.GetAxis("Vertical") * speed;
        float rotation = Input.GetAxis("Mouse X") * rotationSpeed;
        float pitch = Input.GetAxis("Mouse Y") * rotationSpeed;

        translation *= Time.deltaTime;
        rotation *= Time.deltaTime;
        pitch *= Time.deltaTime;

        transform.Translate(0,0,translation);
        transform.Rotate(Vector3.up, rotation);
        transform.Rotate(Vector3.left, pitch);
    }
}
