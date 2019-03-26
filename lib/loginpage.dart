import 'package:flutter/material.dart';
import 'auth.dart';
enum FormType{
  login,
  register
}


class LoginPage extends StatefulWidget {
  LoginPage({this.auth, this.onSignedIn});
  final BaseAuth auth;
  final VoidCallback onSignedIn;
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final formkey = new GlobalKey<FormState>();

  String _email;
  String _password;
  FormType _formType = FormType.login;
  bool validateAndSave(){
    final form = formkey.currentState;
    form.save();
    if(form.validate())
      return true;
      else
        return false;
  }
  void validateAndSubmit() async{
    if(validateAndSave()){
      try {
        if(_formType == FormType.login) {
          String userId = await widget.auth.signInWithEmailAndPassword(_email, _password);
          print('Signed In $userId');
        }
        else{
          String userId = await widget.auth.createUserWithEmailAndPassword(_email, _password);
          print('Registered Usr $userId');
        }
        widget.onSignedIn();
      }
      catch(e){
        print('Error $e');
      }
    }
  }
  void moveToRegister(){
    setState(() {
      formkey.currentState.reset();
      _formType = FormType.register;
    });
  }
  void moveToLogin(){
    setState(() {
      formkey.currentState.reset();
      _formType = FormType.login;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text('Firebase Demo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[

            new Container(

                 child: new Form(
                   key: formkey,
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: buildInputs() + buildSubmitButtons(),
                    )
              ),
               ),
          ],
        )
          ),
      );
  }
  List<Widget> buildInputs(){
    return[
      new TextFormField(
        decoration: new InputDecoration(
            labelText: 'Email',
            labelStyle: TextStyle(color: Colors.blue),
            hintText: 'Enter your Email'

        ),
        validator: (value)=> value.isEmpty ? 'Email can\'t be empty' : null ,
        onSaved: (value) => _email = value,
      ),
      new TextFormField(
        decoration: new InputDecoration(
            labelText: 'Password',
            labelStyle: TextStyle(color: Colors.blue),
            hintText: 'Enter your Password'
        ),
        obscureText: true,
        validator: (value)=> value.isEmpty ? 'Password can\'t be empty' : null,
        onSaved: (value) => _password = value,
      ),

    ];
  }
  List<Widget> buildSubmitButtons() {
    if(_formType == FormType.login) {
    return[
        new RaisedButton(
            child: new Text('Login', style: TextStyle(fontSize: 20),),
            onPressed: validateAndSubmit
        ),
      new FlatButton(onPressed: moveToRegister,
      child: new Text('Create an account',style: TextStyle(color: Colors.blue),))
      ];
      }
      else{
        return[
        new RaisedButton(
        child: new Text('Register', style: TextStyle(fontSize: 20),),
        onPressed: validateAndSubmit
        ),
        new FlatButton(onPressed: moveToLogin,
        child: new Text('Already have an account?',style: TextStyle(color: Colors.blue),))
        ];
      }
  }
}

