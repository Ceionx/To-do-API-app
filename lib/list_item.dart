import 'package:flutter/material.dart';
import './add_item.dart';

class ListItem extends StatelessWidget {
  final AddItem item;
  ListItem(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    if(item.completed==true){ 
      return GestureDetector(
        onTap: () {
          print('Hejdå');
        },
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
                  child: Icon(Icons.check_box_outlined)
                ),
                Expanded(
                  child: Text(item.name, style: TextStyle(fontSize: 18, decoration: TextDecoration.lineThrough),),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
                  child: Icon(Icons.remove_circle_outline, color: Colors.red,)
                ),
              ],
            ),
            Divider(thickness: 0.5, color: Theme.of(context).colorScheme.inversePrimary)
          ],
        )
      );
      }
    return GestureDetector(
        onTap: () {
          item.completed == true;
          print('Hej');
        },
        child: Column(
      children: [
        Row(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
              child: Icon(Icons.check_box_outline_blank)
            ),
            Expanded(
              child: Text(item.name, style: TextStyle(fontSize: 18),),
            ),
            Padding(
              padding: EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
              child: Icon(Icons.remove_circle_outline, color: Colors.red,)
            ),
          ],
        ),
        Divider(thickness: 0.5, color: Theme.of(context).colorScheme.inversePrimary)
      ],
    )
    );
  }
}