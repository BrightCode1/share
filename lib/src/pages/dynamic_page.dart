import 'package:flutter/material.dart';

class DynamicPage extends StatefulWidget {
  final dynamic data;
  const DynamicPage({Key key, @required this.data}) : super(key: key);

  @override
  _DynamicPageState createState() => _DynamicPageState();
}

class _DynamicPageState extends State<DynamicPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(widget.data['text']),
      ),
    );
  }
}
