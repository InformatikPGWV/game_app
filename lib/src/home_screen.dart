import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children:[
                RaisedButton(
                    onPressed: (){
                        Navigator.of(context).push(/* HIER ROUTE FÜR TTT EINFÜGEN */);
                    },
                    child: Text("Tic-Tac-Toe"),
                    style RaisedButton.stylesheet(primary: Colors.green,),
                ),
            ],
        ),
    );
  }
}