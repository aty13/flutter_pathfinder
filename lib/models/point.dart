// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class Point extends Equatable {
  int x;
  int y;
  bool isStarting;
  bool isEnding;
  bool isBlocked;
  bool isAPath;

  Point({
    required this.x,
    required this.y,
    this.isStarting = false,
    this.isEnding = false,
    this.isBlocked = false,
    this.isAPath = false,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'x': x,
      'y': y,
    };
  }

  factory Point.fromMap(Map<String, dynamic> map) {
    return Point(
      x: map['x'] as int,
      y: map['y'] as int,
    );
  }

  int get points => x + y;

  String toJson() => json.encode(toMap());

  factory Point.fromJson(String source) =>
      Point.fromMap(json.decode(source) as Map<String, dynamic>);

  // factory Point.fromString(String source) {
  //   List<int> list = source
  //       .substring(1, source.length - 2)
  //       .split(',')
  //       .map((e) => int.parse(e))
  //       .toList();

  //   return Point(
  //     x: list[0],
  //     y: list[1],
  //   );
  // }

  Point copyWith({
    int? x,
    int? y,
    bool? isStarting,
    bool? isEnding,
    bool? isBlocked,
    bool? isAPath,
  }) {
    return Point(
      x: x ?? this.x,
      y: y ?? this.y,
      isStarting: isStarting ?? this.isStarting,
      isEnding: isEnding ?? this.isEnding,
      isBlocked: isBlocked ?? this.isBlocked,
      isAPath: isAPath ?? this.isAPath,
    );
  }

  @override
  List<Object?> get props => [x, y];

  @override
  bool get stringify => false;

  @override
  String toString() {
    return '($x,$y)';
  }
}
