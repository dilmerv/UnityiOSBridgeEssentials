using System.Collections.Generic;
using System.Reflection;
using UnityEngine;

public class iOSPluginCallBacks : MonoBehaviour
{
    [SerializeField]
    private GameObject rotatorObject;

    [SerializeField]
    private Vector3 rotationSpeed = new Vector3(100,0,0);

    private bool rotateUp = true;

    public void CallBack()
    {
        iOSPlugin.ShowAlert($"{MethodBase.GetCurrentMethod()}", "Callback Executed...");
    }

    void Update()
    {
        if(rotateUp)
        {
            rotatorObject.transform.Rotate(rotationSpeed * Time.deltaTime, Space.World);
        }
        else
        {
            rotatorObject.transform.Rotate(new Vector3(-rotationSpeed.x, rotationSpeed.y, rotationSpeed.z) * Time.deltaTime, Space.World);
        }
    }

    public void RotateUpCallBack()
    {
        rotateUp = true;
    }

    public void RotateDownCallBack()
    {
        rotateUp = false;
    }
}
