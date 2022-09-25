// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:developer';

import 'package:pathfinder/models/point.dart';
import 'package:pathfinder/models/task.dart';

class Pathfinder {
  late String id;
  late Task _task;
  late Point _currentPoint;
  final List<Point> _steps = [];
  String _resultMessage = '';
  // late int _distance; //TODO:

  Pathfinder(Map<String, dynamic> map) {
    _task = Task(
      id: map['id'],
      matrix: returnMatrix(map['field']),
      start: Point.fromMap(map['start']),
      end: Point.fromMap(map['end']),
    );
    id = _task.id;
    _currentPoint = _task.start;
    runToEnd();
  }

  Task get task => _task;

  Point get currentPoint => _currentPoint;

  List<Point> get steps => _steps;

  String get resultMessage => _resultMessage;

  void setResultMessage(String message) {
    _resultMessage = message;
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'result': {
        'steps': [..._steps],
        'path': '',
      },
    };
  }

  /// Pathfinder
  /// sum of indexes starting and ending
  /// nextmove > starting checks closest points
  /// if closestPointNotBlocked && endingSum - closestPoint > other closestPoints
  /// currentmove = closestpoint

  void runToEnd() {
    if (_task.start.isBlocked || _task.end.isBlocked) {
      setResultMessage('-1');
      return;
    }

    while (getValidNeighbours(_currentPoint).isNotEmpty) {
      makeAMove();
    }

    if (_currentPoint == _task.end) {
      String message = '';
      for (Point result in _steps) {
        message += '$result->';
      }
      setResultMessage(message.substring(0, message.length - 2));
    } else {
      setResultMessage('-1'); // moves are over
    }
  }

  void makeAMove() {
    List<Point> possibleMoves = getValidNeighbours(_currentPoint);

    _currentPoint = getValidNeighbours(_currentPoint).reduce((value, element) {
      if (value.points >= element.points) {
        return Point(x: value.x, y: value.y);
      } else {
        return Point(x: element.x, y: element.y);
      }
    });
    _task.matrix[_currentPoint.x][_currentPoint.y].isAPath = true;
    _steps.add(_currentPoint);
    log('current point is: $_currentPoint');

    // if (task.end.x > _currentPoint.x &&
    //     task.end.y > _currentPoint.y &&
    //     possibleMoves.any(
    //       (element) =>
    //           element == Point(x: _currentPoint.x + 1, y: _currentPoint.y + 1),
    //     )) {
    //   _currentPoint = Point(x: _currentPoint.x + 1, y: _currentPoint.y + 1);
    // }

    // if (task.end.x > _currentPoint.x &&
    //     task.end.y < _currentPoint.y &&
    //     possibleMoves.any(
    //       (element) =>
    //           element == Point(x: _currentPoint.x + 1, y: _currentPoint.y - 1),
    //     )) {
    //   _currentPoint = Point(x: _currentPoint.x + 1, y: _currentPoint.y - 1);
    // }

    // if (task.end.x < _currentPoint.x &&
    //     task.end.y > _currentPoint.y &&
    //     possibleMoves.any(
    //       (element) =>
    //           element == Point(x: _currentPoint.x - 1, y: _currentPoint.y + 1),
    //     )) {
    //   _currentPoint = Point(x: _currentPoint.x - 1, y: _currentPoint.y + 1);
    // }

    // if (task.end.x < _currentPoint.x &&
    //     task.end.y < _currentPoint.y &&
    //     possibleMoves.any(
    //       (element) =>
    //           element == Point(x: _currentPoint.x - 1, y: _currentPoint.y - 1),
    //     )) {
    //   _currentPoint = Point(x: _currentPoint.x - 1, y: _currentPoint.y = 1);
    // }
  }

  List<Point> getValidNeighbours(Point current) {
    List<Point> validNeighbours = [];
    List<Point> possibleDirections = getPossibleDirections(current);

    for (var direction in possibleDirections) {
      if (isPointValid(_task, direction) && !direction.isBlocked) {
        validNeighbours.add(direction);
      }
    }

    return validNeighbours;
  }

  List<Point> getPossibleDirections(Point current) {
    return [
      /// Indexes of neighbours
      /// x + 1, y + 1
      /// x - 1, y - 1
      /// x - 1 , y = y
      /// x = x, y - 1
      /// x - 1, y + 1
      /// x = x, y + 1
      /// x + 1, y = y
      /// x + 1, y - 1

      Point(x: current.x + 1, y: current.y + 1),
      Point(x: current.x - 1, y: current.y - 1),
      Point(x: current.x, y: current.y - 1),
      Point(x: current.x - 1, y: current.y + 1),
      Point(x: current.x, y: current.y + 1),
      Point(x: current.x, y: current.y + 1),
      Point(x: current.x + 1, y: current.y),
      Point(x: current.x + 1, y: current.y - 1),
    ];
  }

  // TODO:
  // int getDistanceToTarget(Task task, Point currentPoint) {
  //   int result = 0;
  //   for (int i = 0; i < task.end.x; i++) {
  //     for (int j = 0; j < task.end.y; j++) {}
  //   }
  // }

  /// [Point] part

  bool isPointStarting(Point point) => _task.start == point;

  bool isPointEnding(Point point) => _task.end == point;

  bool isPointValid(Task task, Point point) {
    return point.x >= 0 &&
        point.y >= 0 &&
        point.x < task.matrix.length &&
        point.y < task.matrix.length &&
        !_steps.any((step) => step == point);
  }

  /// Matrix part
  static List<List<Point>> returnMatrix(List<String> input) {
    List<List<Point>> result = [];

    for (int row = 0; row < input.length; row++) {
      List<Point> buff = input[row]
          .split('')
          .map((e) => e.contains('.')
              ? Point(x: 0, y: 0, isBlocked: true)
              : Point(x: 0, y: 0))
          .toList();

      for (int column = 0; column < buff.length; column++) {
        buff[column].x = column;
        buff[column].y = row;
      }
      result.add(buff);
    }

    return result;
  }

  List<Point> getMatrixInList() {
    List<Point> widgetList = [];
    for (var row in task.matrix) {
      for (var item in row) {
        widgetList.add(item);
      }
    }
    return widgetList;
  }
}
