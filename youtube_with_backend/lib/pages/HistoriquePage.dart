import 'package:flutter/material.dart';
import 'package:gestion_fidele/controllers/HistoriqueCtrl.dart';
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

class HistoriquePage extends StatefulWidget {
  const HistoriquePage({Key? key}) : super(key: key);

  @override
  State<HistoriquePage> createState() => _HistoriquePageState();
}

class _HistoriquePageState extends State<HistoriquePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var historiquectrl = context.read<HistoriqueCtrl>();
      historiquectrl.recupererHistApi();
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
    var historiquectrl = context.watch<HistoriqueCtrl>();

    return AppBar(
      title: Row(
        children: [
          Icon(Icons.list_alt),
          Text(
            "Historique(${historiquectrl.historique.length})",
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
                message: 'Historique ',
                child: Icon(Icons.lock_clock))),
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
    var userCtrl = context.watch<UserCtrl>();
    var tube = context.watch<HistoriqueCtrl>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text("Connecté en tant que: ${userCtrl.user?.username}")),

        Expanded(
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: tube.historique.length,
              itemBuilder: (ctx, i) {
                var f = tube.historique[i];


                //var f = FidelModele.fromJson(fidele);

                //  return Text("${f.id}");
                return ListTile(
                  title: Text("${f.action}"),
                  subtitle: Text("${f.id}"),
                  trailing: IconButton(
                      onPressed: () {

                        var userCtrl = context.read<UserCtrl>();
                        userCtrl.stockage?.remove(Stockage.userKey);
                        Map data={'action' : 'vous avez telecharger la video'};
                        tube.envoieApi(data);
                        Navigator.push(
                            context, MaterialPageRoute(builder: (_) => ProfilPage(video_id: f.id,)));
                      },
                      icon: Icon(Icons.download)),
                  leading: Icon(Icons.people),
                  onLongPress: ()
                  {},);
              }),
        ),
      ],
    );
  }
}
