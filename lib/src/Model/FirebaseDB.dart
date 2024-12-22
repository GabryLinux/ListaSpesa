import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:prova/src/Model/ListaSpesaClass.dart';

import '../../firebase_options.dart';

class FirebaseDB extends ChangeNotifier{
  final fbApp = Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  List<ListaSpesaClass> _checkedItems = [];
  List<ListaSpesaClass> _uncheckedItems = [];

  List<ListaSpesaClass> get checkedItems => UnmodifiableListView(_checkedItems);
  List<ListaSpesaClass> get uncheckedItems => UnmodifiableListView(_uncheckedItems);

  FirebaseDB(){
    getCheckedItems();
    getUncheckedItems();
  }

  Future<List<ListaSpesaClass>> getCheckedItems(){
    return _getItemsFiltered(true);
  }

  Future<List<ListaSpesaClass>> getUncheckedItems() {
    return _getItemsFiltered(false);
  }

  Future<List<ListaSpesaClass>> _getItemsFiltered(bool flag) {
    return FirebaseFirestore.instance.collection('Acquisti3')
    .where('Status', isEqualTo: flag)
    .get().then<List<ListaSpesaClass>>((value) {
        final lista = [...value.docs];
        var listaCasted = <ListaSpesaClass>[];
        for(var item in lista){
          listaCasted.add(ListaSpesaClass.fromMap(item.data()));
        }
        return listaCasted;
      },);
  }
  
  Future<List<ListaSpesaClass>> getItems() {


    return FirebaseFirestore.instance.collection('Acquisti3').get().then<List<ListaSpesaClass>>((value) {
        final lista = [...value.docs];
        var listaCasted = <ListaSpesaClass>[];
        for(var item in lista){
          listaCasted.add(ListaSpesaClass.fromMap(item.data()));
        }
        return listaCasted;
      },);
  }

}