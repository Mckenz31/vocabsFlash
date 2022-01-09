import 'package:flutter/material.dart';
import 'package:vocabs_flash/search.dart';

class Result extends StatelessWidget {
  final Meaning result;
  const Result(this.result);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: <Widget>[
        SizedBox(height: 40),
        Row(children: <Widget>[
          Text('Meaning : ',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
          Expanded(child: Text(result.meanings, style: TextStyle(fontSize: 16)))
        ]),
        SizedBox(height: 40),
        Row(children: [
          Text('Antonyms : ',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
          Row(children: [
            ...(result.antonyms)
                .map((e) => Padding(
                      padding: EdgeInsets.all(4),
                      child: Text(e, style: TextStyle(fontSize: 16)),
                    ))
                .toList()
          ])
        ]),
        SizedBox(height: 40),
        Row(children: [
          Text('Synonyms : ',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
          ...(result.synonyms)
              .map((e) => Padding(
                    padding: EdgeInsets.all(4),
                    child: Text(e, style: TextStyle(fontSize: 16)),
                  ))
              .toList(),
        ]),
        SizedBox(height: 40),
        Row(children: <Widget>[
          Text('Example : ',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
          Text(result.example, style: TextStyle(fontSize: 16))
        ]),
        SizedBox(height: 40),
        Row(children: <Widget>[
          Text('Origin : ',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
          Text(result.origin, style: TextStyle(fontSize: 16))
        ])
      ],
    ));
  }
}
