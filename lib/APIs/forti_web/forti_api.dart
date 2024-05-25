import 'package:forti_grad/models/ip_info.dart';
import 'package:forti_grad/models/policy_info.dart';
import 'package:forti_grad/models/waf_info.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:http/http.dart';

class FortiAPI {
  static const String _serverIP =
      'https://orchestrifybackend-production.up.railway.app';

  /// WL
  static Future<List<IPInfo>> fetchWhitelist() async {
    String getIpListPolicyMember = '/wl';
    var response = await http.get(Uri.parse(_serverIP + getIpListPolicyMember));

    if (response.statusCode == 200) {
      // Successful request
      List<dynamic> decodedData = convert.jsonDecode(response.body);
      return decodedData
          .map((e) => IPInfo(ip: e['ip'] as String, id: e['id'] as String))
          .toList();
    } else {
      throw Exception('Failed to load data');
    }
  }

  static Future<void> deleteWhitelist({required String id}) async {
    String getIpListPolicyMember = '/wl/d/$id';
    var response = await http.get(Uri.parse(_serverIP + getIpListPolicyMember));

    if (response.statusCode != 200) {
      throw Exception('Failed delete data');
    }
  }

  static Future<void> addWhitelist({required String ip}) async {
    String getIpListPolicyMember = '/wl/a/$ip';
    var response = await http.get(Uri.parse(_serverIP + getIpListPolicyMember));

    if (response.statusCode != 200) {
      throw Exception('Failed add data');
    }
  }

  ///BL
  static Future<List<IPInfo>> fetchBlacklist() async {
    String getIpListPolicyMember = '/bl';
    var response = await http.get(Uri.parse(_serverIP + getIpListPolicyMember));

    if (response.statusCode == 200) {
      // Successful request
      List<dynamic> decodedData = convert.jsonDecode(response.body);
      return decodedData
          .map((e) => IPInfo(ip: e['ip'] as String, id: e['id'] as String))
          .toList();
    } else {
      throw Exception('Failed to load data');
    }
  }

  static Future<void> deleteBlacklist({required String id}) async {
    String getIpListPolicyMember = '/bl/d/$id';
    var response = await http.get(Uri.parse(_serverIP + getIpListPolicyMember));

    if (response.statusCode != 200) {
      throw Exception('Failed delete data');
    }
  }

  static Future<void> addBlacklist({required String ip}) async {
    String getIpListPolicyMember = '/bl/a/$ip';
    var response = await http.get(Uri.parse(_serverIP + getIpListPolicyMember));

    if (response.statusCode != 200) {
      throw Exception('Failed add data');
    }
  }

  ///POL
  static Future<void> addPolicy({required PolicyInfo policyInfo}) async {
    String getIpListPolicyMember = '/pol/a';
    Response response = await http.post(
        Uri.parse(_serverIP + getIpListPolicyMember),
        body: convert.jsonEncode(policyInfo.toMap()),
        headers: {"Content-Type": "application/json"});

    if (response.statusCode != 200) {
      throw Exception('Failed add data');
    }
  }

  static Future<List<PolicyInfo>> fetchPolicy() async {
    String getIpListPolicyMember = '/pol';
    var response = await http.get(Uri.parse(_serverIP + getIpListPolicyMember));
    if (response.statusCode == 200) {
      List<dynamic> decodedData = convert.jsonDecode(response.body);

      var data = decodedData.map((e) => PolicyInfo.toObject(e)).toList();

      return data;
    } else {
      throw Exception('Failed add data');
    }
  }

  static Future<void> updatePolicy({required PolicyInfo policyInfo}) async {
    String getIpListPolicyMember = '/pol/u';
    Response response = await http.post(
        Uri.parse(_serverIP + getIpListPolicyMember),
        body: convert.jsonEncode(policyInfo.toMap()),
        headers: {"Content-Type": "application/json"});

    if (response.statusCode != 200) {
      throw Exception('Failed add data');
    }
  }

  static Future<void> deletePolicy({required PolicyInfo policyInfo}) async {
    String getIpListPolicyMember = '/pol/d';
    Response response = await http.post(
        Uri.parse(_serverIP + getIpListPolicyMember),
        body: convert.jsonEncode(policyInfo.toMap()),
        headers: {"Content-Type": "application/json"});

    if (response.statusCode != 200) {
      throw Exception('Failed add data');
    }
  }

  ///WAF
  static Future<void> addWaf({required WafInfo wafInfo}) async {
    String getIpListPolicyMember = '/waf/a';
    Response response = await http.post(
        Uri.parse(_serverIP + getIpListPolicyMember),
        body: convert.jsonEncode(wafInfo.toMap()),
        headers: {"Content-Type": "application/json"});

    if (response.statusCode != 200) {
      throw Exception('Failed add data');
    }
  }

  static Future<List<WafInfo>> fetchWaf() async {
    String getIpListPolicyMember = '/waf';
    var response = await http.get(Uri.parse(_serverIP + getIpListPolicyMember));
    if (response.statusCode == 200) {
      List<dynamic> decodedData = convert.jsonDecode(response.body);

      var data = decodedData.map((e) => WafInfo.toObject(e)).toList();
      return data;
    } else {
      throw Exception('Failed add data');
    }
  }

  static Future<void> updateWaf({required WafInfo wafInfo}) async {
    String getIpListPolicyMember = '/waf/u';
    Response response = await http.post(
        Uri.parse(_serverIP + getIpListPolicyMember),
        body: convert.jsonEncode(wafInfo.toMap()),
        headers: {"Content-Type": "application/json"});

    if (response.statusCode != 200) {
      throw Exception('Failed add data');
    }
  }

  static Future<void> deleteWaf({required WafInfo wafInfo}) async {
    String getIpListPolicyMember = '/waf/d';
    Response response = await http.post(
        Uri.parse(_serverIP + getIpListPolicyMember),
        body: convert.jsonEncode(wafInfo.toMap()),
        headers: {"Content-Type": "application/json"});

    if (response.statusCode != 200) {
      throw Exception('Failed add data');
    }
  }
}
