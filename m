From: "Anson.Huang@freescale.com" <Anson.Huang@freescale.com>
Subject: RE: [PATCH 2/3] thermal: imx: add necessary clk operation
Date: Thu, 19 Dec 2013 07:33:20 +0000
Message-ID: <4b50b52c774c4e99970b7c07a4edba94@DM2PR03MB317.namprd03.prod.outlook.com>
References: <1387477045-19037-1-git-send-email-b20788@freescale.com>
 <1387477045-19037-2-git-send-email-b20788@freescale.com>
 <20131219065915.GB6691@S2101-09.ap.freescale.net>
 <d067cdecda2046f5998302deed320c2a@DM2PR03MB317.namprd03.prod.outlook.com>
 <20131219072922.GD6691@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-bn1blp0188.outbound.protection.outlook.com ([207.46.163.188]:25965
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750807Ab3LSHdY (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 19 Dec 2013 02:33:24 -0500
In-Reply-To: <20131219072922.GD6691@S2101-09.ap.freescale.net>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: "kernel@pengutronix.de" <kernel@pengutronix.de>, "rui.zhang@intel.com" <rui.zhang@intel.com>, "eduardo.valentin@ti.com" <eduardo.valentin@ti.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

DQoNCkJlc3QgUmVnYXJkcy4NCkFuc29uIGh1YW5nIOm7hOWLh+aJjQ0KwqANCkZyZWVzY2FsZSBT
ZW1pY29uZHVjdG9yIFNoYW5naGFpDQrkuIrmtbfmtabkuJzmlrDljLrkuq7mma/ot68xOTLlj7dB
5bqnMualvA0KMjAxMjAzDQpUZWw6MDIxLTI4OTM3MDU4DQoNCg0KPi0tLS0tT3JpZ2luYWwgTWVz
c2FnZS0tLS0tDQo+RnJvbTogU2hhd24gR3VvIFttYWlsdG86c2hhd24uZ3VvQGxpbmFyby5vcmdd
DQo+U2VudDogVGh1cnNkYXksIERlY2VtYmVyIDE5LCAyMDEzIDM6MjkgUE0NCj5UbzogSHVhbmcg
WW9uZ2NhaS1CMjA3ODgNCj5DYzoga2VybmVsQHBlbmd1dHJvbml4LmRlOyBydWkuemhhbmdAaW50
ZWwuY29tOyBlZHVhcmRvLnZhbGVudGluQHRpLmNvbTsNCj5kZXZpY2V0cmVlQHZnZXIua2VybmVs
Lm9yZzsgbGludXgtZG9jQHZnZXIua2VybmVsLm9yZzsgbGludXgtYXJtLQ0KPmtlcm5lbEBsaXN0
cy5pbmZyYWRlYWQub3JnOyBsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmcNCj5TdWJqZWN0OiBSZTog
W1BBVENIIDIvM10gdGhlcm1hbDogaW14OiBhZGQgbmVjZXNzYXJ5IGNsayBvcGVyYXRpb24NCj4N
Cj5PbiBUaHUsIERlYyAxOSwgMjAxMyBhdCAwNzowODoxNkFNICswMDAwLCBBbnNvbi5IdWFuZ0Bm
cmVlc2NhbGUuY29tIHdyb3RlOg0KPj4gPk9uIFRodSwgRGVjIDE5LCAyMDEzIGF0IDAxOjE3OjI0
UE0gLTA1MDAsIEFuc29uIEh1YW5nIHdyb3RlOg0KPj4gPj4gQEAgLTQyNyw2ICs0MjksMTMgQEAg
c3RhdGljIGludCBpbXhfdGhlcm1hbF9wcm9iZShzdHJ1Y3QNCj4+ID4+IHBsYXRmb3JtX2Rldmlj
ZQ0KPj4gPipwZGV2KQ0KPj4gPj4gIAkJcmV0dXJuIHJldDsNCj4+ID4+ICAJfQ0KPj4gPj4NCj4+
ID4+ICsJZGF0YS0+dGhlcm1hbF9jbGsgPSBkZXZtX2Nsa19nZXQoJnBkZXYtPmRldiwgTlVMTCk7
DQo+PiA+PiArCWlmIChJU19FUlIoZGF0YS0+dGhlcm1hbF9jbGspKSB7DQo+PiA+PiArCQlyZXQg
PSBJU19FUlIoZGF0YS0+dGhlcm1hbF9jbGspOw0KPj4gPj4gKwkJZGV2X2VycigmcGRldi0+ZGV2
LCAiZmFpbGVkIHRvIGdldCB0aGVybWFsIGNsayFcbiIpOw0KPj4gPj4gKwkJcmV0dXJuIHJldDsN
Cj4+ID4+ICsJfQ0KPj4gPj4gKw0KPj4gPg0KPj4gPlNvIHdoZW4gdGhlIG5ldyBrZXJuZWwgcnVu
cyBvbiBhIGJvYXJkIHdpdGggYW4gb2xkIERUQiBpbnN0YWxsZWQsDQo+PiA+dGhlcm1hbCBkcml2
ZXIgd2lsbCBiZSBicm9rZW4uDQo+PiA+DQo+PiBZZXMsIEkgdGhvdWdodCBhYm91dCB0aGlzIGNh
c2UsIGJ1dCB0aGUgcHJldmlvdXMgaW1wbGVtZW50IGlzDQo+PiBpbmNvcnJlY3QsIGlmIHRoZSBQ
TEwzIGlzIG5vdCBlbmFibGVkIGJ5IG90aGVyIGRyaXZlcnMsIHRoZXJtYWwgZHJpdmVyDQo+PiB3
aWxsIG5vdCB3b3JrLCBzbyB0aGlzIHBhdGNoIGlzIGEgYnVnIGZpeCwgbm90IGVuaGFuY2VtZW50
LiBTbyB3ZQ0KPj4gc3RpbGwgbmVlZCB0byBjb25zaWRlciBvbGQgZHRzIGNhc2U/DQo+DQo+VGhl
IHRoaW5nIGlzIG1haW5saW5lIGtlcm5lbCBydW5zIG9uIG1hbnkgYm9hcmQgd2l0aCB0aGVybWFs
IGRyaXZlciBiZWluZw0KPmZ1bmN0aW9uYWwgdG9kYXkuICBUaGF0IHNhaWQsIFBMTDMgaXMgYWxy
ZWFkeSBlbmFibGVkIG9uIHRoZXNlIHBsYXRmb3JtcyB3aGVuDQo+dGhlcm1hbCBkcml2ZXIgaXMg
cnVubmluZy4gIFlvdSBjYW5ub3QgZml4IGEgYnVnIGJ1dCBtZWFud2hpbGUgYnJlYWsgdGhlc2UN
Cj51c2VycyB3aG8gdXNlIG9sZCBEVEIuDQoNCk9rYXksIGdvdCBpdCwgSSB3aWxsIHJlcGxhY2Ug
dGhlIHJldHVybiB3aXRoIG9uZSB3YXJuaW5nIG1lc3NhZ2UgaW4gVjIuDQoNCkFuc29uIA0KDQoN
Cj4NCj5TaGF3bg0KDQo=
