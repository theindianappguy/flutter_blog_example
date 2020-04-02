import 'package:flutter/material.dart';

class NewBlog extends StatefulWidget {
  @override
  _NewBlogState createState() => _NewBlogState();
}

class _NewBlogState extends State<NewBlog> {

  String authorName, title, desc;

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
              print("$authorName $title $desc");
            },
            child: Container(
              padding: EdgeInsets.only(right: 16),
                child: Icon(Icons.file_upload, color: Colors.white,)),
          )
        ],
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),

      body: Container(
        margin: EdgeInsets.symmetric(vertical: 24),
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Column(children: <Widget>[
          Container(
            height: 150,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4)
            ),
            child: Icon(Icons.add_a_photo, color: Colors.grey,),
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
        ],),
      ),
    );
  }
}
