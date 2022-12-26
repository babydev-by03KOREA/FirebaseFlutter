import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'constructor/FirebaseUsers.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: DataCRUD(
      title: 'Flutter CRUD',
    ),
  ));
}

class DataCRUD extends StatefulWidget {
  const DataCRUD({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<DataCRUD> createState() => _DataCRUDState();
}

class _DataCRUDState extends State<DataCRUD> {
  late TextEditingController controller;
  String name = "";
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                inputUserData();
              },
              icon: const Icon(Icons.add)),
        ],
      ),
      body: MemberDTO(name: name),
    );
  }

  Future<String?> inputUserData() => showDialog<String>(
        context: context,
        builder: (context) => AlertDialog(
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  autofocus: true,
                  decoration:
                      const InputDecoration(hintText: 'Enter your name'),
                  controller: controller,
                  validator: (value) {
                    return value!.isNotEmpty ? null : "Invalid Field";
                  },
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Navigator.of(context).pop();
                    setState(() {
                      name = controller.text;
                    });
                  }
                },
                child: const Text('ADD DB')),
          ],
        ),
      );

  void submitOK() {
    Navigator.of(context).pop(controller.text);
    controller.clear();
  }

  Future createUser({required String name}) async {
    final docUser = FirebaseFirestore.instance.collection('users').doc('my-id');
    // final json = {
    //   'name': name,arch -x86_64 pod install
    //   'age': 20,
    //   'birthday' : DateTime(2003, 11, 22),
    // };
    // final constructorUser = Users().toJson();
    // await docUser.set(constructorUser);
  }
}

class MemberDTO extends StatelessWidget {
  const MemberDTO({Key? key, required this.name}) : super(key: key);
  final String name;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Text(
            'Name: $name',
            style:
            const TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
          ),
        )
      ],
    );
  }
}
