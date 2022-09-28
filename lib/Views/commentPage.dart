import 'package:crudayifa/Models/alert_helper.dart';
import 'package:crudayifa/Models/commentaire.dart';
import 'package:crudayifa/Services/ApiServices.dart';
import 'package:crudayifa/Views/component.dart';
import 'package:crudayifa/Views/updateComment.dart';
import 'package:flutter/material.dart';

import 'AddComment.dart';
import 'LesArticles.dart';


class CommentPage extends StatefulWidget {
  int id ;
 CommentPage({Key? key, required  this.id}) : super(key: key);

  @override
  State<CommentPage> createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  List<Commentaire>? comments;

  bool isloading = false;
  bool isempty = true;

  void getData() async {
    comments = await ApiService().getComentaire(widget.id);
    print(comments);
    if (comments != null) {
      setState(() {
        isloading = true;
      });
      if(comments?.length != 0){
        setState(() {
          isempty = false;
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(

            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  alignment: Alignment.topCenter,
                  color: Colors.green,
                  padding: const EdgeInsets.all(15),
                  height: 100,
                  child: const Text(
                    'Les commentaires', textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.italic
                    ),),
                ),
               // Container(height: 40,color: Colors.red,),
               isempty ? Container(
                 child: Center(child:TextWidget(text: "Aucun commentaire pour cet article",fontsize: 20,) ,),
               ) : Expanded(
                  child: ListView.builder(
                    // scrollDirection: Axis.horizontal,
                    itemCount: comments?.length,
                    itemBuilder: (context, index) {
                      return Card(
                        color: Colors.orange,
                        elevation: 5,
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            color: Colors.orange,
                            borderRadius: BorderRadius.circular(10)
                          ),
                         // height: 50,
                          child: Column(
                            children: [
                              TextWidget(text: "Commentaire n°${index+1}",fontsize: 20,),
                              const SizedBox(height: 20,),
                              TextWidget(text: comments![index].contenu,color: Colors.white,),
                              const SizedBox(height: 20,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  OutlinedButton(
                              child:
                                  TextWidget(text: "Modifier",fontsize: 20,color: Colors.white,),
                                    style: ButtonStyle(
                                      //elevation: MaterialStateProperty.all(1),
                                        side: MaterialStateProperty.all(BorderSide(width: 2,color: Colors.white)),
                                        shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
                                        padding: MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 5,horizontal: 30))
                                    ),
                                    onPressed: (){
                                     /* Navigator.push(context, MaterialPageRoute(builder: (context){
                                        return  CommentPage(id: widget.index);
                                      }));*/
                                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
                                        return UpdateComment(id_article: widget.id, id_comment: comments![index].id, contenu: comments![index].contenu);
                                      }));
                                    },
                                  ),
                                  const SizedBox(width: 20,),
                                  OutlinedButton(
                                    child: TextWidget(text: "Supprimer",fontsize: 20,color: Colors.white,),
                                    style: ButtonStyle(
                                      //elevation: MaterialStateProperty.all(1),
                                        side: MaterialStateProperty.all(BorderSide(width: 2,color: Colors.white)),
                                        shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
                                        padding: MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 5,horizontal: 30))
                                    ),
                                    onPressed: (){
                                      AlertHelper().supprimer(context, "Voulez-vous vraiment supprimer ce commentaire", ApiService().supprimerComment(widget.id, context));
                                      /* Navigator.push(context, MaterialPageRoute(builder: (context){
                                        return  CommentPage(id: widget.index);
                                      }));*/
                                    },
                                  ),

                                ],
                              )

                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 20,),
                InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
                        return AddComment(id: widget.id,);
                      }));
                    },
                    child: AppButton(
                        color: Colors.red,
                        widget: TextWidget(text: "Ajouter un commentaire",color: Colors.white,fontsize: 20,)
                    )
                ),
                const SizedBox(height: 40,),
                InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
                        return LesArticles();
                      }));
                    },
                    child: AppButton(
                        color: Colors.green,
                        widget: TextWidget(text: "Voir les Articles",color: Colors.white,fontsize: 20,)
                    )
                ),
                const SizedBox(height: 40,)
              ],
            )
        )
    );
  }

}
/*  Container(
        padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 10),
            child: Visibility(
              replacement: Center(child: const CircularProgressIndicator(color: Colors.green,)),
              visible: isloading,
              child:SafeArea(

                    child: Column(
                      children: [
                        Container(
                          color: Colors.green,
                          height: 50,
                          child: const Text('Les commentaires', textAlign: TextAlign.center,style: TextStyle(
                              color: Colors.white
                          ),),
                        ),
                        Expanded(
                          child: ListView.builder(
                            // scrollDirection: Axis.horizontal,
                            itemCount: comments?.length,
                            itemBuilder: (context , index){
                              return Card(
                                color: (index %2 == 0) ? Colors.blueGrey : Colors.white,
                                elevation: 5,
                                child: Container(
                                  color: Colors.blue,
                                  height: 50,
                                  child: Column(
                                    children: [
                                      TextWidget(text: comments![index].contenu),
                                    ],
                                  ),
                                ),
                              );
                            },),)

                      ],
                    ),
                  ),
                ) ,
              ) ,
    );
  }
}*/
/*
*  SafeArea(
        child: Visibility(
          replacement:const  Center(child: CircularProgressIndicator(),),
          visible: isloading,
            child: Container(
              height: MediaQuery.of(context).size.height,
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      color: Colors.green,
                      height: 50,
                      child: const Text('Les commentaires', textAlign: TextAlign.center,style: TextStyle(
                        color: Colors.white
                      ),),
                    ),
                    Expanded(
                      child: ListView.builder(
                     // scrollDirection: Axis.horizontal,
                      itemCount: comments?.length,
                      itemBuilder: (context , index){
                        return Card(
                          color: (index %2 == 0) ? Colors.blueGrey : Colors.white,
                          elevation: 5,
                          child: Container(
                            child: Column(
                              children: [
                                TextWidget(text: comments![index].contenu),
                              ],
                            ),
                          ),
                        );
                      },),)
                  ],
                ),
              ),
            ),
          ),
        ),*/
