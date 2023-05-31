import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:convert';
import '../config.dart';
import 'login_page.dart';

class DevelopmentPage extends StatefulWidget {
  final userId;
  const DevelopmentPage({super.key, this.userId});

  @override
  State<DevelopmentPage> createState() => _DevelopmentPageState();
}

class _DevelopmentPageState extends State<DevelopmentPage> {
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
    var url = Uri.parse('${Config.Developpements}/$userId');
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
          title: const Text('Vaccination'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
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
          title: const Text('Development'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: !isListe || userVaccin!.length == 0
            ? const Center(
                child: Text("Il n'y a pas Development"),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      // color: Colors.amber,
                      child: Padding(
                          padding: const EdgeInsets.all(1),
                          child: !isListe || userVaccin!.length == 0
                              ? const Center(
                                  child: Text("Il n'y a pas Vaccination"),
                                )
                              : ListView.builder(
                                  itemCount: userVaccin!.length,
                                  itemBuilder: (context, int index) {
                                    return Card(
                                      borderOnForeground: false,
                                      child: ListTile(
                                        leading: CircleAvatar(
                                          child: FaIcon(
                                            userVaccin![index]['type'] ==
                                                    "moteur" //put icon of hade of baby
                                                ? FontAwesomeIcons.baby
                                                : userVaccin![index][
                                                            'type'] == //put icon of eye
                                                        "cognitif"
                                                    ? FontAwesomeIcons.eye
                                                    : userVaccin![index][
                                                                'type'] == //put icon of lage
                                                            "motricité fine"
                                                        ? FontAwesomeIcons
                                                            .shoePrints
                                                        : null,
                                            size: 20,
                                            color: const Color.fromARGB(
                                                255, 255, 255, 255),
                                          ),
                                        ),
                                        title: Text(
                                          'Suivi du developpement ${userVaccin![index]['type']} ${userVaccin![index]['mois']} mois',
                                          style: const TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        subtitle: Text(
                                            '${userVaccin![index]['note']}'),
                                      ),
                                    );
                                  })),
                    ),
                  ),
                ],
              ));
  }
}
