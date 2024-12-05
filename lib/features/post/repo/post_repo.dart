import 'dart:convert';

import 'package:wallpeper/features/post/model/post_model.dart';
import 'package:http/http.dart' as http;

class PostRepo {
  static Future<List<Postmodel>> getdata() async {
    try {
      List<Postmodel> posts = [];
      var client = http.Client();
      var response = await client
          .get(Uri.parse("https://jsonplaceholder.typicode.com/posts"));
      List result = jsonDecode(response.body);
      for (int i = 0; i < result.length; i++) {
        Postmodel post = Postmodel.fromJson(result[i] as Map<String, dynamic>);
        posts.add(post);
      }
      return posts;
    } catch (e) {
      print(e);
    }
    return [];
  }

  static Future<bool> postdata() async {
    try {
     var url = Uri.parse('https://jsonplaceholder.typicode.com/posts/1');
     var requestbody={
       'id': "1",
       'title': 'its Ebin peter',
       'body': 'this is not me',
       'userId': "1",
     };
     var responce =await http.put(url,
     headers:{
       'Content-Type': 'application/json; charset=UTF-8',
     },
     body: jsonEncode(requestbody)
     );
      if(responce.statusCode==200||responce.statusCode<300){
        return true;
      }
    } catch (e) {
      print(e);
    }
    return false;
  }
}
