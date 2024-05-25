import 'package:flutter/material.dart';
import 'package:forti_grad/APIs/forti_web/forti_api.dart';
import 'package:forti_grad/widgets/feature_template.dart';
import 'package:forti_grad/widgets/spacers.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../../../constants.dart';
import '../../../models/waf_info.dart';
import 'components/add_new_waf_rule.dart';
import 'components/modify_waf_rule.dart';

class WafPage extends StatefulWidget {
  const WafPage({super.key});

  @override
  State<WafPage> createState() => _WafPageState();
}

class _WafPageState extends State<WafPage> {
  late Future<List<WafInfo>> wafList;
  late bool _inAsyncCall;
  @override
  void initState() {
    wafList = FortiAPI.fetchWaf();
    _inAsyncCall = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: _inAsyncCall,
      blur: 2,
      child: FeatureTemplate(
        title: "WAF",
        child: Column(
          children: [
            AddNewWAFRule(
              onSave: (WafInfo wafInfo) async {
                setState(() {
                  _inAsyncCall = true;
                });
                await FortiAPI.addWaf(wafInfo: wafInfo).then((value) async {
                  wafList = FortiAPI.fetchWaf().then((value) {
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
            const VSpacer100(),
            const SizedBox(
              width: 768,
              child: Divider(
                height: 2,
                color: Colors.white,
              ),
            ),
            ModifyWAFRule(
              wafList: wafList,
              onSave: (WafInfo wafInfo) async {
                setState(() {
                  _inAsyncCall = true;
                });
                await FortiAPI.updateWaf(wafInfo: wafInfo).then((value) async {
                  wafList = FortiAPI.fetchWaf().then((value) {
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
