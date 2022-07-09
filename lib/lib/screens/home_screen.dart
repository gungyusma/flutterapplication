import 'package:flutter/material.dart';

import '../widgets/hotel_carousel.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../widgets/destination_carousel.dart';
import '../widgets/explore_carrousel.dart';
import '../screens/activities_screen.dart';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key ? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentTab = 0;
  String? def;
  late DatabaseReference ref;

  void _onItemTapped(int index) {
    setState(() {
      _currentTab = index;
    });
  }

  List<Map> destination = [];
  List<String> keys = [];
  List<Map> hotel = [];
  List<String> hotelkey = [];
  List<Map> explor = [];
  List<String> explorkey = [];
  List<Map> activity = [];
  List<String> activitykey = [];
  @override

  // ignore: must_call_super
  void initState() {
    super.initState();
    ref = FirebaseDatabase.instance.ref('Destination');
    ref.onValue.listen((event) {
      final rows = event.snapshot.value as Map;
      setState(() {
        rows.forEach((key, value) {
          destination.add(value as Map);
          keys.add(key);
        });
      });
    });
    ref = FirebaseDatabase.instance.ref('hotel');
    ref.onValue.listen((event) {
      final rows = event.snapshot.value as Map;
      setState(() {
        rows.forEach((key, value) {
          hotel.add(value as Map);
          hotelkey.add(key);
        });
      });
    });
    ref = FirebaseDatabase.instance.ref('rekomendasi');
    ref.onValue.listen((event) {
      final rows = event.snapshot.value as Map;
      setState(() {
        rows.forEach((key, value) {
          explor.add(value as Map);
          explorkey.add(key);
        });
      });
    });
    ref = FirebaseDatabase.instance.ref('aktivitas');
    ref.onValue.listen((event) {
      final rows = event.snapshot.value as Map;
      setState(() {
        rows.forEach((key, value) {
          activity.add(value as Map);
          activitykey.add(key);
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final widgetOptions = [
      ListView(
        padding: EdgeInsets.symmetric(vertical: 30.0),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 60.0),
            child: Text(
              'Mau liburan kemana kali ini? ✈️',
              style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
              padding:
                  const EdgeInsets.only(left: 20.0, right: 40.0, top: 20.0),
              child: TextField(
                  decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                  ),
                ),
                hintText: 'Cari destinasi impianmu',
                contentPadding: EdgeInsets.all(15),
                filled: true,
                fillColor: Color.fromARGB(95, 207, 207, 207),
              ))),
          SizedBox(
            height: 20.0,
          ),
          DestinationCarousel(destination, activity,keys),
          SizedBox(
            height: 5.0,
          ),
          HotelCarousel(hotel, hotelkey),
        ],
      ),
      ListView(
        padding: EdgeInsets.symmetric(vertical: 30.0),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 60.0),
            child: Text(
              'Destinasi paling dicari tahun ini 🏆',
              style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Padding(
              padding:
                  const EdgeInsets.only(left: 20.0, right: 40.0, top: 20.0),
              child: TextField(
                  decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                  ),
                ),
                hintText: 'Cari tempat',
                contentPadding: EdgeInsets.all(15),
                filled: true,
                fillColor: Color.fromARGB(95, 207, 207, 207),
              ))),
          SizedBox(
            height: 20.0,
          ),
          ExploreCarrousel(explor,explorkey)
        ],
      ),
      ActivitiesScreen(activity,activitykey)
    ];
    return Scaffold(
      body: Center(
        child: widgetOptions.elementAt(_currentTab),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentTab,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                size: 20.0,
              ),
              label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.explore,
                size: 20.0,
              ),
              label: "Explore"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.local_activity,
                size: 20.0,
              ),
              label: "Aktivitas"),
        ],
      ),
    );
  }
}
