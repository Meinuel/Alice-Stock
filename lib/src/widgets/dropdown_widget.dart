import 'package:flutter/material.dart';

class DropDownMenu extends StatelessWidget {
  final List<String> items;
  const DropDownMenu({Key? key , required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(  
      child: DropdownButton<String>(
        items: items.map(buildItem).toList(),
        onChanged: (value) => {},
      )
    );
  }
}
  DropdownMenuItem<String> buildItem (String item) {
    return DropdownMenuItem(child: Text(item)); 
}
