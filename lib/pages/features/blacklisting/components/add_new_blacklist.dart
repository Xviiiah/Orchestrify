import 'package:flutter/material.dart';

import '../../../../widgets/input/custom_text_form_field.dart';
import '../../../../widgets/input/save_button.dart';
import '../../../../widgets/spacers.dart';

class AddNewBlacklist extends StatefulWidget {
  const AddNewBlacklist({super.key, required this.onAdd});
  final Function(String) onAdd;

  @override
  State<AddNewBlacklist> createState() => _AddNewBlacklistState();
}

class _AddNewBlacklistState extends State<AddNewBlacklist> {
  late TextEditingController _ip;
  final _ipAddressRegex = RegExp(r'^([0-9]{1,3}\.){3}[0-9]{1,3}$');
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _ip = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _ip.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Column(
      children: [
        Text(
          "New IP",
          style: Theme.of(context)
              .textTheme
              .headlineSmall!
              .copyWith(color: Colors.white),
        ),
        Form(
          key: _formKey,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomTextFormField(
                size: size,
                width: 0.20,
                textEditingController: _ip,
                hint: 'xxx.xxx.xxx.xxx',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Mandatory Field';
                  } else if (!_ipAddressRegex.hasMatch(value)) {
                    return "Make sure to input proper IP address";
                  }
                  return null;
                },
              ),
              const HSpacer20(),
              SaveButton(
                onTap: () {
                  setState(() {
                    if (_formKey.currentState!.validate()) {
                      widget.onAdd(_ip.value.text);
                      _ip.text = '';
                    }
                  });
                },
              )
            ],
          ),
        ),
      ],
    );
  }
}
