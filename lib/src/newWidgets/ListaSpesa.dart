import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:flutter/foundation.dart';
import 'package:prova/src/Model/FirebaseDB.dart';
import 'package:prova/src/widgets/ListaItem.dart';

import 'package:prova/src/Model/ListaSpesaClass.dart';
import 'package:provider/provider.dart';

class ListaSpesa extends StatefulWidget {
  late Future<List<ListaSpesaClass>> newArrayProdotti;
  List<ListaSpesaClass> array = [];
  final ref = FirebaseFirestore.instance.collection('Acquisti3');

  ListaSpesa({Key? key}) : super(key: key);

  @override
  State<ListaSpesa> createState() => _ListaSpesaState();
}

class _ListaSpesaState extends State<ListaSpesa> {
  List<ListaSpesaClass> arrayDaFare = [];
  List<ListaSpesaClass> arrayCompletato = [];

  @override
  void initState() {
    /** 
    widget.ref.snapshots().listen((event) {
      debugPrint('UPDATE...');
      final lista = [...event.docs];
      var listaCasted = <ListaSpesaClass>[];
      for (var item in lista) {
        listaCasted.add(ListaSpesaClass.fromMap(item.data()));
      }
      setState(() {
        widget.array.clear();
        widget.array = listaCasted;
        //debugPrint(widget.array.last.title.toString());
        arrayDaFare.clear();
        arrayCompletato.clear();
        for (int i = 0; i < widget.array.length; i++) {
          if (widget.array[i].state == false) // da completare
            arrayDaFare.add(widget.array[i]);
          else
            arrayCompletato.add(widget.array[i]);
          //
        }
        arrayDaFare = arrayDaFare.reversed.toList();
      });
      
      debugPrint("AGGIORNAMENTO...");
    });
    */
    context.read<FirebaseDB>().getUncheckedItems().then(
      (value) {
        arrayDaFare = value.sublist(0);
        setState(() {});
      }
    );
    context.read<FirebaseDB>().getCheckedItems().then(
      (value) {
        arrayCompletato = value;
        setState(() {});
      }
    );
    super.initState();
  }

  void CheckChange(ListaSpesaClass item)  {
    DateTime now = DateTime.now();
    String convertedDateTime =
        "${now.day.toString().padLeft(2, '0')}/${now.month.toString().padLeft(2, '0')}/${now.year.toString()}";
    debugPrint('${item.title},${item.state},${item.quantity},${item.uuid}');

    final bool status = item.state;
    late Map<String, dynamic> itemm;
    var docID;
     FirebaseFirestore.instance
        .collection('Acquisti3')
        .where('uuid', isEqualTo: item.uuid)
        .get()
        .then((value) {
      docID = value.docs[0].reference.id;
      FirebaseFirestore.instance
          .collection('Acquisti3')
          .doc(docID)
          .update(
            ListaSpesaClass(item.Key, !status, item.title, item.quantity,convertedDateTime, item.uuid)
              .toMap());
          
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: arrayDaFare.length,
          itemBuilder: (context, i) {
            return ListaItem(
              checkValue: arrayDaFare[i].state,
              product: arrayDaFare[i].title,
              onChangeCheck: () => CheckChange(arrayDaFare[i]),
              quantity: arrayDaFare[i].quantity != null
                  ? arrayDaFare[i].quantity!
                  : "",
              details: arrayDaFare[i].date != null ? arrayDaFare[i].date! : "",
            );
          },
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 10),
        ),
        ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: arrayCompletato.length,
          itemBuilder: (context, i) {
            return Dismissible(
                key: Key(arrayCompletato[i].uuid! + i.toString()),
                onDismissed: (direction) async {
                  var docID;
                  await FirebaseFirestore.instance
                      .collection('Acquisti3')
                      .where('uuid', isEqualTo: arrayCompletato[i].uuid)
                      .get()
                      .then((value) {
                    docID = value.docs[0].reference.id;
                    FirebaseFirestore.instance
                        .collection('Acquisti3')
                        .doc(docID)
                        .delete()
                        .then((value) {
                      debugPrint(docID);
                      setState(() {
                        arrayCompletato.remove(arrayCompletato[i]);
                      });
                    });
                  });
                },
                child: ListaItem(
                  checkValue: arrayCompletato[i].state,
                  product: arrayCompletato[i].title,
                  onChangeCheck: () => CheckChange(arrayCompletato[i]),
                  quantity: arrayCompletato[i].quantity != null
                      ? arrayCompletato[i].quantity!
                      : "",
                  details: arrayCompletato[i].date != null
                      ? arrayCompletato[i].date!
                      : "",
                ));
          },
        ),
      ],
    );
  }
}
