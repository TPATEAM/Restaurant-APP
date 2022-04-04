import 'package:flutter/material.dart';
import 'package:restaurant/models/Category.dart';
import 'package:restaurant/models/Platillo.dart';
import 'package:restaurant/values.dart';
import 'package:restaurant/views/orderdetails.dart';

class PedidosOrder extends StatefulWidget {
  final int numTable;
  List<Platillo>? listaPlatillos;
  List<Category>? listaCategorias;
  PedidosOrder(
      {Key? key,
      required this.numTable,
      this.listaPlatillos,
      this.listaCategorias})
      : super(key: key);

  @override
  State<PedidosOrder> createState() => _PedidosOrderState();
}

class _PedidosOrderState extends State<PedidosOrder> {
  int currentIdx = -1;
  final query = TextEditingController();
  late List<Platillo> listaPlatillosSearch =
      widget.listaPlatillos as List<Platillo>;
  late List<Category> categorias = widget.listaCategorias as List<Category>;

  @override
  void initState() {
    if (listaPlatillosSearch.isEmpty) {
      listaPlatillosSearch = widget.listaPlatillos as List<Platillo>;
    }
    if (categorias.isEmpty) {
      categorias = widget.listaCategorias as List<Category>;
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
                  margin: EdgeInsets.only(bottom: 10),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.06,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: categorias.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            if(currentIdx == index)
                            {
                              listaPlatillosSearch = widget.listaPlatillos as List<Platillo>;
                              currentIdx = -1;
                            }
                            else
                            {
                              listaPlatillosSearch = widget.listaPlatillos
                                    ?.where((platillo) => 
                                        platillo.idCategory == index)
                                    .toList() as List<Platillo>;
                              currentIdx = index;
                            }
                            
                            setState(() {});
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: currentIdx == index ? reptileGreen : ligthGreen,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            width: MediaQuery.of(context).size.width * 0.3,
                            height: MediaQuery.of(context).size.height * 0.04,
                            margin: EdgeInsets.only(left: 5, right: 5),
                            child: Center(
                              child: Text(
                                categorias.elementAt(index).name.toString(),
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: currentIdx == index ? blackLight : Colors.grey.shade500,
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
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
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
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
                        children: [
                          Row(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.68,
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
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.68,
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
