
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:prova/src/widgets/ListaSpesaClass.dart';
import 'package:uuid/uuid.dart';

class modalPanel extends StatefulWidget {
  final String product;
  modalPanel({Key? key,this.product = ""}) : super(key: key);

  @override
  State<modalPanel> createState() => _modalPanelState();
}

class _modalPanelState extends State<modalPanel> {
  var uuid = Uuid();
  bool switchState = true;
  @override
  Widget build(BuildContext context) {
    debugPrint('prodotto : ${widget.product}');
    final controller = TextEditingController(text: widget.product);
    return Container(
      height: 230,
      margin: EdgeInsets.only(left: 7, right: 7, bottom: MediaQuery.of(context).viewInsets.bottom + 10),
      padding: EdgeInsets.only(left: 30, right: 30, top: 30, bottom: 0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25)
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Aggiungi nuovo prodotto",style: TextStyle(fontSize: 19),),
          Container(
            margin: EdgeInsets.only(bottom: 10),
            child: TextField(
              controller: controller,
            ),
          ),
          Container(
            padding: EdgeInsets.only(bottom: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Salva per le prossime ricerche"),
                Switch(
                  value: switchState, 
                  onChanged: (val) {
                    setState(() {
                      switchState = val;
                    });
                  }
                )
              ],
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
                  onPressed: () async{

                    final db = FirebaseFirestore.instance.collection('Acquisti').doc('Supermercato');
                    final length = await FirebaseFirestore.instance.collection('Acquisti').doc('Supermercato').get().then((value) => (value.data()!['Prodotti'].length) as int );
                    await db.update({
                      'Prodotti' : FieldValue.arrayUnion([ListaSpesaClass(length, false, controller.text, "", "",uuid.v4()).toMap()])
                    });

                    if(switchState){
                      await FirebaseFirestore.instance.collection('Prodotti').doc('0').update({
                        'Categorie' : FieldValue.arrayUnion([{'Nome' : 'Varie','Prodotti' : [{'Item' : controller.text}]}])
                      });
                    }
                    final snackBar = SnackBar(
                                content:Text('${widget.product} aggiunto alla lista!'),
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