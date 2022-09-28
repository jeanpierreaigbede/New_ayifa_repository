import 'package:crudayifa/Models/article.dart';
import 'package:get/get.dart';

import '../Services/ApiServices.dart';

class ArticleControlleur extends GetxController{

  var articleList = List<Article>.empty().obs ;
  var isloading = true.obs;

  @override
  void onInit() {
    getArticles();
    super.onInit();
  }

  void getArticles() async {
   try {
     isloading(true);
     var articles = await ApiService().getArticles();
     if(articles != null){
       articleList.value = articles ;
     }
   }
   finally{
     isloading(false);
   }
  }
}