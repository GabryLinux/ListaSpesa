
import 'package:flutter/material.dart';
import 'package:prova/src/widgets/AddExtraItemButton.dart';
import 'package:prova/src/widgets/ItemSpesa.dart';

class ListaRisultati extends StatefulWidget {
  final List<String> risultati;
  final String product;
  ListaRisultati({Key? key, required this.risultati, this.product = ""}) : super(key: key);

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