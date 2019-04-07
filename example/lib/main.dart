import 'package:flutter/material.dart';
import 'example.dart';
import 'examples/key_derivation.dart';
import 'examples/random_data.dart';
import 'examples/version.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: HomePage());
  }
}

class HomePage extends StatelessWidget {
  final _examples = [
    Example('Common', isHeader: true),
    randomData,
    version,
    Example('Key functions', isHeader: true),
    keyDerivation
  ];

  Widget _buildListTile(BuildContext context, Example example) {
    if (example.isHeader) {
      return ListTile(
          title: Text(example.title, style: Theme.of(context).textTheme.title));
    } else {
      return ListTile(
          title: Text(example.title),
          trailing: Icon(Icons.arrow_forward_ios, size: 12.0),
          onTap: () => example.navigate(context));
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("Flutter Sodium"),
        ),
        body: SafeArea(
            child: ListView(
                children: _examples
                    .map((e) => _buildListTile(context, e))
                    .toList())));
  }
}
