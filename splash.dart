import 'package:flutter/material.dart';
import 'package:money_new/screens/home/screen_home.dart';


class ScreenSplash extends StatefulWidget {
  
  const ScreenSplash({super.key});

  @override
  State<ScreenSplash> createState() => _ScreenSplashState();
}

class _ScreenSplashState extends State<ScreenSplash> {
@override
  void initState() {
      showSplah(context);
    super.initState();
  
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: SafeArea(child: Center(child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          
              children: [
                Expanded(child: Container()),
                
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  
                  ]),
                  SizedBox(height: 10,),
                 Text('MoneyManager',style: TextStyle(color: Color.fromARGB(255, 98, 194, 8),fontWeight: FontWeight.bold,fontSize: 35),),
            
                Expanded(child: Container(
                 child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                     Padding(
                      padding:EdgeInsets.only(bottom: 10)
                      ,child: Text('CROWN INFOTECH',style: TextStyle(color: Color.fromARGB(255, 165, 169, 166),fontSize: 10,fontWeight: FontWeight.bold),),),
                    
                     
                  ],
                 ),
                )),
              ],
              
        ),)),
    );
  }

  Future<void>showSplah(BuildContext ctx)async
  {
    await Future.delayed(Duration(seconds: 2));
    Navigator.of(ctx).pushReplacement(MaterialPageRoute(builder:(ctx){
      return ScreenHome();
    } ));
  }
}
