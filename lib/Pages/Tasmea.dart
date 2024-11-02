import 'package:flutter/material.dart';
import 'package:telawa/Services/MicServices.dart';

class TasmeaQuran extends StatefulWidget
{
  const TasmeaQuran({super.key});

  _TasmeaQuran createState() => _TasmeaQuran();
}
class _TasmeaQuran extends State<TasmeaQuran>
{
  final TextEditingController _speechResultController = TextEditingController();
  bool isPermissionGranted = false;
   late MicService speechRecognizer;
  String? _selectedSura = 'إختار اسم السورة';
  String? _selectedStartAya;
  String? _selectedEndAya;
  bool _isRecording = false;
  final Map<String, List<String>> suraAyatMap = {
    'إختار اسم السورة': [],
    'الفاتحة': List.generate(7, (index) => '${index + 1}'),
    'البقرة': List.generate(286, (index) => '${index + 1}'),
    'آل عمران': List.generate(200, (index) => '${index + 1}'),
    'النساء': List.generate(176, (index) => '${index + 1}'),
    'المائدة': List.generate(120, (index) => '${index + 1}'),
    'الأنعام': List.generate(165, (index) => '${index + 1}'),
    'الأعراف': List.generate(206, (index) => '${index + 1}'),
    'الأنفال': List.generate(75, (index) => '${index + 1}'),
    'التوبة': List.generate(129, (index) => '${index + 1}'),
    'يونس': List.generate(109, (index) => '${index + 1}'),
    'هود': List.generate(123, (index) => '${index + 1}'),
    'يوسف': List.generate(111, (index) => '${index + 1}'),
    'الرعد': List.generate(43, (index) => '${index + 1}'),
    'إبراهيم': List.generate(52, (index) => '${index + 1}'),
    'الحجر': List.generate(99, (index) => '${index + 1}'),
    'النحل': List.generate(128, (index) => '${index + 1}'),
    'الإسراء': List.generate(111, (index) => '${index + 1}'),
    'الكهف': List.generate(110, (index) => '${index + 1}'),
    'مريم': List.generate(98, (index) => '${index + 1}'),
    'طه': List.generate(135, (index) => '${index + 1}'),
    'الأنبياء': List.generate(112, (index) => '${index + 1}'),
    'الحج': List.generate(78, (index) => '${index + 1}'),
    'المؤمنون': List.generate(118, (index) => '${index + 1}'),
    'النور': List.generate(64, (index) => '${index + 1}'),
    'الفرقان': List.generate(77, (index) => '${index + 1}'),
    'الشعراء': List.generate(227, (index) => '${index + 1}'),
    'النمل': List.generate(93, (index) => '${index + 1}'),
    'القصص': List.generate(88, (index) => '${index + 1}'),
    'العنكبوت': List.generate(69, (index) => '${index + 1}'),
    'الروم': List.generate(60, (index) => '${index + 1}'),
    'لقمان': List.generate(34, (index) => '${index + 1}'),
    'السجدة': List.generate(30, (index) => '${index + 1}'),
    'الأحزاب': List.generate(73, (index) => '${index + 1}'),
    'سبأ': List.generate(54, (index) => '${index + 1}'),
    'فاطر': List.generate(45, (index) => '${index + 1}'),
    'يس': List.generate(83, (index) => '${index + 1}'),
    'الصافات': List.generate(182, (index) => '${index + 1}'),
    'ص': List.generate(88, (index) => '${index + 1}'),
    'الزمر': List.generate(75, (index) => '${index + 1}'),
    'غافر': List.generate(85, (index) => '${index + 1}'),
    'فصلت': List.generate(54, (index) => '${index + 1}'),
    'الشورى': List.generate(53, (index) => '${index + 1}'),
    'الزخرف': List.generate(89, (index) => '${index + 1}'),
    'الدخان': List.generate(59, (index) => '${index + 1}'),
    'الجاثية': List.generate(37, (index) => '${index + 1}'),
    'الأحقاف': List.generate(35, (index) => '${index + 1}'),
    'محمد': List.generate(38, (index) => '${index + 1}'),
    'الفتح': List.generate(29, (index) => '${index + 1}'),
    'الحجرات': List.generate(18, (index) => '${index + 1}'),
    'ق': List.generate(45, (index) => '${index + 1}'),
    'الذاريات': List.generate(60, (index) => '${index + 1}'),
    'الطور': List.generate(49, (index) => '${index + 1}'),
    'النجم': List.generate(62, (index) => '${index + 1}'),
    'القمر': List.generate(55, (index) => '${index + 1}'),
    'الرحمن': List.generate(78, (index) => '${index + 1}'),
    'الواقعة': List.generate(96, (index) => '${index + 1}'),
    'الحديد': List.generate(29, (index) => '${index + 1}'),
    'المجادلة': List.generate(22, (index) => '${index + 1}'),
    'الحشر': List.generate(24, (index) => '${index + 1}'),
    'الممتحنة': List.generate(13, (index) => '${index + 1}'),
    'الصف': List.generate(14, (index) => '${index + 1}'),
    'الجمعة': List.generate(11, (index) => '${index + 1}'),
    'المنافقون': List.generate(11, (index) => '${index + 1}'),
    'التغابن': List.generate(18, (index) => '${index + 1}'),
    'الطلاق': List.generate(12, (index) => '${index + 1}'),
    'التحريم': List.generate(12, (index) => '${index + 1}'),
    'الملك': List.generate(30, (index) => '${index + 1}'),
    'القلم': List.generate(52, (index) => '${index + 1}'),
    'الحاقة': List.generate(52, (index) => '${index + 1}'),
    'المعارج': List.generate(44, (index) => '${index + 1}'),
    'نوح': List.generate(28, (index) => '${index + 1}'),
    'الجن': List.generate(28, (index) => '${index + 1}'),
    'المزمل': List.generate(20, (index) => '${index + 1}'),
    'المدثر': List.generate(56, (index) => '${index + 1}'),
    'القيامة': List.generate(40, (index) => '${index + 1}'),
    'الإنسان': List.generate(31, (index) => '${index + 1}'),
    'المرسلات': List.generate(50, (index) => '${index + 1}'),
    'النبأ': List.generate(40, (index) => '${index + 1}'),
    'النازعات': List.generate(46, (index) => '${index + 1}'),
    'عبس': List.generate(42, (index) => '${index + 1}'),
    'التكوير': List.generate(29, (index) => '${index + 1}'),
    'الانفطار': List.generate(19, (index) => '${index + 1}'),
    'المطففين': List.generate(36, (index) => '${index + 1}'),
    'الانشقاق': List.generate(25, (index) => '${index + 1}'),
    'البروج': List.generate(22, (index) => '${index + 1}'),
    'الطارق': List.generate(17, (index) => '${index + 1}'),
    'الأعلى': List.generate(19, (index) => '${index + 1}'),
    'الغاشية': List.generate(26, (index) => '${index + 1}'),
    'الفجر': List.generate(30, (index) => '${index + 1}'),
    'البلد': List.generate(20, (index) => '${index + 1}'),
    'الشمس': List.generate(15, (index) => '${index + 1}'),
    'الليل': List.generate(21, (index) => '${index + 1}'),
    'الضحى': List.generate(11, (index) => '${index + 1}'),
    'الشرح': List.generate(8, (index) => '${index + 1}'),
    'التين': List.generate(8, (index) => '${index + 1}'),
    'العلق': List.generate(19, (index) => '${index + 1}'),
    'القدر': List.generate(5, (index) => '${index + 1}'),
    'البينة': List.generate(8, (index) => '${index + 1}'),
    'الزلزلة': List.generate(8, (index) => '${index + 1}'),
    'العاديات': List.generate(11, (index) => '${index + 1}'),
    'القارعة': List.generate(11, (index) => '${index + 1}'),
    'التكاثر': List.generate(8, (index) => '${index + 1}'),
    'العصر': List.generate(3, (index) => '${index + 1}'),
    'الهمزة': List.generate(9, (index) => '${index + 1}'),
    'الفيل': List.generate(5, (index) => '${index + 1}'),
    'قريش': List.generate(4, (index) => '${index + 1}'),
    'الماعون': List.generate(7, (index) => '${index + 1}'),
    'الكوثر': List.generate(3, (index) => '${index + 1}'),
    'الكافرون': List.generate(6, (index) => '${index + 1}'),
    'النصر': List.generate(3, (index) => '${index + 1}'),
    'المسد': List.generate(5, (index) => '${index + 1}'),
    'الإخلاص': List.generate(4, (index) => '${index + 1}'),
    'الفلق': List.generate(5, (index) => '${index + 1}'),
    'الناس': List.generate(6, (index) => '${index + 1}'),
  };

