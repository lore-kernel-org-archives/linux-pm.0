From: EunTaik Lee <eun.taik.lee@samsung.com>
Subject: Re: Re: [RFC PATCH] suspend/resume performance improvement
Date: Wed, 27 May 2015 10:38:10 +0000 (GMT)
Message-ID: <2002354124.810441432723088778.JavaMail.weblogic@epmlwas01d>
Reply-To: eun.taik.lee@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset=euc-kr
Content-Transfer-Encoding: base64
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:15409 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750854AbbE0KiM (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 27 May 2015 06:38:12 -0400
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTP id <0NP000HJW87M8V50@mailout2.samsung.com> for
 linux-pm@vger.kernel.org; Wed, 27 May 2015 19:38:10 +0900 (KST)
MIME-version: 1.0
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "len.brown@intel.com" <len.brown@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

DQpPbiBUdWUgMjAxNS0wNS0yNyAxNjo1MCAoR01UKzA5OjAwKSwgUGF2ZWwgTWFjaGVrIHdyb3Rl
Og0KDQo+PiBTbywgaW5zdGVhZCBvZiBkZXBlbmRpbmcgb24gYSB1c2Vyc3BhY2UgdGFzaydzIHRp
bWUNCj4+IHNsaWNlLCBsZXQga3dvcmtlciBkbyB0aGUgd29yayB0byBhdm9pZCBhIGxvbmcgd2Fp
dA0KPj4gb24gdGhlIHJ1bnF1ZXVlLg0KPg0KPi4uLnNvIGlmIHlvdSByZWFsbHkgd2FudCBoaWdo
IHByaW9yaXR5IGZvciB0aGF0IG9wZXJhdGlvbiwganVzdCByZW5pY2UNCj55b3Vyc2VsZiB0byBo
aWdoZXIgcHJpb3JpdHkgb3Igc29tZXRoaW5nLi4uDQoNClRoZSBwcm9ibGVtIG9jY3VyZWQgb24g
QW5kcm9pZCBMIHZlcnNpb24uIEtLIGhhZCBhdXRvc3VzcGVuZCBlbmFibGVkDQpidXQgaXQgd2Fz
IGRpc2FibGVkIGluIEwgdG8gYWxsb3cgdXNlcnNwYWNlIHRvIGNvbGxlY3Qgc3RhdHMuDQoNClRo
ZSBkZWxheSB3YXMgaW5zaWRlIHRyeV90b19mcmVlemVfdGFza3MgZnVuY3Rpb24gKGF0IHN5c3Rl
bV9zZXJ2ZXIgdGhyZWFkIG9mIHN5c3RlbV9zZXJ2ZXIgcHJvY2VzcykuDQpzeXN0ZW1fc2VydmVy
IGdvdCBwcmVlbXB0ZWQgYWZ0ZXIgdW5sb2NraW5nIHRoZSB0YXNrbGlzdF9sb2NrLg0KIDQ2ICAg
ICAgICAgd2hpbGUgKHRydWUpIHsNCiA0NyAgICAgICAgICAgICAgICAgdG9kbyA9IDA7DQogNDgg
ICAgICAgICAgICAgICAgIHJlYWRfbG9jaygmdGFza2xpc3RfbG9jayk7DQogNDkgICAgICAgICAg
ICAgICAgIGZvcl9lYWNoX3Byb2Nlc3NfdGhyZWFkKGcsIHApIHsNCiA1MCAgICAgICAgICAgICAg
ICAgICAgICAgICBpZiAocCA9PSBjdXJyZW50IHx8ICFmcmVlemVfdGFzayhwKSkNCiA1MSAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNvbnRpbnVlOw0KIDUyIA0KIDUzICAgICAgICAg
ICAgICAgICAgICAgICAgIGlmICghZnJlZXplcl9zaG91bGRfc2tpcChwKSkNCiA1NCAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIHRvZG8rKzsNCiA1NSAgICAgICAgICAgICAgICAgfQ0K
IDU2ICAgICAgICAgICAgICAgICByZWFkX3VubG9jaygmdGFza2xpc3RfbG9jayk7DQoNCkFsbCBv
ZiB0aGUgdGhyZWFkcyBvZiBzeXN0ZW1fc2VydmVyIHByb2Nlc3MgdGhhdCB3YXMgb24gdGhlIHJ1
bnF1ZXVlIGRpZCBub3QgcnVuIGR1cmluZyB0aGlzIHBlcmlvZC4NCkZyZWV6aW5nIG9mIHRhc2tz
IHJlc3VtZWQgYWZ0ZXIgb3RoZXIgdGFza3Mgd2VudCBvdXQgb2YgdGhlIHJ1bnF1ZXVlLg0KDQpJ
IGhhdmUgdGVzdGVkIHdpdGggdGhlIGxvd2VzdCBuaWNlIHZhbHVlIGJ1dCB0aGUgcHJvYmxlbSB3
YXMgc3RpbGwsIGFsdGhvdWdoIGxlc3MsIHJlcHJvZHVjaWJsZS4NCg0KQmVzdCBSZWdhcmRzLA0K
RXVudGFpayBMZWU=


