import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:task1/views/Screen/screen3.dart';

class Screen2 extends StatefulWidget {
  const Screen2({Key? key}) : super(key: key);

  @override
  State<Screen2> createState() => _Screen2State();
}

class _Screen2State extends State<Screen2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: const Text('Screen 2')),
        automaticallyImplyLeading: false,
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('userData').snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                  child: Column(
                children: const [
                  Text('Loading'),
                  CircularProgressIndicator(),
                ],
              ));
            }
            return Center(
              child: ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot ds = snapshot.data!.docs[index];
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Screen3(
                                      name: ds['name'],
                                      number: ds['phone'],
                                      url: ds['image'],
                                      department: ds['department'],
                                      age: ds['age'],
                                    )));
                      },
                      child: Container(
                        margin: const EdgeInsets.all(10),
                        height: 100,
                        width: 100,
                        child: Card(
                          child: Container(
                            margin: const EdgeInsets.all(10),
                            padding: const EdgeInsets.all(8),
                            height: 50,
                            width: 100,
                            child: Row(
                              children: [
                                CircleAvatar(
                                    radius: 30,
                                    child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            child: Image.network(
                                              ds['image'],
                                              height: 100,
                                              width: 100,
                                              fit: BoxFit.cover,
                                            )) ??
                                        Icon(Icons.person)),
                                const SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  ds['name'],
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            );
          }),
    );
  }
}
