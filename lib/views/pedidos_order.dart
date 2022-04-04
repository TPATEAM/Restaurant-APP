import 'package:flutter/material.dart';
import 'package:restaurant/models/Platillo.dart';
import 'package:restaurant/values.dart';
import 'package:restaurant/views/orderdetails.dart';

class PedidosOrder extends StatefulWidget {
  final int numTable;
  List<Platillo>? listaPlatillos;
  PedidosOrder({Key? key, required this.numTable, this.listaPlatillos})
      : super(key: key);

  @override
  State<PedidosOrder> createState() => _PedidosOrderState();
}

class _PedidosOrderState extends State<PedidosOrder> {
  final query = TextEditingController();
  late List<Platillo> listaPlatillosSearch =
      widget.listaPlatillos as List<Platillo>;

  @override
  void initState() {
    if (listaPlatillosSearch.isEmpty) {
      listaPlatillosSearch = widget.listaPlatillos as List<Platillo>;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          bottom: PreferredSize(
            preferredSize:
                Size.fromHeight(MediaQuery.of(context).size.height * 0.15),
            child: Column(
              children: [
                Container(
                  color: Colors.white,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          margin:
                              EdgeInsets.only(bottom: 10, left: 20, right: 20),
                          child: TextField(
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                              fontSize: 24,
                            ),
                            textInputAction: TextInputAction.done,
                            controller: query,
                            onChanged: (value) {
                              setState(() {
                                listaPlatillosSearch = widget.listaPlatillos
                                    ?.where((platillo) => platillo.name!
                                        .toLowerCase()
                                        .contains(value.toLowerCase()))
                                    .toList() as List<Platillo>;

                                if (listaPlatillosSearch.isEmpty) {
                                  listaPlatillosSearch =
                                      widget.listaPlatillos as List<Platillo>;
                                }
                              });
                            },
                            autofocus: false,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              hintText: 'Nombre del Platillo',
                              prefixIcon: Icon(
                                Icons.search,
                                color: Colors.grey,
                              ),
                              contentPadding: EdgeInsets.all(10),
                              hintStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: 18,
                              ),
                              labelText: 'Buscar Platillo',
                              labelStyle: TextStyle(
                                fontSize: 18,
                                color: Colors.grey,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.green, width: 2.0),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  color: fusionRed,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.08,
                ),
              ],
            ),
          ),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_sharp,
              color: Colors.grey.shade400,
              size: 30,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            "Mesa #" + widget.numTable.toString(),
            style: TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w600,
              fontSize: 25,
              color: Colors.black54,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          // color: fusionRed,
          child: ListView.builder(
            itemCount: listaPlatillosSearch.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OrderDetails(
                          platillo: listaPlatillosSearch.elementAt(index)),
                    ),
                  );
                },
                child: Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        //Imagen
                        children: [
                          SizedBox(
                            width: 110,
                            height: 120,
                            child: Image.network(
                              listaPlatillosSearch
                                  .elementAt(index)
                                  .imageUrl
                                  .toString(),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        //Info Platillo
                        children: [
                          Row(
                            //Nombre
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.68,
                                // color: reptileGreen,
                                child: Text(
                                  listaPlatillosSearch
                                      .elementAt(index)
                                      .name
                                      .toString(),
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 20,
                                    color: blackLight,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            //Descripcion
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.68,
                                // color: orangeHibiscus,
                                child: Text(
                                  listaPlatillosSearch
                                      .elementAt(index)
                                      .description
                                      .toString(),
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                    color: Colors.grey.shade500,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 3,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            //Precio
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.68,
                                child: Text(
                                  '\$' +
                                      listaPlatillosSearch
                                          .elementAt(index)
                                          .price
                                          .toString(),
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18,
                                    color: Colors.grey.shade600,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 3,
                                  textAlign: TextAlign.right,
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
        ),
      ),
    );
  }
}
