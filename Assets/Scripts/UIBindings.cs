using UnityEngine;
using UnityEngine.UI;

public class UIBindings : MonoBehaviour
{
    [SerializeField]
    private Button showAlertButton;

    [SerializeField]
    private Button showAlertConfirmationButton;

    void Start()  
    {
        showAlertButton.onClick.AddListener(ShowBasicAlert);
        showAlertConfirmationButton.onClick.AddListener(ShowAlertConfirmation);
    }

    void ShowBasicAlert() => iOSPlugin.ShowAlert("Basic Alert", "Hello this is a basic alert !");

    void ShowAlertConfirmation() => iOSPlugin.ShowAlertConfirmation("Basic Alert Confirmation", "Hello this is a basic confirmation !", "CallBack");
}