import 'package:flutter/material.dart';
import 'package:nested_listviews/slivers/list_from_slivers.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nested ListViews',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatelessWidget {
  MainScreen({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nested ListViews'),
      ),
      body: Menu(),
    );
  }
}

class Menu extends StatelessWidget {
  void showWidget(BuildContext context, WidgetBuilder builder) {
    Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (context) => Scaffold(
          appBar: AppBar(),
          body: Builder(
            builder: builder,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MaterialButton(
          onPressed: () => showWidget(context, (context) => NestedListViews()),
          child: Text('Nested ListViews'),
        ),
        MaterialButton(
          onPressed: () => showWidget(
            context,
            (context) => ListViewOfColumns(),
          ),
          child: Text('ListView of Columns'),
        ),
        MaterialButton(
          onPressed: () => showWidget(context, (context) => FlattenedList()),
          child: Text('Flattened List'),
        ),
        MaterialButton(
          onPressed: () => showWidget(context, (context) => ListFromSlivers()),
          child: Text('Multiple SliverLists'),
        ),
      ],
      crossAxisAlignment: CrossAxisAlignment.start,
    );
  }
}

class NestedListViews extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, outerIndex) {
        return ListView.builder(
          itemBuilder: (context, innerIndex) {
            print('Building row: Outer = $outerIndex, Inner = $innerIndex');

            return Text('Outer = $outerIndex, Inner = $innerIndex');
          },
          itemCount: 1000,
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
        );
      },
      itemCount: 10,
    );
  }
}

class ListViewOfColumns extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, outerIndex) {
        return Column(
          children: <Widget>[
            ...List.generate(
              1000,
              (innerIndex) {
                print('Building row: Outer = $outerIndex, Inner = $innerIndex');

                return Text('Outer = $outerIndex, Inner = $innerIndex');
              },
            ),
          ],
          crossAxisAlignment: CrossAxisAlignment.start,
        );
      },
      itemCount: 10,
    );
  }
}

@immutable
class Section {
  Section(this.title, this.items);

  final String title;

  final List<String> items;
}

@immutable
abstract class Row {}

class HeaderRow implements Row {
  HeaderRow(this.title);

  final String title;
}

class ItemRow implements Row {
  ItemRow(this.description);

  final String description;
}

// mocked API response
final tasksByDay = [
  Section(
    'Saturday',
    [
      'Shopping',
      'Clean 🚲',
    ],
  ),
  Section(
    'Sunday',
    [
      'Relax',
      'Read a book',
    ],
  ),
  Section(
    'Monday',
    [...List.generate(1000, (i) => 'Thing #$i')],
  ),
];

class FlattenedList extends StatefulWidget {
  @override
  _FlattenedListState createState() => _FlattenedListState();
}

class _FlattenedListState extends State<FlattenedList> {
  // in practice this would be based on a property and update when changed
  final items = tasksByDay.expand<Row>((section) {
    return [
      HeaderRow(section.title),
      ...section.items.map((item) => ItemRow(item)),
    ];
  }).toList();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        print('Building item for index $index');

        final item = items[index];

        if (item is HeaderRow) {
          return Header(title: item.title);
        }

        if (item is ItemRow) {
          return Item(description: item.description);
        }

        // Won't ever happen, but can't be explained to the typesystem yet
        assert(
          false,
          'Invalid case',
        );
        return SizedBox.shrink();
      },
      itemCount: items.length,
    );
  }
}

class Header extends StatelessWidget {
  const Header({
    Key key,
    @required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      padding: EdgeInsets.all(10),
      child: Text(
        title,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class Item extends StatelessWidget {
  const Item({
    Key key,
    @required this.description,
  }) : super(key: key);

  final String description;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Text(
        description,
      ),
    );
  }
}
