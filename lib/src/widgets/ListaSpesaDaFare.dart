import 'package:flutter/material.dart';


class ListaSpesaDaFare extends StatefulWidget {
  final List<String> listaspesa;
  ListaSpesaDaFare({Key? key,required this.listaspesa}) : super(key: key);

  @override
  State<ListaSpesaDaFare> createState() => _ListaSpesaDaFareState();
}

class _ListaSpesaDaFareState extends State<ListaSpesaDaFare> {
  @override
  Widget build(BuildContext context) {
    return ReorderableListView(
      onReorder: ((oldIndex, newIndex) {
        
      }),
      children: [

      ],
    ) ;
  }
}