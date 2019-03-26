import 'package:flutter/material.dart';
import 'loginpage.dart';
import 'auth.dart';
import 'homepage.dart';
class Rootpage extends StatefulWidget {
  Rootpage ({this.auth});
  final BaseAuth auth;
  @override
  _RootpageState createState() => _RootpageState();
}
enum AuthStatus{
  notSignedIn,
  signedIn
}

class _RootpageState extends State<Rootpage> {
  @override
  AuthStatus _authStatus = AuthStatus.notSignedIn ;
  void initState() {
    widget.auth.currentUser().then((userId){
      setState(() {
        _authStatus = userId == null ? AuthStatus.notSignedIn : AuthStatus.signedIn;
      });
    }
    );
    super.initState();
  }
  void _signedIn(){
    setState(() {
      _authStatus = AuthStatus.signedIn;
    });
  }
  void _signedOut(){
    setState(() {
      _authStatus = AuthStatus.notSignedIn;
    });
  }
  @override
  Widget build(BuildContext context) {

    switch(_authStatus){
      case AuthStatus.notSignedIn:
        return new LoginPage(auth : widget.auth,
          onSignedIn: _signedIn,
        );
      case AuthStatus.signedIn:
        return new Homepage(
          auth: widget.auth,
          onSignOut: _signedOut,
        );
    }

  }
}
