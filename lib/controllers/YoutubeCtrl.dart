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


  Future<bool> envoieDonneesAuth(Map data) async {
    var url = Uri.parse("${Constance.BASE_URL}${Constance.authEndpoint}");
    var dataStr = json.encode(data);
    var reponse = await http.post(url, body: dataStr);
    print("status : ${reponse.statusCode}");
    if (reponse.statusCode == 200) {
      Map bodymap = json.decode(reponse.body);
      print(bodymap['id']);

      return true;
    }
    return false;
  }

  Future<bool> envoieApi(Map data) async {

    var url = Uri.parse("${Constance.BASE_URL}${Constance.histopriqueEndpoint}");

    var headers = {
      'Content-Type': 'application/json'
    };
    var dataStr = json.encode(data);
    var reponse = await http.post(url,headers: headers, body: dataStr);

    if (reponse.statusCode == 200) {
      Map bodymap = json.decode(reponse.body);

      return true;
    }
    return false;
  }



  void recupererDataAPI() async {
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
      print("test data $dataStockee");
      var tmp=dataStockee.map<YoutubeModele>((e)=> YoutubeModele.fromJson(e)).toList();
      video = tmp;
      print("Mes donnees : $tmp");
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

void main() {
  var f = YoutubeCtrl();
  f.recupererDataAPI();
}

/*
class User {
   String? name;
   int? age;

  User({ this.name, this.age});
}

void main() {
  var mapList = [{'name': 'John', 'age': 30}, {'name': 'Jane', 'age': 40}];
  var userList = mapList.map((item) => User(name: item['name'] as String,age: item['age'] as int)).toList();
  userList.forEach((user) {
    print("Nom : ${user.name}, Age: ${user.age}");
  });



  var data = jsonEncode(userList);
  print(data);
  print("="*20);
  print(userList.length);
  print(userList); // [Instance of 'User', Instance of 'User']
}*/
}
