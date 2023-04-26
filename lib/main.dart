import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Screens/home/whather_view.dart';
import 'Screens/provider/whather_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => HomeProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => HomePage(),
        },
      ),
    ),
  );
}