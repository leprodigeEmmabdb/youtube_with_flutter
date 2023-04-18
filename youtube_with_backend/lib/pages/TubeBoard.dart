import 'package:flutter/material.dart';
import 'package:gestion_fidele/controllers/UserCtrl.dart';
import 'package:gestion_fidele/controllers/YoutubeCtrl.dart';
import 'package:gestion_fidele/controllers/YoutubeCtrl.dart';
import 'package:gestion_fidele/controllers/YoutubeCtrl.dart';

import 'package:gestion_fidele/utils/Constance.dart';
import 'package:provider/provider.dart';

import '../controllers/UserCtrl.dart';
import '../controllers/UserCtrl.dart';
import '../controllers/YoutubeCtrl.dart';
import '../utils/Stockage.dart';

import 'HistoriquePage.dart';
import 'LogiPage.dart';
import 'ProfilPage.dart';

class TubeBoard extends StatefulWidget {
  const TubeBoard({Key? key}) : super(key: key);

  @override
  State<TubeBoard> createState() => _TubeBoardState();
}

class _TubeBoardState extends State<TubeBoard> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var youtubectrl = context.read<YoutubeCtrl>();
      youtubectrl.recupererDataAPI();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _body(),
    );
  }

  AppBar _appBar() {
    //var youtubectrl = context.watch<YoutubeCtrl>();

    return AppBar(
      title: Row(
        children: [
          Icon(Icons.youtube_searched_for),
          Text(
            "YouTube",
            style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
          ),
        ],
      ),
      backgroundColor: Colors.red,
      elevation: 0,
      actions: [
        IconButton(
            onPressed: () {
              var userCtrl = context.read<UserCtrl>();
              userCtrl.stockage?.remove(Stockage.userKey);
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => HistoriquePage()));
            },
            color: Colors.white,
            icon: Tooltip(
                message: 'Historique',
                child: Icon(Icons.access_time_outlined))),
        IconButton(
            onPressed: () {
              var userCtrl = context.read<UserCtrl>();
              userCtrl.stockage?.remove(Stockage.userKey);
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (_) => LoginPage()));
            },
            color: Colors.white,
            icon: Tooltip(
                message: "Se deconnecter",
                child: Icon(Icons.exit_to_app)))
      ],
    );
  }

  Widget _body() {
    Color couleur=Colors.black45;
    var userCtrl = context.watch<UserCtrl>();
    var youtube = context.watch<YoutubeCtrl>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text("Connecté en tant que: ${userCtrl.user?.username}")),

        Expanded(
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: youtube.video.length,
              itemBuilder: (ctx, i) {
                var f = youtube.video[i];



                //var f = FidelModele.fromJson(fidele);

                //  return Text("${f.id}");
                return ListTile(onTap:(){
                  Map data={'action' : 'vous avez lu la video'};
                  youtube.envoieApi(data);
                  Navigator.push(
                      context, MaterialPageRoute(builder: (_) => ProfilPage(video_id: f.id,)));
                } ,
                    title: Text("${f.title}"),
                    subtitle: Text("${f.content}"),
                    trailing: IconButton(
                        onPressed: () {

                          var userCtrl = context.read<UserCtrl>();
                          userCtrl.stockage?.remove(Stockage.userKey);
                          Map data={'action' : 'vous avez telecharger la video'};
                          youtube.envoieApi(data);

                          setState(() {
                            couleur=Colors.red;
                          });
                        },
                        color: couleur,
                    icon: Icon(Icons.add_alert_sharp)),
                    leading:f.video != null ? Image.network(
                        "${Constance.BASE_URL}/${f.video}") : Icon(Icons.error),
                    onLongPress: ()
                {},);
              }),
        ),
      ],
    );
  }
}
