import 'package:flutter/foundation.dart';
import 'package:gestion_fidele/utils/requetes.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/UserModele.dart';
import '../models/UserModele.dart';
import '../utils/Constance.dart';
import '../utils/Stockage.dart';

class UserCtrl with ChangeNotifier {
  UserModel? user;
  GetStorage? stockage;
  UserCtrl({this.stockage}){

  }
  Future<bool> authenfierUser(Map data) async {
    var url = "${Constance.BASE_URL}${Constance.authEndpoint}";
    print(url);
    Map reponse = await postData(url, data);
    print("test $reponse");
    if (reponse != null) {
      user = UserModel.fromJson(reponse);
      stockage?.write(Stockage.userKey, user?.toJson());
      notifyListeners();
      print(user?.toJson());
    }

    return reponse != null;
  }
}
void main() {
  var ctrl=UserCtrl();
  Map data= {"username":"odc"};
  ctrl.authenfierUser(data);
}