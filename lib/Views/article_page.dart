import 'package:crudayifa/Controlleur/ArticlePageControlleur.dart';
import 'package:crudayifa/Models/Article_Specifique.dart';
import 'package:crudayifa/Models/commentaire.dart';
import 'package:crudayifa/Views/AddComment.dart';
import 'package:crudayifa/Views/addNote.dart';
import 'package:crudayifa/Views/ajoutermedia.dart';
import 'package:crudayifa/Views/commentPage.dart';
import 'package:crudayifa/Views/component.dart';
import 'package:flutter/material.dart';
import 'package:crudayifa/Services/ApiServices.dart';

import '../Models/alert_helper.dart';
import '../Models/media.dart';
import 'package:open_file/open_file.dart';
import 'package:get/get.dart';


class ArticlePage extends StatefulWidget {
  int index ;
   ArticlePage({Key? key, required this.index}) : super(key: key);

  @override
  State<ArticlePage> createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {

  List<Commentaire>? comments ;
  List<Media>? medias ;
  bool hasMedia = false ;
  bool isloading = false ;
  bool areComments = false ;
  String? note ;
  bool  notecontroller = false ;
  void getData() async{
   //  note = await ApiService().recuperer(widget.index, context);
    comments = await ApiService().getComentaire(widget.index);
    medias = await ApiService().getMedias(widget.index);

      if(medias != null && medias!.length != 0){
        setState(() {
          hasMedia = true ;
        });
      }
     /* if(note != null && double.parse(note!)>0.0)
        {
          notecontroller = true;
        }*/
  }
  @override
  void initState(){
    getData();
  }


  Widget build(BuildContext context) {
    ArticlePageControlleur articlePageControlleur = Get.put(ArticlePageControlleur(id: widget.index));
    return Scaffold(
      backgroundColor: Colors.green,
      body: Container(
          child: SafeArea(
              child: Container(
            padding: const EdgeInsets.symmetric(vertical: 30,horizontal: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    alignment: Alignment.center,
                    height: 70,
                      width: MediaQuery.of(context).size.width,
                      child: TextWidget(text: "Détail de l'article",color: Colors.white,fontsize: 28,)
                  ),
                  const SizedBox(height: 20,),
                  Expanded(child: Obx((){
                    if(articlePageControlleur.isLoading.value){
                      return const Center(child: CircularProgressIndicator(color: Colors.white,),);
                    }
                    else{
                    return ListView.builder(
                      itemCount: articlePageControlleur.article.length,
                        itemBuilder: (context,index){
                      return Container(
                        color: Colors.black12,
                          child: Column(
                            children: [
                              const SizedBox(height: 20,),
                              TextWidget(text: articlePageControlleur.article[index].titre,color: Colors.white,fontsize: 25,),
                              const SizedBox(height: 20,),
                              TextWidget(text: articlePageControlleur.article[index].contenu,color: Colors.white,fontsize: 15,),
                              const SizedBox(height: 20,),

                                    TextWidget(text: "Note :",color: Colors.white,fontsize: 20,),
                                    const SizedBox(width: 10,),
                                    TextButton(
                                        style: TextButton.styleFrom(
                                            backgroundColor: Colors.black26
                                        ),
                                        onPressed: (){
                                          Navigator.push(context, MaterialPageRoute(builder: (context){
                                            return AddNote(id: widget.index,);
                                          }));
                                        },
                                        child: TextWidget(text: "Ajouter de note",color: Colors.white,)),
                              const SizedBox(height: 20,),
                              OutlinedButton(
                                  style: ButtonStyle(
                                    //elevation: MaterialStateProperty.all(1),
                                      side: MaterialStateProperty.all(const BorderSide(width: 2,color: Colors.white)),
                                      shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
                                      padding: MaterialStateProperty.all(const EdgeInsets.symmetric(vertical: 5,horizontal: 30))
                                  ),
                                  onPressed: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context){
                                      return  CommentPage(id: widget.index);
                                    }));
                                  },
                                  child: TextWidget(text: "Voir les Commentaires",fontsize: 20,color: Colors.white,)),
                              const SizedBox(height: 20,),
                              hasMedia ? ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.white,
                                    padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 15),
                                    elevation: 2,
                                  ),
                                  onPressed: (){
                                    OpenFile.open(medias!.first.path);
                                  }, child: TextWidget(text: "Ouvir un fichier",)): Container(
                                height: 150,
                                decoration: const BoxDecoration(
                                    image: DecorationImage(
                                        image:AssetImage("images/evergreen.png"),
                                        fit: BoxFit.cover
                                    ),
                                    color: Colors.green
                                ),
                              ),

                              const SizedBox(height: 20,),

                              InkWell(
                                  onTap: (){
                                    Navigator.push(context,MaterialPageRoute(builder: (BuildContext context){
                                      return AjouterMedia(id: articlePageControlleur.article[index].id);
                                    }));
                                  },
                                  child: AppButton(color: Colors.white, widget: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.filter_drama,color: Colors.green,size: 25,),
                                      const SizedBox(width: 10,),
                                      TextWidget(text: "Ajouter un fichier media",color: Colors.green,fontsize: 20,)
                                    ],
                                  ))),
                            ],
                          ),
                      );

                    });
                    }
                  }
                  )
                  ),// media ,

                      const SizedBox(height: 20,),
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
                            return AddComment(id: widget.index,);
                          }));
                        },
                          child: AppButton(
                          color: Colors.white,
                          widget: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children:[
                          const   Icon(Icons.comment,color: Colors.green,),
                            const SizedBox(width: 20,),
                            TextWidget(text: "Ajouter un commentaire",color: Colors.green,fontsize: 20,)])
                       )
                      ),


                ],
              ),
            ),
          )),
    );
  }

}

/*
*
*  return Scaffold(
      body:  SafeArea(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 30,horizontal: 15),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextWidget(text: 'Titre',color: Colors.red,fontsize: 20,),
                  const SizedBox(height: 20,),
                  TextWidget(text: "Contenu",color: Colors.black,fontsize: 15,),
                  const SizedBox(height: 20,),
                  // media ,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextWidget(text: "Note:" + "5"),
                      const SizedBox(width: 10,),
                      TextButton(onPressed: (){},
                          child: TextWidget(text: "Ajouter une note",color: Colors.teal,)),
                    ],
                  ),
                  const SizedBox(height: 20,),
                  TextWidget(text: 'Les Commentaires',color: Colors.red,fontsize: 20,),
                  const SizedBox(height: 10,),
                  // les commentaires
                  InkWell(child: AppButton(color: Colors.red, widget: TextWidget(text: "Ajouter un commentaire",color: Colors.white,fontsize: 20,))),
                  const SizedBox(height: 20,),
                  InkWell(child: AppButton(color: Colors.red, widget: TextWidget(text: "Ajouter un fichier media",color: Colors.white,fontsize: 20,))),
                  const SizedBox(height: 20,),
                  InkWell(child: AppButton(
                    color: Colors.red,
                      widget: TextWidget(text: "Ajouter un commentaire",color: Colors.white,fontsize: 20,))),

                ],
              ),
            ),
          ),
        ),/*
        replacement: const Center(
          child: CircularProgressIndicator(color: Colors.teal,),*/


    );*/

