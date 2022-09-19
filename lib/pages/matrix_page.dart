import 'package:flutter/material.dart';
import 'package:pathfinder/models/point.dart';
import 'package:pathfinder/models/task.dart';
import 'package:pathfinder/pathfinder/pathfinder.dart';

// ignore: must_be_immutable
class MatrixPage extends StatelessWidget {
  late Pathfinder _pathfinder;
  MatrixPage({
    Key? key,
    required Pathfinder pathfinder,
  }) : super(key: key) {
    _pathfinder = pathfinder;
  }

  @override
  Widget build(BuildContext context) {
    List<List<Point>> matrix = _pathfinder.task.matrix;
    List<Point> widgetList = _pathfinder.getMatrixInList();

    return Scaffold(
      appBar: AppBar(title: const Text('Matrix Page')),
      body: Column(
        children: [
          SizedBox(
            height: 400,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: GridView.builder(
                itemCount: widgetList.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: matrix.length,
                  crossAxisSpacing: 5.0,
                  mainAxisSpacing: 5.0,
                ),
                itemBuilder: ((context, index) {
                  return _buildItem(_pathfinder.task, widgetList[index]);
                }),
              ),
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 35.0),
            child: Text(_pathfinder.resultMessage),
          ),
        ],
      ),
    );
  }

  Widget _buildItem(Task task, Point point) {
    return Container(
      decoration: BoxDecoration(
        color: getBackgroundColor(point),
        border: Border.all(color: Colors.blueAccent),
      ),
      child: Center(
        child: Text(
          '$point',
          style: TextStyle(color: getTextColor(task, point)),
        ),
      ),
    );
  }

  Color getTextColor(Task task, Point point) =>
      point.isBlocked ? Colors.white : Colors.black;

  Color getBackgroundColor(Point point) {
    Color color = Colors.white;

    if (point.isBlocked) {
      return const Color(0xFF000000);
    } else if (_pathfinder.isPointStarting(point) && !point.isBlocked) {
      return const Color(0xFF64FFDA);
    } else if (_pathfinder.isPointEnding(point)) {
      return const Color(0xFF009688);
    } else if (point.isAPath && !point.isBlocked) {
      return const Color(0xFF4CAF50);
    }

    return color;
  }
}
