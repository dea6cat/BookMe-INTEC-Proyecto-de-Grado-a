import 'package:bookme/authentication_service/authentication_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text("INTEC", style: TextStyle(color: Color(0XFFd90429), fontWeight: FontWeight.bold),),
          automaticallyImplyLeading: false,
          elevation: 0.0,
          //shadowColor: Colors.white,
          backgroundColor: Colors.white,

        ),
        backgroundColor: Color(0XFFFFFFFF),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              children: [
                //SizedBox(height: 10,),
                Container(
                  //padding: EdgeInsets.symmetric(vertical: 10.0),
                  child: Image(image: AssetImage('assets/eastwood-school-desk.png'),)
                ),
                Container(
                  padding: EdgeInsets.symmetric( vertical: 4.0),
                  child: Text('Bienvenido',

                    style: TextStyle(
                      wordSpacing: 0.0,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Color(0XFF000000),
                    ),),
                ),
                SizedBox(
                  height: 6,
                ),

                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelStyle: TextStyle(fontSize: 18),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                    hintText: 'ID@est.intec.edu.do',
                    labelText: "Correo Electrónico",
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                TextField(
                  controller: passwordController,
                  enableSuggestions: false,
                  autocorrect: false,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelStyle: TextStyle(fontSize: 18),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                    hintText: '9230jd290jd2hd',
                    labelText: "Contraseña",
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 16, horizontal: 30.0),
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: const Color(0XFFE30425),
                      borderRadius: BorderRadius.circular(30)),
                  child: FlatButton(
                    onPressed: (){
                      String strWithDig = emailController.text;
                      String ID0 = strWithDig.replaceAll(RegExp(r'[@est.intec.edu.do]'), '');
                      Map <String,dynamic> data = {"ID": ID0.trim(),
                      "eMail" : emailController.text };
                      FirebaseFirestore.instance.collection("StudentsU").doc(ID0).update(data);
                      context.read<AuthenticationService>().signIn(
                          email: emailController.text.trim(),
                      password: passwordController.text.trim());
                    },
                    child: Text(
                      'Iniciar sesión',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Container(
                  //margin: EdgeInsets.symmetric(vertical: 9, horizontal: 20.0),
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: const Color(0XFFFFFFF),
                      borderRadius: BorderRadius.circular(30)
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
