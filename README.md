# UnityiOSBridgeEssentials

Unity3d iOS Plugin / iOS Bridge for communicating with iOS Native Code from Unity

Example of how to use the iOSPlugin:


### Basic Alert

```csharp
iOSPlugin.ShowAlert("Hello", "World");
```

### Alert With Confirmation and callback to Unity

```csharp
iOSPlugin.ShowAlertConfirmation("Basic Alert Confirmation", "Hello this is a basic confirmation !", "CallBack");
```

### Sharing a Message and Url

```csharp
iOSPlugin.ShareMessage("Welcome To iOS Bridge Essentials", "https://www.github.com/dilmerv/UnityiOSBridgeEssentials");
```

<img src="https://github.com/dilmerv/UnityiOSBridgeEssentials/blob/master/docs/images/bridge.gif" width="300">