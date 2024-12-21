import 'package:flutter/material.dart';
import 'package:prova/src/widgets/ListItem.dart';
import 'package:prova/src/widgets/Searchbar.dart' as sb;


class SearchList extends StatefulWidget {
  SearchList({Key? key}) : super(key: key);

  @override
  State<SearchList> createState() => _SearchListState();
}

class _SearchListState extends State<SearchList> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: sb.SearchBar(),),
            
          ],
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
          ),
          child: ListView(
            shrinkWrap: true,
            children: [
              SearchListItem(),
              SearchListItem(),
              SearchListItem(),
            ],
          ),
        )
      ],
    );
  }
}