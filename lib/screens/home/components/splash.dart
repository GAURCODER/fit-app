import 'package:fit_app/screens/login_screen.dart';
import 'package:flutter/material.dart';
// import 'package:splash_page/home.dart';
// import 'package:splash_page/main.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  void initState() {
    super.initState();
    _navigatetohome();
  }

  _navigatetohome() async {
    await Future.delayed(const Duration(milliseconds: 3000), () {});
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const LoginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 300,
              width: 300,
              decoration: const BoxDecoration(
                image: const DecorationImage(
                    image: AssetImage('assets/images/logo.svg'),
                    fit: BoxFit.fill),
                // shape: BoxShape.circle,
              ),
            ),
            Container(
              // ignore: prefer_const_constructors
              child: Text(
                'Alten Care',
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
