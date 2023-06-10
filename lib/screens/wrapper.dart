import 'package:flutter/material.dart';
import 'package:brew_crew/models/users.dart';
import 'package:brew_crew/screens/authenticate/authneticate.dart';
import 'package:brew_crew/screens/home/home.dart';
import 'package:provider/provider.dart';
import 'package:brew_crew/models/users.dart';


class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {


//return home or auth
final user = Provider.of<Users?>(context);
print(user);

if(user==null)  {
  return Authenticate();

}
else
{
  return Home();
}}}
