import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<dynamic> getFriendsList() async {
  http.Response response =
      await http.get('https://firefly-dev-owxqu.run-ap-south1.goorm.io');
  String body = response.body;
  var jsonData = jsonDecode(body);
  return jsonData;
}

Future<dynamic> addFriend(String name, String profession, int age) async{
  http.Response response = await http.post('https://firefly-dev-owxqu.run-ap-south1.goorm.io/name=$name&profession=$profession&age=$age');
  String body = response.body;
  var jsonData = jsonDecode(body);
  return jsonData;
}

Future<dynamic> deleteFriend(String id) async{
  http.Response response = await http.delete('https://firefly-dev-owxqu.run-ap-south1.goorm.io/$id');
  String body = response.body;
  var jsonData = jsonDecode(body);
  return jsonData;
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoadingScreen(),
    );
  }
}

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    getFriendsList().then((friends) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Friends(friends)));
    });
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
    );
  }
}

class Friends extends StatefulWidget {
  final friendsDataInit;

  Friends(this.friendsDataInit);

  @override
  _FriendsState createState() => _FriendsState();
}

class _FriendsState extends State<Friends> {

  var friendsData;

  @override
  void initState() {
    super.initState();
    friendsData = widget.friendsDataInit;
  }


  List<ListTile> get getFriends {
    List<ListTile> friends = [];
    for (int i = 0; i < friendsData.length; i++) {
      friends.add(
        ListTile(
          leading: CircleAvatar(
            radius: 20.0,
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                friendsData[i]["name"].substring(0, 1),
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          title: Text(
            friendsData[i]["name"],
            style: TextStyle(fontSize: 18.0),
          ),
          subtitle: Text(
            friendsData[i]["profession"],
            style: TextStyle(fontSize: 14.0),
          ),
          trailing: Text(
            (friendsData[i]["age"].toString()),
            style: TextStyle(fontSize: 18.0),
          ),
          onLongPress: () async {
            deleteFriend(friendsData[i]["_id"]).then((newData){
              setState(() {
                friendsData = newData;
              });
            });
            },
        ),
      );
    }

    return friends;
  }

  void presentBottomSheet(BuildContext ctx, Function onPressed) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {

          String name;
          String profession;
          String age;

          return Container(
            padding: EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(labelText: 'Name'),
                  onChanged: (val){name=val;},
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'Profession'),
                  onChanged: (val){profession=val;},
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'Age'),
                  onChanged: (val){age=val;},
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal:20.0, vertical: 20.0),
                  child: FlatButton(
                    child: Padding(
                      padding:EdgeInsets.all(15.0),
                      child: Text('Add Friend', style: TextStyle(color: Colors.white),),
                    ),
                    color: Colors.lightBlueAccent,
                    onPressed: (){
                      onPressed(name,profession,int.parse(age));
                      Navigator.pop(ctx);
                    },
                  ),
                )
              ],
            ),
          );
        });
  }

  void submitFriend(String name, String profession, int age){
    if(name.isEmpty || profession.isEmpty || age <=0){
      return;
    }
    
    addFriend(name,profession,age).then((newData){
      setState(() {
        friendsData = newData;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          presentBottomSheet(context, submitFriend);
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text('Friends !'),
      ),
      body: SafeArea(
        child: Column(
            children: getFriends,
            ),
      ),
    );
  }
}
