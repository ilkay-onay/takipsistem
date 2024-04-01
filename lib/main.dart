import 'package:flutter/material.dart';
import 'HakkimizdaPage.dart';
import 'YardimPage.dart';
import 'AyarlarPage.dart';
import 'BagisPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isRaspiConnected = false;
  bool isAlarmActive = false;
  String capturedPicture = 'assets/placeholder_image.png';
  bool isFallDetected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ModülTespitçi Versiyon 0.1'),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF64B5F6),
                Color(0xFFE8F5E9),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        elevation: 0,
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF64B5F6),
                    Color(0xFFE8F5E9),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Text('Seçenekler'),
            ),
            ListTile(
              title: Text('Hakkımızda'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => HakkimizdaPage()));
              },
            ),
            ListTile(
              title: Text('Yardım'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => YardimPage()));
              },
            ),
            ListTile(
              title: Text('Ayarlar'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => AyarlarPage()));
              },
            ),
            ListTile(
              title: Text('Bağış'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => BagisPage()));
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        isRaspiConnected ? 'Tespit sistemine bağlanıldı' : 'Tespit sistemine bağlanılamadı',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          color: isRaspiConnected ? Colors.green : Colors.red,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Image.asset(
                        isRaspiConnected
                            ? 'assets/color_raspi.png'
                            : 'assets/black_white_raspi.png',
                        width: 50.0,
                        height: 65.0,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Text(
                      isAlarmActive ? 'Alarm Çalışıyor' : 'Alarm Çalışmıyor',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: isAlarmActive ? Colors.green : Colors.red,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 16.0,
                  ),
                  Transform.scale(
                    scale: 1.1,
                    child: Switch(
                      value: isAlarmActive,
                      onChanged: (value) {
                        setState(() {
                          isAlarmActive = value;
                        });
                      },
                      activeColor: Colors.green,
                      inactiveTrackColor: Colors.red,
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 20.0),
                    child: Stack(
                      children: [
                        Image.asset(
                          capturedPicture,
                          fit: BoxFit.contain,
                        ),
                        if (isFallDetected)
                          Positioned(
                            bottom: 10.0,
                            left: 10.0,
                            child: Row(
                              children: [
                                Image.asset(
                                  'assets/danger.png',
                                  width: 30.0,
                                  height: 30.0,
                                ),
                                SizedBox(width: 5.0),
                                Container(
                                  padding: EdgeInsets.all(10.0),
                                  color: Colors.black.withOpacity(0.7),
                                  child: Text(
                                    'Düşme tespit edildi!',
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 24.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        bool fileExists = true;
                        if (fileExists) {
                          capturedPicture = 'assets/goruntu.png';
                        }
                      });
                    },
                    style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all(Size(200, 60)),
                    ),
                    child: Text('Fotoğraf Çek', 
                    style: TextStyle(fontSize: 24)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
