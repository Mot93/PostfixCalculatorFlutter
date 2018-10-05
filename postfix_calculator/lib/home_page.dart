// Defining the home page of the app

import 'package:flutter/material.dart';


//-------------------------------------
/// Home page widget
class HomePage extends StatefulWidget {
  /// Constructor
  const HomePage();
  /// State initialization
  @override
  _HomePageState createState() => new _HomePageState();
}


//-------------------------------------------
/// Home page state
class _HomePageState extends State<HomePage>{

  //
  String str = "";

  // Return a numeric button
  // Expanded(MaterialButton(Conteiner(Center(Text()))))
  Widget _buildButton(value){
    return Expanded(
      flex: 1,
      child: MaterialButton(
        onPressed: () => print("$value"),
        child: Container(
          child: Center(
            child:Text(
              "$value",
              style: TextStyle(
                fontSize: 45.0,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Return a row of button
  Widget _buildButtonRow(List values){
    // Creating a list of buttons
    List<Widget> buttons = [];
    for (var x in values){
      buttons.add(_buildButton(x));
    }
    // Pacing the list of buttons in a Expanded(Row)
    return Expanded(
      flex: 1,
      child: Row(
        children: buttons,
      ),
    );
  }

  /// Build
  @override
  Widget build(BuildContext context){

    // Definin the AppBar
    // Using final because I won't change my appBar
    // TODO add navigation button to the bar
    var appBar = AppBar(
      title: Text("Postfix Calculator"),
    );

    // Defining the Body of the home page
    // The body is a column containing a text field and a gridview
    var body = Container(
      child: Column(
        children: <Widget>[
          // Equation holder (Text())
          Expanded(
            flex: 1,
            child: Center(
              child:Padding(
                padding: EdgeInsets.all(10.0), 
                child: Text("Dummy text"),
              ),
            ),
          ),
          // Gridview containing the "keyboard"
          // TODO "keyboard"
          Expanded(
            flex: 2,
            // There are 2 column
            //    1) Containing the numbers
            //    2) Containing the Oparation
            child: Row(
              children: <Widget>[
                // Numeric Pad
                Expanded(
                  flex: 2,
                  child: Column(
                    children: <Widget>[
                      _buildButtonRow([7,8,9]),
                      _buildButtonRow([4,5,6]),
                      _buildButtonRow([1,2,3]),
                      _buildButtonRow([0, '.']),
                    ],
                  ),
                ),
                // Operation keys
                Expanded(
                  flex: 1,
                  child: Column(
                    children: <Widget>[
                      // Erase Button
                      Expanded(
                        flex: 1,
                        child: MaterialButton(
                          onPressed: () => print("Erase"),
                          child: Container(
                            child: Center(
                              child: Icon(
                                Icons.backspace,
                              ),
                            ),
                          ),
                        ),
                      ),
                      // Buttons + - / *
                      _buildButton('+'),
                      _buildButton('-'),
                      _buildButton('/'),
                      _buildButton('*'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ]
      ),
    );

    return Scaffold(
      appBar: appBar,
      body: body,
    );
  }

}