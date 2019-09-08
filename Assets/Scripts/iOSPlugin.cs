using System;
using System.Runtime.InteropServices;
using UnityEngine;

public class iOSPlugin : MonoBehaviour
{
    public enum BatteryStatus 
    {
        UIDeviceBatteryStateUnknown = 0,
        UIDeviceBatteryStateUnplugged = 1,
        UIDeviceBatteryStateCharging = 2,
        UIDeviceBatteryStateFull = 3
    }

    private const string NOT_SUPPORTED = "not supported on this platform";
    
    #if UNITY_IOS

    [DllImport("__Internal")]
    private static extern void _ShowAlert(string title, string message);

    [DllImport("__Internal")]
    private static extern void _ShowAlertConfirmation(string title, string message, string callback);

    [DllImport("__Internal")]
    private static extern void _ShareMessage(string message, string url);

    [DllImport("__Internal")]
    private static extern int _GetBatteryStatus();

    [DllImport("__Internal")]
    private static extern string _GetBatteryLevel();

    [DllImport("__Internal")]
    private static extern string _iCloudGetStringValue(string key);

    [DllImport("__Internal")]
    private static extern bool _iCloudSaveStringValue(string key, string value);

    [DllImport("__Internal")]
    private static extern int _iCloudGetIntValue(string key);

    [DllImport("__Internal")]
    private static extern bool _iCloudSaveIntValue(string key, int value);

    [DllImport("__Internal")]
    private static extern bool _iCloudGetBoolValue(string key);

    [DllImport("__Internal")]
    private static extern bool _iCloudSaveBoolValue(string key, bool value);
    
    public static void ShowAlert(string title, string message)
    {
        _ShowAlert(title, message);
    }

    public static void ShowAlertConfirmation(string title, string message, string callBack)
    {
        _ShowAlertConfirmation(title, message, callBack);
    }

    public static void ShareMessage(string message, string url = "")
    {
        _ShareMessage(message, url);
    }

    public static BatteryStatus GetBatteryStatus()
    {
        return (BatteryStatus)_GetBatteryStatus();
    }

    public static string GetBatteryLevel()
    {
        return _GetBatteryLevel();
    }

    public static string iCloudGetStringValue(string key)
    {
        return _iCloudGetStringValue(key);
    }

    public static bool iCloudSaveStringValue(string key, string value)
    {
        return _iCloudSaveStringValue(key, value);
    }

    public static int iCloudGetIntValue(string key)
    {
        return _iCloudGetIntValue(key);
    }

    public static bool iCloudSaveIntValue(string key, int value)
    {
        return _iCloudSaveIntValue(key, value);
    }

    public static bool iCloudGetBoolValue(string key)
    {
        return _iCloudGetBoolValue(key);
    }

    public static bool iCloudSaveBoolValue(string key, bool value)
    {
        return _iCloudSaveBoolValue(key, value);
    }

    #else

    public static void ShowAlert(string title, string message)
    {
        Debug.LogError($"{MethodBase.GetCurrentMethod()} {NOT_SUPPORTED}");
    }

    public static void ShowAlertConfirmation(string title, string message)
    {
        Debug.LogError($"{MethodBase.GetCurrentMethod()} {NOT_SUPPORTED}");
    }

    public static void ShareMessage(string title, string url = "")
    {
        Debug.LogError($"{MethodBase.GetCurrentMethod()} {NOT_SUPPORTED}");
    }

    public static int GetBatteryStatus()
    {
        Debug.LogError($"{MethodBase.GetCurrentMethod()} {NOT_SUPPORTED}");
        return 0;
    }

    public static void GetBatteryLevel()
    {
        Debug.LogError($"{MethodBase.GetCurrentMethod()} {NOT_SUPPORTED}");
    }

    public static string iCloudGetValue(string key)
    {
        Debug.LogError($"{MethodBase.GetCurrentMethod()} {NOT_SUPPORTED}");
        return "";
    }

    public static bool iCloudSaveValue(string key, string value)
    {
        Debug.LogError($"{MethodBase.GetCurrentMethod()} {NOT_SUPPORTED}");
        return false;
    }

    public static int iCloudGetIntValue(string key)
    {
        Debug.LogError($"{MethodBase.GetCurrentMethod()} {NOT_SUPPORTED}");
        return 0;
    }

    public static bool iCloudSaveIntValue(string key, int value)
    {
        Debug.LogError($"{MethodBase.GetCurrentMethod()} {NOT_SUPPORTED}");
        return false;
    }

    public static bool iCloudGetBoolValue(string key)
    {
        Debug.LogError($"{MethodBase.GetCurrentMethod()} {NOT_SUPPORTED}");
        return false;
    }

    public static bool iCloudSaveBoolValue(string key, bool value)
    {
        Debug.LogError($"{MethodBase.GetCurrentMethod()} {NOT_SUPPORTED}");
        return false;
    }

    #endif
}
