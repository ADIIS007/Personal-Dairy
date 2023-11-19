import 'package:flutter/material.dart';
import 'package:my_flutter_project/Entity/dairy.dart';
import 'package:my_flutter_project/Service/db.dart';
import 'package:my_flutter_project/add_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  void initState(){
    super.initState();
  }

  Future<List<DiaryEntry>> _getAllEntries() async {
    return DairyService().getAllEntries();
  }

  Widget _buildRow(String date) {
    return ListTile(
      leading: const CircleAvatar(
        child: Icon(Icons.text_snippet),
      ),
      title: Text(
        'Entry $date',
        style: const TextStyle(fontSize: 18.0),
      ),
      trailing: const Icon(Icons.arrow_forward_ios_rounded),
      onTap: ()=>_readDairy(date),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        //       style: Theme.of(context).textTheme.headlineMedium,
        child: FutureBuilder<List<DiaryEntry>>(
          future: _getAllEntries(),
          builder: (context, snapshot){
            switch(snapshot.connectionState){
              case ConnectionState.none:
                return const Text(
                  'An Error Occurred',
                );
              case ConnectionState.active:
              case ConnectionState.waiting:
                return const CircularProgressIndicator();
              case ConnectionState.done:
                if(snapshot.hasError){
                  return Text(
                    'Error: ${snapshot.error}',
                  );
                }
                else{
                  if(!snapshot.hasData){
                    return const Text(
                        'Make Some Memories now!'
                    );
                  }
                  else if(snapshot.data!.isEmpty){
                    return const Text(
                        'Make Some Memories!!'
                    );
                  }
                  else{
                    List<DiaryEntry> data = snapshot.data!;
                    return ListView.builder(
                      itemCount: data.length,
                      padding: const EdgeInsets.all(16.0),
                      itemBuilder: (BuildContext context, int i) {
                        return _buildRow(data[i].date);
                      },
                    );
                  }
                }
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addDairy,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void _addDairy(){
    Navigator.pushNamed(context, '/addDairy');
  }

  void _readDairy(String date) {
    DateTime currentDate = DateTime.now();
    String dateStr = '${currentDate.year}-${currentDate.month}-${currentDate.day}';
    if(date==dateStr){
      _addDairy();
    }
    else{
      Navigator.pushNamed(context, '/readDairy', arguments: {'dateStr': date});
    }
  }
}
