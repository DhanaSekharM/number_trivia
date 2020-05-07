part of 'number_trivia_bloc.dart';

abstract class NumberTriviaEvent extends Equatable {
  const NumberTriviaEvent();

  @override
  List<Object> get props => const <dynamic>[];
}

class GetTriviForConcreteNumber extends NumberTriviaEvent {
  final String numberString;

  GetTriviForConcreteNumber(this.numberString);

  @override
  List<Object> get props => [numberString];

}

class GetTriviaForRandomNumber extends NumberTriviaEvent {}