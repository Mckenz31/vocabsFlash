import 'package:flutter/material.dart';
import 'pages/search.dart';

class Result extends StatelessWidget {

  String synonyms="", antonyms = "";
  final Meaning result;
  Result(this.result);

  @override
  Widget build(BuildContext context) {
    for(int i=0; i<result.antonyms.length; i++){
      antonyms += result.antonyms[i] + ', ';
    }
    for(int i=0; i<result.synonyms.length; i++){
      synonyms += result.synonyms[i] + ', ';
    }
    // synonyms = result.synonyms[0] + ', ' +result.synonyms[1] + ', ' + result.synonyms[2] + ', ' + result.synonyms[3];
    return Container(
        child: Column(
          children: <Widget>[
          SizedBox(height: 40),
        Row(children: <Widget>[
          Text('Meaning : ',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
          SizedBox(width: 10,),
          Expanded(child: Text(result.meanings, style: TextStyle(fontSize: 16)))
        ]),
        SizedBox(height: 40),
        result.antonyms[0] != "No Antonyms Found" ?
          Row(children: [
            Text('Antonyms : ',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            // Column(children: [
            //   ...(result.antonyms)
            //       .map((e) => Padding(
            //             padding: EdgeInsets.all(4),
            //             child: Text(e, style: TextStyle(fontSize: 16)),
            //           ))
            //       .toList()
              // ])
              Flexible(
                child: Text(synonyms, style: TextStyle(fontSize: 16)
                ),
              )
          ]) :
          SizedBox(height: 0,),
        SizedBox(height: 40),
        result.synonyms[0] != "No Synonyms Found"
            ?Row(children: [
              Text('Synonyms : ',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
              // SizedBox(width: 40,),
              // Column(children: [
              //   ...(result.synonyms)
              //       .map((e) => Padding(
              //     padding: EdgeInsets.all(4),
              //     child: Text(e, style: TextStyle(fontSize: 16)),
              //   ))
              //       .toList(),
              // ]),
              Flexible(
                child: Text(synonyms, style: TextStyle(fontSize: 16)
                ),
              )
        ]) : SizedBox(height: 0,),
        SizedBox(height: 40),
        result.example != "No Example Found" ? Row(children: <Widget>[
          Text('Example : ',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
          SizedBox(width: 15,),
          Expanded(child: Text(result.example, style: TextStyle(fontSize: 16)))
        ]) : SizedBox(height: 0,),
        SizedBox(height: 40),
      ],
    ));
  }
}
