import 'package:flutter/material.dart';

import 'package:infinity_page_view_astro/infinity_page_view_astro.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'infinity_page_view'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late String label;
  late int itemCount;
  late InfinityPageController infinityPageController;

  @override
  void initState() {
    infinityPageController = InfinityPageController(initialPage: 0);
    itemCount = 3;
    label = "1/$itemCount";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Column(
          children: <Widget>[
            SizedBox(
              height: 300.0,
              child: InfinityPageView(
                itemBuilder: (BuildContext context, int index) {
                  switch (index) {
                    case 0:
                      return Image.network(
                        "http://via.placeholder.com/350x150",
                        fit: BoxFit.fill,
                      );
                    case 1:
                      return Image.network(
                        "http://via.placeholder.com/250x100",
                        fit: BoxFit.fill,
                      );
                  }
                  return Image.network(
                    "http://via.placeholder.com/288x188",
                    fit: BoxFit.fill,
                  );
                },
                itemCount: itemCount,
                onPageChanged: (int index) {
                  setState(() {
                    label = "${index + 1}/$itemCount";
                  });
                },
                controller: infinityPageController,
              ),
            ),
            Text(
              label,
              style: TextStyle(fontSize: 100.0),
            ),
            Row(
              children: <Widget>[
                TextButton(
                    onPressed: () {
                      print("the page is ${infinityPageController.page}");

                      infinityPageController.animateToPage(
                          infinityPageController.page - 1,
                          duration: new Duration(milliseconds: 300),
                          curve: Curves.ease);
                    },
                    child: new Text("left")),
                TextButton(
                    onPressed: () {
                      print("the page is ${infinityPageController.page}");

                      infinityPageController.animateToPage(
                          infinityPageController.page + 1,
                          duration: new Duration(milliseconds: 300),
                          curve: Curves.ease);
                    },
                    child: Text("right")),
                TextButton(
                    onPressed: () {
                      print("the page is ${infinityPageController.page}");

                      infinityPageController
                          .jumpToPage(infinityPageController.page - 1);
                    },
                    child: Text("left")),
                TextButton(
                    onPressed: () {
                      print("the page is ${infinityPageController.page}");

                      infinityPageController
                          .jumpToPage(infinityPageController.page + 1);
                    },
                    child: Text("right")),
              ],
            ),
          ],
        ));
  }
}
