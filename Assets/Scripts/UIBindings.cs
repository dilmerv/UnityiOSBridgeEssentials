using UnityEngine;
using UnityEngine.UI;

public class UIBindings : MonoBehaviour
{
    [SerializeField]
    private Button showAlertButton;

    void Start() => showAlertButton.onClick.AddListener(ShowAlert);

    void ShowAlert() => iOSPlugin.ShowAlert("Hello", "World");
}
