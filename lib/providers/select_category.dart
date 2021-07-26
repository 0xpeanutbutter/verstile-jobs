import 'package:flutter/foundation.dart';

import '../services/get_category.dart';

class SelectedCategory extends ChangeNotifier {
  List<Job> _data = [];
  List<Job> get data => _data;

  setcategory(List<Job> jobs) {
    _data = jobs;
    notifyListeners();
  }
}
