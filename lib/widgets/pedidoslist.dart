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
      height: MediaQuery.of(context).size.height-290,
      child: FutureBuilder(
        future: readJsonData(),
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
                      Column(
                        children: [
                          Image(
                            image: NetworkImage(items[index].imageUrl.toString()), 
                            width: 120,
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 180,
                                child: Text(
                                  items[index].name.toString(),
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w600,
                                    color: Colors.grey.shade600,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),

                              Container(
                                margin: EdgeInsets.only(right: 10),
                                child: Text(
                                  '\$${items[index].price.toString()}',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w600,
                                    color: blackLight,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width - 150,
                                height: 50,
                                child: Text(
                                  '${items[index].description.toString()}',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w600,
                                    color: Colors.grey.shade600,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width - 220,
                                margin: EdgeInsets.only(top: 10),
                                child: Text(
                                  '${items[index].category.toString()}',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w600,
                                    color: Colors.grey.shade400,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),

                              Container(
                                child: Text(
                                  'Cant: 3',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w600,
                                    color: reptileGreen,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
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

  Future<List<Platillo>>readJsonData() async
  {
    final jsondata = await rootBundle.rootBundle.loadString('assets/data/platillos.json');
    final list = json.decode(jsondata) as List<dynamic>;
    return list.map((e) => Platillo.fromJson(e)).toList();
  }
}