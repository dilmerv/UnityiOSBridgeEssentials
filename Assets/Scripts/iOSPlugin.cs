using System.Diagnostics;
using System.Runtime.InteropServices;
using UnityEngine;

public class iOSPlugin : MonoBehaviour
{
    #if UNITY_IOS

    [DllImport("__Internal")]
    private static extern void _ShowAlert(string title, string message);
    
    public static void ShowAlert(string title, string message)
    {
        _ShowAlert(title, message);
    }

    #else

    public static void ShowAlert(string title, string message)
    {
        Debug.LogError("ShowAlert is only supported on iOS platform");
    }

    #endif
}
