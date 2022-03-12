
import 'package:equatable/equatable.dart';

class Score extends Equatable {
  int? id;
  final DateTime date;
  final int score;

  Score({required this.date, required this.score});
  Score.withId({required this.date, required this.score, required this.id});

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{};
    map['date'] = date.toIso8601String();
    map['score'] = score;
    map['id'] = id;
    return map;
  }

  factory Score.fromMap(Map<String, dynamic> map) {
    return Score.withId(
      date: DateTime.parse(map['date']),
      score: map['score'],
      id: map['id'],
    );
  }

  @override
  List<Object?> get props => [score];
}
