import 'package:aes_crypt_null_safe/aes_crypt_null_safe.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'package:app3/constants.dart';

class ImaegisApp extends StatefulWidget {
  const ImaegisApp({super.key});
  @override
  _ImaegisAppState createState() => _ImaegisAppState();
}

class _ImaegisAppState extends State<ImaegisApp> {
  bool _isGranted = true;
  final myController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String _fileName = "File Not Selected";
  PlatformFile? _fileInfo;
  File? superFile;
  final int fileLimitation = 2000000;

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  void _openFileExplorer() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      PlatformFile file = result.files.first;
      if (file.size < fileLimitation) {
        setState(() {
          _fileName = file.name;
          _fileInfo = file;
        });
      } else {
        setState(() {
          _fileName = "File Size Exceeded 2 MB";
          _fileInfo = null;
        });
      }
      print(file.name);
    } else {
      // User canceled the picker
    }
  }

  Future<Directory> get getExternalVisibleDir async {
    if (await Directory('/storage/emulated/0/MyEncFolder').exists()) {
      final externalDir = Directory('/storage/emulated/0/MyEncFolder');
      return externalDir;
    } else {
      await Directory('/storage/emulated/0/MyEncFolder')
          .create(recursive: true);
      final externalDir = Directory('/storage/emulated/0/MyEncFolder');
      return externalDir;
    }
  }

  requestStoragePermission() async {
    if (!await Permission.storage.isGranted) {
      PermissionStatus result = await Permission.storage.request();
      if (result.isGranted) {
        setState(() {
          _isGranted = true;
        });
      } else {
        setState(() {
          _isGranted = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    requestStoragePermission();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: kColor1,
      appBar: AppBar(
        title: const Text(
          'IMAEGIS',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        // backgroundColor: Colors.grey[850],
        backgroundColor: Colors.black,
        elevation: 0.0,
      ),
      body: Center(
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.always,

          // FileName
          child: Column(
            children: [
              Hero(
                tag: 'logo',
                child: Container(
                  child: Image.asset('assets/img1.png'),
                  height: 250,
                  width: 250,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(60, 10, 60, 10),
                child: Text(
                  _fileName,
                  style: const TextStyle(
                    color: kColor4,
                    fontWeight: FontWeight.bold,
                    fontSize: 15.0,
                  ),
                ),
              ),

              // Password Field
              Padding(
                padding: const EdgeInsets.fromLTRB(60, 10, 60, 10),
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  controller: myController,
                  style: const TextStyle(color: Colors.black),
                  decoration: const InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      labelText: 'Password',
                      labelStyle: TextStyle(
                          fontSize: 20.0,
                          color: kColor2,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'SourceSans3')),
                  keyboardType: TextInputType.text,
                ),
              ),

              // Encrypt Button
              Container(
                margin: const EdgeInsets.fromLTRB(20, 30, 20, 20),
                child: ElevatedButton(
                    key: const Key('encrypt'),
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(kColor2),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ))),
                    onPressed: () async {
                      if (_isGranted) {
                        Directory d = await getExternalVisibleDir;
                        if (_formKey.currentState!.validate() &&
                            _fileInfo?.extension != null) {
                          var crypt = AesCrypt();
                          crypt.setPassword(myController.text);
                          crypt.setOverwriteMode(AesCryptOwMode.on);
                          crypt.encryptFileSync(
                              _fileInfo!.path!, '${d.path}/$_fileName.aes');
                          print("file encrypted successfully");
                          Navigator.pushNamed(context, '/second');
                        } else {
                          print("file encryption unsuccessful");
                        }
                      } else {
                        print("Permission not granted");
                      }
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text('Encrypt', style: kButtonStyle),
                    )),
              ),

              //Decrypt Button
              Container(
                child: ElevatedButton(
                    key: const Key('decrypt'),
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(kColor2),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ))),
                    onPressed: () async {
                      if (_isGranted) {
                        Directory d = await getExternalVisibleDir;
                        var crypt = AesCrypt();
                        crypt.setPassword(myController.text);
                        crypt.setOverwriteMode(AesCryptOwMode.on);
                        crypt.decryptFileSync('${d.path}/$_fileName');
                        print("file decrypted successfully");
                        Navigator.pushNamed(context, '/second');
                      }
                    },
                    child: const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text('Decrypt', style: kButtonStyle))),
              ),
            ],
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton.extended(

        onPressed: () => _openFileExplorer(),
        label: const Text(
          'Add File',
          style: TextStyle(color: kColor4),
        ), // Added Custom Text
        icon: const Icon(
          Icons.file_open,
          color: kColor4,
        ), // Added Custom Icon
        backgroundColor: kColor5,
      ),
    );
  }
}
