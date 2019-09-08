using UnityEngine;
using UnityEngine.UI;

public class UIBindings : MonoBehaviour
{
    private const string ICLOUD_KEY = "myAppKey";

    [SerializeField]
    private Button showAlertButton;

    [SerializeField]
    private Button showAlertConfirmationButton;

    [SerializeField]
    private Button rotateUpAlertConfirmationButton;

    [SerializeField]
    private Button rotateDownAlertConfirmationButton;

    [SerializeField]
    private Button shareMessageButton;

    [SerializeField]
    private Button batteryStatusButton;

    [SerializeField]
    private Button batteryLevelButton;

    [SerializeField]
    private Button iCloudGetValueButton;

    [SerializeField]
    private Button iCloudSaveValueButton;

    void Start()  
    {
        showAlertButton.onClick.AddListener(ShowBasicAlert);
        showAlertConfirmationButton.onClick.AddListener(ShowAlertConfirmation);
        rotateUpAlertConfirmationButton.onClick.AddListener(RotateUpAlertConfirmation);
        rotateDownAlertConfirmationButton.onClick.AddListener(RotateDownAlertConfirmation);
        shareMessageButton.onClick.AddListener(ShareMessage);
        batteryStatusButton.onClick.AddListener(BatteryStatus);
        batteryLevelButton.onClick.AddListener(BatteryLevel);
        iCloudGetValueButton.onClick.AddListener(iCloudGetValue);
        iCloudSaveValueButton.onClick.AddListener(iCloudSaveValue);
    }

    void ShowBasicAlert() 
    {
        iOSPlugin.ShowAlert("Basic Alert", "Hello this is a basic alert !");
    }

    void ShowAlertConfirmation()
    {
        iOSPlugin.ShowAlertConfirmation("Basic Alert Confirmation", "Hello this is a basic confirmation !", "CallBack");
    }

    void RotateUpAlertConfirmation()
    {
        iOSPlugin.ShowAlertConfirmation("Rotating Up", "Should I Rotate Up?", "RotateUpCallBack");
    }

    void RotateDownAlertConfirmation()
    {
        iOSPlugin.ShowAlertConfirmation("Rotating Down", "Should I Rotate Down?", "RotateDownCallBack");
    }

    void ShareMessage()
    {
        iOSPlugin.ShareMessage("Sharing a message!", "https://www.youtube.com/c/dilmervalecillos");
    }

    void BatteryStatus()
    {
        var batteryStatus = iOSPlugin.GetBatteryStatus();
        iOSPlugin.ShowAlert("Battery Status", batteryStatus.ToString());
    }

    void BatteryLevel()
    {
        string batteryLevel = iOSPlugin.GetBatteryLevel();
        iOSPlugin.ShowAlert("Battery Level", batteryLevel);
    }

    void iCloudGetValue()
    {
        string savedValue = iOSPlugin.iCloudGetValue(ICLOUD_KEY);
        iOSPlugin.ShowAlert("iCloud Value", string.IsNullOrEmpty(savedValue) ? "Nothing Saved Yet..." : savedValue);
    }

    void iCloudSaveValue()
    {
        string valueToSave = System.Guid.NewGuid().ToString();
        bool success = iOSPlugin.iCloudSaveValue(ICLOUD_KEY, valueToSave);
        
        if(success)
        {
            iOSPlugin.ShowAlert("iCloud Value Saved Success", valueToSave);
        }
        else 
        {
            iOSPlugin.ShowAlert("iCloud Value Saved failed", valueToSave);
        }
    }
}