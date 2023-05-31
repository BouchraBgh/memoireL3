import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../components/chart/lineChart.dart';
import '../components/chart/poidsPoint.dart';
import '../config.dart';
import 'login_page.dart';

class ConsultationPage extends StatefulWidget {
  final userId;
  const ConsultationPage({super.key, this.userId});
  @override
  State<ConsultationPage> createState() => _ConsultationPageState();
}

class _ConsultationPageState extends State<ConsultationPage> {
  String userId = "";
  dynamic userVaccin;
  late List<Point> poidSpots;
  late List<Point> tailleSpots;
  bool isListe = false;
  @override
  void initState() {
    super.initState();
    userId = widget.userId;
    getuserData(userId);
  }

  void getuserData(userId) async {
    var url = Uri.parse('${Config.getConsultation}/$userId');
    var response =
        await http.get(url, headers: {"Content-Type": "application/json"});
    var jsonResponse = jsonDecode(response.body);
    if (jsonResponse['status']) {
      // the userVaccin state variable is updated using setState to trigger a
      //rebuild with the received data
      setState(() {
        userVaccin = jsonResponse['consultation'];
        print("*****************************************************");
        print(userVaccin);
        print("*****************************************************");
        poidSpots = List<Point>.from(userVaccin.map((item) {
          int mois = item['mois'];
          double poid = item['poids'].toDouble();
          double x = mois.toDouble();
          double y = poid;
          return Point(x: x, y: y);
        }));
        tailleSpots = List<Point>.from(userVaccin.map((item) {
          int mois = item['mois'];
          double poid = item['taille'].toDouble();
          double x = mois.toDouble();
          double y = poid;
          return Point(x: x, y: y);
        }));
        poidSpots.sort((a, b) => a.x.compareTo(b.x));
        tailleSpots.sort((a, b) => a.x.compareTo(b.x));
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
    if (userVaccin == null || !isListe) {
      // Display loading indicator or other appropriate content while waiting for userData
      return Scaffold(
        appBar: AppBar(
          title: Text('Vaccination'),
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
    Size screenSize = MediaQuery.of(context).size;
    double screenWidth = screenSize.width;
    return Scaffold(
        appBar: AppBar(
          title: Text('Consultation'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 25,
              ),
              Container(
                  margin: EdgeInsets.only(left: 10, bottom: 20),
                  child: const Text(
                    "Poid",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                  )),
              Container(
                // color: Colors.amber,
                width: screenWidth * 0.9,
                height: 260,
                child: LineChartWidget(poidSpots),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                  margin: EdgeInsets.only(left: 5, bottom: 20),
                  child: const Text(
                    "Taille",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                  )),
              Container(
                width: screenWidth * 0.9,
                height: 260,
                child: LineChartWidget(tailleSpots),
              ),
            ],
          ),
        ));
  }
}
