import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:brew_crew/models/brew.dart';
import 'package:brew_crew/screens/home/settings_form.dart';
import 'package:brew_crew/services/auth.dart';
import 'package:brew_crew/services/database.dart';
import 'package:provider/provider.dart';
import 'package:brew_crew/screens/home/brew_list.dart';


class Home extends StatelessWidget {
  final AuthService _auth = AuthService();

   Home({super.key});

  @override
  Widget build(BuildContext context) {

 void _showSettingsPanel() {
      showModalBottomSheet(context: context, builder: (context) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
          child:SettingsForm(),
        );
      });
    }

    
    return StreamProvider<List<Brew>?>.value(
      catchError: (_, __) {} ,
      initialData: null,
      value: DatabaseService(uid: '').brews,
      
      child: Scaffold(
           backgroundColor: Colors.brown[50],
           appBar: AppBar(
             title: Text('Brew Crew'),
             backgroundColor: Colors.brown[400],
             elevation: 0.0,
             actions: <Widget>[
               TextButton.icon(
                 style: ButtonStyle(
    foregroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(255, 0, 8, 15)),
  ),
                 icon: Icon(Icons.person),
                 label: Text('logout'),
                 onPressed: () async {
                   await _auth.signOut();
                 },
               ),
 TextButton.icon(
  style: ButtonStyle(
    foregroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(255, 0, 8, 15)),
  ),
          icon: Icon(Icons.settings),
              label: Text('settings'),
              onPressed: () => _showSettingsPanel(),
            )

             ],
           ),
           body: Container(
            decoration: BoxDecoration(
             image: DecorationImage(
              image:AssetImage('assets/coffee_bg.png'),
              fit: BoxFit.cover, 
              )
              ),
            child:BrewList()
            ),
      ),
    );
  }
}