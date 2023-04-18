import 'dart:convert';

import 'package:http/http.dart';

class EssaieApi{

  static _makeGetRequest() async {
    // make GET request
    var url =Uri.parse('https://jsonplaceholder.typicode.com/posts');
    var reponseRequette= await get(url);
    var data = reponseRequette.body;
    Map dataM= jsonDecode(data);
    var headers = reponseRequette.headers;
    print(headers['content-type']);
    print("=" *20);
   // List<Map> Ldata= dataM;

    //print(Ldata);
    //print(reponseRequette.body);
    print(reponseRequette.runtimeType);

    /*// sample info available in response
    int statusCode = response.statusCode;
    Map<String, String> headers = response.headers;
    String contentType = headers['content-type'];
    String json = response.body;
    // TODO convert json to object...*/
  }
}

void main (){
  EssaieApi._makeGetRequest();

}