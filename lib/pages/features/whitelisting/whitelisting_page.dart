import 'package:flutter/material.dart';
import 'package:forti_grad/APIs/forti_web/forti_api.dart';
import 'package:forti_grad/constants.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../../models/ip_info.dart';
import '../../../widgets/feature_template.dart';
import '../../../widgets/spacers.dart';
import 'components/add_new_whitelist.dart';
import 'components/delete_whitelist_ip.dart';

class WhitelistingPage extends StatefulWidget {
  const WhitelistingPage({super.key});

  @override
  State<WhitelistingPage> createState() => _WhitelistingPageState();
}

class _WhitelistingPageState extends State<WhitelistingPage> {
  late Future<List<IPInfo>> _whitelist;
  late bool _inAsyncCall = false;
  @override
  void initState() {
    _whitelist = FortiAPI.fetchWhitelist();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: _inAsyncCall,
      color: Colors.white,
      blur: 2,
      child: FeatureTemplate(
        title: "Whitelisting",
        child: Column(
          children: [
            AddNewWhitelist(onAdd: (String ip) async {
              setState(() {
                _inAsyncCall = true;
              });
              await FortiAPI.addWhitelist(ip: ip).then((value) async {
                _whitelist = FortiAPI.fetchWhitelist().then((value) {
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
            }),
            const VSpacer100(),
            const SizedBox(
              width: 768,
              child: Divider(
                height: 2,
                color: Colors.white,
              ),
            ),
            DeleteExistingWhitelist(
              ips: _whitelist,
              onDelete: (String id) async {
                setState(() {
                  _inAsyncCall = true;
                });
                await FortiAPI.deleteWhitelist(id: id).then((value) async {
                  _whitelist = FortiAPI.fetchWhitelist().then((value) {
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
