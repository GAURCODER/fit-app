import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_app/constants.dart';
import 'package:fit_app/model/user_model.dart';
import 'package:fit_app/pages/edit_profile.dart';
import 'package:fit_app/screens/home/components/body.dart';
import 'package:fit_app/screens/home/components/myhomepage.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
  }

  int _selectedIndex = 0;
  final pages = [const Body(), const MyHomePage(), SettingsUI()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Fitness App",
          style: TextStyle(fontSize: 23),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.menu_rounded),
            onPressed: () {
              Colors.blue;
              // ignore: avoid_print
              print('Menu button pressed');
            },
          ),
        ],
      ),
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.leaderboard), label: "Sensor Data"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile")
        ],
        backgroundColor: kBackgroundColor,
        unselectedItemColor: Colors.white,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
