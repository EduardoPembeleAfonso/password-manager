import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Firebase CRUD App',
      home: DisplayDataScreen(),
    );
  }
}
// creating UI that will gather data and send it to firestore with means performing Flutter Firebase CRUD operations 
class DisplayDataScreen extends StatefulWidget {
  DisplayDataScreen({Key? key}) : super(key: key);
  @override
  State<DisplayDataScreen> createState() => _DisplayDataScreenState();
}
class _DisplayDataScreenState extends State<DisplayDataScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => SendOrUpdateData()));
          },
          backgroundColor: Colors.red.shade900,
          child: Icon(Icons.add)),
      appBar: AppBar(
        backgroundColor: Colors.red.shade900,
        centerTitle: true,
        title: Text(
          'Home',
          style: TextStyle(fontWeight: FontWeight.w300),
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          return streamSnapshot.hasData
              ? ListView.builder(
                  padding: EdgeInsets.symmetric(vertical: 41),
                  itemCount: streamSnapshot.data!.docs.length,
                  itemBuilder: ((context, index) {
                    return Container(
                        margin: EdgeInsets.symmetric(horizontal: 20)
                            .copyWith(bottom: 10),
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        decoration:
                            BoxDecoration(color: Colors.white, boxShadow: [
                          BoxShadow(
                              color: Colors.grey.shade300,
                              blurRadius: 5,
                              spreadRadius: 1,
                              offset: Offset(2, 2))
                        ]),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.person,
                                  size: 31,
                                  color: Colors.red.shade300,
                                ),
                                SizedBox(width: 11),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      streamSnapshot.data!.docs[index]['name'],
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      streamSnapshot.data!.docs[index]['age']
                                          .toString(),
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w300),
                                    ),
                                    Text(
                                      streamSnapshot.data!.docs[index]['email'],
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                SendOrUpdateData(
                                                  name: streamSnapshot.data!
                                                      .docs[index]['name'],
                                                  age: streamSnapshot
                                                      .data!.docs[index]['age']
                                                      .toString(),
                                                  email: streamSnapshot.data!
                                                      .docs[index]['email'],
                                                  id: streamSnapshot
                                                      .data!.docs[index]['id'],
                                                )));
                                  },
                                  child: Icon(
                                    Icons.edit,
                                    color: Colors.blue,
                                    size: 21,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    final docData = FirebaseFirestore.instance
                                        .collection('users')
                                        .doc(streamSnapshot.data!.docs[index]
                                            ['id']);
                                    await docData.delete();
                                  },
                                  child: Icon(
                                    Icons.delete,
                                    color: Colors.red.shade900,
                                    size: 21,
                                  ),
                                )
                              ],
                            ),
                          ],
                        ));
                  }))
              : Center(
                  child: SizedBox(
                      height: 100,
                      width: 100,
                      child: CircularProgressIndicator()),
                );
        },
      ),
    );
  }
}
class SendOrUpdateData extends StatefulWidget {
  final String name;
  final String age;
  final String email;
  final String id;
  const SendOrUpdateData(
      {this.name = '', this.age = '', this.email = '', this.id = ''});
  @override
  State<SendOrUpdateData> createState() => _SendOrUpdateDataState();
}
class _SendOrUpdateDataState extends State<SendOrUpdateData> {
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  bool showProgressIndicator = false;

  @override
  void initState() {
    nameController.text = widget.name;
    ageController.text = widget.age;
    emailController.text = widget.email;
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    ageController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red.shade900,
        centerTitle: true,
        title: Text(
          'Send Data',
          style: TextStyle(fontWeight: FontWeight.w300),
        ),
      ),
      body: SingleChildScrollView(
        padding:
            EdgeInsets.symmetric(horizontal: 20).copyWith(top: 60, bottom: 200),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Name',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            TextField(
              controller: nameController,
              decoration: InputDecoration(hintText: 'e.g. Zeeshan'),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Age',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            TextField(
              controller: ageController,
              decoration: InputDecoration(hintText: 'e.g. 25'),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Email Address',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            TextField(
              controller: emailController,
              decoration:
                  InputDecoration(hintText: 'e.g. zeerockyf5@gmail.com'),
            ),
            SizedBox(
              height: 40,
            ),
            MaterialButton(
              onPressed: () async {
                setState(() {});
                if (nameController.text.isEmpty ||
                    ageController.text.isEmpty ||
                    emailController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Fill in all fields')));
                } else {
                  //reference to document
                  final dUser = FirebaseFirestore.instance
                      .collection('users')
                      .doc(widget.id.isNotEmpty ? widget.id : null);
                  String docID = '';
                  if (widget.id.isNotEmpty) {
                    docID = widget.id;
                  } else {
                    docID = dUser.id;
                  }
                  final jsonData = {
                    'name': nameController.text,
                    'age': int.parse(ageController.text),
                    'email': emailController.text,
                    'id': docID
                  };
                  showProgressIndicator = true;
                  if (widget.id.isEmpty) {
                  //create document and write data to firebase
                    await dUser.set(jsonData).then((value) {
                      nameController.text = '';
                      ageController.text = '';
                      emailController.text = '';
                      showProgressIndicator = false;
                      setState(() {});
                    });
                  } else {
                    await dUser.update(jsonData).then((value) {
                      nameController.text = '';
                      ageController.text = '';
                      emailController.text = '';
                      showProgressIndicator = false;
                      setState(() {});
                    });
                  }
                }
              },
              minWidth: double.infinity,
              height: 50,
              color: Colors.red.shade400,
              child: showProgressIndicator
                  ? CircularProgressIndicator(
                      color: Colors.white,
                    )
                  : Text(
                      'Submit',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w300),
                    ),
            )
          ],
        ),
      ),
    );
  }
}