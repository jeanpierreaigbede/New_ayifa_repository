

import 'package:crudayifa/Models/Article_Specifique.dart';
import 'package:crudayifa/Services/ApiServices.dart';
import 'package:get/get.dart';

class ArticlePageControlleur extends GetxController {
  final int id ;
  var article = List<ArticleSpecifique>.empty().obs;
  ArticlePageControlleur({required this.id});
  var isLoading = true.obs;
  @override
  void onInit(){
    getArticle(id);
    super.onInit();
  }

  void getArticle(int id) async{
    try{
      isLoading(true);
      var product = await ApiService().getArticle(id);
      if(product != null){
        article.add(product);
      }
    }
    finally{
      isLoading(false);
    }
  }
}