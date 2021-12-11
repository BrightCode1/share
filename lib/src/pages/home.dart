import 'package:content_share/src/firebase/dynamic_link.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String generatedLink = 'No Link Generated';
  bool isGenerated = false;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: [
        Text(generatedLink),
        const SizedBox(height: 15),
        ElevatedButton(
          child: Text("Generate Link"),
          style: ElevatedButton.styleFrom(
              enableFeedback: true,
              primary: Colors.redAccent,
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
              elevation: 2,
              side: BorderSide.none),
          onPressed: () async {
            String joinUrl = "link?text=This is the parameter";
            Uri url = await DynamicLinkController().createDynamicLink(
                context,
                joinUrl,
                "Social Title",
                "Social Description",
                "Social image.png");
            generatedLink = url.toString();
            setState(() {});
          },
        ),
        const SizedBox(height: 15),
      ],
    ));
  }
}
