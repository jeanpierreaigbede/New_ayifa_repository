import 'package:crudayifa/Controlleur/article_controlleur.dart';
import 'package:crudayifa/Models/alert_helper.dart';
import 'package:crudayifa/Services/ApiServices.dart';
import 'package:crudayifa/Views/AddArticle.dart';
import 'package:crudayifa/Views/article_page.dart';
import 'package:crudayifa/Views/component.dart';
import 'package:crudayifa/Views/update_file.dart';
import 'package:flutter/material.dart';
import 'package:crudayifa/Services/globals.dart' as globals;
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import '../Models/article.dart';

class LesArticles extends StatefulWidget {
  const LesArticles({Key? key}) : super(key: key);

  @override
  State<LesArticles> createState() => _LesArticlesState();
}

class _LesArticlesState extends State<LesArticles> {
  final ArticleControlleur articleControlleur = Get.put(ArticleControlleur());

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      /*appBar: AppBar(
        centerTitle: true,
        title: const Text('Les articles'),
      ),*/
      body: SafeArea(child: Column(
        children: [
          Container(
            height: 100,
            color: const  Color(0xff52c18e),
            child:Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextWidget(text: "Les Articles",fontsize: 20,color:Colors.white,),
          InkWell(
          onTap: (){
              Navigator.push(context,
                  MaterialPageRoute(builder: (context){
                    return AddArticle();
                  }));
          },
          child: Container(
            padding: const EdgeInsets.only(top: 8,right: 7,left: 7,bottom: 12),
            height: 50,
            width: MediaQuery.of(context).size.width*0.6,
            decoration:const  BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: TextWidget(text: "Ajouter",fontsize: 20,),
          ),
        )
              ],
            ) 
          ),
          //Container(height: 10,color: Colors.red,),
          Expanded(
                child: Obx((){
                  if(articleControlleur.isloading.value){
                    return const Center(child: CircularProgressIndicator(color: Colors.green,),);
                  }
                  else{
                    return  ListView.builder(
                        itemCount: articleControlleur.articleList.length,
                        itemBuilder: (context , index){
                          return GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
                                return ArticlePage(index: articleControlleur.articleList[index].id);
                              }));
                            },
                            child: Card(
                              color: (index % 2 == 0) ? Colors.white : Colors.black26,
                              elevation: 10.5,
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(20)),
                                    color: (index.isEven) ? Colors.white54 : Colors.black
                                ),
                                padding: const EdgeInsets.all(20),
                                // height: 220,
                                child: Center(

                                  child: Column(
                                    children: [
                                      Text(articleControlleur.articleList[index].titre.toUpperCase(),
                                        style: const  TextStyle(
                                            color: Colors.red,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold
                                        ),),
                                      const SizedBox(height: 15,),

                                      Text(articleControlleur.articleList[index].contenu,
                                        textAlign: TextAlign.center,
                                        style:  TextStyle(
                                            color: (index.isEven) ? Colors.black : Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold
                                        ),),
                                      const SizedBox(height: 15,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          TextWidget(text: "Mis à jour le :",color: (index.isEven)?Colors.black : Colors.white,),
                                          TextWidget(text: articleControlleur.articleList[index].updatedAt.toString(),color: (index.isEven)?Colors.black : Colors.white,)
                                        ],
                                      ),
                                      const SizedBox(height: 10,),
                                      Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            InkWell(
                                                onTap:(){
                                                  Navigator.push(context, MaterialPageRoute(builder: (context){
                                                    return Update(index:articleControlleur.articleList[index].id);
                                                  }));
                                                } ,
                                                child: Container(
                                                  height: 50,
                                                  width: 50,
                                                  decoration:const BoxDecoration(
                                                      color:  Color(0xff52c18e),
                                                      borderRadius: BorderRadius.all(Radius.circular(10))
                                                  ),
                                                  alignment: Alignment.center,
                                                  child:const Icon(Icons.edit,size: 25,color: Colors.white,),
                                                )
                                            ),
                                            InkWell(
                                                onTap:(){
                                                  AlertHelper().supprimer(context, "Voulez-vous vraiment supprimer cet article ?", ApiService().supprimerArticle(articleControlleur.articleList[index].id,context));
                                                } ,
                                                child: Container(
                                                  height: 50,
                                                  width: 50,
                                                  decoration:const BoxDecoration(
                                                      color: Colors.red,
                                                      borderRadius: BorderRadius.all(Radius.circular(10))
                                                  ),
                                                  alignment: Alignment.center,
                                                  child: const Icon(Icons.delete,size: 25,color: Colors.white,),
                                                )
                                            ),
                                            InkWell(
                                                onTap: (){
                                                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
                                                    return ArticlePage(index: articleControlleur.articleList[index].id);
                                                  }));
                                                },
                                                child: Container(
                                                  height: 60,
                                                  width: MediaQuery.of(context).size.width*0.4,
                                                  decoration:const  BoxDecoration(
                                                      color: Color(0xff52c18e) ,
                                                      borderRadius: BorderRadius.all(Radius.circular(10))
                                                  ),
                                                  alignment: Alignment.center,
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                    children: [
                                                      TextWidget(text: "Voir Plus",color: Colors.white,fontsize: 15,),
                                                      const  Icon(Icons.forward,color: Colors.white,size: 20,)
                                                    ],
                                                  ),
                                                )
                                            )

                                          ]
                                      ),
                                    ],
                                  ) ,
                                ),
                              ),
                            ),
                          );
                        });
                }

                }

          )
          )
        ],
      ),
          )
    );
  }

}
