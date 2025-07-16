import Flutter
import UIKit

public class FaceLivenessDetectorPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "face_liveness_detector", binaryMessenger: registrar.messenger())
    let instance = FaceLivenessDetectorPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)

    let handler = EventStreamHadler()
    let eventChannel = FlutterEventChannel(name: "face_liveness_event", binaryMessenger: registrar.messenger())
    eventChannel.setStreamHandler(handler)
    
    let factory = FaceLivenessViewFactory(messenger: registrar.messenger(), handler: handler)
    registrar.register(factory, withId: "face_liveness_view")
    
    print("FaceLivenessPlugin initialized with custom credentials provider")
  }
  
  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {

    if call.method == "getPlatformVersion" {
      result("iOS " + UIDevice.current.systemVersion)
    } else {
      result(FlutterMethodNotImplemented)
    }
  }
} 