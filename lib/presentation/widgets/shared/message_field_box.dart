import 'package:flutter/material.dart';

class MessageFieldBox extends StatelessWidget {
  final ValueChanged<String> onValue;

  const MessageFieldBox({super.key, required this.onValue});

  @override
  Widget build(BuildContext context) {
    // final colors = Theme.of(context).colorScheme;

    final textController = TextEditingController();

    final focusNode = FocusNode();

    final inputOutlineBorder = OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.transparent),
        borderRadius: BorderRadius.circular(40));

    return TextFormField(
      onTapOutside: (event) {
        focusNode.unfocus();
      },
      focusNode: focusNode,
      controller: textController,
      decoration: InputDecoration(
          hintText: "Enter your message",
          enabledBorder: inputOutlineBorder,
          focusedBorder: inputOutlineBorder,
          filled: true,
          suffixIcon: IconButton(
            icon: const Icon(Icons.send),
            onPressed: () {
              final textValue = textController.value.text;
              textController.clear();
              onValue(textValue);
            },
          )),
      onFieldSubmitted: (value) {
        textController.clear();
        focusNode.requestFocus();
        onValue(value);
      },
    );
  }
}
