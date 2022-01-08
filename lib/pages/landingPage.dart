import 'package:flutter/material.dart';
import 'flashcards.dart';

class landingPage extends StatefulWidget {
  @override
  _landingPageState createState() => _landingPageState();
}

class _landingPageState extends State<landingPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 250,
              width: double.infinity ,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(90)),
                color: Color(0xffF5591F),
                gradient: LinearGradient(
                    colors: [(new Color(0xffF5591F)), (new Color(0xffF2861E))],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(onPressed: (){
                        Navigator.pushNamed(context,'/fourth');
                      }, icon: Icon(Icons.settings),
                        color: Colors.white,),

                      IconButton(onPressed: (){
                        Navigator.pushNamed(context,'/fifth');
                      }, icon: Icon(Icons.info_outline),
                        color: Colors.white,),
                    ],
                  ),
                  Container(
                    child: Text(
                      "Flashcards",
                      style: TextStyle(
                          fontSize: 50.0,
                          fontFamily: "Times New Roman",
                          color: Colors.white
                      ),
                    ),
                  ),
                  SizedBox(
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20, right:20,top:150),
              // ignore: deprecated_member_use
              child: FlatButton(
                splashColor: Color(0xffF5341F),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                onPressed: (){
                  Navigator.pushNamed(context,'/first');
                },
                padding: EdgeInsets.symmetric(
                  horizontal: 100.0,
                  vertical: 10.0,
                ),
                color: Color(0xffF5591F),
                textColor: Colors.white,
                child: Text(
                  "PRACTICE",
                  style: TextStyle(
                    fontSize: 30.0,
                    fontFamily: "Times New Roman",
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.only(left: 20, right:20,top:30),
              child: FlatButton(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                onPressed: (){
                  // Navigator.pushNamed(context,'/flashCards');
                  Navigator.push(context, MaterialPageRoute(builder: (context) => FlashCards()));
                },
                padding: EdgeInsets.symmetric(
                  horizontal: 100.0,
                  vertical: 10.0,
                ),
                color: Color(0xffF5591F),
                textColor: Colors.white,
                child: Text(
                  "LEARN",
                  style: TextStyle(
                    fontSize: 30.0,
                    fontFamily: "Times New Roman",
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20, right:20,top:100),
              child: FlatButton.icon(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                onPressed: (){
                  Navigator.pushNamed(context,'/third');
                },
                padding: EdgeInsets.symmetric(
                  horizontal: 80.0,
                  vertical: 20.0,
                ),

                color: Color(0xffF5591F),
                textColor: Colors.white,

                icon: Icon(Icons.search, color: Colors.white),
                label: Text("BROWSE SEARCH",
                  style: TextStyle(
                    fontSize: 20.0,
                    fontFamily: "Times New Roman",
                    fontWeight: FontWeight.w400,
                  ),),
              ),
            ),
          ],
        ),
      ),
    ); //
  }
}