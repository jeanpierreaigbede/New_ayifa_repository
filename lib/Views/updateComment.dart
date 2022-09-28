import 'package:crudayifa/Services/ApiServices.dart';
import 'package:crudayifa/Views/LesArticles.dart';
import 'package:crudayifa/Views/commentPage.dart';
import 'package:crudayifa/Views/component.dart';
import 'package:flutter/material.dart';
import 'package:crudayifa/Models/alert_helper.dart';
import 'package:http/http.dart' as http;
import 'package:crudayifa/Services/globals.dart' as globals;


class UpdateComment extends StatefulWidget {
  final int id_article;
  final int id_comment ;
  final String contenu ;
  UpdateComment({Key? key,required this.id_article,required this.id_comment, required this.contenu}) : super(key: key);

  @override
  State<UpdateComment> createState() => _UpdateCommentState();
}

class _UpdateCommentState extends State<UpdateComment> {


  @override
  Widget build(BuildContext context) {
    TextEditingController contenucontroller = TextEditingController(text: widget.contenu);
    return Scaffold(
      backgroundColor: Colors.orange,
      body: SafeArea(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 40),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidget(text: "Modifier ce Commentaire",color: Colors.white,fontsize: 40,),
                  const SizedBox(height: 50, ),
                  // TextWidget(text: "Titre de l'article",color: Colors.white,),
                  const SizedBox(height: 10,),
                  // ArticleTextfield(titrecontroller,  "titre", 1),
                  const SizedBox(height: 15,),
                  // TextWidget(text: "Contenu du commentaire",color: Colors.white,),
                  const SizedBox(height: 10,),
                  ArticleTextfield(contenucontroller,  "Contenu du commentaire", 5),
                  const SizedBox(height: 20,),
                  InkWell(
                    onTap: (){
                      if(validtext(contenucontroller.text)){

                      }
                      else{
                        AlertHelper().error(context, "Veuillez bien remplir le contenu du commentaire");
                      }
                    },
                    child: AppButton(widget: TextWidget(text: 'Modifier',fontsize: 20,color: Colors.white,),
                      color: Colors.teal,),
                  ),
                  const SizedBox(height: 20,),
                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context){
                        return CommentPage(id: widget.id_article);
                      }));
                    },
                    child: AppButton(widget: TextWidget(text: 'Annuler',fontsize: 20,color: Colors.white,),
                      color: Colors.red,),
                  )
                ],
              ),
            ),
          )),
    );
  }
  /*void create(String titre, String content) async
  {
    if(validtext(titre) && validtext(content)){
      var response = await http.post(
          Uri.parse("http://post-app.herokuapp.com/api/articles"),
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
        AlertHelper().error(context, "Commentaire Ajouté");
        Navigator.push(context, MaterialPageRoute(builder: (context){
          return LesArticles();
        }));
      }
      else{
        AlertHelper().error(context, " Une erreur s'est produite");
      }
    }
    else{
      //veuillez remplir tout les champ

      AlertHelper().error(context, "Veuillez remplir convenablement tous les champs");

    }
  }*/
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
