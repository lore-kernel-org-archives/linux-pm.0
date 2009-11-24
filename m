From: wkq5325 <wkq5325@163.com>
Subject: =?gbk?q?The_relationship_between_acpi_and_cpufreq?=
	=?gbk?q?=A3=ACcpuidle=3F?=
Date: Tue, 24 Nov 2009 17:32:05 +0800 (CST)
Message-ID: <24766079.1077741259055125471.JavaMail.coremail@bj163app123.163.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6979460508466702271=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Mime-version: 1.0
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

--===============6979460508466702271==
Content-Type: multipart/alternative;
	boundary="----=_Part_281128_8985524.1259055125471"

------=_Part_281128_8985524.1259055125471
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: base64

SGmjrAoKSSBoYXZlIHJlYWQgc29tZSBwYXBlcnMgYWJvdXQgTGludXgvYWNwaS4gSSB3YW50IHRv
IGFzayAgYSAgcXVlc3Rpb24uCjEgLlRoZSBhY3BpY2EgaXMgYSBwYXJ0IG9mIE9TUE0uIENwdWZy
ZXEgYW5kIGNwdWlkbGUgdXNlcyBzb21lIGludGVyZmFjZSBpbiBBQ1BJIHByb2Nlc3NvciBkcml2
ZXJzLiAKMi4gSW4gQUNQSSBzcGVjaWZpY2F0aW9ucyA0LjAgo6xzb21ldGhpbmcgbGlrZSBPU1BN
IHN5c3RlbSBjb2RlLiBBbHRob3VnaCBpdCBpcyBhIGFic3RyYWN0IGRlc2NyaXB0aW9uLAogICBP
U1BNIHN5c3RlbSBjb2RlIG1lYW5zIHNvbWV0aGluZyBrZXJuZWwgbW9kdWxlcyBsaWtlIGNwdWZy
ZXEgYW5kIGNwdWlkbGWjv0J1dCB0aGV5IGFyZSBpbiBrZXJuZWwsIHdoeQogICBkb2VzIGl0IG1h
a2UgYSBkaWZmZXJlbmNlIGJldHdlZW4ga2VybmVsIGFuZCBPU1BNIHN5c3RlbSBjb2RlPwozLiBB
Y3BpY2EgaXMgaW5kZXBlbmRlbnQgb2YgTGludXgvYWNwaaOsIHRoZXkgYXJlIGdsdWVkIHdpdGgg
dGhlIE9TTCBsYXllci4gU28gdGhlIExpbnV4L2FjcGkgaXMgbWFpbmx5IAogICBhYm91dCBkZXZp
Y2UgZHJpdmVycz8gCgogVGhhbmsgeW91IGZvciB5b3VyIGFwcHJlY2lhdGlvbiEKCgoKCjA5xOrQ
wr36M0TW98H3zfjTzqG2zOzPwrehobejrM340tfB+cTq0trXyrTy1Ow=
------=_Part_281128_8985524.1259055125471
Content-Type: text/html; charset=gbk
Content-Transfer-Encoding: base64

SGmjrDxicj48ZGl2PkkgaGF2ZSByZWFkIHNvbWUgcGFwZXJzIGFib3V0IExpbnV4L2FjcGkuIEkg
d2FudCB0byBhc2smbmJzcDsgYSZuYnNwOyBxdWVzdGlvbi48YnI+MSAuVGhlIGFjcGljYSBpcyBh
IHBhcnQgb2YgT1NQTS4gQ3B1ZnJlcSBhbmQgY3B1aWRsZSB1c2VzIHNvbWUgaW50ZXJmYWNlIGlu
IEFDUEkgcHJvY2Vzc29yIGRyaXZlcnMuIDxicj4yLiBJbiBBQ1BJIHNwZWNpZmljYXRpb25zIDQu
MCCjrHNvbWV0aGluZyBsaWtlIE9TUE0gc3lzdGVtIGNvZGUuIEFsdGhvdWdoIGl0IGlzIGEgYWJz
dHJhY3QgZGVzY3JpcHRpb24sPGJyPiZuYnNwOyZuYnNwOyBPU1BNIHN5c3RlbSBjb2RlIG1lYW5z
IHNvbWV0aGluZyBrZXJuZWwgbW9kdWxlcyBsaWtlIGNwdWZyZXEgYW5kIGNwdWlkbGWjv0J1dCB0
aGV5IGFyZSBpbiBrZXJuZWwsIHdoeTxicj4mbmJzcDsmbmJzcDsgZG9lcyBpdCBtYWtlIGEgZGlm
ZmVyZW5jZSBiZXR3ZWVuIGtlcm5lbCBhbmQgT1NQTSBzeXN0ZW0gY29kZT88YnI+My4gQWNwaWNh
IGlzIGluZGVwZW5kZW50IG9mIExpbnV4L2FjcGmjrCB0aGV5IGFyZSBnbHVlZCB3aXRoIHRoZSBP
U0wgbGF5ZXIuIFNvIHRoZSBMaW51eC9hY3BpIGlzIG1haW5seSA8YnI+Jm5ic3A7Jm5ic3A7IGFi
b3V0IGRldmljZSBkcml2ZXJzPyA8YnI+PGJyPiZuYnNwO1RoYW5rIHlvdSBmb3IgeW91ciBhcHBy
ZWNpYXRpb24hPGJyPiA8L2Rpdj48YnI+PGJyPjxzcGFuIHRpdGxlPSJuZXRlYXNlZm9vdGVyIj48
aHI+CjxhIGhyZWY9Imh0dHA6Ly9hbGx5ZXMubmllLjE2My5jb20vbWFpbi9hZGZjbGljaz9kYj1h
ZmFuaWUmYW1wO2JpZD0xMjU0LDYxMSwyMyZhbXA7Y2lkPTE0NSw0LDEmYW1wO3NpZD0xMzUxJmFt
cDtzaG93PWlnbm9yZSZhbXA7dXJsPWh0dHA6Ly90eDIuMTYzLmNvbS9mYWIuaHRtbCI+MDnE6tDC
vfozRNb3wffN+NPOobbM7M/Ct6Ght6OszfjS18H5xOrS2tfKtPLU7DwvYT4KPC9zcGFuPjxicj48
YnI+PHNwYW4gdGl0bGU9Im5ldGVhc2Vmb290ZXIiLz48aHIvPgo8YSBocmVmPSJodHRwOi8vYWxs
eWVzLm5pZS4xNjMuY29tL21haW4vYWRmY2xpY2s/ZGI9YWZhbmllJmJpZD0xMjU0LDYxMSwyMyZj
aWQ9MTQ1LDQsMSZzaWQ9MTM1MSZzaG93PWlnbm9yZSZ1cmw9aHR0cDovL3R4Mi4xNjMuY29tL2Zh
Yi5odG1sIj4wOcTq0MK9+jNE1vfB9834086htszsz8K3oaG3o6zN+NLXwfnE6tLa18q08tTsPC9h
Pgo8L3NwYW4+
------=_Part_281128_8985524.1259055125471--


--===============6979460508466702271==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6979460508466702271==--
