import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:money_new/db/category/category_db.dart';
import 'package:money_new/db/category/transactions/transaction_db.dart';
import 'package:money_new/models/category/category_model.dart';


class ScreenTransactions extends StatelessWidget {
  const ScreenTransactions({super.key});

  @override
  Widget build(BuildContext context) {
   
    TransactionDb.instance.refresh();
    CategoryDb.instance.refreshUi();
    return ValueListenableBuilder(
      valueListenable: TransactionDb.instance.transactionListNotifier,
       builder: (ctx,newList,child){
        return ListView.separated(
      padding: EdgeInsets.all(10),
      itemBuilder: (ctx,index){
        final _value =newList[index];
         return Slidable(
          key: Key(_value.id!),
          startActionPane: ActionPane(
            motion:ScrollMotion() ,
             children:[ SlidableAction(onPressed: (ctx){
              TransactionDb.instance.deleteTransaction(_value.id!);

             },icon: Icons.delete,label: 'Delete',)],),
           child: Card(
            elevation: 0,
             child: ListTile(
              leading: CircleAvatar(
                backgroundColor: _value.type == CategoryType.income? Color.fromARGB(255, 5, 171, 11):Color.fromARGB(255, 253, 23, 6),
                radius: 50,
                child: Text(parseDate(_value.date),textAlign: TextAlign.center,style: TextStyle(color: Color.fromARGB(255, 252, 250, 250)),),),
              title: Text('RS ${_value.amount}'),
              subtitle: Text(_value.category.name),
             ),
           ),
         );
      },
       separatorBuilder: (ctx,index){
        return const SizedBox(height: 10,);
       }, 
       itemCount: newList.length);
       });
  }

String parseDate(DateTime date)
{
 final _date = DateFormat.MMMd().format(date);
 final _splitDate = _date.split('  ');
 return '${_splitDate.first}';
  //return '${date.day}\n${date.month}';
}

}