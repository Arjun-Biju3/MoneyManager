import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

import 'package:money_new/models/category/category_model.dart';

const CATEGORY_DB_NAME = 'CATEGORY-DATABASE';

abstract class CategoryDbFunctions{
 Future <List<CategoryModel>> getCategories();
  Future <void> insertCategory(CategoryModel value);
  Future<void> deleteCategory(String categoryId);
}

class CategoryDb implements CategoryDbFunctions
{

CategoryDb._internal();
static CategoryDb instance =CategoryDb._internal();

factory CategoryDb(){
  return instance;
}


ValueNotifier<List<CategoryModel>> incomeCategoryListListener =ValueNotifier([]);
ValueNotifier<List<CategoryModel>> expenseCategoryListListener =ValueNotifier([]);
  
  @override
  Future<void> insertCategory(CategoryModel value) async {
  final _categoryDb =await  Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
  await _categoryDb.put(value.id,value);
  
  refreshUi();
  }
  
  @override
  Future<List<CategoryModel>> getCategories() async{
   final _categoryDb =await  Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
   return _categoryDb.values.toList();
  }
 Future<void> refreshUi()async{
  final _allCategories=await getCategories();
  incomeCategoryListListener.value.clear();
  expenseCategoryListListener.value.clear();
 await Future.forEach(_allCategories, (CategoryModel category){
    if(category.type == CategoryType.income)
    {
      incomeCategoryListListener.value.add(category);
    }
    else{
      expenseCategoryListListener.value.add(category);
    }
  });
  incomeCategoryListListener.notifyListeners();
  expenseCategoryListListener.notifyListeners();
 }
 
  @override
  Future<void> deleteCategory(String categoryId)async {
     final _categoryDb =await  Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
     _categoryDb.delete(categoryId);
     refreshUi();
   
  }
  
}