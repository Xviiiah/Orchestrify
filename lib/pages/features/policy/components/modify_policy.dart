import 'package:flutter/material.dart';
import 'package:forti_grad/models/policy_info.dart';
import 'package:forti_grad/pages/features/policy/components/create_new_policy.dart';
import 'package:forti_grad/widgets/spacers.dart';

class ModifyPolicy extends StatefulWidget {
  const ModifyPolicy(
      {super.key,
      required this.onAction,
      required this.onDelete,
      this.policies});
  final Function(PolicyInfo) onAction;
  final Function(PolicyInfo) onDelete;
  final Future<List<PolicyInfo>>? policies;

  @override
  State<ModifyPolicy> createState() => _ModifyPolicyState();
}

class _ModifyPolicyState extends State<ModifyPolicy> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const VSpacer20(),
        Text(
          "Modify Existing Policy",
          style: Theme.of(context)
              .textTheme
              .headlineSmall!
              .copyWith(color: Colors.white),
        ),
        const VSpacer20(),
        FutureBuilder(
            future: widget.policies,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<PolicyInfo> policies = snapshot.data as List<PolicyInfo>;
                return SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                    itemCount: policies.length,
                    itemBuilder: (context, index) {
                      return Container(
                        color: const Color(0xff2b2b2b),
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.only(bottom: 10),
                        child: ExpansionTile(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                policies[index].name,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white),
                              ),
                              Text(
                                policies[index].ip,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white),
                              )
                            ],
                          ),
                          children: [
                            modifyPolicy(policies[index]),
                            const VSpacer20()
                          ],
                        ),
                      );
                    },
                    shrinkWrap: true,
                    primary: false,
                  ),
                );
              } else if (snapshot.hasError) {
                return const Center(child: Text("Error"));
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }),
      ],
    );
  }

  CreateNewPolicy modifyPolicy(PolicyInfo policyInfo) {
    return CreateNewPolicy(
      add: false,
      originalHttpServices: policyInfo.httpService,
      originalHttpsServices: policyInfo.httpsService,
      originalServerPool: policyInfo.serverPool,
      originalVServer: policyInfo.vServer,
      originalIp: policyInfo.ip,
      originalPolicyName: policyInfo.name,
      originalWebProtectionProfile: policyInfo.webProtectionProfile,
      onAction: widget.onAction,
      onDelete: widget.onDelete,
    );
  }
}
