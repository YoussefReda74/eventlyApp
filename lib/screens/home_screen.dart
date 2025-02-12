import 'package:eventapp/screens/create_event/create_event.dart';
import 'package:eventapp/screens/tabs/home_tab.dart';
import 'package:eventapp/screens/tabs/love_tap.dart';
import 'package:eventapp/screens/tabs/map_tap.dart';
import 'package:eventapp/screens/tabs/profile_tab.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'homeScreen';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
       Navigator.pushNamed(context, CreateEvent.routeName);
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (value) {
          selectedIndex = value;
          setState(() {});
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.location_on_outlined), label: 'Map'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border_outlined), label: 'Love'),
          BottomNavigationBarItem(icon: Icon(Icons.person_3_outlined), label: 'Profile'),
        ],
      ),
      body: tabs[selectedIndex],
    );
  }

  List<Widget> tabs = [
     HomeTab(),
    const MapTap(),
     LoveTap(),
    const ProfileTab(),
  ];
}
