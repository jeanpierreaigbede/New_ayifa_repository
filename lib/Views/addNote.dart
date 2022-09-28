import 'package:crudayifa/Services/ApiServices.dart';
import 'package:crudayifa/Views/LesArticles.dart';
import 'package:crudayifa/Views/article_page.dart';
import 'package:crudayifa/Views/component.dart';
import 'package:flutter/material.dart';
import 'package:crudayifa/Models/alert_helper.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:crudayifa/Services/globals.dart' as globals;

class AddNote extends StatefulWidget {
  int id ;
   AddNote({Key? key,required this.id}) : super(key: key);

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {

  TextEditingController contenucontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 40),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextWidget(text: "Ajout d'une note",color: Colors.teal,fontsize: 40,),
                  const SizedBox(height: 50, ),

                  TextWidget(text: "La note :",color: Colors.teal,),
                  const SizedBox(height: 10,),
                  ArticleTextfield(contenucontroller,  "une note : un seul caractere", 1),
                  const SizedBox(height: 20,),
                  InkWell(
                    onTap: (){
                  if(validtext(contenucontroller.text) && contenucontroller.text.length==1 ){
                    ajouter(widget.id, contenucontroller.text);
                  }
                    },
                    child: AppButton(widget: TextWidget(text: 'Ajouter',fontsize: 20,color: Colors.white,),
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
    );
  }
  void ajouter(int id,String note) async
  {
    var response = await http.post(
        Uri.parse("http://post-app.herokuapp.com/api/rates"),
        body: {
          "rate":note,
          "article_id":id.toString()
        },
        headers:<String , String> {
         //'Content-type': 'application/json;charset=UTF-8',
          'Authorization':  "Bearer ${globals.token}",
         // 'Accept':'application/json'
        }
    );
    if(response.statusCode == 200){
      AlertHelper().info(context, "Note ajoutée avec succès");
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
        return ArticlePage(index: widget.id);
      }));
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
