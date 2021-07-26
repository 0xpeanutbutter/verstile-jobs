import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:verstile/services/get_category.dart';
import 'package:verstile/providers/select_category.dart';

List<dynamic> catergories = [];
List<Job> jobs = [];
String urlSlug = "software-dev";

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
        body: SingleChildScrollView(
          child: Column(
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
                                onTap: () async {
                                  setState(() {
                                    urlSlug = item.slug;
                                  });
                                },
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
          ),
        ));
  }
}

class CategoryJobs extends StatelessWidget {
  void getJobs(SelectedCategory selectedCategory) async {
    try {
      jobs = await ApiCalls().fetchJobs(slug: urlSlug);
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
              ? Container(
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        // ignore: unnecessary_null_comparison
                        SizedBox(
                          height: 15,
                        ),
                        // ignore: unnecessary_null_comparison
                        selectedCategory.data[0].category != null
                            ? Text(
                                selectedCategory.data[0].category.toUpperCase(),
                                style:
                                    TextStyle(fontSize: 15, color: Colors.blue),
                              )
                            : Text("Software Developer"),
                        SizedBox(
                          height: 15,
                        ),
                        for (int i = 0; i < selectedCategory.data.length; i++)
                          Card(
                            color: Colors.white10,
                            margin: EdgeInsets.all(4.0),
                            child: InkWell(
                              child: ListTile(
                                title: Text(selectedCategory.data[i].title),
                                subtitle:
                                    Text(selectedCategory.data[i].companyName),
                              ),
                              onTap: () async {
                                String url = selectedCategory.data[i].url;
                                if (await canLaunch(url)) {
                                  await launch(url);
                                } else {
                                  throw "couldnt launch";
                                }
                              },
                            ),
                          )
                      ],
                    ),
                  ),
                )
              : CircularProgressIndicator(),
        );
      },
    );
  }
}
