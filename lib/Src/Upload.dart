import 'dart:io';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Upload extends StatefulWidget {
  const Upload({Key? key}) : super(key: key);

  @override
  State<Upload> createState() => _UploadState();
}

class _UploadState extends State<Upload> {
  PlatformFile? pickedFile;
  UploadTask? uploadTask;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purpleAccent,
      appBar: AppBar(
        title: const Text(
          'Upload File',
          style: TextStyle(
            color: Color(0xffEDFF36),
          ),
        ),
        leading: BackButton(
          color: Colors.purpleAccent,
        )
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if(pickedFile != null)
              Expanded(
                child: Container(
                  color: Colors.purple[100],
                  child: Center(
                    child: Image.file(
                      File(pickedFile!.path!),
                      width: double.infinity,
                      fit: BoxFit.cover,
                    )
                  ),
                ),
              ),
            SizedBox(height: 32,),
            ElevatedButton(
              onPressed: selectFile,
              child: Text('Select',style: TextStyle(color: Color(0xffEDFF36),),),
              style: ElevatedButton.styleFrom(shape: StadiumBorder()),
            ),
            const SizedBox(height: 32,),
            ElevatedButton(
              onPressed: uploadFile,
              child: Text('Upload',style: TextStyle(color: Color(0xffEDFF36),),),
              style: ElevatedButton.styleFrom(shape: StadiumBorder()),
            ),
            buildProgress(),
          ],
        ),
      ),
    );
  }

  Future selectFile()async{
    final result = await FilePicker.platform.pickFiles();
    if(result == null) return;

    setState((){
      pickedFile = result.files.first;
    });
  }

  Future uploadFile()async{
    final path = 'files/${pickedFile!.name}';
    final file = File(pickedFile!.path!);

    final ref = FirebaseStorage.instance.ref().child(path);
    setState((){
      uploadTask = ref.putFile(file);
    });

    final snapshot = await uploadTask!.whenComplete((){

    });

    final urlDownload = await snapshot.ref.getDownloadURL();
    print('Download Link: ${urlDownload}');

    setState((){
      //uploadTask = ref.putFile(file);
      uploadTask = null;
    });
  }

  Widget buildProgress(){
    return StreamBuilder<TaskSnapshot>(
      stream: uploadTask?.snapshotEvents,
      builder: (context,snapshot){
        if(snapshot.hasData){
          final data = snapshot.data!;
          double progress = data.bytesTransferred / data.totalBytes;

          return SizedBox(
            height: 50,
            child: Stack(
              fit: StackFit.expand,
              children: [
                LinearProgressIndicator(
                  value: progress,
                  backgroundColor: Colors.purple,
                  color: Colors.purple,
                ),
                Center(
                  child: Text(
                    '${(100 * progress).roundToDouble()}%',
                    style: TextStyle(
                      color: Colors.purpleAccent,
                    ),
                  ),
                )
              ],
            ),
          );
        }else{
          return const SizedBox(height: 50,);
        }
      },
    );
  }
}