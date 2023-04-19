import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:gestion_fidele/Widget/Chargement.dart';
import 'package:gestion_fidele/controllers/YoutubeCtrl.dart';
import 'package:gestion_fidele/controllers/UserCtrl.dart';
import 'package:gestion_fidele/models/Youtube.dart';
import 'package:gestion_fidele/pages/TubeBoard.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import '../Widget/ChampsSaisie.dart';
import '../Widget/Chargement.dart';
import '../controllers/YoutubeCtrl.dart';
import '../utils/Constance.dart';

class DetailPage extends StatefulWidget {
  int? video_id;
  @override
  State<DetailPage> createState() => _LoginPageState();
  DetailPage({this.video_id});
}

class _LoginPageState extends State<DetailPage> {
  YoutubeModele? videoSelect;
  Color fondcolor = Colors.white;

  String message = "";
  bool isVisible = false;
  var formKey = GlobalKey<FormState>();
  final ImagePicker picker = ImagePicker();
  XFile? imageSelectionner;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var youtubectrl = context.read<YoutubeCtrl>();
      var data=youtubectrl.recupererDataAPI();
      var select=youtubectrl.video.where((f) => f.id ==widget.video_id ).toList();
      if(select.length!=0){
        videoSelect=select[0];
        setState(() {

        });
      }

    });


  }

  @override
  Widget build(BuildContext context) {

    var fideleCtrl = context.watch<YoutubeCtrl>();
    var userCtrl = context.read<UserCtrl>();
    return Scaffold(
      appBar: AppBar(
        title: Text("Video"),
        backgroundColor: Colors.red,
      ),
      backgroundColor: fondcolor,
      body: Stack(
        children: [_body(), Chargement(isVisible)],
      ),
    );
  }

  Widget _body() {
    var youtubectrl = context.watch<YoutubeCtrl>();
    return Form(
      key: formKey,
      child: Center(
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _iconApp(),
                SizedBox(
                  height: 10,
                ),
                Text("Video",
                    style:
                    TextStyle(fontWeight: FontWeight.bold, fontSize: 20,color: Colors.black54)),
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: Column(
                    children: [
                      Text(" ${videoSelect?.title} ${videoSelect?.content} ",style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black
                      ),),
                      Text("${videoSelect?.title}",
                          style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 15,color: Colors.black45)),
                    ],
                  ),

                ),
                //_add(),
                SizedBox(
                  height: 20,
                ),

                SizedBox(
                  height: 20,
                ),

                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _iconApp() {
    return Image.network("${Constance.BASE_URL}/${videoSelect?.video}",width: double.infinity,);
  }
  /*Widget _add(){
    var fideleCtrl = context.watch<YoutubeCtrl>();
    return Container(child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (_)=>TubeBoard()));
          },
          icon: Tooltip(
              message: "Télécharger",
              child: Icon(Icons.download)),
        ),
        IconButton(
          onPressed: (){},
          icon: Tooltip(
              message: "Ajouter",
              child: Icon(Icons.add_business)),
        )
      ],
    ));
  }*/
  Widget _buttonWidget(BuildContext ctx) {
    return Container(
      width: 500,
      height: 50,
      child: ElevatedButton(
        onPressed: _validateFormulaire,
        child: Text(widget.video_id==null? "Créer": "Modifier"),
        style: ElevatedButton.styleFrom(
            primary: Colors.red,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16))),
      ),
    );
  }

//Widget _textError() {
//return Text(errorMsg, style: TextStyle(color: Colors.red, fontSize: 16));
//}

  void _validateFormulaire () async {

    FocusScope.of(context).requestFocus(new FocusNode());

    if(formKey.currentState?.validate()!=true){
      return;
    }

    // Map dataAenvoyer={
    //   "Nom":tubetitle.text,
    //   "Prenom":tubedesc.text,
    //   "Age":int.parse(age.text),
    //   "Image":"",
    // };


  }

}