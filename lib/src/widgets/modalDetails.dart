import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:prova/src/widgets/ListaSpesaClass.dart';
import 'package:uuid/uuid.dart';

class ModalDetails extends StatefulWidget {
  final String title;
  late TextEditingController quantity = TextEditingController();
  ModalDetails({Key? key, required this.title}) : super(key: key);

  @override
  State<ModalDetails> createState() => _ModalDetailsState();
}

class _ModalDetailsState extends State<ModalDetails> {
  var uuid = Uuid();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 7, right: 7, bottom: MediaQuery.of(context).viewInsets.bottom + 10),
      padding: EdgeInsets.only(left: 30, right: 30, top: 30, bottom: 30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25)
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Aggiungi la quantitá del prodotto",style: TextStyle(fontSize: 20),),
          Container(
            margin: EdgeInsets.only(bottom: 10,top: 10),
            child: TextField(
              controller: widget.quantity,
              decoration: InputDecoration(
              ),
              style: TextStyle(
                fontSize: 16
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: TextButton(
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  }, 
                  child: Text("Cancella",style: TextStyle(fontSize: 17),)
                )
              ),
              Container(
                width: 0,
                margin: EdgeInsets.only(right: 10),
              ),
              Expanded(
                child: TextButton(
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    backgroundColor: Colors.blue,
                    primary: Colors.white
                  ),
                  onPressed: () async {
                    final db = FirebaseFirestore.instance.collection('Acquisti').doc('Supermercato');
                              final length = await FirebaseFirestore.instance.collection('Acquisti').doc('Supermercato').get().then((value) => (value.data()!['Prodotti'].length) as int );
                              db.update({
                                'Prodotti' : FieldValue.arrayUnion([ListaSpesaClass(length, false, widget.title, widget.quantity.text, "", uuid.v4()).toMap()])
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
                    
                    Navigator.of(context).pop();
                  }, 
                  child: Text("Aggiungi",style: TextStyle(fontSize: 17),)
                )
              ),
            ],
          )
        ],
      ),
    );
  }
}