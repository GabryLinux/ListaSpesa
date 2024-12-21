import 'package:flutter/material.dart';

class ListaSpesaClass{
  bool state;
  final String title;
  final int Key;
  final String? quantity;
  String? date;
  final String? uuid;
  ListaSpesaClass(this.Key,this.state,this.title,this.quantity,this.date,this.uuid );

  Map<String, dynamic> toMap() => {
    'Status' : state,
    'Item' : title,
    'Quantity' : quantity,
    'data' : date,
    'id' : Key,
    'uuid' : uuid
  };

  ListaSpesaClass.fromMap(Map<String, dynamic> map)
    : state = map['Status'] as bool,
    title = map['Item'] != null ? map['Item'] : '',
    quantity = map['Quantity'],
    date = map['data'],
    Key = map['id'],
    uuid = map['uuid'];

  String Print(){
    return 'Titolo Prodotto: ${this.title}\t num:${this.Key}';
  }
}