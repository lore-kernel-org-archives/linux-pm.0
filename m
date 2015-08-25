From: "Chen, Yu C" <yu.c.chen@intel.com>
Subject: RE: [PATCH] [v2] x86, suspend: Save/restore extra MSR registers for
 suspend
Date: Tue, 25 Aug 2015 01:58:18 +0000
Message-ID: <36DF59CE26D8EE47B0655C516E9CE6401CB01E3F@SHSMSX101.ccr.corp.intel.com>
References: <1440158014-29610-1-git-send-email-yu.c.chen@intel.com>
 <20150824084946.GA7819@nazgul.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:36493 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751984AbbHYB6Y (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 24 Aug 2015 21:58:24 -0400
In-Reply-To: <20150824084946.GA7819@nazgul.tnic>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "pavel@ucw.cz" <pavel@ucw.cz>, "tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, "hpa@zytor.com" <hpa@zytor.com>, "Zhang, Rui" <rui.zhang@intel.com>, "lenb@kernel.org" <lenb@kernel.org>, "x86@kernel.org" <x86@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

SGksIEJvcmlzLHRoYW5rcyBmb3IgeW91ciByZXZpZXcNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3Nh
Z2UtLS0tLQ0KPiBGcm9tOiBCb3Jpc2xhdiBQZXRrb3YgW21haWx0bzpicEBhbGllbjguZGVdDQo+
IFNlbnQ6IE1vbmRheSwgQXVndXN0IDI0LCAyMDE1IDQ6NTAgUE0NCj4gVG86IENoZW4sIFl1IEMN
Cj4gQ2M6IHJqd0Byand5c29ja2kubmV0OyBwYXZlbEB1Y3cuY3o7IHRnbHhAbGludXRyb25peC5k
ZTsNCj4gbWluZ29AcmVkaGF0LmNvbTsgaHBhQHp5dG9yLmNvbTsgWmhhbmcsIFJ1aTsgbGVuYkBr
ZXJuZWwub3JnOw0KPiB4ODZAa2VybmVsLm9yZzsgbGludXgtcG1Admdlci5rZXJuZWwub3JnOyBs
aW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIFt2Ml0g
eDg2LCBzdXNwZW5kOiBTYXZlL3Jlc3RvcmUgZXh0cmEgTVNSIHJlZ2lzdGVycyBmb3INCj4gc3Vz
cGVuZA0KPiANCj4gT24gRnJpLCBBdWcgMjEsIDIwMTUgYXQgMDc6NTM6MzRQTSArMDgwMCwgQ2hl
biBZdSB3cm90ZToNCj4gPiArc3RydWN0IG1zcl90eXBlIHsNCj4gPiArCXVuc2lnbmVkIGludCBt
c3JfaWQ7DQo+ID4gKwlib29sIG1zcl9zYXZlZDsNCj4gPiArCXU2NCBtc3JfdmFsdWU7DQo+ID4g
K307DQo+IA0KPiBUaGVzZSBkZWZpbml0aW9ucyBsb29rIGF3ZnVsbHkgY2xvc2UgdG8gc3RydWN0
IG1zcl9pbmZvIGluIGluY2x1ZGUvYXNtL21zci5oDQo+IA0KPiBNYXliZSByZXVzZSB0aGVtIGlu
c3RlYWQgb2YgZ3Jvd2luZyB5ZXQgYW5vdGhlciB0eXBlLi4uDQo+IA0KT0ssICBJJ2xsIHVzZSBt
c3JfaW5mbyBpbnN0ZWFkIG9mICBtc3JfaWQgYW5kIG1zcl92YWx1ZToNCnN0cnVjdCBtc3JfdHlw
ZSB7DQoJYm9vbCBtc3Jfc2F2ZWQ7DQoJc3RydWN0IG1zcl9pbmZvIHJ2Ow0KfTsNCg0KPiA+ICtz
dGF0aWMgdm9pZCBtc3Jfc2F2ZV9jb250ZXh0KHN0cnVjdCBzYXZlZF9jb250ZXh0ICpjdHh0KSB7
DQo+ID4gKwlpbnQgaSA9IDA7DQo+ID4gKw0KPiA+ICsJZm9yIChpID0gMDsgaSA8IGN0eHQtPm1z
cl9mb3Jfc2F2ZS5udW07IGkrKykgew0KPiA+ICsJCXN0cnVjdCBtc3JfdHlwZSAqbXNyID0NCj4g
PiArCQkJJmN0eHQtPm1zcl9mb3Jfc2F2ZS5tc3JfYXJyYXlbaV07DQo+IA0KPiBObyBuZWVkIGZv
ciB0aGUgbGluZSBicmVha3MgaGVyZSwgbGV0IHRoZW0gc3RpY2sgb3V0IGZvciBiZXR0ZXIgcmVh
ZGFiaWxpdHkuDQo+IA0KT0ssIHdpbGwgZG8uDQo+ID4gKwkJbXNyLT5tc3Jfc2F2ZWQgPSAhcmRt
c3JsX3NhZmUobXNyLT5tc3JfaWQsDQo+ID4gKwkJCSZtc3ItPm1zcl92YWx1ZSk7DQo+ID4gKwl9
DQo+ID4gKwkJc3RydWN0IG1zcl90eXBlICptc3IgPQ0KPiA+ICsJCQkmY3R4dC0+bXNyX2Zvcl9z
YXZlLm1zcl9hcnJheVtpXTsNCj4gPiArCQlpZiAobXNyLT5tc3Jfc2F2ZWQpDQo+ID4gKwkJCXdy
bXNybChtc3ItPm1zcl9pZCwgbXNyLT5tc3JfdmFsdWUpOw0KPiANCj4gRGl0dG8uDQo+IA0KT0ss
IHdpbGwgZG8uDQoNCg0KQmVzdCBSZWdhcmRzLA0KWXUNCg==
