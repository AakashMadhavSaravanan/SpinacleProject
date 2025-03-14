import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({super.key});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  final Map<String, String?> _uploadedFiles = {
    'KYC': null,
    'Medical Bills': null,
    'Doctor Prescription': null,
    'Policy': null,
    'Claim Form': null,
    'Hospital Bills': null,
  };

  /// Function to pick a file for a specific document type
  Future<void> pickFile(String documentType) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx', 'jpg', 'png', 'jpeg'],
    );

    if (result != null) {
      String fileName = result.files.first.name;
      String extension = fileName.split('.').last.toLowerCase();

      if (['pdf', 'doc', 'docx', 'jpg', 'png', 'jpeg'].contains(extension)) {
        setState(() {
          _uploadedFiles[documentType] = fileName;
        });
      } else {
        // Show an error if an invalid file type is selected
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Only Word documents, PDFs, and images are allowed.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  /// Function to remove an uploaded file
  void removeFile(String documentType) {
    setState(() {
      _uploadedFiles[documentType] = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            /// Bigger and Center-Aligned Title
            const SizedBox(height: 16),
            const Text(
              'Upload and Attach File',
              style: TextStyle(
                fontSize: 24, // **Even bigger**
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            const Text(
              'Only Word documents, PDFs, and images are allowed.',
              style: TextStyle(
                fontSize: 18, // **Bigger subtitle**
                fontWeight: FontWeight.bold,
                color: Colors.grey, // **Changed to grey**
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),

            /// Section Headers and File Upload Boxes
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Financial Documents:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            _buildFileBox('KYC'),
            _buildFileBox('Medical Bills'),
            _buildFileBox('Doctor Prescription'),
            const SizedBox(height: 12),

            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Insurance Documents:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            _buildFileBox('Policy'),
            _buildFileBox('Claim Form'),
            _buildFileBox('Hospital Bills'),
            const SizedBox(height: 24),

            /// Buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      setState(() {
                        _uploadedFiles.updateAll((key, value) => null);
                      });
                    },
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      side: BorderSide(color: Colors.grey.shade300),
                    ),
                    child: const Text(
                      'Discard',
                      style: TextStyle(color: Colors.purple),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: FilledButton(
                    onPressed: () {},
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: Colors.purple,
                    ),
                    child: const Text('Attach files'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// Widget to display each document type inside a separate box
  Widget _buildFileBox(String documentType) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 2,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// File Name or Default Document Name
            Text(
              _uploadedFiles[documentType] ?? documentType,
              style: TextStyle(
                fontSize: 14,
                fontWeight: _uploadedFiles[documentType] != null
                    ? FontWeight.bold
                    : FontWeight.normal,
                color: _uploadedFiles[documentType] != null
                    ? Colors.black
                    : Colors.grey.shade700,
              ),
            ),
            const SizedBox(height: 8),

            /// Upload and Delete Icons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                /// Upload or Check Icon
                IconButton(
                  icon: Icon(
                    _uploadedFiles[documentType] == null
                        ? Icons.upload_file
                        : Icons.check_circle,
                    color: _uploadedFiles[documentType] == null
                        ? Colors.grey
                        : Colors.green,
                  ),
                  onPressed: () => pickFile(documentType),
                ),

                /// Delete Icon (Appears Only If File Is Uploaded)
                if (_uploadedFiles[documentType] != null)
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => removeFile(documentType),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
