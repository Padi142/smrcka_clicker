import 'package:flutter/material.dart';

class SalinaNumber extends StatelessWidget {
  final String lineName;
  const SalinaNumber({required this.lineName, super.key});

  @override
  Widget build(BuildContext context) {
    if (lineName == "1") {
      return Padding(
        padding: const EdgeInsets.all(4),
        child: SizedBox(
          width: 40,
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.red),
            child: Center(
              child: Text(
                lineName,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      );
    }
    if (lineName == "2") {
      return Padding(
        padding: const EdgeInsets.all(4),
        child: SizedBox(
          width: 40,
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.greenAccent),
            child: Center(
              child: Text(
                lineName,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.all(4),
        child: SizedBox(
          width: 40,
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.amber),
            child: Center(
              child: Text(
                lineName,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      );
    }
  }
}
