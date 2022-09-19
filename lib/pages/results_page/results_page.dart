import 'package:flutter/material.dart';

import 'package:pathfinder/pages/results_page/components/results_list.dart';
import 'package:pathfinder/pathfinder/pathfinder.dart';
import 'package:pathfinder/services/find_a_path.dart';

// ignore: must_be_immutable
class ResultsPage extends StatelessWidget {
  late List<Pathfinder> _tasks;
  // ignore: use_key_in_widget_constructors
  ResultsPage({Key? key}) {
    _tasks = FindAPathService.tasks;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Results list page')),
        body:
            // FindAPathService().isLocal
            //     ?
            ResultsList(tasks: _tasks)
        // : FutureBuilder<List<Pathfinder>>(
        //     future: FindAPathService().getTasksFromApi(),
        //     builder: ((context, snapshot) {
        //       if (snapshot.hasData) {
        //         List<Pathfinder> tasks = snapshot.data as List<Pathfinder>;
        //         return ResultsList(tasks: tasks);
        //       }

        //       if (snapshot.hasError) {
        //         return const Center(
        //           child: Text('Some error occured'),
        //         );
        //       }
        //       return const Center(
        //         child: CircularProgressIndicator(),
        //       );
        //     }),
        //   ),
        );
  }
}
