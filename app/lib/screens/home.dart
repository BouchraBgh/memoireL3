import 'package:carnetmobil/screens/userInfo.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../components/homeCard.dart';
import '../components/syringeCard.dart';
import '../config.dart';
import 'AutresInformationPage.dart';
import 'ConsultationPage.dart';
import 'DevelopmentPage.dart';
import 'VaccinationPage.dart';
import 'login_page.dart';

class Home extends StatefulWidget {
  final token;

  const Home({
    Key? key,
    required this.token,
  }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late String userId;
  dynamic userData;
  dynamic LasteSyring;

  @override
  void initState() {
    super.initState();
    Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);
    userId = jwtDecodedToken['_id'];
    getuserData(userId);
    getLasteSyring(userId);
  }

  void getuserData(userId) async {
    var reqBody = {"userId": userId};

    var response = await http.post(Uri.parse(Config.getuserData),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(reqBody));
    var jsonResponse = jsonDecode(response.body);
    if (jsonResponse['status']) {
      // the userData state variable is updated using setState to trigger a
      //rebuild with the received data
      setState(() {
        userData = jsonResponse['userData'];
      });
    } else {
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
    }
  }

  void getLasteSyring(userId) async {
    var url = Uri.parse('${Config.getLasteSyring}/$userId');
    var response =
        await http.get(url, headers: {"Content-Type": "application/json"});
    var jsonResponse = jsonDecode(response.body);
    if (jsonResponse['status']) {
      // the userData state variable is updated using setState to trigger a
      //rebuild with the received data
      setState(() {
        LasteSyring = jsonResponse['vaccin'];
      });
    } else {
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
    }
  }

  void logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // Clear the token
    // ignore: use_build_context_synchronously
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginPage()));
  }

  @override
  Widget build(BuildContext context) {
    if (userData == null || userData['name'] == null) {
      // Display loading indicator or other appropriate content while waiting for userData
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    Size screenSize = MediaQuery.of(context).size;
    double screenWidth = screenSize.width;
    double screenHeight = screenSize.height;

    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      // appBar: AppBar(backgroundColor: Colors.),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: screenHeight * 0.01,
          ),
          //general information
          Container(
            // color: Colors.amber,
            padding: EdgeInsets.only(
                top: screenHeight * 0.036,
                left: 30.0,
                right: 30.0,
                bottom:
                    15.0), //A value of type 'Null' can't be assigned to a parameter of type 'double' in a const constructor
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //name logout
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('${userData!['name']}',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromARGB(255, 32, 32, 32),
                                        fontSize: 20)),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text('${userData!['familyName']}',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromARGB(255, 32, 32, 32),
                                        fontSize: 20))
                              ],
                            ),
                            Text(
                              userData['SocialNumber'].toString(),
                              style: const TextStyle(
                                  color: Color.fromARGB(255, 240, 239, 239),
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Container(
                          // color: Colors.amber,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all<Color?>(
                                      Colors.blue),
                            ),
                            onPressed: logout,
                            child: Text('Logout'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          //card
          Container(
            margin: EdgeInsets.only(left: screenWidth * 0.05),
            child: Syring(
                name: LasteSyring?['name'],
                date: LasteSyring?['date'],
                note: LasteSyring?['note']),
          ),
          SizedBox(
            height: screenHeight * 0.024,
          ),
          Container(
            width: screenWidth,
            height: screenHeight * 0.659,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40))),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: screenHeight * 0.01,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 100,
                      height: screenHeight * 0.1,
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color?>(Colors.blue),
                      ),
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => UserInfo(userId: userId)),
                      ),
                      child: SizedBox(
                          width: 155,
                          height: 60,
                          child: Center(
                              child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(bottom: 6.0),
                                child: FaIcon(
                                  FontAwesomeIcons.user,
                                  size: 20,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                'Utilisateur',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15),
                              ),
                            ],
                          ))),
                    ),
                  ],
                ),
                SizedBox(
                  height: screenHeight * 0.03,
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            // Navigation logic here
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    VaccinationPage(userId: userId),
                              ),
                            );
                          },
                          child: const HomeCard(
                            titel: "Vaccination",
                            icon: FontAwesomeIcons.syringe,
                          ),
                        ),
                        //error Evaluation of this constant expression throws an exception.
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ConsultationPage(userId: userId),
                              ),
                            );
                          },
                          child: const HomeCard(
                            titel: "Consultation",
                            icon: FontAwesomeIcons.stethoscope,
                          ),
                        ),
                      ],
                    )),
                SizedBox(
                  height: screenHeight * 0.02,
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    DevelopmentPage(userId: userId),
                              ),
                            );
                          },
                          child: const HomeCard(
                            titel: "Développement",
                            icon: FontAwesomeIcons.userMd,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    AutresInformationPage(userId: userId),
                              ),
                            );
                          },
                          child: const HomeCard(
                            titel: "    Autres\nPerspectives",
                            icon: FontAwesomeIcons.fileMedicalAlt,
                          ),
                        ),
                      ],
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
