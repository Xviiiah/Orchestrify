class PolicyInfo {
  String httpService;
  String httpsService;
  String name;
  String ip;
  String serverPool;
  String vServer;
  String webProtectionProfile;

  PolicyInfo({
    required this.httpService,
    required this.httpsService,
    required this.name,
    required this.ip,
    required this.serverPool,
    required this.vServer,
    required this.webProtectionProfile,
  });

  Map<String, String> toMap() => {
        "https-service": httpsService,
        "name": name,
        "real-ip-addr": ip,
        "server-pool": serverPool,
        "service": httpService,
        "vserver": vServer,
        "web-protection-profile": webProtectionProfile,
      };

  static PolicyInfo toObject(Map<String, dynamic> data) => PolicyInfo(
        httpService: data['service'],
        httpsService: data['https-service'],
        name: data['name'],
        ip: data['real-ip-addr'],
        serverPool: data['server-pool'],
        vServer: data['vserver'],
        webProtectionProfile: data['web-protection-profile'],
      );
}
