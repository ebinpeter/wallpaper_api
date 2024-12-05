part of 'post_bloc.dart';

@immutable
sealed class PostState {}

abstract class postaction extends PostState {}

class PostInitial extends PostState {}

class Postloading extends PostState {}

class postsuccesful extends PostState {
  final List<Postmodel> post;
  postsuccesful({required this.post});
}

class posterror extends PostState {
  final String message;

  posterror(this.message);
}
class update extends postaction{}
class updateError extends postaction{}
