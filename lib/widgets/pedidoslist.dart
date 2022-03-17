import 'package:flutter/material.dart';
import 'package:restaurant/models/Platillo.dart';
import 'package:restaurant/values.dart';
import 'package:restaurant/views/ordenar.dart';

class PlatilloView extends StatelessWidget {
  final List<Platillo> platillos;
  const PlatilloView({Key? key, required this.platillos}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height-290,
      child: ListView.builder(
              itemCount: platillos == null? 0 : platillos.length,
              itemBuilder: (context, index){
                return GestureDetector(
                  onTap: (){
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => OrdenarView(table: 1, platillo: platillos.elementAt(index))
                      ),
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: 10, top: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            Container(
                              width: 100,
                              height: 115,
                              child: Image.network(platillos[index].imageUrl.toString(),
                                fit: BoxFit.cover,
                              ),
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
                                    platillos[index].name.toString(),
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
                                    '\$${platillos[index].price.toString()}',
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
                                    '${platillos[index].description.toString()}',
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
                                    '${platillos[index].category.toString()}',
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
                  ),
                );
              },
            ),
      );
  }
}