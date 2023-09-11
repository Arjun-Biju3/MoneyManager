import 'package:flutter/material.dart';

import 'package:money_new/screens/home/screen_home.dart';

class MoneyManagerBottomNavigation extends StatelessWidget {
  const MoneyManagerBottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: ScreenHome.selectedIndexNotifier,
      builder: (ctx, updatedIndex, child) {
       return BottomNavigationBar(
        selectedItemColor: Color.fromARGB(255, 11, 205, 37),
        unselectedItemColor: Colors.grey,
        currentIndex: updatedIndex,
        onTap: (newIndex){
           ScreenHome.selectedIndexNotifier.value=newIndex;
        },
        items:const [
        BottomNavigationBarItem(icon: Icon(Icons.home),label: 'TRANSACTIONS'),
        BottomNavigationBarItem(icon: Icon(Icons.category),label: 'CATEGORY')
      ],);

      },
      
    );
  }
}