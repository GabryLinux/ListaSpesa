
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:prova/src/widgets/ListaRisultati.dart';
import 'package:prova/src/newWidgets/ListaSpesa.dart';
import 'package:prova/src/widgets/SearchbarNew.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';


class slideUpProdotti extends StatefulWidget {
  final dbProd = FirebaseFirestore.instance.collection('Prodotti').doc('0');
  slideUpProdotti({Key? key}) : super(key: key);
  late TextEditingController queryText;
  @override
  State<slideUpProdotti> createState() => _slideUpProdottiState();
}



class _slideUpProdottiState extends State<slideUpProdotti> {
  List<String> array = <String>[];
  
  //final array2 = List<ListaSpesaClass>.generate(10, (index) => new ListaSpesaClass(index,false,index.toString(),'20','data'));
  final double radius = 30;
/*
  void RetrieveValues(){
    List<String> arraySemplificato = [];
    widget.dbProd.get().then((value) {
        final arrayy = [...?value.data()!['Categorie']];
        
        
        for(var items in arrayy){
          for(var item in items!['Prodotti']){
            arraySemplificato.add(item['Item']);
          }
        }
        
        setState(() {
          array = arraySemplificato;
        });
    },);

    //return arraySemplificato;
  }
*/
  @override
  void initState() {
    // TODO: implement initState
    widget.dbProd.snapshots().listen(
      (value) {
        List<String> arraySemplificato = [];
        final arrayy = [...?value.data()!['Categorie']];
        
        for(var items in arrayy){
          for(var item in items!['Prodotti']){
            arraySemplificato.add(item['Item']);
          }
        }
        setState(() {
          array = arraySemplificato;
        });
    });

    widget.queryText = TextEditingController()
      ..addListener(() {setState(() {
        
      });});
    

    //RetrieveValues();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
    return Stack(
      children: [
        Container(
            height: MediaQuery.of(context).size.height - 50,
            margin: EdgeInsets.only(bottom: 50, top: 0),
            child: ListaSpesa()
        ),
        SlidingUpPanel(
        backdropEnabled: true,
        backdropOpacity: 0.10,
        minHeight: 45,
        margin: EdgeInsets.symmetric(horizontal: 10),
        borderRadius: BorderRadius.vertical(top : Radius.circular(radius)),
          
          panel: Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            margin: EdgeInsets.only(top: 20, right: 10, left: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(22),
              color: Colors.white,            
            ),
              child: Column(
                children: <Widget>[
                  Center(
                    child: Container(
                      margin: EdgeInsets.only(bottom: 20),
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.grey
                      ),
                    ),
                  ),
                    FlatSearchBar(queryText: widget.queryText),
                    Container(
                      padding: EdgeInsets.only(top: 15,left: 5),
                      alignment: Alignment.centerLeft,
                      child: Text(
                          "Risultati",
                          style: TextStyle(
                            color: Colors.grey.shade700
                          ),
                        ),
                    ),
                    //ListaRisultati(risultati: array.where((element) => element.toLowerCase().startsWith(widget.queryText.text.toLowerCase())).toList(),product: widget.queryText.text,)
                  ]
                ),
            ),
          )
      ],
    );
  }
}