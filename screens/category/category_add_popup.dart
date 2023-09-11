import 'package:flutter/material.dart';
import 'package:money_new/db/category/category_db.dart';
import 'package:money_new/models/category/category_model.dart';



ValueNotifier<CategoryType> selectedCategoryNotifier = ValueNotifier(CategoryType.income);



Future<void> showCategoryAddPopup(BuildContext context) async{
  final _nameEditingController =TextEditingController();
 showDialog(
  context: context, 
  builder: (ctx){
    return SimpleDialog(
      title: Text('add category'),
      children: [
        Padding(
          padding: EdgeInsets.all(8.0),
          child: TextFormField(
            controller: _nameEditingController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'category name'),
              )
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(children: [

                RadioButton(title: 'Income', type: CategoryType.income),
                  RadioButton(title: 'Expense', type: CategoryType.expense),

                ],),
                ),

       Padding(
        padding: EdgeInsets.all(8.0),
        child: ElevatedButton(onPressed: (){
              final _name = _nameEditingController.text;
              if(_name.isEmpty )
              {
                return;
              }
              final _type =selectedCategoryNotifier.value;

             final _category = CategoryModel(id: DateTime.now().millisecondsSinceEpoch.toString(), name: _name, type: _type);
             CategoryDb().insertCategory(_category);
             Navigator.of(ctx).pop();

        }, child: Text('add')))
      ],
    );
  }
  );
}


class RadioButton extends StatelessWidget {

  final String title;
  final CategoryType type;
    
  const RadioButton({super.key,required this.title,required this.type});


  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
       ValueListenableBuilder(
        valueListenable: selectedCategoryNotifier,
         builder: (ctx,newCategory,child){
          return  Radio<CategoryType>(
          value: type,
           groupValue:newCategory,
            onChanged: (value){
              if(value == null)
              {
                return;
              }
              selectedCategoryNotifier.value = value;
              selectedCategoryNotifier.notifyListeners();
            }
            );
         }),
            Text(title)
      ],
    );
  }
}