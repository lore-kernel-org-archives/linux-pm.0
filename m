From: "Chen, Yu C" <yu.c.chen@intel.com>
Subject: RE: [PATCH 1/3] Thermal: initialize thermal zone device correctly
Date: Mon, 28 Sep 2015 17:30:30 +0000
Message-ID: <36DF59CE26D8EE47B0655C516E9CE64026F225EA@SHSMSX101.ccr.corp.intel.com>
References: <1443332908-13948-1-git-send-email-yu.c.chen@intel.com>
 <20150928142812.GA8359@e104805>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:18806 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933540AbbI1Rae (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 28 Sep 2015 13:30:34 -0400
In-Reply-To: <20150928142812.GA8359@e104805>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Javi Merino <javi.merino@arm.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "edubezval@gmail.com" <edubezval@gmail.com>, "Zhang, Rui" <rui.zhang@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>

SGksIEphdmksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSmF2aSBN
ZXJpbm8gW21haWx0bzpqYXZpLm1lcmlub0Bhcm0uY29tXQ0KPiBTZW50OiBNb25kYXksIFNlcHRl
bWJlciAyOCwgMjAxNSAxMDoyOCBQTQ0KPiBUbzogQ2hlbiwgWXUgQw0KPiBDYzogbGludXgtcG1A
dmdlci5rZXJuZWwub3JnOyBlZHViZXp2YWxAZ21haWwuY29tOyBaaGFuZywgUnVpOyBsaW51eC0N
Cj4ga2VybmVsQHZnZXIua2VybmVsLm9yZzsgc3RhYmxlQHZnZXIua2VybmVsLm9yZw0KPiBTdWJq
ZWN0OiBSZTogW1BBVENIIDEvM10gVGhlcm1hbDogaW5pdGlhbGl6ZSB0aGVybWFsIHpvbmUgZGV2
aWNlIGNvcnJlY3RseQ0KPiANCj4gT24gU3VuLCBTZXAgMjcsIDIwMTUgYXQgMDY6NDg6MjhBTSAr
MDEwMCwgQ2hlbiBZdSB3cm90ZToNCj4gPiBGcm9tOiBaaGFuZyBSdWkgPHJ1aS56aGFuZ0BpbnRl
bC5jb20+DQo+ID4NCj4gPiBBZnRlciB0aGVybWFsIHpvbmUgZGV2aWNlIHJlZ2lzdGVyZWQsIGFz
IHdlIGhhdmUgbm90IHJlYWQgYW55DQo+ID4gdGVtcGVyYXR1cmUgYmVmb3JlLCB0aHVzIHR6LT50
ZW1wZXJhdHVyZSBzaG91bGQgbm90IGJlIDAsIHdoaWNoDQo+ID4gYWN0dWFsbHkgbWVhbnMgMEMs
IGFuZCB0aGVybWFsIHRyZW5kIGlzIG5vdCBhdmFpbGFibGUuDQo+ID4gSW4gdGhpcyBjYXNlLCB3
ZSBuZWVkIHNwZWNpYWxseSBoYW5kbGluZyBmb3IgdGhlIGZpcnN0DQo+ID4gdGhlcm1hbF96b25l
X2RldmljZV91cGRhdGUoKS4NCj4gPg0KPiA+IEJvdGggdGhlcm1hbCBjb3JlIGZyYW1ld29yayBh
bmQgc3RlcF93aXNlIGdvdmVybm9yIGlzIGVuaGFuY2VkIHRvDQo+ID4gaGFuZGxlIHRoaXMuDQo+
IA0KPiBJdCBtYXkgYmUgd29ydGggcG9pbnRpbmcgb3V0IHRoYXQgdGhlIHN0ZXBfd2lzZSBnb3Zl
cm5vciBpcyB0aGUgb25seSBvbmUNCj4gdGhhdCB1c2VzIHRyZW5kcywgc28gaXQncyB0aGUgb25s
eSB0aGVybWFsIGdvdmVybm9yIHRoYXQgbmVlZHMgdG8gYmUgdXBkYXRlZC4NCj4gDQpPSywgd2ls
bCBhZGQuDQo+IA0KPiA+IC0JCWlmIChvbGRfdGFyZ2V0ID09IGluc3RhbmNlLT50YXJnZXQpDQo+
ID4gKwkJaWYgKGluc3RhbmNlLT5pbml0aWFsaXplZCAmJg0KPiA+ICsJCSAgICBvbGRfdGFyZ2V0
ID09IGluc3RhbmNlLT50YXJnZXQpDQo+IA0KPiBuaXQ6IGl0IGZpdHMgaW4gb25lIGxpbmUsDQo+
IA0KPiAJCWlmIChpbnN0YW5jZS0+aW5pdGlhbGl6ZWQgJiYgb2xkX3RhcmdldCA9PSBpbnN0YW5j
ZS0+dGFyZ2V0KQ0KPiANCj4gaXMgNzcgY2hhcmFjdGVycy4NCj4gDQpOb3Qgc3VyZSBpZiB0aGUg
bGltaXQgZm9yIG9uZSBsaW5lIGlzIDc1IGluIGNoZWNrcGF0Y2gucGwsIEknbGwgaGF2ZSBhIHRy
eS4NClRoYW5rcyENCg0KQmVzdCBSZWdhcmRzLA0KWXUNCg==
