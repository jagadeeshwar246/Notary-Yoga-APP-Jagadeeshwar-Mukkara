import 'dart:convert';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:notary_yoga/widgets/continue_watching_widget.dart';
import 'package:notary_yoga/widgets/header_widget.dart';
import 'package:notary_yoga/widgets/popular_videos_widget.dart';
import 'package:notary_yoga/widgets/yoga_category_widget.dart';

import 'offlinewrapper.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  Map<String, dynamic>? homeData;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _checkConnection();
    Connectivity().onConnectivityChanged.listen((result) {
      _checkConnection();
    });
    fetchHome();
  }
  Future<void> _checkConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isEmpty && result[0].rawAddress.isEmpty) {
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>OfflineWrapper()),(Route<dynamic> route) => false);
      }
    } on SocketException catch (_) {
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>OfflineWrapper()),(Route<dynamic> route) => false);
    }
  }

  Future<void> fetchHome() async {
    final response = await http.post(
      Uri.parse('https://api.prosignings.online/api/home'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({"userId": "randomstring"}),
    );

    if (response.statusCode == 200) {
      setState(() {
        homeData = jsonDecode(response.body);
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final baseWidth = 392.72727272727275;
    final baseHeight = 850.9090909090909;

    double w(double v) => screenWidth * (v / baseWidth);
    double h(double v) => screenHeight * (v / baseHeight);

    return Scaffold(
      backgroundColor: const Color(0xffF7F7F7),
      body: homeData == null
          ? Center(
          child: SpinKitFadingFour(
            color: Colors.deepPurpleAccent,
            size: w(40),
          )
      )
          : SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              HeaderWidget(header: homeData!['header']),
              ContinueWatchingWidget(data: homeData!['continueWatching']),
              YogaCategoryWidget(data: homeData!['yogaCategories']),
              PopularVideosWidget(data: homeData!['popularVideos']),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        fixedColor: Colors.deepPurpleAccent,
        currentIndex: currentIndex,
        onTap: (i) => setState(() => currentIndex = i),
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined,size: w(31),), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.auto_graph_outlined,size: w(31)), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.local_fire_department_outlined,size: w(31)), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline,size: w(31)), label: ''),
        ],
      ),
    );
  }
}
