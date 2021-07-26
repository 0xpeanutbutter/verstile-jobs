import 'dart:convert';
import 'package:http/http.dart' as http;

class Category {
  int id;
  String name;
  String slug;

  Category({required this.id, required this.name, required this.slug});
}

class Job {
  String url;
  String title;
  String companyName;
  String category;

  Job(
      {required this.url,
      required this.title,
      required this.companyName,
      required this.category});
}

class ApiCalls {
  Future<List> fetchCategories() async {
    List data = [];
    List<Category> catergoryData = [];

    try {
      const url = 'https://remotive.io/api/remote-jobs/categories';
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        print("success");
        data = jsonDecode(response.body)["jobs"];
        data.forEach((element) {
          catergoryData.add(Category(
              id: element["id"], name: element["name"], slug: element["slug"]));
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      print(error.toString());
    }
    return catergoryData;
  }

  Future<List<Job>> fetchJobs({String slug = "software-dev"}) async {
    List data = [];
    List<Job> jobData = [];

    try {
      String url = 'https://remotive.io/api/remote-jobs?category=' + slug;
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        data = jsonDecode(response.body)["jobs"];
        data.forEach((element) {
          jobData.add(Job(
              url: element["url"],
              title: element["title"],
              companyName: element["company_name"],
              category: slug));
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {}
    return jobData;
  }
}
