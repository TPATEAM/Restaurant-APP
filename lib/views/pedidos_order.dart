import 'package:flutter/material.dart';
import 'package:restaurant/models/Platillo.dart';
import 'package:restaurant/views/orderdetails.dart';

class PedidosOrder extends StatefulWidget {
  final int numTable;
  final List<Platillo> listaPlatillos;
  const PedidosOrder(
      {Key? key, required this.numTable, required this.listaPlatillos})
      : super(key: key);

  @override
  State<PedidosOrder> createState() => _PedidosOrderState();
}

class _PedidosOrderState extends State<PedidosOrder> {
  final query = TextEditingController();
  List<Platillo> listaPlatillosSearch = [];
  @override
  Widget build(BuildContext context) {
    listaPlatillosSearch = widget.listaPlatillos;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          bottom: PreferredSize(
            preferredSize:
                Size.fromHeight(MediaQuery.of(context).size.height * 0.08),
            child: Container(
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(bottom: 10, left: 20, right: 20),
                      child: TextField(
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                          fontSize: 24,
                        ),
                        textInputAction: TextInputAction.done,
                        controller: query,
                        onChanged: (value) {
                          findPlatillo(value);
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
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.77,
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: listaPlatillosSearch.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => OrderDetails(
                                    platillo: listaPlatillosSearch
                                        .elementAt(index))));
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              Container(
                                margin: EdgeInsets.only(bottom: 7),
                                width: 100,
                                height: 128,
                                child: Image.network(
                                  listaPlatillosSearch[index]
                                      .imageUrl
                                      .toString(),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.70,
                                    child: Text(
                                      listaPlatillosSearch
                                          .elementAt(index)
                                          .name
                                          .toString(),
                                      style: TextStyle(
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w600,
                                        fontSize: 20,
                                        color: Colors.grey.shade900,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      maxLines: 1,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.70,
                                    child: Text(
                                      listaPlatillosSearch
                                          .elementAt(index)
                                          .description
                                          .toString(),
                                      style: TextStyle(
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18,
                                        color: Colors.black38,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      maxLines: 3,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.70,
                                    child: Text(
                                      '\$' +
                                          listaPlatillosSearch
                                              .elementAt(index)
                                              .price
                                              .toString(),
                                      style: TextStyle(
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                        color: Colors.black38,
                                      ),
                                      textAlign: TextAlign.right,
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
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void findPlatillo(String value) {
    List<Data> listadoPlatillos = [];
    value = value.toLowerCase();
    List<String> keys = value.split(" ");
    for (int i = 0; i < widget.listaPlatillos.length; i++) 
    {
      listadoPlatillos.add(Data(
          posiciones: null,
          platillo: widget.listaPlatillos.elementAt(i),
          ocurrencias: 0));

      if (keys.length > 1) 
      {
        for (int j = 0; j < keys.length; j++) 
        {
          if(widget.listaPlatillos.elementAt(i).name!.toLowerCase().indexOf(keys[j]) > -1)
          {
            listadoPlatillos.elementAt(i).ocurrencias = listadoPlatillos.elementAt(i).ocurrencias! + 1;
            listadoPlatillos.elementAt(i).posiciones!.add(widget.listaPlatillos.elementAt(i).name!.toLowerCase().indexOf(keys[j]));
          }
        }
      }
    }
    setState(() {});
  }
}

class Data {
  List<int>? posiciones;
  Platillo? platillo;
  int? ocurrencias;

  Data({this.posiciones, this.platillo, this.ocurrencias});
}
