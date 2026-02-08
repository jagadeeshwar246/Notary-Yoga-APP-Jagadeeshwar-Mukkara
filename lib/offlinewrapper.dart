import 'dart:io';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';

import 'home_page.dart';

class OfflineWrapper extends StatefulWidget {
  const OfflineWrapper({super.key});

  @override
  State<OfflineWrapper> createState() => _OfflineWrapperState();
}

class _OfflineWrapperState extends State<OfflineWrapper> {
  bool isOffline = false;

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.dark,
    ));
    _checkConnection();
    Connectivity().onConnectivityChanged.listen((result) {
      _checkConnection();
    });
  }


  Future<void> _checkConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder: (context)=>HomePage()),(Route<dynamic> route) => false);
      }
    } on SocketException catch (_) {
        isOffline = true;
    }
  }


  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    double w(double val) => screenWidth * (val / 392.72727272727275);
    double h(double val) => screenHeight * (val / 850.9090909090909);
      return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.wifi_off, size: w(100), color: Colors.grey),
              SizedBox(height: h(20)),
              const Text(
                'You are offline.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: h(5)),
              const Text(
                'Please connect to the internet.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      );
    }
}
