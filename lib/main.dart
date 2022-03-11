
import 'package:flutter/material.dart';
import 'package:imtihon6modl/Pages/AddcardPage.dart';
import 'package:imtihon6modl/Pages/CreditCards.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Credit Cards Project',
      theme: ThemeData(fontFamily: 'Lato'),
      debugShowCheckedModeBanner: false,
      home: CreditCardPage(),
      routes: {
        CreditCardPage.id:(context)=>CreditCardPage(),
        AddCardPage.id:(context)=>AddCardPage(),
      },
    );
  }}