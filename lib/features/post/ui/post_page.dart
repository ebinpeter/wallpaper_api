import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wallpeper/features/post/bloc/post_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  final PostBloc postBloc = PostBloc();
  @override
  void initState() {
    postBloc.add(Postinitialise());
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton:FloatingActionButton(
        child: Icon(Icons.add),
        onPressed:() {
        postBloc.add(PostAddevent());
      },),
      appBar: AppBar(
        title: Center(child: Text("Posts Page")),
      ),
      body: BlocConsumer<PostBloc, PostState>(
        bloc: postBloc,
        listenWhen: (previous, current) => current is postaction,
        buildWhen: (previous, current) => current is! postaction,
        listener: (context, state) {
          if (state is posterror) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Error: ${state.message}")),
            );
          }
        },
        builder: (context, state) {
          switch (state.runtimeType) {
            case postsuccesful:
              final successtate = state as postsuccesful;

              return ListView.builder(
                itemCount: successtate.post.length,
                itemBuilder: (context, index) {
                  final post = successtate.post[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      tileColor: Colors.grey,
                      title: Text(post.title),
                    ),
                  );

                },
              );
            case Postloading:
              return Center(child: CircularProgressIndicator(),);
            default:
              return Center(child: Text("data"),);
          }
        },
      ),
    );
  }
}
