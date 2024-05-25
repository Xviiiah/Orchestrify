import 'package:flutter/material.dart';
import 'package:forti_grad/constants.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../../APIs/forti_web/forti_api.dart';
import '../../../models/ip_info.dart';
import '../../../widgets/feature_template.dart';

import '../../../widgets/spacers.dart';
import 'components/add_new_blacklist.dart';
import 'components/delete_blacklist_ip.dart';

class BlacklistingPage extends StatefulWidget {
  const BlacklistingPage({super.key});

  @override
  State<BlacklistingPage> createState() => _BlacklistingPageState();
}

class _BlacklistingPageState extends State<BlacklistingPage> {
  late Future<List<IPInfo>> _blacklist;
  late bool _inAsyncCall = false;

  @override
  void initState() {
    _blacklist = FortiAPI.fetchBlacklist();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: _inAsyncCall,
      child: FeatureTemplate(
        title: "Blacklisting",
        child: Column(
          children: [
            AddNewBlacklist(onAdd: (String ip) async {
              setState(() {
                _inAsyncCall = true;
              });
              await FortiAPI.addBlacklist(ip: ip).then((value) async {
                _blacklist = FortiAPI.fetchBlacklist().then((value) {
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
            DeleteExistingBlacklist(
              ips: _blacklist,
              onDelete: (String id) async {
                setState(() {
                  _inAsyncCall = true;
                });
                await FortiAPI.deleteBlacklist(id: id).then((value) async {
                  _blacklist = FortiAPI.fetchBlacklist().then((value) {
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
