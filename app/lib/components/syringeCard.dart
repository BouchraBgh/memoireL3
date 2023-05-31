import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Syring extends StatefulWidget {
  final name;
  final date;
  final note;
  const Syring(
      {super.key,
      @required this.name,
      @required this.date,
      @required this.note});

  @override
  State<Syring> createState() => _SyringState();
}

class _SyringState extends State<Syring> {
  @override
  Widget build(BuildContext context) {
    return Container(
        // margin: EdgeInsets.only(left: 1),
        width: 370,
        height: 135,
        decoration: BoxDecoration(
            color: Color(0xffF5591F),
            gradient: LinearGradient(colors: [
              (Color.fromARGB(255, 19, 93, 189)),
              (Color.fromARGB(255, 31, 172, 238)),
            ]),
            borderRadius: BorderRadius.circular(10)),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.only(left: 10),
              width: 90,
              height: 120,
              child: const CircleAvatar(
                backgroundColor: Color.fromARGB(255, 30, 81, 148),
                child: FaIcon(
                  FontAwesomeIcons.syringe,
                  size: 40,
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
              ),
            ),
            const SizedBox(
              width: 9,
            ),
            Container(
              width: 261,
              // color: Colors.amber,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Note"),
                            content: Text(widget.note),
                            actions: [
                              TextButton(
                                child: Text("Close"),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Container(
                      width: 30,
                      margin: const EdgeInsets.only(left: 231, top: 6),
                      padding: const EdgeInsets.all(7),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 33, 33, 33),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.only(left: 3),
                        child: FaIcon(
                          FontAwesomeIcons.question,
                          size: 17,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      const Text(
                        "Nom:",
                        style: TextStyle(
                            fontSize: 19,
                            color: Color.fromARGB(255, 40, 40, 40),
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        widget.name,
                        style: const TextStyle(
                            fontSize: 16,
                            color: Color.fromARGB(255, 0, 0, 0),
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      const Text(
                        "Date:",
                        style: TextStyle(
                            fontSize: 19,
                            color: Color.fromARGB(255, 40, 40, 40),
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        widget.date.toString().substring(0, 10),
                        style: const TextStyle(
                            fontSize: 16,
                            color: Color.fromARGB(255, 0, 0, 0),
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            //question Icon
          ],
        ));
  }
}
