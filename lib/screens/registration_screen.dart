import 'package:chatapp/constants.dart';
import 'package:flutter/material.dart';
import 'package:chatapp/widget/roundbutton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:chatapp/screens/chat_screen.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';


class RegistrationScreen extends StatefulWidget {
  static const String id = 'register_screen';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  bool showSpinner = false;
  String email;
  String password;
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Hero(
                  tag: 'logo',
                  child: Container(
                    height: 200.0,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  email = value;
                },
                decoration: kTextFieldDecoration.copyWith(hintText: 'Email'),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                textAlign: TextAlign.center,
                obscureText: true,
                onChanged: (value) {
                 password = value;
                },
                decoration: kTextFieldDecoration.copyWith(hintText: 'Password'),
              ),
              SizedBox(
                height: 24.0,
              ),
              RoundButton(
                  colours: Colors.blueAccent,
                  onPressed: () async {
                    setState(() {
                      showSpinner = true;
                    });
                    try{
                      final newUser =  await _auth.createUserWithEmailAndPassword(email: email, password: password);
                      setState(() {
                        showSpinner = false;
                      });
                      if(newUser != null){
                        Navigator.pushNamed(context, ChatScreen.id);
                      }
                    } catch(e) {
                      setState(() {
                        showSpinner = false;
                      });
                      print(e);
                    }

                  },
                  text: 'Register'),
            ],
          ),
        ),
      ),
    );
  }
}
