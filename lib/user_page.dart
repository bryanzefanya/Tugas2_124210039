import 'package:flutter/material.dart';
import 'detail_page.dart';
import 'users_model.dart';
import 'api_data_sources.dart';

class UserPage extends StatelessWidget {
  const UserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("List Users"),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
      ),
      body: FutureBuilder(
          future: ApiDataSource.instance.loadUsers(),
          builder: (context, snapshot){
            if(snapshot.hasError){
              return Text("Error!");
            }
            if(snapshot.hasData){
              UsersModel users = UsersModel.fromJson(snapshot.data!);
              return ListView.builder(
                  itemCount: users.data!.length,
                  itemBuilder: (context, index){
                    var user = users.data![index];
                    return ListTile(
                      leading: CircleAvatar(
                        foregroundImage: NetworkImage(user.avatar!),
                      ),
                      title: Text('${user.firstName} ${user.lastName}'),
                      subtitle: Text('${user.email}'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailPage(id: user.id!),
                          ),
                        );
                      },
                    );
                  }
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          }
      ),
    );
  }
}
