import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import './Src/Download.dart';
import './Src/Upload.dart';

Future<void> main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: const GradientHome(),
      //home: const Upload(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purpleAccent,
      appBar: AppBar(
        backgroundColor: Colors.purpleAccent,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 100,
              backgroundImage: NetworkImage(
                'https://pbs.twimg.com/media/FgGf2J9agAAxO70?format=jpg&name=medium'
              ),
              backgroundColor: Colors.deepPurple,
            ),
            SizedBox(height: 35,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Upload()));
                  },
                  child: Text('Upload',style: TextStyle(color: Color(0xffEDFF36),fontSize: 24),),
                  style: ElevatedButton.styleFrom(shape: StadiumBorder()),
                ),
                OutlinedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Download()));
                  },
                  child: Text('Download',style: TextStyle(color: Color(0xffEDFF36),fontSize: 24),),
                  style: OutlinedButton.styleFrom(shape: StadiumBorder(),),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class GradientHome extends StatefulWidget {
  const GradientHome({Key? key}) : super(key: key);

  @override
  State<GradientHome> createState() => _GradientHomeState();
}

class _GradientHomeState extends State<GradientHome> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xffA689C4),
            Color(0xffEE2AA9),
            Color(0xffFF99D9),
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 100,
                backgroundImage: NetworkImage(
                    'https://pbs.twimg.com/media/FgGf2J9agAAxO70?format=jpg&name=medium'
                ),
                foregroundColor: Color(0xffEDFF36),
                backgroundColor: Colors.deepPurple,
              ),
              SizedBox(height: 35,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Upload()));
                    },
                    child: Text('Upload',style: TextStyle(color: Color(0xffEDFF36)),),
                    style: ElevatedButton.styleFrom(shape: StadiumBorder()),
                  ),
                  OutlinedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Download()));
                    },
                    child: Text('Download',style: TextStyle(color: Color(0xffEDFF36)),),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.deepPurple,
                      shape: StadiumBorder(),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

