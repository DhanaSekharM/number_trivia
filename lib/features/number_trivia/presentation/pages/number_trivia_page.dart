import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:number_trivia/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'package:number_trivia/features/number_trivia/presentation/widgets/display_trivia.dart';
import 'package:number_trivia/features/number_trivia/presentation/widgets/loading_indicator.dart';
import 'package:number_trivia/features/number_trivia/presentation/widgets/message_display.dart';
import 'package:number_trivia/features/number_trivia/presentation/widgets/trivia_controls.dart';
import 'package:number_trivia/injection_container.dart';

class NumberTriviaPage extends  StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Number Trivia'),
      ),
      body: buildBody(),
    );
  }

  BlocProvider<NumberTriviaBloc> buildBody() {
    return BlocProvider<NumberTriviaBloc>(
      create: (_) => sl<NumberTriviaBloc>(),
      child: BlocBuilder<NumberTriviaBloc, NumberTriviaState>(
        builder: (context, state) {
          return Column(
            children: <Widget>[
              displayMessage(state),
              displayControls()
            ],
          );
        },
      )
    );
  }

  displayMessage(NumberTriviaState state) {
    if(state is Empty) {
      return MessageDisplay(message: 'Enter a number of choose random number trivia');
    }
    if(state is Error) {
      return MessageDisplay(message: state.message);
    }
    if(state is Loading) {
      return LoadingIndicator();
    }
    if(state is Loaded) {
      return DisplayTrivia(trivia: state.trivia,);
    }
    return Container();
  }

  displayControls() {
    return TriviaControls();
  }

}