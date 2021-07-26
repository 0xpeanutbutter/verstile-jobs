import 'dart:convert';
import 'package:http/http.dart' as http;

List<Category> catergoryData = [];
List<Job> jobData = [];

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

  Job({
    required this.url,
    required this.title,
    required this.companyName,
  });
}

class ApiCalls {
  Future<List> fetchCategories() async {
    List data = [];
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
    try {
      String url = 'https://remotive.io/api/remote-jobs?category=' + slug;
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        print("success");
        data = jsonDecode(response.body)["jobs"];
        print(data.length);
        data.forEach((element) {
          jobData.add(Job(
              url: element["url"],
              title: element["title"],
              companyName: element["company_name"]));
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {}
    return jobData;
  }
}
