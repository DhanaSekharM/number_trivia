import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:number_trivia/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';

class TriviaControls extends StatefulWidget {
  @override
  _TriviaControlsState createState() => _TriviaControlsState();
}

class _TriviaControlsState extends State<TriviaControls> {
  final controller = TextEditingController();
  String inputString;
  @override
  Widget build(BuildContext context) {
   return Column(
     children: <Widget>[
       Padding(
         padding: const EdgeInsets.all(8.0),
         child: TextField(
           controller: controller,
           decoration: InputDecoration(
             border: OutlineInputBorder(),
             hintText: 'Enter number'
           ),
           onChanged: (value) {
             inputString = value;
           },
           onSubmitted: (_) {
             BlocProvider.of<NumberTriviaBloc>(context).add(GetTriviForConcreteNumber(inputString));
           },
         ),
       ),
       ButtonBar(
         children: <Widget>[
           OutlineButton(
             shape: RoundedRectangleBorder(
               side: BorderSide(color: Colors.blue),
               borderRadius: BorderRadius.circular(30.0)
              ),
              textColor: Colors.blue,
             child: Text('Get trivia'),
             onPressed: () {
               BlocProvider.of<NumberTriviaBloc>(context).add(GetTriviForConcreteNumber(inputString));
             },
           ),
           OutlineButton(
             shape: RoundedRectangleBorder(
               side: BorderSide(color: Colors.blue),
               borderRadius: BorderRadius.circular(30.0)
              ),
              textColor: Colors.blue,
             child: Text('Get random trivia'),
             onPressed: () {
               BlocProvider.of<NumberTriviaBloc>(context).add(GetTriviaForRandomNumber());
             },
           ),
         ],
       )
     ],
   );
  }
}