//
//  DeviceModel.swift
//  swiftdemotarget
//
//  Created by Marco Estrella on 7/6/18.
//

import Foundation
import Android
import AndroidBluetooth

struct DeviceModel {
    var device: Android.Bluetooth.Device?
    var rssi: Int?
}
