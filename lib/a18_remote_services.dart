
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pepcorns_app/Models/a17_data_model.dart';

class RemoteServices {
  Future<List<DataModel>?> getCollege(String country) async {
    var client = http.Client();
    var url = Uri.parse('http://universities.hipolabs.com/search?country=$country');
    var response = await client.get(url);
    debugPrint(response.body);

    if(response.statusCode == 200){
      var json = response.body;
      return dataModelFromJson(json);
    }
    return null;
  }
}