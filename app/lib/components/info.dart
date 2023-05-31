import 'package:flutter/material.dart';

class InfoUser extends StatelessWidget {
  final info;
  final screenWidth;
  final keyName;
  final screenHeight;
  const InfoUser(
      {super.key,
      this.info,
      this.screenWidth,
      this.keyName,
      this.screenHeight});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.black,
            width: 1.0,
          ),
        ),
      ),
      width: screenWidth,
      margin: const EdgeInsets.all(7),
      padding: EdgeInsets.symmetric(vertical: screenHeight * 0.017),
      child: Row(
        children: [
          Text(
            '${keyName}:',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          const SizedBox(
            width: 5,
          ),
          Text(
            info,
            style: const TextStyle(fontSize: 20),
          ),
        ],
      ),
    );
  }
}
