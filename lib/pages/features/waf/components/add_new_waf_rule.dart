import 'package:flutter/material.dart';
import 'package:forti_grad/models/waf_info.dart';
import 'package:forti_grad/pages/features/waf/components/toggle/toggle_set.dart';

import '../../../../widgets/input/custom_text_form_field.dart';
import '../../../../widgets/input/save_button.dart';
import '../../../../widgets/spacers.dart';

class AddNewWAFRule extends StatefulWidget {
  const AddNewWAFRule({super.key, required this.onSave});
  final Function(WafInfo) onSave;

  @override
  State<AddNewWAFRule> createState() => _AddNewWAFRuleState();
}

class _AddNewWAFRuleState extends State<AddNewWAFRule> {
  late TextEditingController _ip;
  final _ipAddressRegex = RegExp(r'^([0-9]{1,3}\.){3}[0-9]{1,3}$');
  final _formKey = GlobalKey<FormState>();
  late bool isEnabled;
  @override
  void initState() {
    _ip = TextEditingController();
    isEnabled = true;
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
        const VSpacer20(),
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
              const HSpacer10(),
              ToggleSet(
                isEnabled: true,
                enabled: (val) {
                  isEnabled = val;
                },
              ),
              const HSpacer20(),
              SaveButton(
                onTap: () {
                  setState(() {
                    if (_formKey.currentState!.validate()) {
                      widget.onSave(WafInfo(
                          ip: _ip.value.text,
                          wpp: isEnabled ? 'enabled' : 'none'));
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
