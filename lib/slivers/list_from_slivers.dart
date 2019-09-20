import 'package:flutter/material.dart';
import 'package:nested_listviews/slivers/favorites.dart';
import 'package:nested_listviews/slivers/recommendations.dart';
import 'package:nested_listviews/slivers/static.dart';

class ListFromSlivers extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        Favorites(),
        Static(),
        Recommendations(),
      ],
    );
  }
}
