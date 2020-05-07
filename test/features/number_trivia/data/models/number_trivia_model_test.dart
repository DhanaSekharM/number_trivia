import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:number_trivia/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:number_trivia/features/number_trivia/domain/entities/number_trivia.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final tNumberTriviaModel = NumberTriviaModel('test', 1);
  final tJsonMap = {
    'text': 'test',
    'number': 1
  };

  group('Number trivia model test', () {
    test('Number trivia model test', () async {
      expect(tNumberTriviaModel, isA<NumberTrivia>());
    });

    test('trivia.json test', () async {
      final Map<String, dynamic> jsonMap = json.decode(fixture('trivia.json'));
      final result = NumberTriviaModel.fromJson(jsonMap);
      expect(result, tNumberTriviaModel);
    });

    test('trivia_double.json test', () async {
      final Map<String, dynamic> jsonMap = json.decode(fixture('trivia_double.json'));
      final result = NumberTriviaModel.fromJson(jsonMap);
      expect(result, tNumberTriviaModel);
    });

    test('toJson test', () async {
      final result = tNumberTriviaModel.toJson();
      expect(result, tJsonMap);
    });

  });
}
