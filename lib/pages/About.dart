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
import 'package:bookme/authentication_service/authentication_service.dart';



class DetailPage extends StatelessWidget {

  final _auth = FirebaseAuth.instance;
  @override


  Widget build(BuildContext context) {
    final levelIndicator = Container(
      child: Container(
        child: LinearProgressIndicator(
            backgroundColor: Color(0XFFd90429)),

      ),
    );

    final coursePrice = Container(
      padding: const EdgeInsets.all(7.0),
      decoration: new BoxDecoration(
          border: new Border.all(color: Color(0XFFd90429)),
          borderRadius: BorderRadius.circular(5.0)),
      child:Container()
    );

    final topContentText = Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        SizedBox(height: 120.0),
        Icon(
          Icons.info,
          color: Colors.white,
          size: 60.0,
        ),
        Container(
          width: 90.0,

        ),
        SizedBox(height: 10.0),
        Text("Información",
          style: TextStyle(color: Colors.white, fontSize: 45.0),
        ),
        SizedBox(height: 30.0),

      ],
    );

    final topContent = Stack(
      children: <Widget>[
        Container(
            padding: EdgeInsets.only(left: 10.0),
            height: MediaQuery.of(context).size.height * 0.5,
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: new AssetImage("drive-steering-wheel.jpg"),
                fit: BoxFit.cover,
              ),
            )),
        Container(
          height: MediaQuery.of(context).size.height * 0.5,
          padding: EdgeInsets.all(40.0),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(color: Color(0XFFd90429)),
          child: Center(
            child: topContentText,
          ),
        ),
        Positioned(
          left: 8.0,
          top: 60.0,
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back, color: Colors.white),
          ),
        )
      ],
    );

    final bottomContentText = Text(
     "Esta aplicación fue creada para que puedas hacer tus reservación a tiempo desde donde estés.",
      style: TextStyle(fontSize: 18.0),
    );
    final readButton = Container(
        padding: EdgeInsets.symmetric(vertical: 16.0),
        width: MediaQuery.of(context).size.width,
        // ignore: deprecated_member_use
        child: RaisedButton(
          onPressed: () => { AuthenticationService(_auth).signOut(),
            Navigator.of(context).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false) },
          color: Color.fromRGBO(58, 66, 86, 1.0),
          child:
          Text("cerrar sesión", style: TextStyle(color: Colors.white)),
        ));
    final bottomContent = Container(
      // height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      // color: Theme.of(context).primaryColor,
      padding: EdgeInsets.all(40.0),
      child: Center(
        child: Column(
          children: <Widget>[bottomContentText, readButton],
        ),
      ),
    );

    return Scaffold(
      body: Column(
        children: <Widget>[topContent, bottomContent],
      ),
    );
  }
}