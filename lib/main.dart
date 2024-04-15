import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'layout/home_layout.dart';
import 'shared/bloc_observer.dart';



void main() {
  Bloc.observer = MyBlocObserver();
  runApp(MyApp());


}
//widgets : stateless and stateful

//class MyApp
class MyApp extends StatelessWidget {

  //when obj declared we call constructor then build()

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.white,
      ),
    );
    return MaterialApp(
      debugShowCheckedModeBanner:false ,
      home: HomeLayout(),

    );
  }


}
