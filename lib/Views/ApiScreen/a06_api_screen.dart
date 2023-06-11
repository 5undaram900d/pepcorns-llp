
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pepcorns_app/Models/a17_data_model.dart';
import 'package:http/http.dart' as http;

class ApiScreen extends StatefulWidget {
  const ApiScreen({Key? key}) : super(key: key);

  @override
  State<ApiScreen> createState() => _ApiScreenState();
}

class _ApiScreenState extends State<ApiScreen> {

  List<DataModel> dataModel = [];
  var isLoaded = true;

  var countryController = TextEditingController();
  String country = '';

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('University List', style: TextStyle(fontWeight: FontWeight.bold),),
        // centerTitle: true,
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width/2.4,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: TextField(
                    controller: countryController,
                    decoration: InputDecoration(
                      hintStyle: const TextStyle(color: Colors.white),
                      hintText: 'Country',
                      border: OutlineInputBorder(borderSide: const BorderSide(color: Colors.white),borderRadius: BorderRadius.circular(15)),
                      enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.white), borderRadius: BorderRadius.circular(15)),
                      disabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.white), borderRadius: BorderRadius.circular(15)),
                      focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.white), borderRadius: BorderRadius.circular(15)),
                    ),
                  ),
                ),
              ),
              IconButton(
                onPressed: (){
                  country = countryController.text.toString();
                  setState(() {
                  });
                },
                icon: const Icon(Icons.search,),
              ),
            ],
          ),
        ],
      ),

      body: FutureBuilder(
        future: getCollege(country.toString()),
        builder: (BuildContext context, AsyncSnapshot snapshot){
          // debugPrint(country.toString());
          if(snapshot.connectionState == ConnectionState.done){
            if(snapshot.hasData){
              return ListView.builder(
                // shrinkWrap: true,
                itemCount: dataModel.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: Color(index*446+100000).withOpacity(0.5),
                    margin: const EdgeInsets.all(8.0),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(dataModel[index].name, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),),
                          TextButton(
                            onPressed: (){},
                            child: Text(dataModel[index].webPages[0]),
                          ),
                          Align(alignment: Alignment.topRight, child: Text('-${dataModel[index].stateProvince}')),
                          const SizedBox(height: 10,)
                        ],
                      ),
                    ),
                  );
                },
              );
            }
            else{
              return const Text('Wrong name format');
            }
          }
          else{
            return const Center(child: CircularProgressIndicator(),);
          }
        }
      ),
    );
  }


  Future<List<DataModel>?> getCollege(String country) async {
    debugPrint(country.toString());
    var url = Uri.parse('http://universities.hipolabs.com/search?country=India');
    var response = await http.get(url);
    // debugPrint(response.body);
    var data = jsonDecode(response.body.toString());

    debugPrint(data.toString());

    if(response.statusCode == 200){
      for(Map<String, dynamic> index in data) {
        dataModel.add(DataModel.fromJson(index));
      }
      return dataModel;
    }
    return dataModel;
  }
}
