import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:techdaily/models/TechDailyContent.dart';
import 'package:techdaily/models/api_owner_model.dart';

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



 //Fetch owners lists
  Future <List<TechDailyOwner>> getOwners() async {
    var client = http.Client();

    try {
      var response = await client.get(
          Uri.parse('https://techdailyapi.herokuapp.com/owners/'));

      if (response.statusCode == 200) {
        var jsonStrings = response.body;
        List jsonMap = json.decode(jsonStrings);
        return jsonMap.map((owner) =>TechDailyOwner.fromJson(owner)).toList();
      }
    }
    catch(e){
      print('error: '+e);
    }
    return null;
  }


  //sort by ownerId

  Future<List<TechDailyContent>> getContentsByOwner(int ownerId) async {
    var client = http.Client();

    try {

      var response = await client.get( Uri.parse('http://techdailyapi.herokuapp.com/contents/search/owner_id/'+ownerId.toString()));

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
