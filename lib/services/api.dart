import 'package:dio/dio.dart';
import 'package:rssfeed/models/rssResponceModel.dart';

import 'package:rssfeed/services/url.dart';

class Api{

  final url=Url();
  final dio=Dio();

  Future getData()async{
    
    try {
      final responce= await dio.get(url.rssUrl);
      final result=responce.data;
      print("result : $result");
      return RssFeed.parse(result);
    } catch (e) {
      print("Error : $e");
    }
  } 



 
}