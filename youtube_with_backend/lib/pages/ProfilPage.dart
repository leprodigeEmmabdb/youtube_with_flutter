import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:gestion_fidele/Widget/Chargement.dart';
import 'package:gestion_fidele/controllers/YoutubeCtrl.dart';
import 'package:gestion_fidele/controllers/UserCtrl.dart';
import 'package:gestion_fidele/pages/TubeBoard.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import '../Widget/ChampsSaisie.dart';
import '../Widget/Chargement.dart';
import '../controllers/YoutubeCtrl.dart';
import '../utils/Constance.dart';

class ProfilPage extends StatefulWidget {
  int? video_id;
  @override
  State<ProfilPage> createState() => _LoginPageState();
  ProfilPage({this.video_id});
}

class _LoginPageState extends State<ProfilPage> {
  Color fondcolor = Colors.white;

  String message = "";
  bool isVisible = false;
  var formKey = GlobalKey<FormState>();
  var tubedesc = TextEditingController();
  var password = TextEditingController();
  var tubetitle = TextEditingController();
  var age = TextEditingController();
  var image = TextEditingController();
  final ImagePicker picker = ImagePicker();
  XFile? imageSelectionner;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var fideleCtrl = context.read<YoutubeCtrl>();
      var data=fideleCtrl.recupererDataAPI();
      var fidele=fideleCtrl.video.where((f) => f.id ==widget.video_id ).toList();
      if(fidele.length!=0){
        var tmp=fidele[0];
        tubetitle = TextEditingController(text: tmp.title);
        tubedesc = TextEditingController(text: tmp.content);
        image = TextEditingController(text: tmp.video);
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
        title: Text("Profil"),
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
              mainAxisAlignment: MainAxisAlignment.end,
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
                      Text(" ${tubedesc.text} ${tubetitle.text} ",style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black
                      ),),
                      Text("${tubetitle.text}",
                          style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 15,color: Colors.black45)),
                    ],
                  ),

                ),
                _add(),
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
    return Image.network("${Constance.BASE_URL}/${image.text}");
  }
  Widget _add(){
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
  }
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
    print(tubetitle.text);
    print(tubetitle.text);
    print(tubetitle.text);
    FocusScope.of(context).requestFocus(new FocusNode());

    if(formKey.currentState?.validate()!=true){
      return;
    }

    Map dataAenvoyer={
      "Nom":tubetitle.text,
      "Prenom":tubedesc.text,
      "Age":int.parse(age.text),
      "Image":"",
    };


  }

}