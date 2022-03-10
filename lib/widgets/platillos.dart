import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' as rootBundle;
import 'package:restaurant/models/Platillo.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget 
{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {


  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: ReadJsonData(),
        builder: (context,data){
          if(data.hasError){
            return Center(child: Text("${data.error}"));
          }else if(data.hasData){
            var items =data.data as List<Platillo>;
            return ListView.builder(
              itemCount: items == null? 0: items.length,
                itemBuilder: (context,index){
                  return Card(
                    elevation: 5,
                    margin: EdgeInsets.symmetric(horizontal: 10,vertical: 6),
                    child: Container(
                      padding: EdgeInsets.all(8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            child: Image(image: NetworkImage(items[index].imageUrl.toString()),fit: BoxFit.fill,),
                          ),
                          Expanded(child: Container(
                            padding: EdgeInsets.only(bottom: 8),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(padding: EdgeInsets.only(left: 8,right: 8),child: Text(items[index].name.toString(),style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold
                                ),),),
                                Padding(padding: EdgeInsets.only(left: 8,right: 8),child: Text(items[index].price.toString()),)
                              ],
                            ),
                          ))
                        ],
                      ),
                    ),
                  );
                }
            );
          }else{
            return Center(child: CircularProgressIndicator(),);
          }
        },
      )
    );
  }

  Future<List<Platillo>>ReadJsonData() async{
     final jsondata = await rootBundle.rootBundle.loadString('assets/data/platillos.json');
     final list = json.decode(jsondata) as List<dynamic>;

     return list.map((e) => Platillo.fromJson(e)).toList();
  }
  }