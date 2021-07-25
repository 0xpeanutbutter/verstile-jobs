import 'package:flutter/material.dart';
import 'package:verstile/providers/get_category.dart';

List<dynamic> catergories = [];

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void getCategories() async {
    try {
      catergories = await ApiCalls().fetchCategories();
      setState(() {});
      print(catergories.length);
    } catch (error) {
      print(error.toString());
    }
  }

  @override
  void initState() {
    getCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(widget.title)),
      ),
      body: Center(
        child: catergories.length != 0
            ? ListView.builder(
                itemBuilder: (context, index) {
                  final item = catergories[index];
                  return ListTile(
                    title: Text(item.name),
                    subtitle: Text(item.slug),
                  );
                },
                itemCount: catergories.length,
              )
            : CircularProgressIndicator(),
      ),
    );
  }
}

// class DemoApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return new Scaffold(
//       appBar: new AppBar(title: new Text('Nested ListView Example')),
//       body: new Center(
//         child: new ListView(
//           children: <Widget>[
//             new Container(
//               height: 80.0,
//               child: new ListView(
//                 scrollDirection: Axis.horizontal,
//                 children: new List.generate(10, (int index) {
//                   return new Card(
//                     color: Colors.blue[index * 100],
//                     child: new Container(
//                       width: 50.0,
//                       height: 50.0,
//                       child: new Text("$index"),
//                     ),
//                   );
//                 }),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
