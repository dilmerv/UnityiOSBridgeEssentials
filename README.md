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

### Get Battery Status

```csharp
iOSPlugin.GetBatteryStatus()

// possible statuses are return in the BatterStatus enum
public enum BatteryStatus 
{
    UIDeviceBatteryStateUnknown = 0,
    UIDeviceBatteryStateUnplugged = 1,
    UIDeviceBatteryStateCharging = 2,
    UIDeviceBatteryStateFull = 3
}

```

### Get Battery Level

```csharp
iOSPlugin.GetBatteryLevel()
```

### Save Value to iCloud

```csharp
bool success = iOSPlugin.iCloudSaveValue(ICLOUD_KEY, valueToSave);
```

### Get Value from iCloud

```csharp
string savedValue = iOSPlugin.iCloudGetValue(ICLOUD_KEY);
```

### iCloud Entitlement Requirement

Be sure to include the entitlement below otherwise icloud key value store will not work

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>com.apple.developer.icloud-container-identifiers</key>
	<array/>
	<key>com.apple.developer.ubiquity-kvstore-identifier</key>
	<string>$(TeamIdentifierPrefix)$(CFBundleIdentifier)</string>
</dict>
</plist>
```

<img src="https://github.com/dilmerv/UnityiOSBridgeEssentials/blob/master/docs/images/bridge.gif" width="300">
