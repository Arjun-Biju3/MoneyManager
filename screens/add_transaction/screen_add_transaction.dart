import 'package:flutter/material.dart';
import 'package:money_new/db/category/category_db.dart';
import 'package:money_new/db/category/transactions/transaction_db.dart';
import 'package:money_new/models/category/category_model.dart';
import 'package:money_new/models/transactions/transaction_model.dart';


class ScreenAddTransaction extends StatefulWidget {
  static const routeName ='add-transaction';
  const ScreenAddTransaction({super.key});

  @override
  State<ScreenAddTransaction> createState() => _ScreenAddTransactionState();
}

class _ScreenAddTransactionState extends State<ScreenAddTransaction> {

DateTime? _selectedDate;
CategoryType? _selectedCategoryType;
CategoryModel? _selectedCategoryModel;
String? _categoryId;

final purposeController = TextEditingController();
final amountController = TextEditingController();


@override
  void initState() {
  _selectedCategoryType = CategoryType.income;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: purposeController,
              decoration: InputDecoration(border: OutlineInputBorder(),hintText: 'Purpose'),),
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: TextFormField(
                controller: amountController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(border: OutlineInputBorder(),hintText: 'Amount'),),
            ),
          
            
              TextButton.icon(onPressed: ()async{
         final _selectedDateTemp = await showDatePicker(
             context: context, 
             initialDate: DateTime.now(),
              firstDate: DateTime.now().subtract(Duration(days: 30)),
               lastDate: DateTime.now());

               if(_selectedDateTemp == null)
               {
                return;
               }
               else{
                print(_selectedDateTemp.toString());
                setState(() {
                  _selectedDate =_selectedDateTemp;
                });
               }

              }, icon: Icon(Icons.calendar_today), 
              label: Text(_selectedDate == null ?'select date' :_selectedDate!.toString())),
             
                 
            
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children:[ Radio(
                      value:CategoryType.income,
                       groupValue: _selectedCategoryType, 
                       onChanged: (newValue){
                      setState(() {
                          _selectedCategoryType =CategoryType.income;
                          _categoryId = null;
                      });
                       }
                       ),
                       Text('Income')
          ]), Row(
                    children:[ Radio(
                      value: CategoryType.expense,
                       groupValue: _selectedCategoryType, 
                       onChanged: (newValue){
                       setState(() {
                          _selectedCategoryType =CategoryType.expense;
                          _categoryId =null;
                       });
                       }
                       ),
                       Text('Expense')
          ]),
                ],
              ),

              DropdownButton<String>(
                hint:  const Text('select category'),
                value: _categoryId,
                items:(_selectedCategoryType == CategoryType.income
                ? 
                CategoryDb().incomeCategoryListListener
                :
                 CategoryDb.instance.expenseCategoryListListener).value.map((e) {
       return DropdownMenuItem(
        onTap: (){
          _selectedCategoryModel = e;
        },
        value: e.id,
        child: Text(e.name));
        
              }).toList() , 
              onChanged: (selectedValue){
                print(selectedValue);
               setState(() {
                  _categoryId = selectedValue;
               });
              }),
              ElevatedButton(onPressed: (){ addTransaction();}, child: Text('Submit'))
          ],
        ),
      )
      
      ),
    );
  }

  Future<void> addTransaction()async{
   final _purposeText = purposeController.text;
   final _amountText = amountController.text;

   if(_purposeText.isEmpty)
   {
    return;
   }
  if(_amountText.isEmpty)
  {
     return;
  }
 if (_categoryId == null)
 {
  return;
 }
 if(_selectedDate == null)
 {
  return;
 }
 if(_selectedCategoryType ==null)
 {
  return;
   }

final _parsedAmount = double.tryParse(_amountText);
if(_parsedAmount == null)
{
  return;
}

 // _selectedDate;
 //_selectedCategoryType;
 //_categoryId;

final _model =  TransactionModel(
  purpose: _purposeText,
   amount: _parsedAmount,
    date: _selectedDate!, 
    type: _selectedCategoryType!, 
    category: _selectedCategoryModel!
    );
    print(_purposeText);
   await TransactionDb.instance.addTransaction(_model);
   Navigator.of(context).pop();
   TransactionDb.instance.refresh();
 
  }
}