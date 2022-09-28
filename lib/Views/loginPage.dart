
import 'dart:convert';

import 'package:crudayifa/Views/component.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:crudayifa/Views/SignUp.dart';
import 'package:crudayifa/Services/globals.dart' as globals;
import 'package:http/http.dart' as http;

import 'package:crudayifa/Views/LesArticles.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}


class _LoginPageState extends State<LoginPage> {
TextEditingController emaiControlleur = TextEditingController();
TextEditingController passwordControlleur = TextEditingController();
 bool toconect = false ;
  @override
  Widget build(BuildContext context) {
    Widget buildPassword(){
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextWidget(text: "Mot de passe",color: Colors.white,),
          const SizedBox(height: 10,),
          Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow:const [
                  BoxShadow(
                    color: Colors.black38,
                    blurRadius: 5,
                    offset: Offset(0,2),
                  )
                ]
            ),
            height: 60,
            child: TextField(
              controller: passwordControlleur,
                obscureText: true,
                keyboardType: TextInputType.emailAddress,
                style: TextStyle(
                  color: Colors.black87,
                ),
                decoration:const InputDecoration(
                    border:InputBorder.none,
                    contentPadding: EdgeInsets.only(top: 10),
                    prefixIcon: Icon(
                      Icons.lock,
                      size: 30,
                      color: Color(0x9052c28e),
                    ),
                    hintText: 'Mot de passe',
                    hintStyle: TextStyle(color: Colors.black45)
                )
            ),
          )
        ],
      );
    }
    Widget buildEmail(){
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextWidget(text: "Email",color: Colors.white,),
          const SizedBox(height: 10,),
          Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow:const [
                  BoxShadow(
                    color: Colors.black38,
                    blurRadius: 5,
                    offset: Offset(0,2),
                  )
                ]
            ),
            height: 60,
            child: TextField(
                controller: emaiControlleur,
                keyboardType: TextInputType.emailAddress,
                style: const TextStyle(
                  color: Colors.black87,
                ),
                decoration:const InputDecoration(
                    border:InputBorder.none,
                    contentPadding: EdgeInsets.only(top: 10),
                    prefixIcon: Icon(
                      Icons.email,
                      size: 30,
                      color: Color(0x9052c28e),
                    ),
                    hintText: 'Email',
                    hintStyle: TextStyle(color: Colors.black45)
                )
            ),
          )
        ],
      );
    }


    return Scaffold(
     /* appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: TextWidget(text: "Login Page",color: Colors.green,fontsize: 25,),
      ),*/
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(

          child: Stack(
            children: [ Container(
              height: double.infinity,
                width: double.infinity,
              decoration:const  BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xff52c18e),
                    Colors.green,
                    Color(0xff52c18e),
                    Colors.green
                  ]
                )
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 25,vertical: 70),
                physics:const AlwaysScrollableScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextWidget(text: "CONNEXION",fontsize: 40,color: Colors.white,),
                    const SizedBox(height: 50,),
                    buildEmail(),
                    const SizedBox(height: 20,),
                    buildPassword(),
                    TextButton(onPressed: (){
                      print("forgot password");
                    }, child: Container(
                      padding: const EdgeInsets.all(5),
                      alignment: Alignment.centerRight,
                      child: TextWidget(
                        text: 'Mot depasse oublié?',
                        color:
                        Colors.white,
                      ),
                    )),
                    const SizedBox(height: 30,),
                    InkWell(
                      onTap: (){
                       login(emaiControlleur.text,passwordControlleur.text);
                      },
                      child:AppButton(widget:toconect ? const Center(child: CircularProgressIndicator(color: Colors.green,),) :  TextWidget(text: "Se Connecter",
                        fontsize: 25,
                      color:const Color(0x8002c18e),
                      ),
                        height: 60,
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextWidget(text: "Avez-vous un compte ?"),
                        TextButton(onPressed: (){
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
                            return SignUp();
                          }));
                        }, child: TextWidget(text: "S'Inscire",
                          color: Colors.white,fontsize: 20,))
                      ],
                    )
                  ],
                ),
              )
            ),
            ]
          ),
        ),
      ),
    );
  }
void login(String email, String password) async {
    setState(() {
      toconect = true;
    });
  var url = Uri.parse("http://post-app.herokuapp.com/api/login",);
  var response = await http.post(
      url,
      body: {
        "email" : email,
        "password" :password
      }
  );
  if( response.statusCode == 200 )
  {
    globals.token = jsonDecode(response.body);
    print(globals.token);
    // ignore: use_build_context_synchronously
    setState(() {
      toconect = false ;
    });
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
      return LesArticles();
    }));
  }
}
}
