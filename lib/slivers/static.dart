import 'package:flutter/material.dart';

class Static extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate([
        Container(
          height: 120,
          color: Colors.grey,
          child: Center(
            child: Text(
              'Tap here to be inspired\nby a random item',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ]),
    );
  }
}
