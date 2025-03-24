import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void showCameraOptions(BuildContext context) {
  final ImagePicker _picker = ImagePicker();

  showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Select an option", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 16),
            Card(
              elevation: 3,
              child: ListTile(
                leading: Icon(Icons.videocam),
                title: Text("Record Video"),
                onTap: () async {
                  Navigator.pop(context);
                  final XFile? video = await _picker.pickVideo(source: ImageSource.camera);
                  if (video != null) {
                    print("Camera Video Path: ${video.path}");
                  }
                },
              ),
            ),
            SizedBox(height: 10),
            Card(
              elevation: 3,
              child: ListTile(
                leading: Icon(Icons.video_library),
                title: Text("Pick Video from Gallery"),
                onTap: () async {
                  Navigator.pop(context);
                  final XFile? video = await _picker.pickVideo(source: ImageSource.gallery);
                  if (video != null) {
                    print("Gallery Video Path: ${video.path}");
                  }
                },
              ),
            ),
          ],
        ),
      );
    },
  );
}
