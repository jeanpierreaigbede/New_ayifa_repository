import 'package:crudayifa/Models/Article_Specifique.dart';
import 'package:crudayifa/Services/ApiServices.dart';
import 'package:crudayifa/Views/LesArticles.dart';
import 'package:crudayifa/Views/component.dart';
import 'package:flutter/material.dart';
import 'package:crudayifa/Models/alert_helper.dart';
import 'package:http/http.dart' as http;
import 'package:crudayifa/Services/globals.dart' as globals;

import '../Models/article.dart';

class Update extends StatefulWidget {
  int index ;
   Update({Key? key,required this.index}) : super(key: key);

  @override
  State<Update> createState() => _Update();
}

class _Update extends State<Update> {
  bool isloading = false ;
  ArticleSpecifique? article ;
  @override
   void initState(){
    getdata();
    super.initState();
  }
  void getdata() async{
    article = await ApiService().getArticle(widget.index);
    if(article != null){
      setState(() {
        isloading = true ;
      });
    }else{
      AlertHelper().error(context, " article non récupéré");
    }
  }

  Widget build(BuildContext context) {
    TextEditingController titrecontroller = TextEditingController(text:article!.titre);
    TextEditingController contenucontroller = TextEditingController(text: article!.contenu);

    return Scaffold(
      body: Visibility(
        visible: isloading,
        child: SafeArea(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 40),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextWidget(text: "Modifier cet article",color: Colors.teal,fontsize: 40,),
                    const SizedBox(height: 50,),
                    TextWidget(text: "Titre de l'article",color: Colors.teal,),
                    const SizedBox(height: 10,),
                    ArticleTextfield(titrecontroller,  "titre", 1),
                    const SizedBox(height: 15,),
                    TextWidget(text: "Contenu de l'article",color: Colors.teal,),
                    const SizedBox(height: 10,),
                    ArticleTextfield(contenucontroller,  "contenu", 5),
                    const SizedBox(height: 20,),
                    InkWell(
                      onTap: (){
                        ModifierArticle(titrecontroller.text, contenucontroller.text, widget.index+1);
                      },
                      child: AppButton(widget: TextWidget(text: 'Modifier',fontsize: 20,color: Colors.white,),
                        color: Colors.teal,),
                    ),
                    const SizedBox(height: 20,),
                    InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context){
                          return LesArticles();
                        }));
                      },
                      child: AppButton(widget: TextWidget(text: 'Annuler',fontsize: 20,color: Colors.white,),
                        color: Colors.red,),
                    )
                  ],
                ),
              ),
            )),
        replacement:const Center(
            child: CircularProgressIndicator(color: Colors.teal,)),
      ),
    );
  }
  void ModifierArticle(String titre, String content,int id) async
  {
    if(validtext(titre) && validtext(content)){
      print(id.toString());
      var response = await http.put(
          Uri.parse("http://post-app.herokuapp.com/api/articles/$id"),
          headers:<String , String> {
            // 'Content-type': 'application/json;charset=UTF-8',
            'Authorization':  "Bearer ${globals.token}",
            "Accept" :"application/json"
          },
          body: {
            "titre" :titre,
            "contenu" :content
          }
      );
      if(response.statusCode == 200){
        AlertHelper().error(context, "Article créé avec succès");
        Navigator.push(context, MaterialPageRoute(builder: (context){
          return LesArticles();
        }));
      }
      else{
        print(response.statusCode);
        print(response.body);
        AlertHelper().error(context, " Une erreur s'est produite");
      }
    }
    else{
      //veuillez remplir tout les champ

      AlertHelper().error(context, "Veuillez remplir convenablement tous les champs");

    }
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
  Widget ArticleTextfield(TextEditingController controller,String hint, int line) {
    return TextField(
      controller:controller ,
      maxLines: line,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        hintText: hint,
        filled:true,
        fillColor: Colors.white,
        border:const  OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(27)),
          borderSide: BorderSide(
              width: 1,
              color: Colors.teal
          ),
        ),
        focusedBorder:const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(27)),
            borderSide: BorderSide(
                width: 1,
                color: Colors.teal
            )
        ),
      ),
    );
  }
}
