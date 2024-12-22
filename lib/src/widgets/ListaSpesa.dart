import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:flutter/foundation.dart';
import 'package:prova/src/widgets/ListaItem.dart';

import 'package:prova/src/widgets/ListaSpesaClass.dart';

class ListaSpesa extends StatefulWidget {
  late Future<List<ListaSpesaClass>> newArrayProdotti;
  List<ListaSpesaClass> array = [];
  final ref =
      FirebaseFirestore.instance.collection('Acquisti').doc('Supermercato');

  ListaSpesa({Key? key}) : super(key: key);

  @override
  State<ListaSpesa> createState() => _ListaSpesaState();
}

class _ListaSpesaState extends State<ListaSpesa> {
  List<ListaSpesaClass> arrayDaFare = [];
  List<ListaSpesaClass> arrayCompletato = [];

  void CheckChange(ListaSpesaClass item) async {
    DateTime now = DateTime.now();
    String convertedDateTime =
        "${now.day.toString().padLeft(2, '0')}/${now.month.toString().padLeft(2, '0')}/${now.year.toString()}";
    debugPrint('${item.title},${item.state},${item.quantity},${item.uuid}');

    final bool status = item.state;
    late Map<String, dynamic> itemm;
    await FirebaseFirestore.instance
        .collection('Acquisti')
        .doc('Supermercato')
        .get()
        .then((value) {
      final lista = [...?value.data()!['Prodotti']];
      itemm =
          lista.where((element) => element['uuid'] == item.uuid).toList()[0];
    });
    await FirebaseFirestore.instance
        .collection('Acquisti')
        .doc('Supermercato')
        .update({
      'Prodotti': FieldValue.arrayRemove([itemm])
    }).then((value) {
      FirebaseFirestore.instance
          .collection('Acquisti')
          .doc('Supermercato')
          .update({
        'Prodotti': FieldValue.arrayUnion([
          ListaSpesaClass(item.Key, !status, item.title, item.quantity,
                  convertedDateTime, item.uuid)
              .toMap()
        ])
      });
    });
  }

  Future<List<ListaSpesaClass>> getItems() {
    return FirebaseFirestore.instance
        .collection('Acquisti')
        .doc('Supermercato')
        .get()
        .then<List<ListaSpesaClass>>(
      (value) {
        final lista = [...?value.data()!['Prodotti']];
        var listaCasted = <ListaSpesaClass>[];
        for (var item in lista) {
          listaCasted.add(ListaSpesaClass.fromMap(item));
        }

        setState(() {
          widget.array = listaCasted;
        });
        return listaCasted;
      },
    );
  }

  @override
  void initState() {
    widget.ref.snapshots().listen((event) {
      debugPrint('UPDATE...');
      final lista = [...?event.data()!['Prodotti']];
      var listaCasted = <ListaSpesaClass>[];
      for (var item in lista) {
        listaCasted.add(ListaSpesaClass.fromMap(item));
      }
      setState(() {
        widget.array.clear();
        widget.array = listaCasted;
        debugPrint(widget.array.last.title.toString());
        arrayDaFare.clear();
        arrayCompletato.clear();
        for (int i = 0; i < widget.array.length; i++) {
          if (widget.array[i].state == false) // da completare
            arrayDaFare.add(widget.array[i]);
          else
            arrayCompletato.add(widget.array[i]);

          arrayDaFare = arrayDaFare.reversed.toList();
        }
      });
    });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      //widget.newArrayProdotti = ();

      //await getItems();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ReorderableListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          onReorder: ((oldIndex, newIndex) {
            setState(() {
              if (oldIndex < newIndex) {
                newIndex -= 1;
              }
              final item = arrayDaFare.removeAt(oldIndex);
              arrayDaFare.insert(newIndex, item);
            });
          }),
          itemCount: arrayDaFare.length,
          itemBuilder: (context, i) {
            return ListaItem(
              checkValue: arrayDaFare[i].state,
              product: arrayDaFare[i].title,
              onChangeCheck: () => /*CheckChange(arrayDaFare[i])*/ null,
              key: ValueKey(i),
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
        ReorderableListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          onReorder: ((oldIndex, newIndex) {
            setState(() {
              if (oldIndex < newIndex) {
                newIndex -= 1;
              }
              final item = arrayCompletato.removeAt(oldIndex);
              arrayCompletato.insert(newIndex, item);
            });
          }),
          itemCount: arrayCompletato.length,
          itemBuilder: (context, i) {
            return Dismissible(
                key: Key(arrayCompletato[i].uuid! + i.toString()),
                onDismissed: (direction) async {
                  late Map<String, dynamic> item;
                  await FirebaseFirestore.instance
                      .collection('Acquisti')
                      .doc('Supermercato')
                      .get()
                      .then((value) {
                    final lista = [...?value.data()!['Prodotti']];
                    item = lista
                        .where((element) =>
                            element['uuid'] == arrayCompletato[i].uuid)
                        .toList()[0];
                  });
                  await FirebaseFirestore.instance
                      .collection('Acquisti')
                      .doc('Supermercato')
                      .update({
                    'Prodotti': FieldValue.arrayRemove([item])
                  });
                  arrayCompletato.remove(arrayCompletato[i]);
                  setState(() {});
                },
                child: ListaItem(
                  checkValue: arrayCompletato[i].state,
                  product: arrayCompletato[i].title,
                  onChangeCheck: () => null, //CheckChange(arrayCompletato[i])
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
