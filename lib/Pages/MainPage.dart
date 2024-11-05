import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:telawa/Pages/Tasmea.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as fs;

class MainPage extends StatefulWidget
{
  const MainPage({super.key});

  _MainPage createState() => _MainPage();
}
class _MainPage extends State<MainPage>
{
  final storage = const fs.FlutterSecureStorage();
  IconData timeIcon = Icons.dark_mode_rounded;
  bool _isDay = false;
  bool _isDarkMod = true;
  bool _isAppSelected = true;
  bool _isUserSelected = false;
  double points = 0.0;
  bool _isChecked = false;
  @override
  void dispose() {
    super.dispose();
  }
  @override
  void initState() {
    _isChecked = false;
    super.initState();
  }

  void _checkTime(TimeOfDay timeOfDay)
  {
    setState(() {
      if(timeOfDay.period.toString() == "DayPeriod.am")
      {
        if(_isAppSelected)
          {
            _isDay = true;
            timeIcon = Icons.sunny;
          }else
            {
              if(_isDarkMod)
              {
                _isDay = false;
                timeIcon = Icons.sunny;
              }else{
                _isDay = true;
                timeIcon = Icons.dark_mode_rounded;
              }
              storage.write(key: "isDay", value: _isDay.toString());
              storage.write(key: "isNight", value: _isDarkMod.toString());
            }
      }
      else
      {
        if(_isAppSelected)
          {
            _isDay = false;
            timeIcon = Icons.dark_mode_rounded;
          }else
            {
              if(_isDarkMod)
              {
                _isDay = false;
                timeIcon = Icons.sunny;
              }else
              {
                _isDay = true;
                timeIcon = Icons.dark_mode_rounded;
              }
              storage.write(key: "isDay", value: _isDay.toString());
              storage.write(key: "isNight", value: _isDarkMod.toString());
            }
      }
      storage.write(key: "colorMode", value: _isAppSelected.toString());
    });
  }
void gotoTasmea()
{
  setState(() {
    Navigator.push(
        context, MaterialPageRoute(builder: ((_) => const TasmeaQuran())));
  });
}
Future<void> initialize()
async {
  String? colorMode = await storage.read(key: "colorMode");
  String? isDay = await storage.read(key: "isDay");
  String? isNight = await storage.read(key: "isNight");
  if(colorMode == "true")
  {
    print(colorMode);
    _isAppSelected = true;
  }else{
    _isAppSelected = false;
    _isUserSelected = true;
    if(isDay == "true" && isNight == "false")
    {
      setState(() {
        _isDay = true;
        _isDarkMod = false;
      });

    }else{
      setState(() {
        _isDay = false;
        _isDarkMod = true;
      });
    }
  }
  _isChecked = true;
}
  @override
  Widget build(BuildContext context)
  {
    if(!_isChecked)
      {
        initialize();
      }
    final TimeOfDay timeOfDay = TimeOfDay.fromDateTime(DateTime.now());
    _checkTime(timeOfDay);
    return LayoutBuilder(builder: (context , constraint){
      final width = constraint.maxWidth;
      final height = constraint.maxHeight;
      return Scaffold(
        appBar: AppBar(
          backgroundColor: _isDay ? const Color.fromARGB(255, 127, 201, 194) : const Color.fromARGB(255, 34, 40, 49),
          title:Center(child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return Center(
                        child: Container(

                          width: width * 0.8,
                          height: height * 0.3,
                          child: Card(
                            color:  const Color.fromARGB(255, 34, 40, 49),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text("إِعْدَادَاتُ ٱلْبَرْنَامَجِ",style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold,color: Colors.white)),
                                const SizedBox(height: 5),
                                const Divider(
                                  height: 1,
                                  color: Colors.white,
                                ),
                                const SizedBox(height: 20),
                               const Text(
                                  'نِظَامُ الإِضَاءَةِ',
                                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold,color: Colors.white),
                                ),

                                const SizedBox(height: 20),
                                ToggleButtons(
                                  isSelected: [_isAppSelected, _isUserSelected],
                                  borderRadius: BorderRadius.circular(12),
                                  selectedColor: Colors.white,
                                  color: Colors.black,
                                  fillColor: Colors.blue,
                                  onPressed: (int index) {
                                    if (index == 0) {
                                      setState(() {
                                        _isAppSelected = true;
                                        _isUserSelected= false;
                                      });
                                      Navigator.pop(context);
                                    } else {
                                      setState(() {
                                        _isAppSelected = false;
                                        _isUserSelected= true;
                                      });
                                      _checkTime(timeOfDay);
                                      Navigator.pop(context);
                                    }
                                  },
                                  children: const [
                                    Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                                      child: Text('تلقائي' , style: TextStyle(color: Colors.white,fontSize: 25),),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                                      child: Text('دعني احدد', style: TextStyle(color: Colors.white,fontSize: 25)),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }, icon: Icon(Icons.list , color: _isDay?Colors.black :Colors.white,)),
                SizedBox(width: width * 0.2),
                 Text("Telawa" , style: GoogleFonts.pacifico(
            fontSize: 30,
            textStyle: const TextStyle(fontWeight: FontWeight.w200),
            color: _isDay? Colors.black: Colors.white,
          )),
                SizedBox(width: _isAppSelected? width * 0.25 :width * 0.2),
                _isAppSelected? Icon(timeIcon , color:  _isDay?Colors.orangeAccent : Colors.white,):
                IconButton( onPressed: (){
                  setState(() {
                    if(_isDarkMod)
                      {
                        _isDarkMod = false;
                      }else
                        {
                          _isDarkMod = true;
                        }
                  });
                },icon:Icon(timeIcon),color: _isDay ? Colors.black : Colors.white,),
              ]
          ),)
        ),
        backgroundColor: _isDay? const Color.fromARGB(255, 37, 50, 56) : const Color.fromARGB(255, 57, 62, 70),
        body:Center(child:
        Column(children: [
          const SizedBox(height: 20,),
          Container(
          width: width * 0.9,
          height: height * 0.15,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: _isDay? const Color.fromARGB(255,55, 70, 79) :const Color.fromARGB(
                180, 128, 236, 245),
          ),
            child: Column(children: [
              const SizedBox(height:45),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                Text("  $points : النِّقَاطِ السَّابِقَة " , style: GoogleFonts.aBeeZee(
                  fontSize: width * 0.06,
                  textStyle: const TextStyle(fontWeight: FontWeight.w200),
                  color:  _isDay? const Color.fromARGB(255,255, 255, 255) : const Color.fromARGB(
                      200, 0, 0, 0),
                )),
              ],),
            ],),
        ),
          const SizedBox(height:30),
          Divider(color: _isDay? Color.fromARGB(255, 127, 201, 194) : Color.fromARGB(255, 255,255,255) ,thickness: 3,height: 25),
          const Text("القَائِمَةُ الرَّئيسِيَّة" , style: TextStyle(fontSize: 40,color: Colors.white )),
          Divider(color: _isDay? Color.fromARGB(255, 127, 201, 194) : Color.fromARGB(255, 255,255,255) ,thickness: 3,height: 25),
          const SizedBox(height:70),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
                onTap: (){gotoTasmea();},
                borderRadius: BorderRadius.circular(20),
                child:  Container(
                  width: width * 0.4,
                  height: height * 0.12,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: _isDay? const Color.fromARGB(255,55, 70, 79) :const Color.fromARGB(
                      180, 128, 236, 245),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                Text("تسميع" , style: TextStyle(color: _isDay? Colors.white : Colors.black,fontSize: 30)),
                  const SizedBox(height:3),
                    Icon(Icons.mic_none_rounded,color: _isDay? Colors.white : Colors.black , size: 35,),
                ],),
              ),),
              const SizedBox(width: 50),
              InkWell(
                onTap: (){},
                borderRadius: BorderRadius.circular(20),
                child:  Container(
                  width: width * 0.4,
                  height: height * 0.12,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: _isDay? const Color.fromARGB(255,55, 70, 79) :const Color.fromARGB(
                        180, 128, 236, 245),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: 5),
                    Text("قراءه" , style: TextStyle(color: _isDay? Colors.white : Colors.black,fontSize: 30)),
                    Icon(Icons.menu_book,color: _isDay? Colors.white : Colors.black , size: 35,),
                  ],),
                ),),

            ],),
          SizedBox(height: 80),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
            InkWell(
              onTap: (){},
              borderRadius: BorderRadius.circular(20),
              child:  Container(
                width: width * 0.4,
                height: height * 0.12,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: _isDay? const Color.fromARGB(255,55, 70, 79) :const Color.fromARGB(
                      180, 128, 236, 245),
                ),
                child: Column(mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 5),
                    Text("مواقيت" , style: TextStyle(color: _isDay? Colors.white : Colors.black,fontSize: 30)),
                    Icon(Icons.timelapse_outlined,color: _isDay? Colors.white : Colors.black , size: 35,),
                  ],),
              ),
            ),
              SizedBox(width: 50),
              InkWell(
                onTap: (){},
                borderRadius: BorderRadius.circular(20),
                child:  Container(
                  width: width * 0.4,
                  height: height * 0.12,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: _isDay? const Color.fromARGB(255,55, 70, 79) :const Color.fromARGB(
                        180, 128, 236, 245),
                  ),
                  child: Column(mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: 5),
                      Text("أذكاري" , style: TextStyle(color: _isDay? Colors.white : Colors.black,fontSize: 30)),
                      Icon(Icons.chrome_reader_mode_outlined,color: _isDay? Colors.white : Colors.black , size: 35,),
                    ],),
                ),
              ),
            ],)
                  ],),
      ));
    }
    );
  }
}