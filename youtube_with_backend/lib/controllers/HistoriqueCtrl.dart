import 'dart:convert';
import 'dart:ffi';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:gestion_fidele/models/Historique.dart';
import 'package:gestion_fidele/utils/Constance.dart';
import 'package:gestion_fidele/utils/Stockage.dart';
import 'package:gestion_fidele/utils/requetes.dart';
import 'package:get_storage/get_storage.dart';


import '../models/Youtube.dart';
import '../utils/Constance.dart';

class HistoriqueCtrl with ChangeNotifier {
  List<Historique> historique = [];
  bool loading = false;
  GetStorage? stockage;
  HistoriqueCtrl({this.stockage});

  Future<bool> sendDataToServer(Map data) async {
    var url = "${Constance.BASE_URL}${Constance.histopriqueEndpoint}";
    var response = await postData(url, data).timeout(Duration(seconds: 3));

    if (response.statusCode == 200) {
      Map bodymap = json.decode(response.body);

      return true;
    }
    return false;
  }
  void getDataFromServer() async{
    var url = "${Constance.BASE_URL}${Constance.listhistoriqueEndpoint}";
    loading = true;
    notifyListeners();
    var reponse = await getData(url);

    if (reponse != null) {
      List<Historique> tmp = reponse
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
  void handleDetelePress(int id) async{
    var url="${Constance.BASE_URL}${Constance.listhistoriqueEndpoint}/$id";
    loading = true;
    notifyListeners();
    print(url);
    var response= await deleteData(url);
    if(response !=null){
      print("suppression réussie ");
    }
  }
}
// void main() {
//   var url = "${Constance.BASE_URL}${Constance.listhistoriqueEndpoint}";
//   var f = HistoriqueCtrl();
//   f.recupererHistApi();
// }



