
import 'package:number_trivia/features/number_trivia/domain/entities/number_trivia.dart';

class NumberTriviaModel extends NumberTrivia {
  NumberTriviaModel(String text, int number) : super(text, number);

  factory  NumberTriviaModel.fromJson(Map<String, dynamic> jsonMap) {
    return NumberTriviaModel(jsonMap['text'], (jsonMap['number'] as num).toInt());
  }

  Map<String, dynamic> toJson() {
    return {
      'text': this.text,
      'number': this.number,
    };
  }
}