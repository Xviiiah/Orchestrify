import 'package:flutter/material.dart';
import 'package:forti_grad/models/policy_info.dart';
import 'package:forti_grad/widgets/input/delete_button.dart';
import 'package:forti_grad/widgets/input/save_button.dart';
import 'package:forti_grad/widgets/spacers.dart';
import '../../../../widgets/input/custom_drop_down_menu.dart';
import '../../../../widgets/input/custom_text_form_field.dart';

class CreateNewPolicy extends StatefulWidget {
  const CreateNewPolicy({
    super.key,
    this.originalPolicyName,
    this.originalIp,
    this.originalServerPool,
    this.originalHttpServices,
    this.originalHttpsServices,
    this.originalVServer,
    this.originalWebProtectionProfile,
    required this.onAction,
    this.onDelete,
    required this.add,
  });
  final bool add;
  final Function(PolicyInfo) onAction;
  final Function(PolicyInfo)? onDelete;
  final String? originalServerPool;
  final String? originalPolicyName;
  final String? originalIp;
  final String? originalHttpServices;
  final String? originalHttpsServices;
  final String? originalVServer;
  final String? originalWebProtectionProfile;
  @override
  State<CreateNewPolicy> createState() => _CreateNewPolicyState();
}

class _CreateNewPolicyState extends State<CreateNewPolicy> {
  late TextEditingController _policyNameController;
  late TextEditingController _ipController;
  late String httpService;
  late String httpsService;
  late String serverPool;
  late String wepProtectionProfile;
  late String vServer;

  final _ipAddressRegex = RegExp(r'^([0-9]{1,3}\.){3}[0-9]{1,3}$');
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _policyNameController =
        TextEditingController(text: widget.originalPolicyName);
    _ipController = TextEditingController(text: widget.originalIp);
    httpService = widget.originalHttpServices ?? 'HTTP';
    httpsService = widget.originalHttpsServices ?? 'HTTP';
    serverPool = widget.originalServerPool ?? 'Enable Single Server';
    wepProtectionProfile =
        widget.originalWebProtectionProfile ?? 'Inline Standard Protection';
    vServer = widget.originalVServer ?? 'Port 1';

    super.initState();
  }

  @override
  void dispose() {
    _policyNameController.dispose();
    _ipController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          widget.originalPolicyName == null
              ? "New Policy"
              : "Modify Policy (${widget.originalPolicyName})",
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
                enabled: widget.add,
                textEditingController: _policyNameController,
                validator: (String? value) {
                  if (value == null ||
                      value.isEmpty ||
                      _policyNameController.value.text.isEmpty) {
                    return "This Field is Mandatory";
                  } else if (_ipAddressRegex.hasMatch(value)) {
                    return "Please Enter Valid Policy Name";
                  }
                  return null;
                },
                label: "Policy name",
                size: size,
                width: 0.2,
              ),
              const HSpacer20(),
              CustomTextFormField(
                textEditingController: _ipController,
                label: "IP address",
                size: size,
                width: 0.2,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Mandatory Field';
                  } else if (!_ipAddressRegex.hasMatch(value)) {
                    return "Make sure to input proper IP address";
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
        const VSpacer20(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomDropDownMenu(
              size: size,
              onChange: (val) {
                httpService = val;
              },
              label: "HTTP Services",
              originalValue: widget.originalHttpServices,
              menuItems: const ['HTTP', 'HTTPS'],
            ),
            const HSpacer20(),
            CustomDropDownMenu(
              size: size,
              originalValue: widget.originalHttpsServices,
              onChange: (val) {
                httpsService = val;
              },
              label: "HTTPs Services",
              menuItems: const ['HTTP', 'HTTPS'],
            ),
          ],
        ),
        const VSpacer20(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomDropDownMenu(
              size: size,
              onChange: (val) {
                serverPool = val;
              },
              originalValue: widget.originalServerPool,
              label: "Server Pool",
              menuItems: const [
                'Enable Single Server',
                'Disable Single Server',
                'Enable Server Balance',
                'Disable Server Balance',
              ],
            ),
            const HSpacer20(),
            CustomDropDownMenu(
              size: size,
              onChange: (val) {
                wepProtectionProfile = val;
              },
              label: "Web Protection Profile",
              originalValue: widget.originalWebProtectionProfile,
              menuItems: const [
                'Inline Standard Protection',
                'Inline Extended Protection'
              ],
            ),
          ],
        ),
        const VSpacer20(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomDropDownMenu(
              size: size,
              onChange: (val) {
                vServer = val;
              },
              originalValue: widget.originalVServer,
              label: "Virtual Server",
              menuItems: const [
                'Port 1',
                'Port 2',
                'Port 3',
                'Port 4',
              ],
            ),
            const HSpacer20(),
            SizedBox(
              width: size.width * 0.2,
            )
          ],
        ),
        const VSpacer20(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SaveButton(onTap: () {
              setState(() {
                if (_formKey.currentState!.validate()) {
                  widget.onAction(policyInfoCollector());
                  if (widget.add) {
                    _ipController.text = '';
                    _policyNameController.text = '';
                  }
                }
              });
            }),
            widget.originalIp != null ? const HSpacer10() : const SizedBox(),
            widget.originalIp != null
                ? DeleteButton(
                    onTap: () {
                      widget.onDelete!(policyInfoCollector());
                    },
                  )
                : const SizedBox(),
          ],
        )
      ],
    );
  }

  PolicyInfo policyInfoCollector() {
    return PolicyInfo(
      httpService: httpService,
      httpsService: httpsService,
      name: _policyNameController.value.text,
      ip: _ipController.value.text,
      serverPool: serverPool,
      vServer: vServer,
      webProtectionProfile: wepProtectionProfile,
    );
  }
}
