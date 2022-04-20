

import 'dart:async';



import 'package:bookme/pages/About.dart';
import 'package:bookme/pages/LockStudent.dart';
import 'package:bookme/pages/available.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:bookme/pages/SignIn.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:core';
import 'package:dropdownfield/dropdownfield.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flow_builder/flow_builder.dart';

class HomePage extends StatelessWidget {
  String Level;
  HomePage({this.Level});
  final _auth = FirebaseAuth.instance;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController ID = new TextEditingController();
  TextEditingController StudentName = new TextEditingController();
  TextEditingController Time = new TextEditingController();
  String RoomID;
  CollectionReference room = FirebaseFirestore.instance.collection("bookroom");

  final List<String> board = ['Si', 'No'];
  final List<String> amountP = ['2', '3', '4', '5', '6'];
  final List<String> Duration = ['1 Hr', '2 Hrs'];
  final List<String> HoM = ['Hoy', 'Mañana'];
  //DateTime dateToday = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  DateTime now = DateTime.now();
  String selectedHr;
  String selectedboard;
  String Amount_People;
  String selectedduration;
  String userEmail;
  dynamic user;
  String userPhoneNumber;
  String Name;
  String selectedDate;
  final _formKey = GlobalKey<FormState>();

  set subscription(StreamSubscription<QuerySnapshot<Map<String, dynamic>>> subscription) {}
  void getCurrentUserInfo() async {
    user = await _auth.currentUser;
    userEmail = user.email;
    userPhoneNumber = user.phoneNumber;
  }


