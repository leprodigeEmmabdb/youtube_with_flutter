import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:gestion_fidele/Widget/Chargement.dart';
import 'package:gestion_fidele/controllers/YoutubeCtrl.dart';
import 'package:gestion_fidele/controllers/UserCtrl.dart';
import 'package:gestion_fidele/pages/TubeBoard.dart';
import 'package:provider/provider.dart';

import '../Widget/ChampsSaisie.dart';
import '../Widget/Chargement.dart';
import '../controllers/YoutubeCtrl.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Color fondcolor = Colors.white;

  String message = "";
  bool isVisible = false;
  var formKey = GlobalKey<FormState>();
  var username = TextEditingController();
  var password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: fondcolor,
      body: Stack(
        children: [_body(), Chargement(isVisible)],
      ),
    );
  }

  Widget _body() {
    return Form(
      key: formKey,
      child: Center(
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _iconApp(),
                Text("Authentification",
                    style:
                    TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                SizedBox(
                  height: 20,
                ),
                ChampSaisie(ctrl: username,
                    label: "utilisateur",
                    required: true,
                    isPassword: false),
                SizedBox(
                  height: 20,
                ),
                ChampSaisie(ctrl: password,
                    label: "Mot de passe",
                    required: true,
                    isPassword: true),
                SizedBox(
                  height: 20,
                ),
                _buttonWidget(),
                Text(
                  message,
                  style: TextStyle(color: Colors.red),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }


  Widget _iconApp() {
    return Icon(Icons.account_circle_outlined,size: 56,color: Colors.red,);
  }


  Widget _buttonWidget() {
    return Container(
      width: double.infinity,
      child: ElevatedButton(

        onPressed: () async {
          FocusScope.of(context).requestFocus(new FocusNode());
          if (formKey.currentState?.validate()!=true) {
            return;
          }
          isVisible=true;
          setState((){});
          var ctr= context.read<UserCtrl>();
          Map donneesAEnvoyer={"username":username.text};
          bool status=await ctr.authenfierUser(donneesAEnvoyer);
          await Future.delayed(Duration(seconds: 2));
          message="Succes";
          isVisible=false;
          setState((){});
          if(!status){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>TubeBoard()));
          }
        },
        child: Text("Connexion"),
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16))),
      ),
    );
  }

}
