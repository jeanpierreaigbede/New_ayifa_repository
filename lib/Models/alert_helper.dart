import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Views/LesArticles.dart';

class AlertHelper{
  Future<void> error(BuildContext context, String error) async {
    bool isIos = (Theme.of(context).platform == TargetPlatform.iOS);
    const title = Text('Error', style: TextStyle(
      color: Colors.red,
      fontSize: 20,
      fontWeight: FontWeight.w500,
    ),);
    final explanation = Text(error);

    return showDialog(context: context,
        builder: (BuildContext  ctx){
          return (isIos) ? CupertinoAlertDialog(
            title: title,
            content: explanation,
            actions: [
              close(ctx, "OK")
            ],
          ):AlertDialog(
            contentPadding: const EdgeInsets.all(10),
            title: title,
            content: explanation,
            actions: [
              close(context, "OK")
            ],
          );
        }
    );
  }
  TextButton close(BuildContext context,String string){
    return TextButton(onPressed: (()=> Navigator.pop(context)),
        child: Text(string)
    );
  }
  Future<void> info(BuildContext context, String string) async {
    bool isIos = (Theme.of(context).platform == TargetPlatform.iOS);
    const title = Text('Information', style: TextStyle(
      color: Colors.orange,
      fontSize: 20,
      fontWeight: FontWeight.w500,
    ),);

    return showDialog(context: context,
        builder: (BuildContext ctx){
          return isIos ? CupertinoAlertDialog(
                title: title,
            content: Text(string,
              style:const  TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            actions: [
              close(ctx, "OK")
            ],
          ):AlertDialog(
            title: title,
            content: Text(string,
              style:const  TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            actions: [
              close(ctx, "OK")
            ],
          );
        });
  }
  Future<void> supprimer(BuildContext context,String string, Future<void> future) async{
    assert(future != null);
    bool isIos = (Theme.of(context).platform == TargetPlatform.iOS);
    const title = Text('Comfirmer', style: TextStyle(
      color: Colors.orange,
      fontSize: 20,
      fontWeight: FontWeight.w500,
    ),);

    return showDialog(context: context,
        builder: (BuildContext ctx){
          return isIos ? CupertinoAlertDialog(
            title: title,
            content: Text(string,
              style:const  TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            actions: [
              oui(context, string, future),
              close(ctx, "NON")
            ],
          ):AlertDialog(
            title: title,
            content: Text(string,
              style:const  TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            actions: [
              oui(context, string, future),
              close(ctx, "NON")
            ],
          );
        });
  }
  TextButton oui(BuildContext context,String string,Future<void> future, ){
    return TextButton(onPressed: (){
      future;

       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
         return LesArticles();
       }));
    },
        child: const Text("Oui", style:  TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.w500,
        ),)
    );
  }

}