  @override
  Widget build(BuildContext context) {
    getCurrentUserInfo();
    return Scaffold(
        backgroundColor: Colors.white,
        key: scaffoldKey,
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



        body: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Column(
            children: [
              Container(
                  //padding: EdgeInsets.symmetric(vertical: 10.0),
                  child: Image(
                image: AssetImage('assets/payment-processed-2.png'),
              )),
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.fromLTRB(30.0,0.0,30.0,0.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: ID,
                        decoration: InputDecoration(

                          labelStyle: TextStyle(fontSize: 18),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30)),
                          hintText: '1072222',
                          labelText: "ID",
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value.isNotEmpty && value.length>=7){
                            return null;
                          } else if (value.length < 7 && value.isNotEmpty){
                            return 'Su ID no es válida';
                          }else{
                            return 'Su ID no es válida';
                          }
                        },
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      TextFormField(
                        controller: StudentName,
                        decoration: InputDecoration(
                          labelStyle: TextStyle(fontSize: 18),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30)),
                          hintText: 'Nombre',
                          labelText: "Nombre",
                        ),
                        validator: (value) {
                          if (value.isNotEmpty && value.length>=1){
                            return null;
                          } else if (value.length < 1 && value.isNotEmpty){
                            return 'proper ID pls';
                          }else{
                            return 'Introduce un nombre';
                          }
                        },
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      DropdownButtonFormField(
                        isDense: true,
                        items: HoM.map((String Today_tomorrow) {
                          return DropdownMenuItem(
                              value: Today_tomorrow,
                              child: Text(
                                Today_tomorrow,
                                style:
                                    TextStyle(color: Colors.black, fontSize: 14),
                              ));
                        }).toList(),
                        style: TextStyle(fontSize: 18),
                        decoration: InputDecoration(
                            labelText: 'Hoy o Mañana',
                            labelStyle: TextStyle(fontSize: 17),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30))),
                        validator: (input) => selectedDate == null
                            ? "Please Select a priority level"
                            : null,
                        onChanged: (value) {
                            selectedDate = value;
                        },
                      ),
                      //Divider(height: 10.0, color: Theme.of(context).primaryColor),
                      SizedBox(
                        height: 10,
                      ),

                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.only(left: 5),
                              width: 150,
                              //padding: EdgeInsets.only(left: 12),
                              //alignment: Alignment.centerLeft,
                              child: DropdownButtonFormField(
                                isDense: true,
                                items: amountP.map((String AmountOfPeople) {
                                  return DropdownMenuItem(
                                      value: AmountOfPeople,
                                      child: Text(
                                        AmountOfPeople,
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 14),
                                      ));
                                }).toList(),
                                style: TextStyle(fontSize: 18),
                                decoration: InputDecoration(
                                    labelText: 'Cantidad',
                                    labelStyle: TextStyle(fontSize: 17),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30))),
                                validator: (input) => Amount_People == null
                                    ? "Please Select a priority level"
                                    : null,
                                onChanged: (value) {

                                    Amount_People = value;

                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.only(right: 5),
                              width: 150,
                              //padding: EdgeInsets.only(left: 12),
                              //alignment: Alignment.centerLeft,
                              child: DropdownButtonFormField(
                                isDense: true,
                                items: Duration.map((String select_Time) {
                                  return DropdownMenuItem(
                                      value: select_Time,
                                      child: Text(
                                        select_Time,
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 14),
                                      ));
                                }).toList(),
                                style: TextStyle(fontSize: 18),
                                decoration: InputDecoration(
                                    labelText: 'Durancion',
                                    labelStyle: TextStyle(fontSize: 17),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30))),
                                validator: (input) => selectedduration == null
                                    ? "Please Select a priority level"
                                    : null,
                                onChanged: (value) {
                                    selectedduration = value;

                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.all(16.0),
                          primary: Color(0XFFd90429),
                          textStyle: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        onPressed: () async {
                          if (!_formKey.currentState.validate() ) {
                            // If the form is valid, display a snackbar. In the real world,
                            // you'd often call a server or save the information in a database.
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Falta información clave en el formulario o sus datos son incorrectos')));
                            }else{
                            String strWithDig = userEmail;
                            String ID0 = strWithDig.replaceAll(
                                RegExp(r'[@est.intec.edu.do]'), '');
                            String him = ID.text;


                            final QuerySnapshot result =
                            await FirebaseFirestore.instance.collection('bookroom').where('1er ID', isEqualTo:
                            ID0).get();

                            final List < DocumentSnapshot > documents = result.docs;
                            final QuerySnapshot result2 =
                            await FirebaseFirestore.instance.collection('bookroom').where('2do ID', isEqualTo:
                            him).get();

                            final List < DocumentSnapshot > dox = result2.docs;

                            if (documents.length > 0) {
                              showDialog(context: context, builder: (BuildContext context) {
                              return AlertDialog(
                              title: const Text('Atencion'),
                              content: const Text('Ya tienes una reservación.'),
                              actions: <Widget>[

                              TextButton(
                              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => AvailablePage()),),
                              child: const Text('OK', style: TextStyle(fontSize: 18),),
                              ),
                              ],
                              );});
                              //Navigator.push(context, MaterialPageRoute(builder: (context) => AvailablePage()),);
                              //ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Tú o tu acompañante ya tienen una reservación.')));
                              return true;

                              //exists
                              }else if (dox.length > 0){
                              showDialog(context: context, builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('Lo sentimos por los inconvenientes'),
                                  content: const Text('tu acompañante ya tiene una reservación.'),
                                  actions: <Widget>[

                                    TextButton(
                                      onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => AvailablePage()),),
                                      child: const Text('OK', style: TextStyle(fontSize: 18),),
                                    ),
                                  ],
                                );});
                              //Navigator.push(context, MaterialPageRoute(builder: (context) => AvailablePage()),);
                              //ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Tú o tu acompañante ya tienen una reservación.')));
                              return true;

                            } else {

                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Te Esperamos')));
                              DocumentSnapshot<Map<String, dynamic>> ds = await FirebaseFirestore.instance.collection('StudentsU').doc(ID0).get();
                              String studentname = ds['StudentName'];
                              //print(studentname);
                              Map<String, dynamic> data = {
                                "1er ID": ID0,
                                "1do Estudiante":studentname,
                                "2do ID": ID.text,
                                "2do Estudiante": StudentName.text,
                                "Origen": now,
                                "Cantidad de Personas": Amount_People,
                                "Duracion": selectedduration,
                                "Dia": selectedDate,
                                "Show":"False",
                              };

                              String Level0 = Level.replaceAll(
                                  RegExp(r'[)]'), '');
                              FirebaseFirestore.instance
                                  .collection("bookroom")
                                  .doc(Level0)
                                  .update(data);

                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => IhaveReservation()),
                              );
                              //not exists
                            }

                           // print(roomsearch.toString());

                            //for (var i = 0; i < l.length; i++){ DocumentSnapshot<Map<String, dynamic>> roomsearch = await FirebaseFirestore.instance.collection("bookroom").doc(PP).get();print(roomsearch);print('^');}

                            //Stream<QuerySnapshot<Map<String, dynamic>>> you = roomsearch.snapshots();



                          }
                        },
                        child: const Text('Reservar'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
