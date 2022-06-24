import 'package:fit_app/constants.dart';
import 'package:fit_app/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

void main() {
  runApp(const MyApp());
}



class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fit App',
      theme: ThemeData(
          scaffoldBackgroundColor: kBackgroundColor,
          primaryColor: kPrimaryColor,
          appBarTheme: const AppBarTheme(
            backgroundColor: kBackgroundColor,
          ),
          textTheme: Theme.of(context).textTheme.apply(bodyColor: kTextColor)),
      home: const HomeScreen(),
    );
  }
}
