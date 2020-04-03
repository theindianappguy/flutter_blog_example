import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blog_example/services/crud.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';

class NewBlog extends StatefulWidget {
  @override
  _NewBlogState createState() => _NewBlogState();
}

class _NewBlogState extends State<NewBlog> {

  String authorName = "", title = "", desc = "";

  File selctedImage;

  CrudMethods crudMethods = new CrudMethods();

  bool _loading = false;

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      selctedImage = image;
    });
  }

  updateBlog() async {

    if(selctedImage != null){

    setState(() {
      _loading = true;
    });

    // uploading image  to firebase storage
      StorageReference blogImagesStorageReference = FirebaseStorage.instance.ref().child("blogImages").child("${randomAlphaNumeric(10)}.jpg");

      final StorageUploadTask task = blogImagesStorageReference.putFile(selctedImage);

      var downloadUrl = await (await task.onComplete).ref.getDownloadURL();

      print(" $downloadUrl");

      Map<String,String> blog = {
        "authorName" : authorName,
        "desc" : desc,
        "imgUrl" : downloadUrl,
        "title" : title
      };

      crudMethods.addData(blog);

      Navigator.pop(context);

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
       title: Row(
         mainAxisAlignment: MainAxisAlignment.center,
         children: <Widget>[
         Text("Flutter"),
         Text("Blog", style: TextStyle(color: Colors.blue),)
       ],),
        actions: <Widget>[
          GestureDetector(
            onTap: (){

              updateBlog();
              setState(() {});
              //print("$authorName $title $desc");
            },
            child: Container(
              padding: EdgeInsets.only(right: 16),
                child: Icon(Icons.file_upload, color: Colors.white,)),
          )
        ],
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),

      body: _loading ? Container(
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      ) : SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 24),
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(children: <Widget>[
            selctedImage == null ? GestureDetector(
              onTap: (){
                getImage();
              },
              child: Container(
                height: 150,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4)
                ),
                child: Icon(Icons.add_a_photo, color: Colors.grey,),
              ),
            )  :  Container(
              height: 150,
              width: MediaQuery.of(context).size.width,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                  child: Image.file(selctedImage, fit: BoxFit.cover,)),
            ),
            SizedBox(height: 8,),
            TextField(
              onChanged: (val){
                authorName = val;
            },
              decoration: InputDecoration(
                  hintText: "Author Name"
              ),
            ),
            SizedBox(height: 8,),
            TextField(
              onChanged: (val){
                title = val;
              },
              decoration: InputDecoration(
                  hintText: "Title"
              ),
            ),
            SizedBox(height: 8,),
            TextField(
              onChanged: (val){
                desc = val;
              },
              decoration: InputDecoration(
                  hintText: "Desc"
              ),
            ),
            SizedBox(height: 8,),
            Text("$authorName $title $desc")
          ],),
        ),
      ),
    );
  }
}
