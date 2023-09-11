import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

import 'package:money_new/models/category/category_model.dart';
import 'package:money_new/models/transactions/transaction_model.dart';
import 'package:money_new/screens/add_transaction/screen_add_transaction.dart';
import 'package:money_new/splash.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
 await Hive.initFlutter();

if(!Hive.isAdapterRegistered(CategoryTypeAdapter().typeId))
 {
  Hive.registerAdapter(CategoryTypeAdapter());
 }


 if(!Hive.isAdapterRegistered(CategoryModelAdapter().typeId))
 {
  Hive.registerAdapter(CategoryModelAdapter());
 }
if(!Hive.isAdapterRegistered(TransactionModelAdapter().typeId))
 {
  Hive.registerAdapter(TransactionModelAdapter());
 }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
      
        primaryColor: Colors.indigo
      ),
      home: ScreenSplash(),
      routes: {
           ScreenAddTransaction.routeName:(ctx) => const ScreenAddTransaction(),
      },
    );
  }
}

