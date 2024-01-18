import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stuverse_ai/features/chat/cubit/chat_cubit.dart';

class FooterTextField extends StatefulWidget {
  const FooterTextField({
    super.key,
  });

  @override
  State<FooterTextField> createState() => _FooterTextFieldState();
}

class _FooterTextFieldState extends State<FooterTextField> {
  ImagePicker _imagePicker = ImagePicker();
  XFile? _image;

  void _pickImage({
    ImageSource source = ImageSource.gallery,
  }) async {
    final image = await _imagePicker.pickImage(
      source: source,
      imageQuality: 70,
      maxWidth: 500,
      maxHeight: 500,
    );
    if (image != null) {
      // Implement image selection logic
      setState(() {
        _image = image;
      });
    }
  }

  final TextEditingController _messageFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final fieldColor = Theme.of(context).colorScheme.outlineVariant;
    final isLoading =
        context.select((ChatCubit cubit) => cubit.state.isLoading);
    final agent = context.select((ChatCubit cubit) => cubit.state.agent);
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: fieldColor),
      padding: EdgeInsets.symmetric(
        horizontal: 10,
      ),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (_image != null)
            Padding(
              padding: const EdgeInsets.only(left: 10, top: 10),
              child: Stack(
                children: [
                  Image.file(
                    File(_image!.path),
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Theme.of(context)
                          .colorScheme
                          .background
                          .withOpacity(0.45),
                    ),
                    child: IconButton(
                        icon: Icon(Icons.close),
                        onPressed: () {
                          setState(() {
                            _image = null;
                          });
                        }),
                  )
                ],
              ),
            ),
          TextField(
            controller: _messageFieldController,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Ask me anything..',
              suffixIcon: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.image),
                    onPressed: _openImagePickerSheet,
                  ),
                  IgnorePointer(
                    ignoring: isLoading,
                    child: IconButton(
                      icon: Icon(isLoading ? Icons.circle : Icons.send,
                          color: Theme.of(context).colorScheme.primary),
                      onPressed: () async {
                        if (_messageFieldController.text.isNotEmpty) {
                          context.read<ChatCubit>().sendMessage(
                                message: _messageFieldController.text,
                                agent: agent,
                                image: _image,
                              );
                          _messageFieldController.clear();
                          setState(() {
                            _image = null;
                          });
                        }
                      },
                    ),
                  ),
                ],
              ),
              filled: true,
              fillColor: fieldColor, // Use the same fillColor for consistency
            ),
            keyboardType: TextInputType.multiline,
            maxLines: 5,
            minLines: 1,
          ),
        ],
      ),
    );
  }

  void _openImagePickerSheet() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          margin: const EdgeInsets.only(
            top: 5,
            left: 5,
            right: 5,
            bottom: 30,
          ),
          child: Wrap(
            children: [
              ListTile(
                leading: Icon(Icons.camera),
                title: Text('Camera'),
                onTap: () {
                  _pickImage(
                    source: ImageSource.camera,
                  );
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Gallery'),
                onTap: () {
                  _pickImage(
                    source: ImageSource.gallery,
                  );
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
