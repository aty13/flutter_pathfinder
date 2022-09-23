// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:pathfinder/models/point.dart';
import 'package:pathfinder/pathfinder/pathfinder.dart';

class Task {
  String id;
  List<List<Point>> matrix;
  Point start;
  Point end;

  Task({
    required this.id,
    required this.matrix,
    required this.start,
    required this.end,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'matrix': matrix.toList(),
      'start': start.toMap(),
      'end': end.toMap(),
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      matrix: Pathfinder.returnMatrix(map['field']),
      start: Point.fromMap(map['start']),
      end: Point.fromMap(map['end']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Task.fromJson(String source) =>
      Task.fromMap(json.decode(source) as Map<String, dynamic>);
}
