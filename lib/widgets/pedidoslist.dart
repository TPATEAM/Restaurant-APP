import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' as rootBundle;
import 'package:restaurant/models/Platillo.dart';
import 'package:restaurant/values.dart';

class PlatilloView extends StatelessWidget {
  const PlatilloView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 600,
      child: FutureBuilder(
        future: ReadJsonData(),
        builder: (context, data){
          if(data.hasError)
          {
            return Center(
              child: Text('Error al cargar los platillos.\n${data.error}'),
            );
          }
          else if(data.hasData)
          {
            var items = data.data as List<Platillo>;
            return ListView.builder(
              itemCount: items == null? 0 : items.length,
              itemBuilder: (context, index){
                return Container(
                  margin: EdgeInsets.only(left: 10, top: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image(
                        image: NetworkImage(
                          items[index].imageUrl.toString(),
                        ),
                        width: 100,
                        fit: BoxFit.cover,
                      ),

                      SizedBox(width: 10),

                      Container(
                        width: 200,
                        child: Text(items[index].name.toString(),
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 19,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey.shade700,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),

                      Spacer(),

                      Container(
                        margin: EdgeInsets.only(right: 10),
                        child: Text("\$${items[index].price.toString()}",
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 19,
                            fontWeight: FontWeight.w600,
                            color: blackLight,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }
          else{
            return Center(child: CircularProgressIndicator(),);
          }
        },
      ),
    );
  }

  Future<List<Platillo>>ReadJsonData() async
  {
    final jsondata = await rootBundle.rootBundle.loadString('assets/data/platillos.json');
    final list = json.decode(jsondata) as List<dynamic>;
    return list.map((e) => Platillo.fromJson(e)).toList();
  }
}