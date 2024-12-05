import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:wallpeper/features/post/repo/post_repo.dart';

import '../model/post_model.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc() : super(PostInitial()) {
    on<Postinitialise>(postinitialise);
    on<PostAddevent>(postadd_event);
  }
  Future<void> postinitialise(
      Postinitialise event, Emitter<PostState> emit) async {
    emit(Postloading());
    try {
      List<Postmodel> posts = await PostRepo.getdata();
      emit(postsuccesful(post: posts));
    } catch (e) {
      emit(posterror("An error occurred: $e"));
      print(e);
    }
  }

  FutureOr<void> postadd_event(PostAddevent event, Emitter<PostState> emit) async{
    try{
      bool succes = await PostRepo.postdata();
      if(succes==true){
        print(succes);
        emit(update());
      }else{
        print(succes);
        emit(updateError());
      }
    }catch(e){
      print(e);}
  }
}
