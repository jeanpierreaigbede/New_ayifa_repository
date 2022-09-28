
import 'dart:convert';

import 'package:crudayifa/Models/alert_helper.dart';
import 'package:crudayifa/Views/component.dart';
import 'package:crudayifa/Views/loginPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:crudayifa/Services/ApiServices.dart' ;
import 'package:crudayifa/Services/globals.dart' as globals;
import 'package:http/http.dart' as http;

import 'package:crudayifa/Views/LesArticles.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}


class _SignUpState extends State<SignUp> {
  TextEditingController emailControlleur = TextEditingController();
  TextEditingController passwordControlleur = TextEditingController();
  TextEditingController nameControlleur = TextEditingController();
  bool isback = false ;

  @override

  void enregistrement( String name,String email, String pwd) async{
    try {
      setState(() {
        isback = true ;
      });
      var url = Uri.parse("http://post-app.herokuapp.com/api/register");

      var response = await http.post(
          url,
          body:{
            'name': name,
            'email':email,
            'password':pwd
          }
      );

      if( response.statusCode == 200 )
      {
        globals.token = jsonDecode(response.body);
        print(globals.token);
        Navigator.push(context, MaterialPageRoute(builder: (context){
          return  LesArticles();
        }));
      }
      else {
        print(response.body);
        AlertHelper().error(context, "veuillez remplir convenablement tous les champs. ");
      }
      setState(() {
        isback = false ;
      });
    }
        catch(e){
          print(e.toString());

        }
  }
  Widget build(BuildContext context) {
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
                controller: emailControlleur,
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
    Widget buildPassword(){
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextWidget(text: "Mot de Passe",color: Colors.white,),
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
                    hintText: 'Au moins 8 caractères',
                    hintStyle: TextStyle(color: Colors.black45)
                )
            ),
          )
        ],
      );
    }
    Widget buildname(){
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextWidget(text: "Nom",color: Colors.white,),
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
                controller: nameControlleur,
                keyboardType: TextInputType.emailAddress,
                style: const TextStyle(
                  color: Colors.black87,
                ),
                decoration:const InputDecoration(
                    border:InputBorder.none,
                    contentPadding: EdgeInsets.only(top: 10),
                    prefixIcon: Icon(
                      Icons.person,
                      size: 30,
                      color: Color(0x9052c28e),
                    ),
                    hintText: 'Nom : Au moins trois caractères',
                    hintStyle: TextStyle(color: Colors.black45)
                )
            ),
          )
        ],
      );
    }

    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: (){
            hiddenKeyborard();
          },
          child: Stack(
              children: [
                Container(
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
                    padding: const EdgeInsets.symmetric(horizontal: 25,vertical: 120),
                    physics:const AlwaysScrollableScrollPhysics(),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextWidget(text: "Inscription",fontsize: 40,color: Colors.white,),
                        const SizedBox(height: 10,),
                        buildname(),
                        const SizedBox(height: 20,),
                        buildEmail(),
                        const SizedBox(height: 20,),
                        buildPassword(),
                        const SizedBox(height: 30,),
                        InkWell(
                          onTap: (){
                            if(validtext(nameControlleur.text) && validtext(emailControlleur.text ) && validtext(passwordControlleur.text))
                              {
                                enregistrement(nameControlleur.text, emailControlleur.text, passwordControlleur.text);
                              }
                            else {
                              AlertHelper().error(context, "Veuillez remplir convenablement tous les champs");
                            }
                          },
                          child:AppButton(widget: isback ? const Center(child: CircularProgressIndicator(color: Colors.green,),): TextWidget(text: "S'Inscrire",
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
                            TextWidget(text: "Avez-vous déja un compte ?"),
                            TextButton(onPressed: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context){
                                return LoginPage();
                              }));
                            }, child: TextWidget(text: "Se Connecter",
                              color: Colors.white,))
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
  bool validtext(String string){
    if(string.isNotEmpty && string != "")
      {
        return true ;
      }
    else{
      return false ;
    }
  }

}

