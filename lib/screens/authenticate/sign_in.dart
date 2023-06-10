import 'package:flutter/material.dart';
import 'package:brew_crew/services/auth.dart';
import 'package:brew_crew/shared/constants.dart';
import 'package:brew_crew/shared/loading.dart';
class SignIn extends StatefulWidget {

  final Function toggleView;

  const SignIn({super.key, required this.toggleView});
  //SignIn({ required this.toggleView });


  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

final AuthService    _auth   = AuthService();
final _formKey = GlobalKey<FormState>();
bool loading =false;

// text field state
  String email = '';
  String password = '';
    String error = '';

  @override
  Widget build(BuildContext context) {
    return loading? Loading(): Scaffold(
      backgroundColor:Colors.brown[100] ,
      appBar: AppBar(
              backgroundColor: Colors.brown[400],
elevation: 0.0,
title: Text ('Sign  in to Brew Crew'),
 actions: <Widget>[
          TextButton.icon(
            style: ButtonStyle(
    foregroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(255, 0, 7, 12)),
  ),
            icon: Icon(Icons.person),
            label: Text('Register'),
            onPressed: (){
             widget.toggleView();

            }
          ),
        ],
      ),
body: Container(
  padding:EdgeInsets.symmetric(vertical: 20.0 ,horizontal: 50.0) ,
child: Form(
            key: _formKey,

          child: Column(

            children: <Widget>[
              SizedBox(height: 20.0),
              TextFormField(
                                decoration:textInputDecoration.copyWith(hintText:'Email'),

           validator: (val) => val!.isEmpty ? 'Enter an email' : null,

                onChanged: (val) {
                  
                  setState(() => email = val);
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                                decoration:textInputDecoration.copyWith(hintText:'Password'),

                obscureText: true,
                 validator: (val) => val!.length < 6 ? 'Enter a password 6+ chars long' : null,

                onChanged: (val) {
                  setState(() => password = val);
                },
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                //color: Colors.pink[400],
                child: Text(
                  'Sign In',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {

                if(_formKey.currentState!.validate()){
                  setState(() =>loading=true);
                    dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                    if(result == null) {
                      setState(() {
                        error = 'Could not sign in with those credentials';
                        loading =false;
                      });
                       }   }
}),
SizedBox(height: 12.0),
              Text(
                error,
                style: TextStyle(color: Colors.red, fontSize: 14.0),
              ),
            ],
          ),
 
),
)
    );
  }
}