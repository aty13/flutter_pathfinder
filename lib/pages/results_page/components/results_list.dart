import 'package:flutter/material.dart';
import 'package:pathfinder/pages/matrix_page.dart';
import 'package:pathfinder/pathfinder/pathfinder.dart';

class ResultsList extends StatelessWidget {
  const ResultsList({
    Key? key,
    required List<Pathfinder> tasks,
  })  : _tasks = tasks,
        super(key: key);

  final List<Pathfinder> _tasks;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: _tasks.length,
      itemBuilder: ((context, index) {
        _tasks[index].runToEnd();
        return ListTile(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: ((context) => MatrixPage(
                      pathfinder: _tasks[index],
                    )),
              ),
            );
          },
          // ignore: unnecessary_string_interpolations
          title: Text('${_tasks[index].resultMessage}'),
        );
      }),
      separatorBuilder: (BuildContext context, int index) => const Divider(
        thickness: 1,
        color: Colors.black,
      ),
    );
  }
}
