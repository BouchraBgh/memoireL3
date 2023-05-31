import 'dart:convert';
import 'package:carnetmobil/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import '../config.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => StartState();
}

class StartState extends State<LoginPage> {
  TextEditingController numberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  late SharedPreferences prefs;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initSharedPref();
  }

  void initSharedPref() async {
    prefs = await SharedPreferences.getInstance();
  }

  void login() async {
    if (numberController.text.isNotEmpty &&
        passwordController.text.isNotEmpty) {
      var reqBody = {
        "SocialNumber": numberController.text,
        "password": passwordController.text
      };

      var response = await http.post(Uri.parse(Config.login),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(reqBody));
      var jsonResponse = jsonDecode(response.body);
      if (jsonResponse['status']) {
        // ignore: unused_local_variable
        var myToken = await jsonResponse['token'];
        prefs.setString('token', myToken);
        // ignore: use_build_context_synchronously
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => Home(token: myToken)));
      } else {
        String mess = jsonResponse['Message'];
        showToast(mess);
      }
    }
  }

  void showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.black54,
      textColor: Colors.white,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                height: 300,
                padding: EdgeInsets.only(top: 90),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(98),
                      bottomRight: Radius.circular(98)),
                  color: Color(0xffF5591F),
                  gradient: LinearGradient(colors: [
                    (Color.fromARGB(255, 19, 93, 189)),
                    (Color.fromARGB(255, 31, 172, 238)),
                  ]),
                ),
                child: Center(
                  child: Column(
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
                )),
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(left: 20, right: 20, top: 70),
              padding: const EdgeInsets.only(left: 20, right: 20),
              height: 54,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.grey[300],
                  boxShadow: const [
                    BoxShadow(
                        offset: Offset(0, 10),
                        blurRadius: 50,
                        color: Color(0xffEEEEEE))
                  ]),
              child: TextField(
                keyboardType: TextInputType.number,
                controller: numberController, //error Invalid constant value.
                cursorColor: const Color(0xff1393aa),
                decoration: const InputDecoration(
                    icon: Icon(
                      Icons.code,
                      color: Color.fromARGB(255, 19, 93, 189),
                    ),
                    hintText: "Numéro",
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none),
              ),
            ),
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
              padding: const EdgeInsets.only(left: 20, right: 20),
              height: 54,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.grey[300],
                  boxShadow: const [
                    BoxShadow(
                        offset: Offset(0, 10),
                        blurRadius: 50,
                        color: Color(0xffEEEEEE))
                  ]),
              child: TextField(
                controller: passwordController,
                cursorColor: const Color(0xff1393aa),
                obscureText: true,
                decoration: const InputDecoration(
                    icon: Icon(
                      Icons.password,
                      color: Color.fromARGB(255, 19, 93, 189),
                    ),
                    hintText: "Psw",
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none),
              ),
            ),
            GestureDetector(
              onTap: () {
                login();
              },
              child: Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.only(left: 20, right: 20, top: 30),
                // padding: const EdgeInsets.only(left: 10, right: 10),
                height: 54,
                width: 260,
                decoration: BoxDecoration(
                  color: Color(0xffF5591F),
                  gradient: LinearGradient(colors: [
                    (Color.fromARGB(255, 19, 93, 189)),
                    (Color.fromARGB(255, 31, 172, 238)),
                  ]),
                  borderRadius: BorderRadius.circular(50),
                  // color: Colors.grey[300],
                  boxShadow: const [
                    BoxShadow(
                        offset: Offset(0, 10),
                        blurRadius: 50,
                        color: Color(0xffEEEEEE))
                  ],
                ),
                child: const Text(
                  "LOGIN",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
