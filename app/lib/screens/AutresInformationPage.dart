import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../config.dart';
import 'login_page.dart';

class AutresInformationPage extends StatefulWidget {
  final userId;
  const AutresInformationPage({super.key, this.userId});

  @override
  State<AutresInformationPage> createState() => _AutresInformationPageState();
}

class _AutresInformationPageState extends State<AutresInformationPage> {
  String userId = "";
  dynamic userVaccin;
  bool isListe = false;
  @override
  void initState() {
    super.initState();
    userId = widget.userId;
    getuserData(userId);
  }

  void getuserData(userId) async {
    var url = Uri.parse('${Config.autresInfo}/$userId');
    var response =
        await http.get(url, headers: {"Content-Type": "application/json"});
    var jsonResponse = jsonDecode(response.body);
    if (jsonResponse['status']) {
      // the userVaccin state variable is updated using setState to trigger a
      //rebuild with the received data
      setState(() {
        userVaccin = jsonResponse['vaccin'];
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
    if (userVaccin == null) {
      // Display loading indicator or other appropriate content while waiting for userData
      return Scaffold(
        appBar: AppBar(
          title: const Text('Autre perspectives'),
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
          title: const Text('Autre perspectives'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                // color: Colors.amber,
                child: Padding(
                    padding: const EdgeInsets.all(1),
                    child: !isListe || userVaccin!.length == 0
                        ? const Center(
                            child: Text("Il n'y a pas perspectives"),
                          )
                        : ListView.builder(
                            itemCount: userVaccin!.length,
                            itemBuilder: (context, int index) {
                              return Container(
                                padding: EdgeInsets.all(6),
                                margin: const EdgeInsets.symmetric(vertical: 6),
                                child: Container(
                                  width: 200,
                                  height: 200,
                                  padding: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                          color: Colors.black, width: 1)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          const FaIcon(
                                            FontAwesomeIcons.fileMedicalAlt,
                                            size: 50,
                                            color: Colors.blue,
                                          ),
                                          Text(
                                            '  ${userVaccin[index]['date'].toString().substring(0, 10)}',
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text('${userVaccin[index]['note']}')
                                    ],
                                  ),
                                ),
                              );
                            })),
              ),
            ),
          ],
        ));
  }
}
