From: "Anson.Huang@freescale.com" <Anson.Huang@freescale.com>
Subject: RE: [PATCH 2/3] thermal: imx: add necessary clk operation
Date: Thu, 19 Dec 2013 07:08:16 +0000
Message-ID: <d067cdecda2046f5998302deed320c2a@DM2PR03MB317.namprd03.prod.outlook.com>
References: <1387477045-19037-1-git-send-email-b20788@freescale.com>
 <1387477045-19037-2-git-send-email-b20788@freescale.com>
 <20131219065915.GB6691@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20131219065915.GB6691@S2101-09.ap.freescale.net>
Content-Language: en-US
Sender: linux-doc-owner@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: "kernel@pengutronix.de" <kernel@pengutronix.de>, "rui.zhang@intel.com" <rui.zhang@intel.com>, "eduardo.valentin@ti.com" <eduardo.valentin@ti.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

DQoNCkJlc3QgUmVnYXJkcy4NCkFuc29uIGh1YW5nIOm7hOWLh+aJjQ0KwqANCkZyZWVzY2FsZSBT
ZW1pY29uZHVjdG9yIFNoYW5naGFpDQrkuIrmtbfmtabkuJzmlrDljLrkuq7mma/ot68xOTLlj7dB
5bqnMualvA0KMjAxMjAzDQpUZWw6MDIxLTI4OTM3MDU4DQoNCg0KPi0tLS0tT3JpZ2luYWwgTWVz
c2FnZS0tLS0tDQo+RnJvbTogU2hhd24gR3VvIFttYWlsdG86c2hhd24uZ3VvQGxpbmFyby5vcmdd
DQo+U2VudDogVGh1cnNkYXksIERlY2VtYmVyIDE5LCAyMDEzIDI6NTkgUE0NCj5UbzogSHVhbmcg
WW9uZ2NhaS1CMjA3ODgNCj5DYzoga2VybmVsQHBlbmd1dHJvbml4LmRlOyBydWkuemhhbmdAaW50
ZWwuY29tOyBlZHVhcmRvLnZhbGVudGluQHRpLmNvbTsNCj5kZXZpY2V0cmVlQHZnZXIua2VybmVs
Lm9yZzsgbGludXgtZG9jQHZnZXIua2VybmVsLm9yZzsgbGludXgtYXJtLQ0KPmtlcm5lbEBsaXN0
cy5pbmZyYWRlYWQub3JnOyBsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmcNCj5TdWJqZWN0OiBSZTog
W1BBVENIIDIvM10gdGhlcm1hbDogaW14OiBhZGQgbmVjZXNzYXJ5IGNsayBvcGVyYXRpb24NCj4N
Cj5PbiBUaHUsIERlYyAxOSwgMjAxMyBhdCAwMToxNzoyNFBNIC0wNTAwLCBBbnNvbiBIdWFuZyB3
cm90ZToNCj4+IEBAIC00MjcsNiArNDI5LDEzIEBAIHN0YXRpYyBpbnQgaW14X3RoZXJtYWxfcHJv
YmUoc3RydWN0IHBsYXRmb3JtX2RldmljZQ0KPipwZGV2KQ0KPj4gIAkJcmV0dXJuIHJldDsNCj4+
ICAJfQ0KPj4NCj4+ICsJZGF0YS0+dGhlcm1hbF9jbGsgPSBkZXZtX2Nsa19nZXQoJnBkZXYtPmRl
diwgTlVMTCk7DQo+PiArCWlmIChJU19FUlIoZGF0YS0+dGhlcm1hbF9jbGspKSB7DQo+PiArCQly
ZXQgPSBJU19FUlIoZGF0YS0+dGhlcm1hbF9jbGspOw0KPj4gKwkJZGV2X2VycigmcGRldi0+ZGV2
LCAiZmFpbGVkIHRvIGdldCB0aGVybWFsIGNsayFcbiIpOw0KPj4gKwkJcmV0dXJuIHJldDsNCj4+
ICsJfQ0KPj4gKw0KPg0KPlNvIHdoZW4gdGhlIG5ldyBrZXJuZWwgcnVucyBvbiBhIGJvYXJkIHdp
dGggYW4gb2xkIERUQiBpbnN0YWxsZWQsIHRoZXJtYWwNCj5kcml2ZXIgd2lsbCBiZSBicm9rZW4u
DQo+DQpZZXMsIEkgdGhvdWdodCBhYm91dCB0aGlzIGNhc2UsIGJ1dCB0aGUgcHJldmlvdXMgaW1w
bGVtZW50IGlzIGluY29ycmVjdCwgaWYNCnRoZSBQTEwzIGlzIG5vdCBlbmFibGVkIGJ5IG90aGVy
IGRyaXZlcnMsIHRoZXJtYWwgZHJpdmVyIHdpbGwgbm90IHdvcmssIHNvDQp0aGlzIHBhdGNoIGlz
IGEgYnVnIGZpeCwgbm90IGVuaGFuY2VtZW50LiBTbyB3ZSBzdGlsbCBuZWVkIHRvIGNvbnNpZGVy
IG9sZA0KZHRzIGNhc2U/IA0KDQpBbnNvbg0KDQo+U2hhd24NCg0K
