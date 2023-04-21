import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:gestion_fidele/models/Historique.dart';
import 'package:gestion_fidele/utils/Constance.dart';
import 'package:gestion_fidele/utils/Stockage.dart';
import 'package:gestion_fidele/utils/requetes.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../models/Youtube.dart';
import '../utils/Constance.dart';

class YoutubeCtrl with ChangeNotifier {
  List<YoutubeModele> video = [];
  List<YoutubeModele> historique = [];
  bool loading = false;
  GetStorage? stockage;
  YoutubeCtrl({this.stockage});


  Future<bool> sendHistoriqueData(Map data) async {

    var url = "${Constance.BASE_URL}${Constance.histopriqueEndpoint}";
    var reponse = await postData(url, data);
    if (reponse != null) {
      return true;
    }
    return false;
  }



  void getVideoFromServer() async {
    var url = "${Constance.BASE_URL}${Constance.videoEndpoint}";
    loading = true;
    notifyListeners();
    var reponse = await getData(url);
    if (reponse != null) {

      List<YoutubeModele> tmp = reponse
          .map<YoutubeModele>((data) => YoutubeModele.fromJson(data))
          .toList();
      video = tmp;


      stockage?.write(Stockage.videokey, reponse);
      notifyListeners();
    }
    else{
      var dataStockee=stockage?.read(Stockage.videokey) ;
      var tmp=dataStockee.map<YoutubeModele>((e)=> YoutubeModele.fromJson(e)).toList();
      video = tmp;
    }
    loading=false;
    notifyListeners();
  }
  void recupererHistApi() async{
    var url = "${Constance.BASE_URL}${Constance.listhistoriqueEndpoint}";
    loading = true;
    notifyListeners();
    var reponse = await getData(url);
    if (reponse != null) {

      List<YoutubeModele> tmp = reponse
          .map<Historique>((data) => Historique.fromJson(data))
          .toList();
      historique = tmp;
      stockage?.write(Stockage.videokey, reponse);
      notifyListeners();
    }
    else{
      var dataStockee=stockage?.read(Stockage.videokey) ;
      var tmp=dataStockee.map<Historique>((e)=> Historique.fromJson(e)).toList();
      historique = tmp;

    }
    loading=false;
    notifyListeners();
}

// void main() {
//   var f = YoutubeCtrl();
//   f.recupererDataAPI();
// }

}
