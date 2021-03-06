import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:techdaily/models/TechDailyContent.dart';
import 'package:techdaily/models/api_owner_model.dart';

class ApiManager {
  Future<List<TechDailyContent>> getContents(int pageNumber) async {
    var client = http.Client();

    try {
      var response = await client
          .get(Uri.parse('https://techdailyapi.herokuapp.com/contents/?page='+pageNumber.toString()));

      if (response.statusCode == 200) {
        print("'/contents' endpoint statusCode: 200");
        var jsonString = response.body;

        Map<String, dynamic> jsonMap = json.decode(jsonString);
        // print(jsonMap['results']);

        List results = jsonMap['results'];
        print(results);
        //print("fetched 'contents' list length: " + results.length.toString());

        return results
            .map((content) => TechDailyContent.fromJson(content))
            .toList();
      }
    } catch (e) {
      print('error:' + e.toString());
    }
    return null;
  }

  //Fetch owners lists
  Future<List<TechDailyOwner>> getOwners() async {
    var client = http.Client();

    try {
      var response = await client
          .get(Uri.parse('https://techdailyapi.herokuapp.com/owners/'));

      if (response.statusCode == 200) {
        print("'/owners' endpoint statusCode: 200");
        var jsonStrings = response.body;
        List jsonMap = json.decode(jsonStrings);
        print(jsonMap);
        print("fetched 'owners' list length: " + jsonMap.length.toString());
        return jsonMap.map((owner) => TechDailyOwner.fromJson(owner)).toList();
      }
    } catch (e) {
      print('error: ' + e);
    }
    return null;
  }

  //sort by ownerId

  Future<List<TechDailyContent>> getContentsByOwner(int ownerId,int pageNumber) async {

    var client = http.Client();

    try {
      var response = await client.get(Uri.parse(
          'http://techdailyapi.herokuapp.com/contents/search/owner_id/'+
              ownerId.toString()+'?page=' + pageNumber.toString()));

      if (response.statusCode == 200) {
        print(
            "'/contents/search/owner_id/\$owner_id' endpoint statusCode: 200");
        var jsonString = response.body;

        Map<String, dynamic> jsonMap = json.decode(jsonString);

        List results = jsonMap['results'];

        // List jsonMap = json.decode(jsonString);


        // print("fetched 'contents' list length: " + jsonMap.length.toString());

        return results
            .map((content) => TechDailyContent.fromJson(content))
            .toList();
      }
    } catch (e) {
      print('error:' + e.toString());
    }
    return null;
  }
}
