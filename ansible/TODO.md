```bash
❯ sudo resolvectl dns ens33 127.0.0.1:8600
❯ sudo resolvectl domain ens33 '~consul'
❯ nano /etc/systemd/resolved.conf.d/consul.conf
❯ sudo systemctl restart systemd-resolved
❯ resolvectl status
Global
          Protocols: +LLMNR +mDNS -DNSOverTLS DNSSEC=no/unsupported
   resolv.conf mode: stub
         DNS Servers 1.1.1.1 1.0.0.1 127.0.0.1:8600
Fallback DNS Servers 8.8.8.8 8.8.4.4

Link 2 (ens33)
Current Scopes: DNS LLMNR/IPv4
     Protocols: -DefaultRoute +LLMNR -mDNS -DNSOverTLS DNSSEC=no/unsupported
   DNS Servers: 127.0.0.1:8600
    DNS Domain: ~consul
❯ dig consul-1.node.consul

; <<>> DiG 9.18.28-1~deb12u2-Debian <<>> consul-1.node.consul
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NXDOMAIN, id: 24291
;; flags: qr rd ra; QUERY: 1, ANSWER: 0, AUTHORITY: 1, ADDITIONAL: 1

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 65494
;; QUESTION SECTION:
;consul-1.node.consul.          IN      A

;; AUTHORITY SECTION:
consul.                 0       IN      SOA     ns.consul. hostmaster.consul. 1732209246 3600 600 86400 0

;; Query time: 0 msec
;; SERVER: 127.0.0.53#53(127.0.0.53) (UDP)
;; WHEN: Thu Nov 21 18:14:06 CET 2024
;; MSG SIZE  rcvd: 99

❯ dig @127.0.0.1 -p 8600 consul-1.node.consul

; <<>> DiG 9.18.28-1~deb12u2-Debian <<>> @127.0.0.1 -p 8600 consul-1.node.consul
; (1 server found)
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NXDOMAIN, id: 39749
;; flags: qr aa rd; QUERY: 1, ANSWER: 0, AUTHORITY: 1, ADDITIONAL: 1
;; WARNING: recursion requested but not available

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 1232
;; QUESTION SECTION:
;consul-1.node.consul.          IN      A

;; AUTHORITY SECTION:
consul.                 0       IN      SOA     ns.consul. hostmaster.consul. 1732209252 3600 600 86400 0

;; Query time: 0 msec
;; SERVER: 127.0.0.1#8600(127.0.0.1) (UDP)
;; WHEN: Thu Nov 21 18:14:12 CET 2024
;; MSG SIZE  rcvd: 99
```