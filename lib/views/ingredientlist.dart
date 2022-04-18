import 'package:flutter/material.dart';
import 'package:restaurant/models/Ingredient.dart';
import 'package:restaurant/values.dart';

class IngredientList extends StatefulWidget {
  List<Ingredient>? listaIngredientes;
  IngredientList({
    Key? key,
    this.listaIngredientes,
  }) : super(key: key);

  @override
  State<IngredientList> createState() => _IngredientListState();
}

class _IngredientListState extends State<IngredientList> {
  final query = TextEditingController();
  late List<Ingredient> listaIngredientSearch =
      widget.listaIngredientes as List<Ingredient>;

  @override
  void initState() {
    if (listaIngredientSearch.isEmpty) {
      listaIngredientSearch = widget.listaIngredientes as List<Ingredient>;
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
                Size.fromHeight(MediaQuery.of(context).size.height * 0.075),
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
                                listaIngredientSearch = widget.listaIngredientes
                                    ?.where((ingrediente) => ingrediente.name!
                                        .toLowerCase()
                                        .contains(value.toLowerCase()))
                                    .toList() as List<Ingredient>;

                                if (listaIngredientSearch.isEmpty) {
                                  listaIngredientSearch = widget
                                      .listaIngredientes as List<Ingredient>;
                                }
                              });
                            },
                            autofocus: false,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              hintText: 'Nombre del Ingrediente',
                              prefixIcon: Icon(
                                Icons.search,
                                color: Colors.grey,
                              ),
                              contentPadding: EdgeInsets.all(10),
                              hintStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: 18,
                              ),
                              labelText: 'Buscar Ingrediente',
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
            "Añadir Extras",
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
          margin: EdgeInsets.only(left: 15, right: 15),
          height: MediaQuery.of(context).size.height,
          color: Colors.white,
          child: ListView.builder(
            itemCount: listaIngredientSearch.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).pop(listaIngredientSearch[index].idIngredient);
                },
                child: Padding(
                  padding: EdgeInsets.all(6.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.65,
                        child: Text(
                          listaIngredientSearch.elementAt(index).name.toString(),
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                            fontSize: 24,
                            color: blackLight,
                            overflow: TextOverflow.ellipsis,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.20,
                        child: Text('\$' + listaIngredientSearch.elementAt(index).price!.toStringAsFixed(2),
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                            color: Colors.black54
                          ),
                          textAlign: TextAlign.left,
                          maxLines: 1,
                        ),
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
