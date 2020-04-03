import 'package:cloud_firestore/cloud_firestore.dart';

class CrudMethods{

  Future<void> addData(blogData){
    Firestore.instance.collection("blogs").add(blogData).catchError((e){
      print(e);
    });
  }

}