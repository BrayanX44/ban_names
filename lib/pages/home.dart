import 'dart:io';
import 'dart:math';

import 'package:band_names/models/band.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Band> bands = [
    Band(id: 1, name: 'Metallica', votes: 5),
    Band(id: 2, name: 'RHCP', votes: 1),
    Band(id: 3, name: 'G&R', votes: 3),
    Band(id: 4, name: 'Pink FLoyd', votes: 2),
    Band(id: 5, name: 'Sound Garden', votes: 4),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        title: Center(
          child: Text(
            'Band Names',
            style: TextStyle(color: Colors.black87),
          ),
        ),
      ),
      body: ListView.builder(
          itemCount: bands.length,
          itemBuilder: (ctx, i) => _bandTile(bands[i])),
      floatingActionButton: FloatingActionButton(
          elevation: 1, child: Icon(Icons.add), onPressed: addNewBand),
    );
  }

  Widget _bandTile(Band band) {
    return Dismissible(
      background: Container(
        padding: EdgeInsets.only(left: 8.0),
        color: Colors.redAccent,
        child: Align(
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                Text('Delete Band', style: TextStyle(color: Colors.white)),
                SizedBox(width: 10),
                Icon(CupertinoIcons.trash, color: Colors.white,)
              ],
            )),
      ),
      direction: DismissDirection.startToEnd,
      onDismissed: (direction){
        //TODO: Llamar el borrado en el server
      },
      key: Key(band.id.toString()),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.blue[100],
          child: Text(band.name!.substring(0, 2)),
        ),
        title: Text('${band.name}'),
        trailing: Text(
          '${band.votes}',
          style: TextStyle(fontSize: 20),
        ),
        onTap: () => print(band.id),
      ),
    );
  }

  addNewBand() {
    final textController = TextEditingController();
    if (Platform.isAndroid) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('New Band Name:'),
              content: TextField(
                controller: textController,
              ),
              actions: [
                MaterialButton(
                    child: Text('Add'),
                    elevation: 5,
                    textColor: Colors.blue,
                    onPressed: () => addBandToList(textController.text))
              ],
            );
          });

      if (Platform.isIOS) {
        showCupertinoDialog(
            context: context,
            builder: (_) {
              return CupertinoAlertDialog(
                title: Text('New Band Name:'),
                content: CupertinoTextField(controller: textController),
                actions: [
                  CupertinoDialogAction(
                    isDefaultAction: true,
                    child: Text('Add'),
                    onPressed: () => addBandToList(textController.text),
                  ),
                  CupertinoDialogAction(
                    isDestructiveAction: true,
                    child: Text('Dismiss'),
                    onPressed: () => Navigator.pop(context),
                  )
                ],
              );
            });
      }
    }
  }

  void addBandToList(String name) {
    Random random = Random();
    int randomVotesuNumber = random.nextInt(5);
    int randomId = random.nextInt(100)+5;
    if (name.length > 1) {
      this.bands.add(new Band(name: name, id: randomId, votes: randomVotesuNumber));
      setState(() {});
    }
    Navigator.pop(context);
  }


}
