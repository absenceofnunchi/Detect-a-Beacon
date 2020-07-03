# Detect-a-Beacon

An iOS app that demonstrates the use of the CoreLocation API to employ the iBeacon technology and communicate with the nearby iBeacon-capable devices.

<img src="https://github.com/igibliss00/Detect-a-Beacon/blob/master/README_assets/1.jpeg" width="400">

<img src="https://github.com/igibliss00/Detect-a-Beacon/blob/master/README_assets/2.jpeg" width="400">

<img src="https://github.com/igibliss00/Detect-a-Beacon/blob/master/README_assets/3.jpeg" width="400">

<img src="https://github.com/igibliss00/Detect-a-Beacon/blob/master/README_assets/4.jpeg" width="400">

## Features

### iBeacon

iBeacon is an Apple’s technology relying on BLE to communicate with nearby iBeacon-capable devices. Requires an iPhone 4S (or later), iPod touch (5th generation), iPad (3rd generation or later), or iPad mini. It uses 2.4GHz which is effected by physical obstructions and water, which means a human body will hinder the signal strength.

Prior to iOS 7, Core Location used regions defined by a geographic location (latitude and longitude) and a radius, known as a ‘geofence’. iBeacon enables a new level of flexibility by defining regions with an identifier. This allows beacons to be affixed to objects that are not tied to a single location. For example, a beacon device could be used to set a region around a movable object like a food truck or on a cruise ship. Furthermore, the same identifier can be used by 
multiple devices. This would enable a retail chain to use beacons in all their locations and allow an iOS device to know when it enters any one of them. 

This project uses the Core Location API to be notified when the iOS device has moved into or out of a beacon region.  One the important aspects to consider is the accuracy. The higher the distance between the beacon and the cell phone, the lower the certain of the position of the device or beacon. It could also be due to the physical obstructions.  The project reacts differently depending on the proximity.

```
UIView.animate(withDuration: 1) {
    switch distance {
    case .far:
        self.view.backgroundColor = .blue
        self.distanceReading.text = "FAR"
    case .near:
        self.view.backgroundColor = .orange
        self.distanceReading.text = "NEAR"
    case .immediate:
        self.view.backgroundColor = .red
        self.distanceReading.text = "RIGHT HERE"
    default:
        self.view.backgroundColor = .gray
        self.distanceReading.text = "UNKNOWN"
    }
}
```

Lastly, in terms of privacy, iBeacon advertisements only contain UUID, major and minor values. This is a unidirectional broadcasting; there is no bidirectional communication between a beacon device and an iOS device via iBeacon technology, therefore iBeacon technology cannot be used to receive by a beacon to receive information from a user. What an app does in response to a notification triggered by an iBeacon advertisement is a separate matter, but this is no different from using existing geofencing technologies. ([Getting Started with iBeacon](https://developer.apple.com/ibeacon/Getting-Started-with-iBeacon.pdf))
