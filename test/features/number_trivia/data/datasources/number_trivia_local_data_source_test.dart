import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:number_trivia/core/error/exception.dart';
import 'package:number_trivia/features/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'package:number_trivia/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  MockSharedPreferences sharedPreferences;
  NumberTriviaLocalDataSourceImpl localDataSourceImpl;

  setUp(() {
    sharedPreferences = MockSharedPreferences();
    localDataSourceImpl = NumberTriviaLocalDataSourceImpl(sharedPreferences);
  });

  group('Last number trivia', () {
    final tNumberTriviaModel =
        NumberTriviaModel.fromJson(json.decode(fixture('trivia_cached.json')));

    test('cached number trivia', () async {
      when(sharedPreferences.getString(any))
          .thenReturn(fixture('trivia_cached.json'));

      final result = await localDataSourceImpl.getLastNumberTrivia();

      verify(sharedPreferences.getString(any));
      expect(result, equals(tNumberTriviaModel));
    });

    test('cache failure', () async {
      when(sharedPreferences.getString(any)).thenReturn(null);

      final call = localDataSourceImpl.getLastNumberTrivia;
      expect(() => call(), throwsA(TypeMatcher<CacheException>()));
    });
  }, skip: true);

  group('cacheNumberTrivia', () {
    final tNumberTriviaModel =
        NumberTriviaModel('test', 1);

    test('should call SharedPreferences to cache the data', () {
      localDataSourceImpl.cacheNumberTrivia(tNumberTriviaModel);
      final expectedJsonString = json.encode(tNumberTriviaModel.toJson());
      verify(sharedPreferences.setString(
        CACHED_NUMBER_TRIVIA,
        expectedJsonString,
      ));
    });
  });
}
