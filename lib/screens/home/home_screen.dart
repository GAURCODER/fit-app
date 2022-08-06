import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_app/constants.dart';
import 'package:fit_app/model/user_model.dart';
import 'package:fit_app/pages/settings.dart';
import 'package:fit_app/screens/home/components/body.dart';
import 'package:fit_app/screens/home/components/heart_bpm.dart';
import 'package:fit_app/screens/home/components/sendnot.dart';
import 'package:fit_app/screens/home/profile_comp/color_set.dart';
import 'package:fit_app/screens/home/profile_comp/proflie_body.dart';
import 'package:curved_drawer_fork/curved_drawer_fork.dart';
import 'package:flutter/material.dart';

class pass {
  static int _selectedIndex = 0;
  static select(int x) {
    _selectedIndex = x;
  }

  static setter(int x) {
    _selectedIndex = x;
  }

  static int get selectedIndex => _selectedIndex;
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<DrawerItem> _drawerItems = <DrawerItem>[
    const DrawerItem(icon: Icon(Icons.account_circle), label: "Profile"),
    const DrawerItem(icon: Icon(Icons.medical_services), label: "Medicine"),
    const DrawerItem(icon: Icon(Icons.settings), label: "Settings"),
    const DrawerItem(icon: Icon(Icons.monitor_heart), label: "Monitor"),
  ];
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

  final draw_page = [
    const ProfileBody(),
    const SendNot(),
    Playground(
      title: "Drawer Settings",
    ),
    const HeartPage()
  ];
  final pages = [Body(), const HeartPage(), const ProfileBody()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Fitness App",
          style: TextStyle(fontSize: 23, color: Colors.black),
        ),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      drawer: CurvedDrawer(
        index: index,
        width: leftWidth,
        color: colorPallete[leftBackgroundColor],
        buttonBackgroundColor: colorPallete[leftBackgroundColor],
        labelColor: colorPallete[leftTextColor],
        items: _drawerItems,
        onTap: (newIndex) {
          setState(() {
            index = newIndex;
            Future.delayed(const Duration(milliseconds: 800), () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => draw_page[index],
                ),
              );
            });
          });
        },
      ),
      body: pages[pass._selectedIndex],
      // account_circle profile profle_body,medical_services medicine sendnot,settings settings settingspage ...
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.monitor_heart), label: "Heart"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile")
        ],
        backgroundColor: kBackgroundColor,
        unselectedItemColor: Colors.black,
        currentIndex: pass._selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      pass._selectedIndex = index;
    });
  }
}
