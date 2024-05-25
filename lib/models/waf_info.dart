class WafInfo {
  String ip;
  String wpp;

  WafInfo({required this.ip, required this.wpp});

  Map<String, String> toMap() => {
        'real-ip-addr': ip,
        'web-protection-profile': wpp,
      };

  static WafInfo toObject(Map<String, dynamic> data) {
    return WafInfo(
        ip: data['real-ip-addr'], wpp: data['web-protection-profile']);
  }
}