  @override
  void dispose() {
    super.dispose();
  }

  void initState() {
    super.initState();
    speechRecognizer = MicService(
      onTextRecognized: (text) {
        setState(() {
          _speechResultController.text = text; // Update the TextField with the recognized text
        });
      },
    );
  }

  Future<void> initializeSpeechRecognition() async {
   isPermissionGranted = await speechRecognizer.getMicrophonePermission();
     handlePermissionResponse(false);
  }

  void handlePermissionResponse(bool isPressed) {
    if (isPressed) {
      setState(() {
        _isRecording = true;
      });
      speechRecognizer.startSpeechRecognition(context); // Start speech recognition when the button is pressed
    }else
      {
        setState(() {
          _isRecording = false;
        });

        speechRecognizer.stopSpeechRecognition();
      }
  }

  Widget build(BuildContext context)
{
  return LayoutBuilder(builder: (context , constraint)
  {

    final width = constraint.maxWidth;
    final height = constraint.maxHeight;

      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title:const Center(child: Text(
              "تسميع", style: TextStyle(color: Colors.white, fontSize: 40))),
          backgroundColor:const Color.fromARGB(255, 37, 50, 56),
        ),
        body: Center(child: Column(children: [
          const SizedBox(height: 20),
          Row(children: [
            const SizedBox(width: 10),
            Container(
            height: MediaQuery.of(context).size.height * 0.055,
        width: MediaQuery.of(context).size.width * 0.4,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: const Color.fromARGB(255, 37, 50, 56),
          boxShadow: const [
            BoxShadow(
              color: Color.fromARGB(66, 172, 172, 172),
              blurRadius: 20,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Center(
            child: DropdownButtonFormField<String>(
              alignment: Alignment.center,
              style: const TextStyle(color: Colors.white, fontSize: 20),
              dropdownColor: const Color.fromARGB(255, 37, 50, 56),
              value: _selectedSura,
              decoration: const InputDecoration(
                labelStyle: TextStyle(color: Color.fromARGB(255, 37, 50, 56)),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.amber),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color.fromARGB(255, 37, 50, 56)),
                ),
              ),
              items: suraAyatMap.keys.map((String suraName) {
                return DropdownMenuItem<String>(
                  value: suraName,
                  child: Text(suraName),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedSura = newValue!;
                  _selectedStartAya = null;
                });
              },
              validator: (value) {
                if (value == null || value.isEmpty || value == "إختار اسم السورة") {
                  return 'إختار اسم السورة';
                }
                return null;
              },
              onSaved: (newValue) {
                _selectedSura = newValue!;
              },
            ),
          ),
        ),
      ),
            const SizedBox(width: 10),
            Container(
              height: MediaQuery.of(context).size.height * 0.055,
              width: MediaQuery.of(context).size.width * 0.25,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: const Color.fromARGB(255, 37, 50, 56),
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromARGB(66, 172, 172, 172),
                    blurRadius: 20,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: Center(
                  child: DropdownButtonFormField<String>(
                    alignment: Alignment.center,
                    style: const TextStyle(color: Colors.white, fontSize: 20),
                    dropdownColor: const Color.fromARGB(255, 37, 50, 56),
                    value: _selectedStartAya,
                    decoration: const InputDecoration(
                      labelStyle: TextStyle(color: Color.fromARGB(255, 37, 50, 56)),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.amber),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color.fromARGB(255, 37, 50, 56)),
                      ),
                    ),
                    items: _selectedSura != null
                        ? suraAyatMap[_selectedSura]!.map((String aya) {
                      return DropdownMenuItem<String>(
                        value: aya,
                        child: Text(aya),
                      );
                    }).toList()
                        : [], // Provide ayat numbers based on selected sura
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedStartAya = newValue!;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty || value == "اختار رقم ايه") {
                        return 'اختار رقم ايه';
                      }
                      return null;
                    },
                    onSaved: (newValue) {
                      _selectedStartAya = newValue!;
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Container(
              height: MediaQuery.of(context).size.height * 0.055,
              width: MediaQuery.of(context).size.width * 0.25,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: const Color.fromARGB(255, 37, 50, 56),
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromARGB(66, 172, 172, 172),
                    blurRadius: 20,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: Center(
                  child: DropdownButtonFormField<String>(
                    alignment: Alignment.center,
                    style: const TextStyle(color: Colors.white, fontSize: 20),
                    dropdownColor: const Color.fromARGB(255, 37, 50, 56),
                    value: _selectedEndAya,
                    decoration: const InputDecoration(
                      labelStyle: TextStyle(color: Color.fromARGB(255, 37, 50, 56)),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.amber),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color.fromARGB(255, 37, 50, 56)),
                      ),
                    ),
                    items: _selectedSura != null
                        ? suraAyatMap[_selectedSura]!.map((String aya) {
                      return DropdownMenuItem<String>(
                        value: aya,
                        child: Text(aya),
                      );
                    }).toList()
                        : [], // Provide ayat numbers based on selected sura
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedEndAya = newValue!;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty || value == "اختار رقم ايه") {
                        return 'اختار رقم ايه';
                      }
                      return null;
                    },
                    onSaved: (newValue) {
                      _selectedEndAya = newValue!;
                    },
                  ),
                ),
              ),
            ),
          ],),
          const SizedBox(height: 10),
          Divider(color: const Color.fromARGB(255, 37, 50, 56),thickness: 3),
          Divider(color: const Color.fromARGB(255, 37, 50, 56),thickness: 3),

         const SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: const Color.fromARGB(255, 37, 50, 56)),
            width: width * 0.95,
            height: height * 0.5,
            child: TextField(
              controller: _speechResultController,
              enabled: false,
              textAlign: TextAlign.right,
            style:  const TextStyle(fontSize: 30 , color: Colors.white),
          ),),
          const SizedBox(height: 10),
          Divider(color: const Color.fromARGB(255, 37, 50, 56),thickness: 3),
          const SizedBox(height: 10),
          Divider(color: const Color.fromARGB(255, 37, 50, 56),thickness: 3),
          const SizedBox(height: 20),
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(30),color: const Color.fromARGB(255, 37, 50, 56)),
            width: width * 0.25,
            height: height * 0.07,
            child:_isRecording? IconButton(onPressed: (){
              handlePermissionResponse(false);
            }, icon: const Icon(Icons.fiber_manual_record_rounded,color: Colors.redAccent,size: 40)):
            IconButton(onPressed: (){
              handlePermissionResponse(true);
            }, icon: const Icon(Icons.mic,color: Colors.white,size: 40)),
          ),
        ],),),
      );});
  }
  Widget buildAyaDropdown() {
    // This widget builds the ayat dropdown based on the selected sura
    return DropdownButtonFormField<String>(
      alignment: Alignment.center,
      style: const TextStyle(color: Colors.white, fontSize: 20),
      dropdownColor: const Color.fromARGB(255, 37, 50, 56),
      value: _selectedStartAya,
      decoration: const InputDecoration(
        labelStyle: TextStyle(color: Color.fromARGB(255, 37, 50, 56)),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.amber),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color.fromARGB(255, 37, 50, 56)),
        ),
      ),
      items: (suraAyatMap[_selectedSura] ?? []).map((String aya) {
        return DropdownMenuItem<String>(
          value: aya,
          child: Text(aya),
        );
      }).toList(),
      onChanged: (String? newValue) {
        setState(() {
          _selectedStartAya = newValue!;
        });
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'إختار رقم الآية';
        }
        return null;
      },
      onSaved: (newValue) {
        _selectedStartAya = newValue!;
      },
    );
  }
}
