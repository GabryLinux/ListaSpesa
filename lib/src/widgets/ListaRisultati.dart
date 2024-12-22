
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:prova/src/widgets/AddExtraItemButton.dart';
import 'package:prova/src/widgets/ItemSpesa.dart';

class ListaRisultati extends StatefulWidget {
  final List<String> risultati;
  final String product;
  ListaRisultati({Key? key, required this.risultati, this.product = ""}) : super(key: key);

  final db = FirebaseFirestore.instance.collection('Acquisti').doc('Supermercato');
  //final length = await FirebaseFirestore.instance.collection('Acquisti').doc('Supermercato').get()
  //.then((value) => (value.data()!['Prodotti'].length) as int );

  @override
  State<ListaRisultati> createState() => _ListaRisultatiState();
}

class _ListaRisultatiState extends State<ListaRisultati> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
                      padding: EdgeInsets.symmetric(vertical: 2),
                      shrinkWrap: true,
                      children: [
                        for(int i = 0; i < widget.risultati.length; i++)
                          ItemSpesa(title: widget.risultati[i]),
                        AddExtraButton(product: widget.product,)
                      ],
                    )
    );
  }
}