import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:verstile/services/get_category.dart';
import 'package:verstile/providers/select_category.dart';

List<dynamic> catergories = [];
List<Job> jobs = [];

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
        body: Column(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height / 7,
              child: Center(
                child: catergories.length != 0
                    ? ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          final item = catergories[index];
                          return Container(
                            width: MediaQuery.of(context).size.width / 1.1,
                            child: InkWell(
                              onTap: () async {},
                              child: Card(
                                color: Colors.lightBlue[100],
                                child: Center(child: Text(item.name)),
                              ),
                            ),
                          );
                        },
                        itemCount: catergories.length,
                      )
                    : CircularProgressIndicator(),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.height / 10,
            ),
            CategoryJobs(),
          ],
        ));
  }
}

class CategoryJobs extends StatelessWidget {
  void getJobs(SelectedCategory selectedCategory) async {
    try {
      jobs = await ApiCalls().fetchJobs();
    } catch (error) {
      print(error.toString());
    }
    selectedCategory.setcategory(jobs);
  }

  @override
  Widget build(BuildContext context) {
    SelectedCategory selectedCategory =
        Provider.of<SelectedCategory>(context, listen: false);
    getJobs(selectedCategory);
    return Consumer<SelectedCategory>(
      builder: (context, value, child) {
        return Center(
          child: selectedCategory.data.length != 0
              ? Text(selectedCategory.data.length.toString())
              : CircularProgressIndicator(),
        );
      },
    );
  }
}
