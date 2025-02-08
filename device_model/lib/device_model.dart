// import 'package:flutter/material.dart';
// import 'package:device_info_plus/device_info_plus.dart';
// import 'dart:io';

// class DeviceInfoPage extends StatefulWidget {
//   @override
//   _DeviceInfoPageState createState() => _DeviceInfoPageState();
// }

// class _DeviceInfoPageState extends State<DeviceInfoPage> {
//   String deviceModel = "Loading...";
//   String osVersion = "Loading...";

//   @override
//   void initState() {
//     super.initState();
//     getDeviceInfo();
//   }

//   Future<void> getDeviceInfo() async {
//     DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
//     if (Platform.isAndroid) {
//       AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
//       setState(() {
//         deviceModel = androidInfo.model;
//         osVersion = "Android ${androidInfo.version.release}";
//       });
//     } else if (Platform.isIOS) {
//       IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
//       setState(() {
//         deviceModel = iosInfo.utsname.machine;
//         osVersion = "iOS ${iosInfo.systemVersion}";
//       });
//     } else {
//       setState(() {
//         deviceModel = "Unknown Device";
//         osVersion = "Unknown OS";
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Device Info")),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               "Device Model: $deviceModel",
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 10),
//             Text(
//               "OS Version: $osVersion",
//               style: TextStyle(fontSize: 18),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'dart:io' show Platform;
import 'dart:html' as html; // For Web Support

class DeviceInfoPage extends StatefulWidget {
  @override
  _DeviceInfoPageState createState() => _DeviceInfoPageState();
}

class _DeviceInfoPageState extends State<DeviceInfoPage> {
  String deviceModel = "Loading...";
  String osVersion = "Loading...";

  @override
  void initState() {
    super.initState();
    getDeviceInfo();
  }

  Future<void> getDeviceInfo() async {
    if (kIsWeb) {
      // Web: Get Browser and OS Info
      final userAgent = html.window.navigator.userAgent;
      setState(() {
        deviceModel = html.window.navigator.platform ?? "Unknown Device";
        osVersion = userAgent;
      });
    } else {
      // Mobile: Use device_info_plus
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        setState(() {
          deviceModel = androidInfo.model;
          osVersion = "Android ${androidInfo.version.release}";
        });
      } else if (Platform.isIOS) {
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        setState(() {
          deviceModel = iosInfo.utsname.machine;
          osVersion = "iOS ${iosInfo.systemVersion}";
        });
      } else {
        setState(() {
          deviceModel = "Unknown Device";
          osVersion = "Unknown OS";
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Device Info")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Device Model: $deviceModel",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              "OS Version: $osVersion",
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
