import 'dart:io';

import 'package:crudayifa/Models/alert_helper.dart';
import 'package:crudayifa/Services/ApiServices.dart';
import 'package:crudayifa/Views/component.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:crudayifa/Views/LesArticles.dart';

import 'article_page.dart';

class AjouterMedia extends StatefulWidget {
  final int id ;

  AjouterMedia({Key? key, required this.id}) : super(key: key);

  @override
  State<AjouterMedia> createState() => _AjouterMediaState();
}

class _AjouterMediaState extends State<AjouterMedia> {
  File? file ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 100,),
              ElevatedButton(onPressed:selectFile, child: TextWidget(text: 'Selectionner un media',color: Colors.white,fontsize: 18,),
              style:ElevatedButton.styleFrom(
                minimumSize: Size(230, 60),
                primary: Colors.green
              ),),
              const SizedBox(height: 20,),
              ElevatedButton(
                  style:ElevatedButton.styleFrom(
                      minimumSize: Size(200, 60),
                      primary: Colors.green
                  ),
                  onPressed: (){
                    if(file !=null){
                      ApiService().AjouterMedia(widget.id, file!, context);
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
                        return ArticlePage(index: widget.id,);
                      }));
                    }
                    else{
                      AlertHelper().error(context, "Veuillez sélectionner un fichier");
                    }
              },
                  child: TextWidget(text: "Ajouter",color: Colors.white,fontsize: 25,)
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
      ),
    );
  }
  Future<void> selectFile() async {
    FilePickerResult? fil = await FilePicker.platform.pickFiles(allowMultiple: false);
    if(fil != null){
      final path = fil.files.single.path!;
      setState(() {
        file = File(path);
      });
    }
    else{
      AlertHelper().error(context, "Veuillez sélectionner un fichier");
    }
  }
}
