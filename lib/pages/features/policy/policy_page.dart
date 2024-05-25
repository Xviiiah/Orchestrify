import 'package:flutter/material.dart';
import 'package:forti_grad/APIs/forti_web/forti_api.dart';
import 'package:forti_grad/widgets/feature_template.dart';
import 'package:forti_grad/widgets/spacers.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../../../constants.dart';
import '../../../models/policy_info.dart';
import 'components/create_new_policy.dart';
import 'components/modify_policy.dart';

class PolicyPage extends StatefulWidget {
  const PolicyPage({super.key});

  @override
  State<PolicyPage> createState() => _PolicyPageState();
}

class _PolicyPageState extends State<PolicyPage> {
  late Future<List<PolicyInfo>> _policies;
  late bool _inAsyncCall;
  @override
  void initState() {
    _policies = FortiAPI.fetchPolicy();
    _inAsyncCall = false;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: _inAsyncCall,
      blur: 2,
      child: FeatureTemplate(
        title: "Policy",
        child: Column(
          children: [
            CreateNewPolicy(
              add: true,
              onAction: (PolicyInfo policyInfo) async {
                setState(() {
                  _inAsyncCall = true;
                });
                await FortiAPI.addPolicy(policyInfo: policyInfo)
                    .then((value) async {
                  _policies = FortiAPI.fetchPolicy().then((value) {
                    setState(() {
                      _inAsyncCall = false;
                    });
                    return value;
                  });
                }).onError((error, stackTrace) {});
              },
            ),
            const VSpacer100(),
            const SizedBox(
              width: 768,
              child: Divider(
                height: 2,
                color: Colors.white,
              ),
            ),
            ModifyPolicy(
              policies: _policies,
              onAction: (PolicyInfo policyInfo) async {
                setState(() {
                  _inAsyncCall = true;
                });
                await FortiAPI.updatePolicy(policyInfo: policyInfo)
                    .then((value) async {
                  _policies = FortiAPI.fetchPolicy().then((value) {
                    setState(() {
                      _inAsyncCall = false;
                    });
                    return value;
                  });
                }).onError((error, stackTrace) {
                  setState(() {
                    _inAsyncCall = false;
                  });
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                });
              },
              onDelete: (PolicyInfo policyInfo) async {
                setState(() {
                  _inAsyncCall = true;
                });
                await FortiAPI.deletePolicy(policyInfo: policyInfo)
                    .then((value) async {
                  _policies = FortiAPI.fetchPolicy().then((value) {
                    setState(() {
                      _inAsyncCall = false;
                    });
                    return value;
                  });
                }).onError((error, stackTrace) {
                  setState(() {
                    _inAsyncCall = false;
                  });
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
