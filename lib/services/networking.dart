


import 'dart:convert';

import 'package:http/http.dart' as http;


class NetworkingHelper{
  NetworkingHelper(this.url);
  final String url;
  Future getImageData() async{
    var response=await http.get(Uri.parse(url));
    if(response.statusCode==200){
      return response.bodyBytes;
    }else{
      print(response.statusCode);
    }
  }

  Future getData() async{
    var response=await http.get(Uri.parse(url));
    if(response.statusCode==200){
      return jsonDecode(response.body);
    }else{
      print(response.statusCode);
    }
  }
}