import 'dart:convert';
import 'package:http/http.dart' as http;

List<Jobs> catergoryData = [];

class Jobs {
  int id;
  String name;
  String slug;

  Jobs({required this.id, required this.name, required this.slug});
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
          catergoryData.add(Jobs(
              id: element["id"], name: element["name"], slug: element["slug"]));
        });
      } else {
        throw Exception('Failed to load post');
      }
    } catch (error) {
      print(error.toString());
    }
    return catergoryData;
  }
}
