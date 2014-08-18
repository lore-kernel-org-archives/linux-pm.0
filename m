From: "Liu, Chuansheng" <chuansheng.liu@intel.com>
Subject: RE: [PATCH 2/3] smp: re-implement the kick_all_cpus_sync() with
 wake_up_if_idle()
Date: Mon, 18 Aug 2014 00:12:39 +0000
Message-ID: <27240C0AC20F114CBF8149A2696CBE4A01E5D3FB@SHSMSX101.ccr.corp.intel.com>
References: <1408086085-16691-1-git-send-email-chuansheng.liu@intel.com>
 <1408086085-16691-2-git-send-email-chuansheng.liu@intel.com>
 <CALCETrUQ7x+kPYewNSUeAX5=0yVmqYWca9XCXtUbM0SNZ2ou+Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:53632 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750725AbaHRAMn (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sun, 17 Aug 2014 20:12:43 -0400
In-Reply-To: <CALCETrUQ7x+kPYewNSUeAX5=0yVmqYWca9XCXtUbM0SNZ2ou+Q@mail.gmail.com>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andy Lutomirski <luto@amacapital.net>
Cc: Peter Zijlstra <peterz@infradead.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Ingo Molnar <mingo@redhat.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Liu, Changcheng" <changcheng.liu@intel.com>, "Wang, Xiaoming" <xiaoming.wang@intel.com>, "Chakravarty, Souvik K" <souvik.k.chakravarty@intel.com>

SGVsbG8gQW5keSwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBbmR5
IEx1dG9taXJza2kgW21haWx0bzpsdXRvQGFtYWNhcGl0YWwubmV0XQ0KPiBTZW50OiBGcmlkYXks
IEF1Z3VzdCAxNSwgMjAxNCAxMTo0MSBQTQ0KPiBUbzogTGl1LCBDaHVhbnNoZW5nDQo+IENjOiBQ
ZXRlciBaaWpsc3RyYTsgRGFuaWVsIExlemNhbm87IFJhZmFlbCBKLiBXeXNvY2tpOyBJbmdvIE1v
bG5hcjsNCj4gbGludXgtcG1Admdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJu
ZWwub3JnOyBMaXUsIENoYW5nY2hlbmc7DQo+IFdhbmcsIFhpYW9taW5nOyBDaGFrcmF2YXJ0eSwg
U291dmlrIEsNCj4gU3ViamVjdDogUmU6IFtQQVRDSCAyLzNdIHNtcDogcmUtaW1wbGVtZW50IHRo
ZSBraWNrX2FsbF9jcHVzX3N5bmMoKSB3aXRoDQo+IHdha2VfdXBfaWZfaWRsZSgpDQo+IA0KPiBP
biBGcmksIEF1ZyAxNSwgMjAxNCBhdCAxMjowMSBBTSwgQ2h1YW5zaGVuZyBMaXUNCj4gPGNodWFu
c2hlbmcubGl1QGludGVsLmNvbT4gd3JvdGU6DQo+ID4gQ3VycmVudGx5IHVzaW5nIHNtcF9jYWxs
X2Z1bmN0aW9uKCkganVzdCB3b2tlIHVwIHRoZSBjb3JyZXNwb25kaW5nDQo+ID4gY3B1LCBidXQg
Y2FuIG5vdCBicmVhayB0aGUgcG9sbGluZyBpZGxlIGxvb3AuDQo+ID4NCj4gPiBIZXJlIHVzaW5n
IHRoZSBuZXcgc2NoZWQgQVBJIHdha2VfdXBfaWZfaWRsZSgpIHRvIGltcGxlbWVudCBpdC4NCj4g
DQo+IGtpY2tfYWxsX2NwdXNfc3luYyBoYXMgb3RoZXIgY2FsbGVycywgYW5kIHRob3NlIG90aGVy
IGNhbGxlcnMgd2FudCB0aGUNCj4gb2xkIGJlaGF2aW9yLiAgSSB0aGluayB0aGlzIHNob3VsZCBi
ZSBhIG5ldyBmdW5jdGlvbi4NCj4gDQpZZXMsIHNlZW1zIHNvbWUgY3VycmVudCB1c2VycyBvZiBr
aWNrX2FsbF9jcHVzX3N5bmMoKSBuZWVkIElQSSBpbmRlZWQsDQp3aWxsIHRyeSB0byBzZW5kIG91
dCBwYXRjaCBWMiB3aXRoIG9uZSBuZXcgZnVuY3Rpb24uDQoNCg==
