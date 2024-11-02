import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class MicService
{
  stt.SpeechToText speech = stt.SpeechToText();
  final Function(String) onTextRecognized;
  MicService({required this.onTextRecognized});

  Future<bool> getMicrophonePermission() async {
    bool hasPermission = await speech.initialize(
      onError: (error) => print('Error initializing speech recognition: $error'),
    );

    if (!hasPermission) {
      bool isPermissionGranted = await speech.requestPermission();

      if (!isPermissionGranted) {
        print('Microphone permission not granted');
      }
      return isPermissionGranted;
    }
    return true;
  }
  bool isSpeechRecognitionAvailable(BuildContext context) {
    try {
      return speech.isAvailable;
    } catch (e) {
      if (e is PlatformException) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Speech recognition not available ${e.message}')),
        );
      }
      return false;
    }
  }
String recResults = "";

  void startSpeechRecognition(BuildContext context) async {
    print("Listening...");
    try {
      bool available = await speech.initialize(
        onStatus: (status) => print('Status: $status'),
        onError: (error) => print('Error: $error'),
      );
      if (available) {
        speech.listen(
          localeId: 'ar', // Set the language to Arabic
          listenFor: const Duration(minutes: 60), // Set the listening duration
          cancelOnError: true,
          partialResults: true, // Enable getting partial results while still speaking
          onResult: (result) {
            onTextRecognized(result.recognizedWords); // Call the callback with the recognized text
          },
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Speech recognition not available')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Speech recognition error: $e')),
      );
    }
  }


  void stopSpeechRecognition() {
    speech.stop();
  }

  void disposeSpeechRecognition() {
    speech.cancel();
  }

}

extension on stt.SpeechToText {
  requestPermission() {}
}