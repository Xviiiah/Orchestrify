import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:forti_grad/pages/features/blacklisting/blacklisting_page.dart';
import 'package:forti_grad/pages/features/waf/waf_page.dart';
import 'package:forti_grad/pages/features/whitelisting/whitelisting_page.dart';
import 'package:forti_grad/widgets/feature_template.dart';
import '../features/policy/policy_page.dart';
import 'components/custom_home_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return const FeatureTemplate(
      background: true,
      title: "Dashboard",
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        runSpacing: 24,
        spacing: 24,
        children: [
          CustomHomeCard(
            text: "WAF",
            destination: WafPage(),
          ),
          CustomHomeCard(
            text: "Policies",
            destination: PolicyPage(),
          ),
          CustomHomeCard(
            text: "Whitelist",
            destination: WhitelistingPage(),
          ),
          CustomHomeCard(
            text: "Blacklist",
            destination: BlacklistingPage(),
          ),
        ],
      ),
    );
  }
}
