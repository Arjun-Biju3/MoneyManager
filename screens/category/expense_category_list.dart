import 'package:flutter/material.dart';

import 'package:money_new/db/category/category_db.dart';

class ExpenseCategoryList extends StatelessWidget {
  const ExpenseCategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable:CategoryDb().expenseCategoryListListener, 
      builder: (context,newList,child){
        return ListView.separated(
      itemBuilder: (ctx,index)
      {
        final category =newList[index];
        return Card(
          child: ListTile(
            title: Text(category.name),
            trailing: IconButton(onPressed: (){
              CategoryDb.instance.deleteCategory(category.id);
            }, icon:const Icon(Icons.delete,color: Colors.red,)),
          ),
        );
      }, 
      separatorBuilder:(ctx,index)
      {
        return SizedBox(height: 10,);
      },
       itemCount: newList.length);
      });
  }
}