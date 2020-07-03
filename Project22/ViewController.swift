//
//  ViewController.swift
//  Project22
//
//  Created by jc on 2020-07-03.
//  Copyright © 2020 J. All rights reserved.
//

import CoreLocation
import UIKit

class ViewController: UIViewController, CLLocationManagerDelegate {
    @IBOutlet var distanceReading: UILabel!
    @IBOutlet var beaconName: UILabel!
    var locationManager: CLLocationManager?
    var alertShown: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.requestAlwaysAuthorization()
        
        view.backgroundColor = .gray
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways {
            if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self) {
                if CLLocationManager.isRangingAvailable() {
                    startScanning()
                }
            }
        }
    }
    
    func startScanning() {
        let uuid1 = UUID(uuidString: "2F234454-CF6D-4A0F-ADF2-F4911BA9FFA6")!
        let uuid2 = UUID(uuidString: "E2C56DB5-DFFB-48D2-B060-D0F5A71096E0")!
        let uuid3 = UUID(uuidString: "5A4BCFCE-174E-4BAC-A814-092E77F6B7E5")!
        let beaconRegion1 = CLBeaconRegion(uuid: uuid1, major: 0, minor: 0, identifier: "MyBeacon1")
        let beaconRegion2 = CLBeaconRegion(uuid: uuid2, major: 0, minor: 0, identifier: "MyBeacon2")
        let beaconRegion3 = CLBeaconRegion(uuid: uuid3, major: 0, minor: 0, identifier: "MyBeacon3")
        
        locationManager?.startMonitoring(for: beaconRegion1)
        locationManager?.startRangingBeacons(in: beaconRegion1)
        
        locationManager?.startMonitoring(for: beaconRegion2)
        locationManager?.startRangingBeacons(in: beaconRegion2)
        
        locationManager?.startMonitoring(for: beaconRegion3)
        locationManager?.startRangingBeacons(in: beaconRegion3)
    }
    
    func update(distance: CLProximity) {
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
    }
    
    func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
        if let beacon = beacons.first {
//            if !alertShown {
//                let ac = UIAlertController(title: "Beacon Detected!", message: nil, preferredStyle: .alert)
//                ac.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { (_) in
//                    self.alertShown = true
//                }))
//                present(ac, animated: true)
//            }
            
            update(distance: beacon.proximity)
            
            switch beacon.uuid {
            case UUID(uuidString: "2F234454-CF6D-4A0F-ADF2-F4911BA9FFA6"):
                beaconName.text = "Radius Networks 2F234454"
            case UUID(uuidString: "E2C56DB5-DFFB-48D2-B060-D0F5A71096E0"):
                beaconName.text = "Apple AirLocate E2C56DB5"
            case UUID(uuidString: "5A4BCFCE-174E-4BAC-A814-092E77F6B7E5"):
                beaconName.text = "Apple AirLocate 5A4BCFCE"
            default:
                beaconName.text = ""
            }
        } else {
            update(distance: .unknown)
            beaconName.text = ""
        }
    }
}
