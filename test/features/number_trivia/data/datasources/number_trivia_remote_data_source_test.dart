import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:matcher/matcher.dart';
import 'package:number_trivia/core/error/exception.dart';
import 'package:number_trivia/features/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:number_trivia/features/number_trivia/data/models/number_trivia_model.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  MockHttpClient httpClient;
  NumberTriviaRemoteDataSourceImpl dataSource;

  setUp(() {
    httpClient = MockHttpClient();
    dataSource = NumberTriviaRemoteDataSourceImpl(httpClient);
  });

  group('concrete number trivia', () {
    final tNumber = 1;
    final tNumberTriviaModel = NumberTriviaModel('test', tNumber);
    test('get request', () async {
      when(httpClient.get(any, headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response(fixture('trivia.json'), 200));

      final result = await dataSource.getConcreteNumberTrivia(tNumber);

      verify(httpClient.get('http://numbersapi.com/$tNumber',
          headers: {'Content-Type': 'application/json'}));
      expect(result, equals(tNumberTriviaModel));
    });

    test('error get request', () async {
      when(httpClient.get(any, headers: anyNamed('headers'))).thenAnswer(
        (_) async => http.Response('Something went wrong', 404),
      );
      final call = dataSource.getConcreteNumberTrivia;
      expect(() => call(tNumber), throwsA(TypeMatcher<ServerException>()));
    });
  });
}
