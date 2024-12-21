
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:prova/src/widgets/ListaSpesaClass.dart';
import 'package:prova/src/widgets/modalDetails.dart';
import 'package:uuid/uuid.dart';


class ItemSpesa extends StatefulWidget {
  final title;
  ItemSpesa({Key? key, required this.title}) : super(key: key);

  @override
  State<ItemSpesa> createState() => _ItemSpesaState();
}

class _ItemSpesaState extends State<ItemSpesa> {
  var uuid = Uuid();
  @override
  Widget build(BuildContext context) {
    return Container(
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Colors.grey.shade300,
                                width: 1
                              )
                            )
                          ),
                          child: TextButton(
                            onPressed: () async {
                              
                              final db = FirebaseFirestore.instance.collection('Acquisti').doc('Supermercato');
                              final length = await FirebaseFirestore.instance.collection('Acquisti').doc('Supermercato').get().then((value) => (value.data()!['Prodotti'].length) as int );
                              await db.update({
                                'Prodotti' : FieldValue.arrayUnion([ListaSpesaClass(length, false, widget.title, "", "",uuid.v4()).toMap()])
                              });
                              
                              final snackBar = SnackBar(
                                content:Text('${widget.title} aggiunto alla lista!'),
                                action: SnackBarAction(
                                  label: 'Fatto',
                                  onPressed: () {
                                    // Some code to undo the change.
                                  },
                                ),
                              );
                              ScaffoldMessenger.of(context).showSnackBar(snackBar);
                            },
                            onLongPress: () {
                              showModalBottomSheet(
                                isScrollControlled: true,
                                context: context, 
                                backgroundColor: Colors.transparent,
                                builder: (context) => ModalDetails(title: widget.title,)
                              ).then((value) => null);
                            },
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.symmetric(horizontal: 15,vertical: 15),
                              alignment: Alignment.centerLeft,
                              primary: Colors.grey.shade500
                            ), 
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  widget.title,
                                  style: TextStyle(
                                    color: Colors.grey.shade600,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                  ),
                                ),
                                Icon(
                                  Icons.add_circle,
                                  color: Colors.green,
                                )
                              ],
                            )
                          )
                        );
  }
}