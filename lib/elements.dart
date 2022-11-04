import 'package:flutter/material.dart';

class Elements extends StatelessWidget {
  final String value;

  Elements(this.value);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: null,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 7,
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(value),
            ),
          ],
        ),
      ),
    );
  }
}
