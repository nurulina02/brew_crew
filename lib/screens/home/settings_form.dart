import 'package:brew_crew/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/users.dart';
import '../../services/database.dart';
//import '../../shared/constants.dart';
import '../../shared/loading.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {

  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4'];
  final List<int> strengths = [100, 200, 300, 400, 500, 600, 700, 800, 900];

  // form values
   String? _currentName;
   String ?_currentSugars;
   int ?_currentStrength;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Users?>(context);

return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user!.uid).userData,
      builder: (context, snapshot) {
        if(snapshot.hasData){
          UserData? userData = snapshot.data;


   
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Text(
            'Update your brew settings.',
            style: TextStyle(fontSize: 18.0),
          ),
          SizedBox(height: 20.0),
          TextFormField(
          initialValue: userData!.name,

            decoration: textInputDecoration,
            validator: (val) => val!.isEmpty ? 'Please enter a name' : null,
            onChanged: (val) => setState(() => _currentName = val),
          ),
          SizedBox(height: 10.0),
          DropdownButtonFormField(
            value: _currentSugars ?? '0',
            decoration: textInputDecoration,
            items: sugars.map((sugar) {
              return DropdownMenuItem(
                value: sugar,
                child: Text('$sugar sugars'),
              );
            }).toList(),
            onChanged: (val) => setState(() => _currentSugars = val! ),
          ),
          //SizedBox(height: 10.0),

           Slider(
            value: (_currentStrength ?? 100).toDouble(),
            activeColor: Colors.brown[_currentStrength ?? 100],
            inactiveColor: Colors.brown[_currentStrength ?? 100],
            min: 100.0,
            max: 900.0,
            divisions: 8,
            onChanged: (val) => setState(() => _currentStrength = val.round()),
          ),
          TextButton(
             child: Text(
              'Update',
              style: TextStyle(color: Color.fromARGB(255, 137, 67, 67)),
            ),
            onPressed: () async {
               if(_formKey.currentState!.validate()){
                      await DatabaseService(uid: user.uid).updateUserData(
                        _currentSugars ?? snapshot.data!.sugars, 
                        _currentName ?? snapshot.data!.name, 
                        _currentStrength ?? snapshot.data!.strength
                      );
                      Navigator.pop(context);
                    }
            }
          ),
        
        ],

      ),
    );
  }    else {
          return Loading();

      }
      
      }
    );
  }
}