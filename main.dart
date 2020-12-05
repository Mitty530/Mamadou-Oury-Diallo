import 'package:flutter/material.dart';
import 'package:Week2/lib.dart';
import 'package:Week2/google_fonts.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';


import 'src/welcomePage.dart';

import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Simple Login Demo',
      theme: ThemeData(
        // Define the default brightness and colors.
        brightness: Brightness.dark,
        primaryColor: Colors.lightBlue[400],
        accentColor: Colors.cyan[200],

        // Define the default font family.
        fontFamily: 'Georgia',

        // Define the default TextTheme. Use this to specify the default
        // text styling for headlines, titles, bodies of text, and more.
        textTheme: TextTheme(
          headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
          bodyText2: TextStyle(fontSize: 20.0, fontFamily: 'Hind'),
        ),
      ),
      home: new LoginPage(),
    );
  }
}
class LoginPage extends StatefulWidget {
  final String title;

  LoginPage({Key key, @required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Container(
          color: Theme.of(context).accentColor,
          child: Text(
            'Text with a background color',
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
      ),
      floatingActionButton: Theme(
        data: Theme.of(context).copyWith(
          colorScheme:
          Theme.of(context).colorScheme.copyWith(secondary: Colors.green),
        ),
        child: FloatingActionButton(
          onPressed: null,
          child: Icon(Icons.add),
        ),
      ),
    );
  }


  @override
  State<StatefulWidget> createState() => new _LoginPageState();
}

// Used for controlling whether the user is login or creating an account
enum FormType {
  SignIn,
  SignUp
}

class _LoginPageState extends State<LoginPage> {

  final TextEditingController _emailFilter = new TextEditingController();
  final TextEditingController _passwordFilter = new TextEditingController();
  final TextEditingController _confirm_passwordFilter = new TextEditingController();

  String _email = "";
  String _password = "";
  String _confirm_password = "";
  FormType _form = FormType.SignIn;
  // our default setting is to login, and we should switch to creating an account when the user chooses to

  _LoginPageState() {
    _emailFilter.addListener(_emailListen);
    _passwordFilter.addListener(_passwordListen);

  }

  void _emailListen() {
    if (_emailFilter.text.isEmpty) {
      _email = "";
    } else {
      _email = _emailFilter.text;
    }
  }

  void _passwordListen() {
    if (_passwordFilter.text.isEmpty) {
      _password = "";
    } else {
      _password = _passwordFilter.text;
    }
  }
  void _confirm_passwordListen() {
    if (_confirm_passwordFilter.text.isEmpty) {
      _confirm_password = "";
    } else {
      _confirm_password = _confirm_passwordFilter.text;
    }
  }

  // Swap in between our two forms, registering and logging in
  void _formChange () async {
    setState(() {
      if (_form == FormType.SignUp) {
        _form = FormType.SignIn;
      } else {
        _form = FormType.SignUp;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: _buildBar(context),
      body: new Container(
        padding: EdgeInsets.all(16.6),
        child: new Column(
          children: <Widget>[
            _buildTextFields(),
            _buildButtons(),
          ],
        ),
      ),
    );
  }


  Widget _buildBar(BuildContext context) {
    return new AppBar(
      title: new Text("H E R O O J O "),
      centerTitle: true,
    );
  }

  Widget _buildTextFields() {
    return new Container(
      child: new Column(
        children: <Widget>[
          new Container(
            child: new TextField(
              controller: _emailFilter,
              decoration: new InputDecoration(
                  labelText: 'Email'
              ),
            ),
          ),
          new Container(
            child: new TextField(
              controller: _passwordFilter,
              decoration: new InputDecoration(
                  labelText: 'Password'
              ),
              obscureText: true,
            ),
          ),
          new Container(
            child: new TextField(
              controller: _confirm_passwordFilter,
              decoration: new InputDecoration(
                  labelText: 'Confirm Password'
              ),
              obscureText: true,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildButtons() {
    if (_form == FormType.SignIn) {
      return new Container(
        child: new Column(
          children: <Widget>[
            new RaisedButton(
              child: new Text('SignUp'),
              onPressed: _loginPressed,
            ),
            new FlatButton(
              child: new Text('Already have an account? Tap here to SignIn.'),
              onPressed: _formChange,
            ),
            new FlatButton(
              child: new Text('SignUp With Google?'),
              onPressed: _passwordReset,
            )
          ],
        ),
      );
    } else {
      return new Container(
        child: new Column(
          children: <Widget>[
            new RaisedButton(
              child: new Text('Create an Account'),
              onPressed: _createAccountPressed,
            ),
            new FlatButton(
              child: new Text('Have an account? Click here to SignIn.'),
              onPressed: _formChange,
            )
          ],
        ),
      );
    }
  }

  // These functions can self contain any user auth logic required, they all have access to _email and _password

  void _loginPressed () {
    print('The user wants to SignIn with $_email and $_password');
  }

  void _createAccountPressed () {
    print('The user wants to create an account with $_email and $_password');

  }

  void _passwordReset () {
    print("The user wants a password reset request sent to $_email");
  }


}