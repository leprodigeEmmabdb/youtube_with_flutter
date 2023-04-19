import 'package:flutter/material.dart';
import 'package:gestion_fidele/controllers/YoutubeCtrl.dart';
import 'package:gestion_fidele/pages/HistoriquePage.dart';
import 'package:gestion_fidele/pages/TubeBoard.dart';
import 'package:gestion_fidele/pages/LogiPage.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';

import '../controllers/HistoriqueCtrl.dart';
import '../controllers/UserCtrl.dart';
import '../utils/Stockage.dart';

class MonApplication extends StatelessWidget {
  var box = GetStorage();

  @override
  Widget build(BuildContext context) {
    var user = box.read<Map>(Stockage.userKey);
    print(user);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HistoriqueCtrl(stockage: box)),
        ChangeNotifierProvider(create: (_) => UserCtrl(stockage: box)),
        ChangeNotifierProvider(create: (_) => YoutubeCtrl()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: user != null ? TubeBoard() : TubeBoard(),
      ),
    );
  }
}

