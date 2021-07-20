import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:techdaily/models/TechDailyContent.dart';

class ApiManager {
  Future<List<TechDailyContent>> getContents() async {
    var client = http.Client();

    try {

      var response = await client.get( Uri.parse('https://techdailyapi.herokuapp.com/contents/'));

      if (response.statusCode == 200) {
        print('statusCode: '+200.toString());
        var jsonString = response.body;
        List jsonMap = json.decode(jsonString);
        print(jsonMap);
       return  jsonMap.map((content) => TechDailyContent.fromJson(content)).toList();

      }
    } catch (e) {
      print('error:'+e.toString());
    }
    return null;
  }
}
