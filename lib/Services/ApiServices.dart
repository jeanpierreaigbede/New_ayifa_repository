
import 'dart:convert';
import 'dart:io';

import 'package:crudayifa/Models/Article_Specifique.dart';
import 'package:crudayifa/Models/alert_helper.dart';
import 'package:crudayifa/Models/article.dart';
import 'package:crudayifa/Models/commentaire.dart';
import 'package:crudayifa/Views/LesArticles.dart';
import 'package:crudayifa/Views/commentPage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:crudayifa/Services/globals.dart' as globals;

import '../Models/media.dart';

class ApiService {

  Future<List<Article>?> getArticles() async{
    var client = http.Client();
    var url  = Uri.parse("http://post-app.herokuapp.com/api/articles");
    var response = await client.get(
      url,
        headers:<String , String> {
          'Content-type': 'application/json;charset=UTF-8',
          'Authorization':  "Bearer ${globals.token}"
        }
    );
    if(response.statusCode == 200){
      var json = jsonDecode(response.body)['articles'];
     print(json);
      return articleFromJson(jsonEncode(json));
    }
  }

  Future<ArticleSpecifique?> getArticle(int id) async {
    var client = http.Client();
    var url  = Uri.parse("http://post-app.herokuapp.com/api/articles/${id.toString()}");
    var response = await client.get(
        url,
        headers:<String , String> {
          'Content-type': 'application/json;charset=UTF-8',
          'Authorization':  "Bearer ${globals.token}",
          'Accept':'application/json'
        }

    );
    if(response.statusCode == 200){
      var json = jsonDecode(response.body)['article'];

      print(json);
      return articleSpecifiqueFromJson(jsonEncode(json));
    }
    else{
    print(response.statusCode);
    print(response.body);
    print(jsonDecode(response.body)['article']);

    }

  }

  // Récuperer un commentaire

  Future<List<Commentaire>?> getComentaire(int index) async {
    var client = http.Client();
    var url  = Uri.parse("http://post-app.herokuapp.com/api/articles/${index.toString()}");
    var response = await client.get(
        url,
        headers:<String , String> {
          'Content-type': 'application/json;charset=UTF-8',
          'Authorization':  "Bearer ${globals.token}",
          'Accept':'application/json'
        }
    );
    if(response.statusCode == 200){
      var json = jsonDecode(response.body)['commentaires'];
      // print(json['articles']);
      return commentaireFromJson(jsonEncode(json)) ;
    }
    else{
     print(response.statusCode);
     print(response.body);

    }
  }
  // Supprimer un article

  Future<void> supprimerArticle(int id,BuildContext context) async{
    var client = http.Client();
    var response = await client.delete(
      Uri.parse("http://post-app.herokuapp.com/api/articles/${id.toString()}"),
      headers:<String , String> {
        'Content-type': 'application/json;charset=UTF-8',
        'Authorization':  "Bearer ${globals.token}",
        'Accept':'application/json'
      }
    );
    if(response.statusCode == 200){
      /*AlertHelper().info(context, "Article supprimer avec succès ");
      /*Navigator.push(context, MaterialPageRoute(builder: (context){
        return LesArticles();
      }));*/*/
      print(response.body);
    }
    else{
        AlertHelper().error(context, "Une erreur s'est produite");
    }
  }

  // Ajout un media
  Future<void> AjouterMedia(int id,File file,BuildContext context) async {
    var response =await http.post(
          Uri.parse("http://post-app.herokuapp.com/api/medias"),
      body: {
            "media":file.toString(),
            "article_id":id.toString()
      },
        headers:<String , String> {
         // 'Content-type': 'application/json;charset=UTF-8',
          'Authorization':  "Bearer ${globals.token}",
          'Accept':'application/json'
        }
    );
    if(response.statusCode == 200){
      AlertHelper().info(context, "Fichier ajouté .");
    }
    else{
      AlertHelper().info(context, "Une erreur s'est produite .");
    }
  }

  // Ajouter un commentaire
  Future<void> ajouterComment(int id, String contenu, BuildContext context) async{
    var response = await http.post(
        Uri.parse("http://post-app.herokuapp.com/api/comments"),
      body: {
          "contenu":contenu,
          "article_id":id.toString()
      },
        headers:<String , String> {
         // 'Content-type': 'application/json;charset=UTF-8',
          'Authorization':  "Bearer ${globals.token}",
         // 'Accept':'application/json'
        }
    );

    if(response.statusCode == 200){
      print(response.body);
      // ignore: use_build_context_synchronously
      Navigator.push(context,MaterialPageRoute(builder: (BuildContext context){
        return LesArticles();
      }
      ));
    }
    else{
      print(response.statusCode);
      print(response.body);
      AlertHelper().error(context, "Une erreur s'est produite .");
    }
  }

  // Récupérer un media
  Future<List<Media>?> getMedias( int id) async {
    var client = http.Client();
    var url  = Uri.parse("http://post-app.herokuapp.com/api/articles/${id.toString()}");
    var response = await client.get(
        url,
        headers:<String , String> {
          'Content-type': 'application/json;charset=UTF-8',
          'Authorization':  "Bearer ${globals.token}",
          'Accept':'application/json'
        }

    );
    if(response.statusCode == 200) {
      var json = jsonDecode(response.body)["medias"];
      return mediaFromJson(jsonEncode(json));
    }
  }
// Supprimer un Commentaire
  Future<void> supprimerComment(int id,BuildContext context) async{
    var client = http.Client();
    var response = await client.delete(
        Uri.parse("http://post-app.herokuapp.com/api/comments/${id.toString()}"),
        headers:<String , String> {
          'Content-type': 'application/json;charset=UTF-8',
          'Authorization':  "Bearer ${globals.token}",
          'Accept':'application/json'
        }
    );
    if(response.statusCode == 200){
      /*AlertHelper().info(context, "Article supprimer avec succès ");
      /*Navigator.push(context, MaterialPageRoute(builder: (context){
        return LesArticles();
      }));*/*/
      print(response.body);
    }
    else{
      AlertHelper().error(context, "Une erreur s'est produite");
    }
  }
  Future Modifier(int id, String contenu,BuildContext context) async {
    // requete
    var response = await http.put(
      Uri.parse("http://post-app.herokuapp.com/api/comments/${id.toString()}"),
      body: {
        "contenu": contenu,
        "article_id": id
      }
    );
    if(response.statusCode == 200){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
        return LesArticles();
      }));
    }
}

Future<void> ajouterNote(int id, String note,BuildContext context) async{
    try{
      var response = await http.post(
          Uri.parse("http://post-app.herokuapp.com/api/rates"),
          body: {
            "rate": note,
            "article_id":id
          },
          headers:<String , String> {
           // 'Content-type': 'application/json;charset=UTF-8',
            'Authorization':  "Bearer ${globals.token}",
            'Accept':'application/json'
          }
      );
      if(response.statusCode == 200){
         AlertHelper().info(context, "Note ajoutée avec succès");
      }
    }
    finally{

    }
}
Future<String?> recuperer(int id,BuildContext context) async {

    var response = await http.get(
      Uri.parse('http://post-app.herokuapp.com/api/rates/${id.toString()}'),
        headers:<String , String> {
          'Content-type': 'application/json;charset=UTF-8',
          'Authorization':  "Bearer ${globals.token}",
          'Accept':'application/json'
        },
    );
    if(response.statusCode == 200){
      return jsonDecode(response.body);
    }
    else
      {
        AlertHelper().error(context, "Une erreur s'est produite");
      }
}
}