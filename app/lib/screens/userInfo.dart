import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../components/info.dart';
import '../config.dart';
import 'login_page.dart';

class UserInfo extends StatefulWidget {
  final userId;
  const UserInfo({super.key, this.userId});

  @override
  State<UserInfo> createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  String userId = "";
  dynamic userVaccin;
  bool isListe = false;
  @override
  void initState() {
    super.initState();
    userId = widget.userId;
    getuserData(userId);
    // setState(() {
    //   Map userV = {
    //     "name": "Dina",
    //     "familyName": "Baghali",
    //     "birthDate": 2002 / 09 / 22,
    //     "placeOfBirth": "annaba",
    //     "hospital": "jjjjjjjjj",
    //     "Rh": "A+",
    //     "gender": "female",
    //     "address": "ffffffff",
    //     "mobilePhone": 1234567890,
    //     "SocialNumber": 1234567890
    //   };
    //   userVaccin = userV;
    //   isListe = true;
    // });
  }

  void getuserData(userId) async {
    var url = Uri.parse('${Config.userInfo}/$userId');
    var response =
        await http.get(url, headers: {"Content-Type": "application/json"});
    var jsonResponse = jsonDecode(response.body);
    if (jsonResponse['status']) {
      // the userVaccin state variable is updated using setState to trigger a
      //rebuild with the received data
      setState(() {
        userVaccin = jsonResponse['user'];
        isListe = true;
      });
    } else {
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double screenWidth = screenSize.width;
    double screenHeight = screenSize.height;
    if (userVaccin == null) {
      // Display loading indicator or other appropriate content while waiting for userData
      return Scaffold(
        appBar: AppBar(
          title: Text('Utilisateur'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    return Scaffold(
        appBar: AppBar(
          title: Text('Utilisateur'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Column(
          children: [
            InfoUser(
                screenWidth: screenWidth,
                info: userVaccin["name"],
                keyName: "Name",
                screenHeight: screenHeight),
            InfoUser(
                screenWidth: screenWidth,
                info: userVaccin["familyName"],
                keyName: "FamilyName ",
                screenHeight: screenHeight),
            InfoUser(
                screenWidth: screenWidth,
                info: userVaccin["birthDate"].toString().substring(0, 10),
                keyName: "birthDate",
                screenHeight: screenHeight),
            InfoUser(
                screenWidth: screenWidth,
                info: userVaccin["placeOfBirth"],
                keyName: "placeOfBirth",
                screenHeight: screenHeight),
            InfoUser(
                screenWidth: screenWidth,
                info: userVaccin["hospital"],
                keyName: "hospital",
                screenHeight: screenHeight),
            InfoUser(
                screenWidth: screenWidth,
                info: userVaccin["Rh"],
                keyName: "Rh",
                screenHeight: screenHeight),
            InfoUser(
                screenWidth: screenWidth,
                info: userVaccin["gender"],
                keyName: "gender",
                screenHeight: screenHeight),
            InfoUser(
                screenWidth: screenWidth,
                info: userVaccin["address"],
                keyName: "address",
                screenHeight: screenHeight),
            InfoUser(
                screenWidth: screenWidth,
                info: userVaccin["mobilePhone"].toString(),
                keyName: "mobilePhone",
                screenHeight: screenHeight),
            InfoUser(
                screenWidth: screenWidth,
                info: userVaccin["SocialNumber"].toString(),
                keyName: "SocialNumber",
                screenHeight: screenHeight),
          ],
        ));
  }
}
