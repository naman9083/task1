import 'package:flutter/material.dart';

class Screen3 extends StatefulWidget {
  Screen3(
      {Key? key,
      required this.name,
      required this.number,
      required this.url,
      required this.department,
      required this.age})
      : super(key: key);
  String name;
  String number;
  String url;
  String department;
  String age;

  @override
  State<Screen3> createState() => _Screen3State();
}

class _Screen3State extends State<Screen3> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(widget.name)),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            CircleAvatar(
                radius: 50,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.network(
                      widget.url,
                      height: 100,
                      width: 100,
                      fit: BoxFit.cover,
                    ))),
            const SizedBox(
              height: 10,
            ),
            Text(
              widget.name,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Age: ${widget.age}",
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Mobile : ${widget.number}",
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Department: ${widget.department}",
              style: const TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
