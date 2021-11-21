import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

class RandomWords extends StatefulWidget {
  const RandomWords({Key? key}) : super(key: key);

  @override
  RandomWordsState createState() => RandomWordsState();
}

class RandomWordsState extends State<RandomWords> {
  final _wordPair = <WordPair>[];
  final _savedWordPairs = <WordPair>{};

  void _pushSaved() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      final Iterable<ListTile> tiles = _savedWordPairs.map((WordPair pair) {
        return ListTile(
          title: Text(
            pair.asPascalCase,
            style: const TextStyle(fontSize: 16),
          ),
        );
      });

      final List<Widget> divided =
          ListTile.divideTiles(context: context, tiles: tiles).toList();
      return Scaffold(
        appBar: AppBar(
          title: const Text('Saved Wordpairs'),
          backgroundColor: Colors.red[900],
          ),
        body: ListView(children: divided,),
      );
    }));
  }

  Widget _buildList() {
    return ListView.builder(
        padding: const EdgeInsets.all(8),
        itemBuilder: (context, item) {
          if (item.isOdd) return Divider();

          final index = item ~/ 2;

          if (index >= _wordPair.length) {
            _wordPair.addAll(generateWordPairs().take(10));
          }

          return _buildRow(_wordPair[index]);
        });
  }

  Widget _buildRow(WordPair word) {
    final alreadySaved = _savedWordPairs.contains(word);

    return ListTile(
      title: Text(word.asPascalCase, style: const TextStyle(fontSize: 18)),
      trailing: Icon(alreadySaved ? Icons.favorite : Icons.favorite_border,
          color: alreadySaved ? Colors.red[700] : null),
      onTap: () {
        setState(() {
          if (alreadySaved) {
            _savedWordPairs.remove(word);
          } else {
            _savedWordPairs.add(word);
          }
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Wordpair Generator'),
          actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.favorite_border,
                color: Colors.white,
              ),
              onPressed: _pushSaved,
            )
          ],
          backgroundColor: Colors.green[900],
        ),
        body: _buildList());
  }
}
