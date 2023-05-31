import 'dart:async';
import 'package:carnetmobil/screens/home.dart';
import 'package:flutter/material.dart';
import 'login_page.dart';

class SplashPage extends StatefulWidget {
  final token;
  SplashPage({this.token});
  @override
  State<StatefulWidget> createState() => StartState();
}

class StartState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    StarTime();
  }

  Future<Timer> StarTime() async {
    const duration = Duration(seconds: 3);
    return Timer(duration, route);
  }

  route() {
    if (widget.token == null) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
    } else {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => Home(
                    token: widget.token,
                  )));
    }
  }

  @override
  Widget build(BuildContext context) {
    return initWidget(context);
  }

  Widget initWidget(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Color(0xffF5591F),
              gradient: LinearGradient(
                colors: [
                  (Color.fromARGB(255, 19, 93, 189)),
                  (Color.fromARGB(255, 31, 172, 238)),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          Center(
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Carnet",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 40),
                ),
                Text("de santé",
                    style: TextStyle(color: Colors.white, fontSize: 24))
              ],
            ),
          )
        ],
      ),
    );
  }
}
