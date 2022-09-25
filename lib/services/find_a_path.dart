import 'package:pathfinder/core/dummy_data.dart';
import 'package:pathfinder/pathfinder/pathfinder.dart';
import 'package:pathfinder/services/api_service.dart';

class FindAPathService {
  bool isLocalData = false;
  static List<Pathfinder> tasks = [];

  void getTasksFromLocal() {
    for (int i = 0; i < data.length; i++) {
      var buff = Pathfinder(data[i]);
      tasks.add(buff);
    }
  }

  Future<List<Pathfinder>> getTasksFromApi(String url) async {
    List<Pathfinder> tasks = [];
    var response = await ApiService().getResponse(url);
    for (int i = 0; i < response.length; i++) {
      var buff = Pathfinder(data[i]);
      tasks.add(buff);
    }
    return tasks;
  }
}
