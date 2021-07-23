// import 'dart:convert';
//
// import 'package:http/http.dart' as http;
// import 'package:techdaily/models/api_owner_model.dart';
//
// class ApiOwnerManager{
//   Future <List<TechDailyOwner>> getContents() async {
//     var client = http.Client();
//
//     try {
//       var response = await client.get(
//           Uri.parse('https://techdailyapi.herokuapp.com/owners/'));
//
//       if (response.statusCode == 200) {
//         var jsonStrings = response.body;
//         List jsonMap = json.decode(jsonStrings);
//          return jsonMap.map((owner) =>TechDailyOwner.fromJson(owner)).toList();
//       }
//     }
//       catch(e){
//       print('error: '+e);
//       }
//       return null;
//   }
// }