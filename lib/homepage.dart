import 'package:flutter/material.dart';
import 'auth.dart';

class Homepage extends StatelessWidget {
  Homepage ({this.auth,this.onSignOut});
  final BaseAuth auth;
  final VoidCallback onSignOut;

  void _signOut() async{
    try{
      await auth.signOut();
      onSignOut();

    }
    catch(e){
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child : new Scaffold(
        appBar: new AppBar(
          actions: <Widget>[
            new FlatButton(
                onPressed: _signOut,
                child: Text('LogOut', style:  new TextStyle(fontSize: 20, color: Colors.white),)
            )
          ],
          title: Text('Home Page'),
        ),
        body: Container(
          child: new Center(
            child: Text('Welcome to HomePage', style: TextStyle(fontSize: 20.0, color: Colors.blue),),
          ),
        ),
        ),
    );
  }
}
