import 'package:flutter/material.dart';

class Favorites extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return Favorite(index: index);
        },
        childCount: 30,
      ),
    );
  }
}

class Favorite extends StatelessWidget {
  const Favorite({
    Key key,
    @required this.index,
  })  : assert(index != null),
        super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Icon(
            Icons.favorite,
            color: Colors.redAccent,
          ),
          SizedBox(width: 10),
          Text('Favorite #${index + 1}'),
        ],
      ),
    );
  }
}
