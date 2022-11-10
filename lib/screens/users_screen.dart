import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_app/models/UsersModel.dart';
import 'package:store_app/services/api_handler.dart';
import 'package:store_app/widgets/user_widget.dart';
class UsersScreen extends StatefulWidget {
  const UsersScreen({Key? key}) : super(key: key);

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(' All Users'),
      ),
      body: FutureBuilder<List<UsersModel>>(
        future: APIHandler.getAllUsers(),
        builder: (context,snapshot){
          if(snapshot.connectionState==ConnectionState.waiting){
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          else if(snapshot.hasError){
             Center(
              child: Text('An error has Occurred${snapshot.error}'),
            );
          }
          else if(snapshot.data==null){
            const Center(
              child: Text('No User found Yet!'),
            );
          }
          return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (ctx,index){
                return ChangeNotifierProvider.value(
                    value: snapshot.data![index],
                    child: const UsersWidget());
              });
        },
      )

    );
  }
}
