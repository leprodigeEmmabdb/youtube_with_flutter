import 'dart:convert';

import 'package:http/http.dart' as http;


Future<dynamic> getData(String url_api) async {
  try{
    var url= Uri.parse(url_api);
    var reponse= await http.get(url).timeout(Duration(seconds:5));

    if(reponse.statusCode==200){
      return json.decode(reponse.body);
    }
    return reponse;
  }catch(e, trace){
    print(e.toString());
    print(trace.toString());
    return null;
  }
}
Future<dynamic> postData(String url_api, Map data) async {
   try{
     var headers = {
       'Content-Type': 'application/json'
     };
     var url=Uri.parse(url_api);
     String dataStr=json.encode(data);
     var reponse=await http.post(url,headers: headers,body: dataStr);
     var successList= [200,201];
     if(successList.contains(reponse.statusCode)){
       return json.decode(reponse.body);
     }
     return null;
   }catch(e, trace){
     print(e.toString());
     print(trace.toString());
     return null;
   }

  }
Future<dynamic> deleteData(String url_api) async {
  try{
    var url=Uri.parse(url_api);
    var reponse=await http.delete(url).timeout(Duration(seconds:5));
    var successList= [200,201,202];
    if(successList.contains(reponse.statusCode)){
      return json.decode(reponse.body);
    }
    return null;
  }catch(e, trace){
    print(e.toString());
    print(trace.toString());
    return null;
  }
}
