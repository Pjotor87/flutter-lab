// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:html';

import 'package:flutter/material.dart';
//import 'package:english_words/english_words.dart';

import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Http request test',
      theme: ThemeData(
        primaryColor: Colors.green,
      ),
      home: HttpRequester(),
    );
  }
}

class HttpRequester extends StatefulWidget {
  @override
  _HttpRequesterState createState() => _HttpRequesterState();
}

class _HttpRequesterState extends State<HttpRequester> {
  final _url = "https://gorest.co.in/public-api/users";
  var _displayText = 'Starting...';

  Future<String> makeRequest(String url) async {
    http.Response response;
    try {
      print('Request sent. Awaiting return inside makeRequest()...');
      response = await http.get(url);
    } catch (e) {
      print('Failed.');
      return e.toString();
    }

    if (response.statusCode == 200) {
      print('Success!');
      return convert.jsonDecode(response.body).toString();
    } else {
      print('Returned and failed.');
      print(
          "Request failed with status: ${response.statusCode}. Body: ${response.body}");
      return "Request failed with status: ${response.statusCode}. Body: ${response.body}";
    }
  }

  void makeRequestAsync(String url) async {
    print('Sending request from initialize...');
    var displayText = await makeRequest(_url);
    print('Request is ready. Triggering new build...');
    setState(() {
      _displayText = displayText;
    });
  }

  @override
  void initState() {
    super.initState();
    makeRequestAsync(_url);
    print('Exiting initialize...');
  }

  @override
  Widget build(BuildContext context) {
    print('Building...');
    return Scaffold(
      appBar: AppBar(
        title: Text('Http requester'),
      ),
      body: Text(_displayText),
    );
  }
}

/*
class RandomWords extends StatefulWidget {
  @override
  _RandomWordsState createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];
  final _saved = Set<WordPair>();
  final _biggerFont = TextStyle(fontSize: 18.0);

  Widget _buildSuggestions() {
    return ListView.builder(
        padding: EdgeInsets.all(16.0),
        itemBuilder: /*1*/ (context, i) {
          if (i.isOdd) return Divider(); /*2*/

          final index = i ~/ 2; /*3*/

          if (index >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10)); /*4*/
          }

          return _buildRow(_suggestions[index]);
        });
  }

  Widget _buildRow(WordPair pair) {
    final alreadySaved = _saved.contains(pair);

    return ListTile(
      title: Text(pair.asPascalCase, style: _biggerFont),
      trailing: Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      onTap: () {
        setState(() {
          if (alreadySaved) {
            _saved.remove(pair);
          } else {
            _saved.add(pair);
          }
        });
      },
    );
  }

  void _pushSaved() {
    Navigator.of(context)
        .push(MaterialPageRoute<void>(builder: (BuildContext context) {
      final tiles = _saved.map(
        (WordPair pair) {
          return ListTile(
            title: Text(
              pair.asPascalCase,
              style: _biggerFont,
            ),
          );
        },
      );
      final divided =
          ListTile.divideTiles(context: context, tiles: tiles).toList();

      return Scaffold(
        appBar: AppBar(
          title: Text('Saved Suggestions'),
        ),
        body: ListView(children: divided),
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Startup Name Generator'),
        actions: [IconButton(icon: Icon(Icons.list), onPressed: _pushSaved)],
      ),
      body: _buildSuggestions(),
    );
  }
}
*/
