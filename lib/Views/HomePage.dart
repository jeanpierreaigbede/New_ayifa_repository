import 'package:crudayifa/Views/component.dart';
import 'package:crudayifa/Views/loginPage.dart';
import 'package:flutter/material.dart';


class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        decoration:const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/evergreen.png'),
            fit: BoxFit.cover
          )
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                TextWidget(text: "Welcome ",fontsize: 30,),
              TextWidget(text: 'to our mobile application...'),
              const SizedBox(height: 30,),
              InkWell(
                onTap: (){
                  Navigator.pushReplacement(context,PageRouteBuilder(
                      pageBuilder: (context,animation,secondaryAnimation)=>LoginPage(),
                    transitionsBuilder: (context,animation,SecondaryAnimation,child){
                      /*  var begin = Offset(0.0, 1.0);
                        var end = Offset.zero;
                        var curve = Curves.easeInOut ;
                        var twen = Tween(begin:begin,end:end).chain(CurveTween(curve: curve));

                        return SlideTransition(
                            position: animation.drive(twen),
                          child: child,
                        );*/
                      animation = CurvedAnimation(parent: animation, curve: Curves.ease);
                      return FadeTransition(
                        opacity: animation,
                        child: child,
                      );
                    }
                  )
                  );
                },
                child: AppButton(widget: TextWidget(text: "Get Started",
                fontsize: 25,)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
