

import 'dart:async';


import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:bookme/pages/About.dart';
import 'package:bookme/pages/available.dart';
import 'package:bookme/pages/homePage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:bookme/pages/SignIn.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:dropdownfield/dropdownfield.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flow_builder/flow_builder.dart';

class IhaveReservation extends StatefulWidget {
  IhaveReservation({Key key}) : super(key: key);

  @override
  _IhaveReservation createState() => _IhaveReservation();

}

class _IhaveReservation extends State<IhaveReservation>{

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
    String ID0 = strWithDig.replaceAll(
        RegExp(r'[@est.intec.edu.do]'), '');
    var ID1 = ID0.toString();
    print(ID1);

    Query<Map<String, dynamic>> room = FirebaseFirestore.instance.collection("bookroom").where('1er ID', isEqualTo: ID1).limit(1);
    Query<Map<String, dynamic>> bookdel = FirebaseFirestore.instance.collection("bookroom").where('1er ID', isEqualTo: ID1);


    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {

            Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (context) =>
                      AvailablePage())); },

          child: Icon(
            Icons.clear, size: 26.0, color: Color(0XFFd90429), // add custom icons also
          ),
        ),

        title: Text("INTEC", style: TextStyle(color: Color(0XFFd90429), fontWeight: FontWeight.bold),),

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
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            RichText(
            text: TextSpan(
              text: 'Tu reservación',
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
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  //
                          if (!snapshot.hasData) {
                            return Center(child: CircularProgressIndicator());
                        } else {
                            return  ListView(
                              children: snapshot.data.docs.map((room){
                                return Center(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 5.0, horizontal: 20.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [

                                        Container(
                                          //height: (MediaQuery.of(context).size.height),
                                          width: (MediaQuery.of(context).size.width),
                                          decoration: BoxDecoration(
                                            //color: Colors.white,
                                              borderRadius:
                                              BorderRadius.all(Radius.circular(20.0)),
                                              boxShadow: [
                                                BoxShadow(blurRadius: 3.0, color: Colors.grey[100])
                                              ]),
                                          child: Card(
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(50),),
                                            elevation: 10,
                                            child: Container(
                                              child: ListTile(
                                                trailing: Icon(Icons.arrow_back_ios_outlined,color: Color(0XFFd90429)),
                                                leading: GestureDetector(
                                                  onTap: () {
                                                  },
                                                  child: Container(

                                                    width: 90.0,
                                                    height: 100.0,
                                                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                                                    alignment: Alignment.center,
                                                    child: const Icon(Icons.bookmarks, color: Color(0XFFd90429)),
                                                  ),
                                                ),
                                                subtitle: Text('Pizarra'+': '+ room['Pizarra'],textScaleFactor: 1.5,) ,
                                                title: Text(room['Inicia'], textScaleFactor: 1.5,),
                                                onTap: (){

                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );}).toList(),
                            );
                        }
                },
              ),
            ),
          ],
        ),
      ),
    );


  }
}

