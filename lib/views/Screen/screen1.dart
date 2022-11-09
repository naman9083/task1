import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class Screen1 extends StatefulWidget {
  const Screen1({Key? key}) : super(key: key);

  @override
  State<Screen1> createState() => _Screen1State();
}

class _Screen1State extends State<Screen1> {
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController age = TextEditingController();
  FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  CollectionReference users = FirebaseFirestore.instance.collection("userData");
  Reference? storageReference;
  List<String> department1 = [
    'HR',
    'Sales',
    'Marketing',
    'Finance',
    'IT',
    'Operations',
  ];
  XFile? file;
  String? url;
  File? imgfile;
  String department = 'Select Department';
  setStateIfMounted(f) {
    if (mounted) setState(f);
  }

  imagePickFromCamera() async {
    final image = await ImagePicker()
        .pickImage(
          source: ImageSource.camera,
          imageQuality: 50,
        )
        .then((value) => setStateIfMounted(() {
              file = value;
              imgfile = File(file!.path);
              storageReference =
                  firebaseStorage.ref().child("images/${file!.name}");
              UploadTask uploadTask = storageReference!.putFile(imgfile!);
              uploadTask.then((res) {
                res.ref.getDownloadURL().then((value) {
                  print(value);
                  setStateIfMounted(() {
                    url = value;
                  });
                });
              });
            }))
        .catchError((e) => print(e));
  }

  imagePickFromGallery() async {
    final image = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 50)
        .then((value) => setStateIfMounted(() {
              file = value;
              imgfile = File(file!.path);
              storageReference =
                  firebaseStorage.ref().child("images/${file!.name}");
              UploadTask uploadTask = storageReference!.putFile(imgfile!);
              uploadTask.then((res) {
                res.ref.getDownloadURL().then((value) {
                  print(value);
                  setStateIfMounted(() {
                    url = value;
                  });
                });
              });
            }))
        .catchError((e) => print(e));
  }

  void createUserInFirestore() {
    users.add({
      "name": name.text,
      "phone": phone.text,
      "image": url,
      "department": department,
      "age": age.text,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Center(child: Text('Screen 1')),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              Positioned(
                left: 10,
                top: 10,
                child: CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.white,
                  child: url == null
                      ? const Icon(
                          Icons.person,
                          size: 50,
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(40),
                          child: Image.network(
                            url!,
                            height: 100,
                            fit: BoxFit.cover,
                            width: 100,
                          ),
                        ),
                ),
              ),
              Positioned(
                right: 10,
                top: 60,
                child: GestureDetector(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Choose Image'),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    imagePickFromCamera();
                                    Navigator.pop(context);
                                  },
                                  child: Row(
                                    children: const [
                                      Icon(
                                        Icons.camera,
                                        color: Colors.blue,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text('Camera'),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    imagePickFromGallery();
                                    Navigator.pop(context);
                                  },
                                  child: Row(
                                    children: const [
                                      Icon(
                                        Icons.image,
                                        color: Colors.blue,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text('Gallery'),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).onError((error, stackTrace) => print(error));
                  },
                  child: const Icon(
                    Icons.camera_alt,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
          Container(
              height: MediaQuery.of(context).size.height / 1.55,
              width: MediaQuery.of(context).size.width / 1.1,
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
                border: Border.all(
                  color: Colors.grey,
                  width: 1,
                ),
              ),
              child: Column(children: [
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "  Full Name",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                TextField(
                  controller: name,
                  keyboardType: TextInputType.name,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter Full Name',
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "  Phone Number",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                TextField(
                  controller: phone,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter Phone Number',
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "  Age",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                TextField(
                  controller: age,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter Age',
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "  Department",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 1.1,
                  height: 60,
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                      hint: Text(department),
                      items: department1.map((String value) {
                        return DropdownMenuItem(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? value) {
                        setState(() {
                          department = value!;
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.blue),
                    shadowColor: MaterialStateProperty.all<Color>(Colors.black),
                    elevation: MaterialStateProperty.all<double>(10),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                    ),
                  ),
                  onPressed: () {
                    if (url == null) {
                      Fluttertoast.showToast(
                          msg: "Wait! Uploading Image",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    } else if (name.text.isNotEmpty &&
                        phone.text.isNotEmpty &&
                        age.text.isNotEmpty &&
                        department.isNotEmpty &&
                        url != null) {
                      createUserInFirestore();
                      Fluttertoast.showToast(
                          msg: "User Added Successfully",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.green,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    } else {
                      Fluttertoast.showToast(
                          msg: "Please Fill All The Fields",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    }
                  },
                  child: const Text('Submit'),
                ),
              ])),
        ],
      ),
    );
  }
}
