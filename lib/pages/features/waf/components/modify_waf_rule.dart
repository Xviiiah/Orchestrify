import 'package:flutter/material.dart';
import 'package:forti_grad/pages/features/waf/components/toggle/toggle_set.dart';
import 'package:forti_grad/widgets/input/save_button.dart';

import '../../../../models/waf_info.dart';
import '../../../../widgets/spacers.dart';

class ModifyWAFRule extends StatefulWidget {
  const ModifyWAFRule({super.key, required this.wafList, required this.onSave});
  final Future<List<WafInfo>> wafList;
  final Function(WafInfo) onSave;
  @override
  State<ModifyWAFRule> createState() => _ModifyWAFRuleState();
}

class _ModifyWAFRuleState extends State<ModifyWAFRule> {
  late bool isEnabled;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const VSpacer20(),
        Text(
          "Modify Existing IP",
          style: Theme.of(context)
              .textTheme
              .headlineSmall!
              .copyWith(color: Colors.white),
        ),
        const VSpacer20(),
        FutureBuilder(
          future: widget.wafList,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<WafInfo>? data = snapshot.data;
              return SizedBox(
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                  itemCount: data!.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      color: const Color(0xff2b2b2b),
                      padding: const EdgeInsets.all(10),
                      child: ListTile(
                        hoverColor: Colors.white60,
                        onTap: () {},
                        leading: Text(
                          (index + 1).toString(),
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white),
                        ),
                        title: Text(
                          data[index].ip,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white),
                        ),
                        trailing: SizedBox(
                          width: 500,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ToggleSet(
                                  isEnabled:
                                      data[index].wpp.isEmpty ? false : true,
                                  enabled: (value) {
                                    isEnabled = value;
                                  }),
                              SaveButton(onTap: () {
                                widget.onSave(WafInfo(
                                  ip: data[index].ip,
                                  wpp: isEnabled ? "enabled" : "none",
                                ));
                              }),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  shrinkWrap: true,
                  primary: false,
                ),
              );
            } else if (snapshot.hasError) {
              return const Center(
                child: Text("Error"),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ],
    );
  }
}
