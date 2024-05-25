class WAF {
  final String _ip;
  final bool _enabled;

  WAF(this._ip, this._enabled);

  Map<String, String> toJson() => {
        'ip': _ip,
        'enabled': _enabled.toString(),
      };

  String get ip => _ip;

  bool get enabled => _enabled;
}
