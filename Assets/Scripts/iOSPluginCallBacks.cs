using System.Reflection;
using UnityEngine;

public class iOSPluginCallBacks : MonoBehaviour
{
    public void CallBack()
    {
        iOSPlugin.ShowAlert($"{MethodBase.GetCurrentMethod()}", "Callback Executed...");
    }
}
