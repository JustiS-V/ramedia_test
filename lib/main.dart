import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/navigation/navigation_bloc.dart';
import 'components/pages/greyPages.dart';

void main() {
  runApp(BlocProvider(
    create: (context) => NavigationBloc(),
    child: MyApp(),
  ),);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        // '/whitePage': (context) => OptionPage(),
        '/webview': (context) => GreyPage(),

      },
      initialRoute: '/webview',
    );
  }
}
