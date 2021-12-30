import 'package:flutter/material.dart';

Map<String, int> users = {};
const Map<String, int> tasks = {
  "Ate Healthy": 5,
  "Slept 7+ hours": 5,
  "Lifted Wieghts": 5,
  "Did Cardio": 5,
  "Woke up before 8am": 3,
  "Went to bed before 1am": 3,
  "Did HW 3 days before it is due": 2,
  "Flossed": 1,
  "Took daily vitamins": 1,
  "Ate a snack": -3,
  "Drank soda": -3,
  "Napped longer then 1hr": -3,
  "Drank more then 1 cup of coffee": -3,
};

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int pageIndex = 0;
  List<Widget> pageList = <Widget>[
    const Home(),
    const Entry(),
    const Modify(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: const Text('Competition Tracker'),
      ),
      body: pageList[pageIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          setState(() {
            pageIndex = value;
          });
        },
        currentIndex: pageIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Today\'s Entry',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.construction_rounded),
            label: 'Modify',
          ),
        ],
      ),
    ));
  }
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    if (users.isEmpty) {
      return const Center(
        child: Text(
          'Go to \'Modify\' and add competitors',
          style: TextStyle(fontSize: 20),
        ),
      );
    } else {
      return Column(children: <Widget>[
        Expanded(
            child: ListView.builder(
                padding: const EdgeInsets.all(2),
                itemCount: users.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                      height: height / 3,
                      width: width - 20,
                      margin: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.0),
                          color: Colors.lightBlue,
                          border: Border.all()),
                      child: Column(
                        children: [
                          Text(
                            users.keys.elementAt(index),
                            style: const TextStyle(
                                fontSize: 35,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            users[users.keys.elementAt(index)].toString(),
                            style: const TextStyle(
                                fontSize: 70,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                      ));
                }))
      ]);
    }
  }
}

class Entry extends StatelessWidget {
  const Entry({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (users.isEmpty) {
      return const Center(
        child: Text(
          'Go to \'Modify\' and add competitors',
          style: TextStyle(fontSize: 20),
        ),
      );
    }
    return Column(children: <Widget>[
      const Padding(
        padding: EdgeInsets.fromLTRB(8, 20, 8, 8),
        child: Text(
          "Click on your name",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ),
      Expanded(
          child: ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: users.keys.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  child: Container(
                    height: 50,
                    margin: const EdgeInsets.all(2),
                    color: Colors.lightBlue,
                    child: Center(
                        child: Text(
                      users.keys.elementAt(index),
                      style: const TextStyle(fontSize: 20, color: Colors.white),
                    )),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) =>
                              CheckBoxes(user: users.keys.elementAt(index))),
                    );
                  },
                );
              })),
    ]);
  }
}

class CheckBoxes extends StatefulWidget {
  const CheckBoxes({Key? key, required this.user}) : super(key: key);
  final String user;

  @override
  _CheckBoxesState createState() => _CheckBoxesState();
}

class _CheckBoxesState extends State<CheckBoxes> {
  Map<String, bool?> switches = {
    "Ate Healthy": false,
    "Slept 7+ hours": false,
    "Lifted Wieghts": false,
    "Did Cardio": false,
    "Woke up before 8am": false,
    "Went to bed before 1am": false,
    "Did HW 3 days before it is due": false,
    "Flossed": false,
    "Took daily vitamins": false,
    "Ate a snack": false,
    "Drank soda": false,
    "Napped longer then 1hr": false,
    "Drank more then 1 cup of coffee": false,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Editing " + widget.user + "'s Points"),
        backgroundColor: Colors.green,
      ),
      body: Column(children: [
        Container(
          padding: const EdgeInsets.all(16.0),
          child: const Text(
            'Mark your points for today',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
                color: Colors.black54),
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 100),
            child: Column(
                children: tasks.keys
                    .map((item) => CheckboxListTile(
                          title: Text(tasks[item].toString() + " | " + item),
                          value: switches[item],
                          onChanged: (bool? value) {
                            setState(() {
                              switches[item] = value;
                            });
                          },
                        ))
                    .toList()),
          ),
        ),
      ]),
      floatingActionButton: FloatingActionButton(
        child: const Text(
          'Save',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
        ),
        onPressed: () {
          int todaysCount = users[widget.user.toString()]!.toInt();
          for (String task in switches.keys) {
            if (switches[task] == true) {
              todaysCount += tasks[task]!.toInt();
            }
          }
          users[widget.user.toString()] = todaysCount;
          Navigator.pop(context, this);
        },
      ),
    );
  }
}

class Modify extends StatefulWidget {
  const Modify({Key? key}) : super(key: key);

  @override
  _ModifyState createState() => _ModifyState();
}

class _ModifyState extends State<Modify> {
  final addController = TextEditingController();
  final removeController = TextEditingController();

  @override
  void dispose() {
    addController.dispose();
    removeController.dispose();
    super.dispose();
  }

  String addCompetitor = "";
  String removeCompetitor = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const Center(
              child: Padding(
                padding: EdgeInsets.fromLTRB(0, 50.0, 0, 0),
                child: Text(
                  'Add a competitor',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextField(
                controller: addController,
                decoration: const InputDecoration(
                  labelText: 'Enter Name',
                  border: OutlineInputBorder(),
                  hintText: 'Enter Name',
                ),
              ),
            ),
            SizedBox(
              width: 100,
              child: TextButton(
                style: TextButton.styleFrom(
                    primary: Colors.white, backgroundColor: Colors.blue),
                onPressed: () {
                  addCompetitor = addController.text;
                  if (users.containsKey(addCompetitor)) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Bad Input'),
                          content: Text("Name $addCompetitor is already used"),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                  } else if (addCompetitor == "") {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Bad Input!'),
                          content: const Text('You entered nothing'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                  } else {
                    users[addCompetitor] = 0;
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Completed!'),
                          content: Text("Added $addCompetitor"),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
                child: const Text('Add'),
              ),
            ),
            const Center(
              child: Padding(
                padding: EdgeInsets.fromLTRB(0, 50.0, 0, 0),
                child: Text(
                  'Remove a competitor',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextField(
                controller: removeController,
                decoration: const InputDecoration(
                  labelText: 'Enter Name',
                  border: OutlineInputBorder(),
                  hintText: 'Enter Name',
                ),
              ),
            ),
            SizedBox(
              width: 100,
              child: TextButton(
                style: TextButton.styleFrom(
                    primary: Colors.white, backgroundColor: Colors.blue),
                onPressed: () {
                  removeCompetitor = removeController.text;
                  if (users.containsKey(removeCompetitor)) {
                    users.remove(removeCompetitor);
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Completed!'),
                          content: Text("Deleted $removeCompetitor"),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                  } else if (removeCompetitor == "") {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Bad Input!'),
                          content: const Text('You entered nothing'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                  } else {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Bad Input'),
                          content: Text("Name $removeCompetitor not found"),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
                child: const Text('Remove'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
