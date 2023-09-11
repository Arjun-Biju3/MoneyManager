import 'package:flutter/material.dart';
import 'package:money_new/screens/add_transaction/screen_add_transaction.dart';
import 'package:money_new/screens/category/category_add_popup.dart';
import 'package:money_new/screens/category/screen_category.dart';
import 'package:money_new/screens/home/widgets/bottom_navigation.dart';
import 'package:money_new/screens/transactions/screen_transactions.dart';


class ScreenHome extends StatelessWidget {
  const ScreenHome({super.key});
  static ValueNotifier<int> selectedIndexNotifier= ValueNotifier(0);
  final _pages =const [ScreenTransactions(),ScreenCategory()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 11, 205, 37),
        title: Text('MONEY MANAGER'),
      centerTitle: true,),
      floatingActionButton: FloatingActionButton(
        backgroundColor:Color.fromARGB(255, 11, 205, 37),
        onPressed: (){
        if(selectedIndexNotifier.value == 0)
        {
          print('add transaction');
          Navigator.of(context).pushNamed(ScreenAddTransaction.routeName);
        }
        else{
          print('add category');
          showCategoryAddPopup(context);

         // final _sample =CategoryModel(
          //  id: DateTime.now().microsecondsSinceEpoch.toString(),
            // name: 'travel',
              //type:CategoryType.expense);
          //CategoryDb().insertCategory(_sample);
        }
        
       },child: Icon(Icons.add),),
      bottomNavigationBar:const MoneyManagerBottomNavigation(),
      body: SafeArea(
        child: 
        ValueListenableBuilder(
          valueListenable: selectedIndexNotifier,
         builder:(context,updatedIndex,child){
               return _pages[updatedIndex];
         },
    )));
  }
}