import 'package:bookme/pages/About.dart';
import 'package:bookme/pages/LockStudent.dart';
import 'package:bookme/pages/homePage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:bookme/pages/SignIn.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:dropdownfield/dropdownfield.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flow_builder/flow_builder.dart';

class AvailablePage extends StatefulWidget {
  AvailablePage({Key key}) : super(key: key);

  @override
  _AvailableState createState() => _AvailableState();
}

class _AvailableState extends State<AvailablePage> {
  final _auth = FirebaseAuth.instance;
  dynamic user;
  String RoomID;
  @override
  Widget build(BuildContext context) {
    @override
    String userEmail;
    void getCurrentUserInfo() async {
      user = _auth.currentUser;
      userEmail = user.email;
    }

    getCurrentUserInfo();
    String strWithDig = userEmail;
    String ID0 = strWithDig.replaceAll(RegExp(r'[@est.intec.edu.do]'), '');
    var ID1 = ID0.toString();
    print(ID1);

    bool selected = false;
    Query<Map<String, dynamic>> room = FirebaseFirestore.instance
        .collection("bookroom")
        .where('Show', isEqualTo: 'True');
    Query<Map<String, dynamic>> confirmedreservation = FirebaseFirestore.instance.collection("bookroom").where('1er ID', isEqualTo: ID1);
    const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics());

    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        title: Text("INTEC", style: TextStyle(color: Color(0XFFd90429), fontWeight: FontWeight.bold),),
        automaticallyImplyLeading: false,
        elevation: 0.0,
        //shadowColor: Colors.white,
        backgroundColor: Colors.white,
        actions: [
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DetailPage()),
                  );
                },
                child: Icon(
                  Icons.info_outline,
                  size: 26.0,
                  color: Color(0XFFd90429),
                ),
              )
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () { Navigator.push(context, MaterialPageRoute(builder: (context) => IhaveReservation()),);},
        child: Icon(Icons.bookmark, color: Color(0XFFd90429), size: 29,),
        backgroundColor: Colors.white,
        tooltip: 'Capture Picture',
        elevation: 5,
        splashColor: Colors.grey,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                text: ' Reservaciones',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 45,
                    color: Colors.black),
                children: <TextSpan>[
                  TextSpan(
                      text: '.',
                      style: TextStyle(
                          color: Color(0XFFd90429), fontWeight: FontWeight.bold)),
                  //TextSpan(text: ' world!'),
                ],
              ),
            ),
            Container(

              height: (MediaQuery.of(context).size.height),
              width: (MediaQuery.of(context).size.width),

              child: StreamBuilder(
                stream: room.snapshots(),
                //Query query = citiesRef.whereEqualTo("state", "CA");
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {

                  if (!snapshot.hasData) {
                    return CircularProgressIndicator();
                  } else {return Padding(
                        padding: const EdgeInsets.fromLTRB(0.0, 4.0, 0.0, 50.0),
                        child: ListView(
                            physics: const AlwaysScrollableScrollPhysics(),
                            //physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                            children: snapshot.data.docs.map((room) {
                              return Center(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 5.0, horizontal: 20.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                            //color: Colors.white,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20.0)),
                                            boxShadow: [
                                              BoxShadow(
                                                  blurRadius: 3.0,
                                                  color: Colors.grey[100])
                                            ]),
                                        child: Card(
                                          shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(50),),
                                          elevation: 10,
                                          child: ListTile(
                                            trailing: Icon(
                                                Icons.arrow_back_ios_outlined, color: Color(0XFFd90429),),
                                            leading: GestureDetector(
                                              onTap: () {
                                                RoomID =
                                                    room.reference.toString();
                                                DocumentReference docRef =
                                                    FirebaseFirestore.instance
                                                        .collection("bookroom")
                                                        .doc(RoomID);
                                                String Level = docRef.id;
                                                //print(RoomID + ' ' + Level);
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            HomePage(
                                                                Level: Level)));
                                              },
                                              child: Container(
                                                width: 48,
                                                height: 48,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 4.0),
                                                alignment: Alignment.center,
                                                child: const Icon(
                                                    Icons.bookmarks_outlined, color: Color(0XFFd90429)),
                                              ),
                                            ),
                                            subtitle: Text(
                                                'Pizarra' +
                                                    ': ' +
                                                    room['Pizarra'],
                                                textScaleFactor: 1.5),
                                            title: Text(
                                              room['Inicia'],
                                              textScaleFactor: 1.5,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black),
                                            ),
                                            onTap: () {
                                              RoomID = room.reference.toString();
                                              DocumentReference docRef =
                                                  FirebaseFirestore.instance
                                                      .collection("bookroom")
                                                      .doc(RoomID);
                                              String Level = docRef.id;
                                              print(RoomID + ' ' + Level);
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          HomePage(
                                                              Level: Level)));
                                            },
                                          ),
                                        ),

                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                      );}

                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
