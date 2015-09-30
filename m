From: "Opensource [Adam Thomson]" <Adam.Thomson.Opensource@diasemi.com>
Subject: RE: [PATCH v5 0/6] Add support for DA9150 Fuel-Gauge
Date: Wed, 30 Sep 2015 08:52:36 +0000
Message-ID: <2E89032DDAA8B9408CB92943514A0337D46067BA@SW-EX-MBX01.diasemi.com>
References: <cover.1441964153.git.Adam.Thomson.Opensource@diasemi.com>
 <20150922160405.GC4235@earth> <20150922171032.GH11284@x1>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150922171032.GH11284@x1>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>
Cc: "Opensource [Adam Thomson]" <Adam.Thomson.Opensource@diasemi.com>, Samuel Ortiz <sameo@linux.intel.com>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Support Opensource <Support.Opensource@diasemi.com>
List-Id: linux-pm@vger.kernel.org

T24gU2VwdGVtYmVyIDIyLCAyMDE1IDE4OjExLCBMZWUgSm9uZXMgd3JvdGU6DQoNCj4gT24gVHVl
LCAyMiBTZXAgMjAxNSwgU2ViYXN0aWFuIFJlaWNoZWwgd3JvdGU6DQo+ID4gT24gRnJpLCBTZXAg
MTEsIDIwMTUgYXQgMTE6MDU6MjFBTSArMDEwMCwgQWRhbSBUaG9tc29uIHdyb3RlOg0KPiA+ID4g
VGhpcyBwYXRjaCBzZXQgYWRkcyBzdXBwb3J0IGZvciB0aGUgRGlhbG9nIERBOTE1MCBGdWVsLUdh
dWdlLg0KPiA+ID4NCj4gPiA+IFsuLi5dDQo+ID4gPg0KPiA+ID4gQWRhbSBUaG9tc29uICg2KToN
Cj4gPiA+ICAgbWZkOiBkYTkxNTA6IEFkZCBzdXBwb3J0IGZvciBGdWVsLUdhdWdlDQo+ID4gPiAg
IG1mZDogZGE5MTUwOiBVcGRhdGUgRFQgYmluZGluZ3MgZm9yIEZ1ZWwtR2F1Z2Ugc3VwcG9ydA0K
PiA+ID4gICBwb3dlcjogQWRkIHN1cHBvcnQgZm9yIERBOTE1MCBGdWVsLUdhdWdlDQo+ID4gPiAg
IHBvd2VyOiBkYTkxNTA6IEFkZCBEVCBiaW5kaW5ncyBkb2N1bWVudGF0aW9uIGZvciBGdWVsLUdh
dWdlDQo+ID4gPiAgIG1mZDogZGE5MTUwOiBVc2UgcmVsYXRpdmUgcGF0aHMgaW4gRFQgYmluZGlu
Z3MgZG9jdW1lbnQNCj4gPiA+ICAgbWZkOiBkYTkxNTA6IFVzZSBERUZJTkVfUkVTX0lSUV9OQU1F
RCgpIGhlbHAgbWFjcm8gZm9yIElSUSByZXNvdXJjZQ0KPiA+ID4NCj4gPiA+ICBEb2N1bWVudGF0
aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWZkL2RhOTE1MC50eHQgICB8ICAzMyArLQ0KPiA+ID4g
IC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL3Bvd2VyL2RhOTE1MC1mZy50eHQgICAgICAgIHwgIDIz
ICsNCj4gPiA+ICBkcml2ZXJzL21mZC9kYTkxNTAtY29yZS5jICAgICAgICAgICAgICAgICAgICAg
ICAgICB8IDE5MSArKysrKy0tDQo+ID4gPiAgZHJpdmVycy9wb3dlci9LY29uZmlnICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgfCAgMTAgKw0KPiA+ID4gIGRyaXZlcnMvcG93ZXIvTWFrZWZp
bGUgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAxICsNCj4gPiA+ICBkcml2ZXJzL3Bv
d2VyL2RhOTE1MC1mZy5jICAgICAgICAgICAgICAgICAgICAgICAgICB8IDU3OCArKysrKysrKysr
KysrKysrKysrKysNCj4gPiA+ICBpbmNsdWRlL2xpbnV4L21mZC9kYTkxNTAvY29yZS5oICAgICAg
ICAgICAgICAgICAgICB8ICAxOSArLQ0KPiA+ID4gIDcgZmlsZXMgY2hhbmdlZCwgODEwIGluc2Vy
dGlvbnMoKyksIDQ1IGRlbGV0aW9ucygtKQ0KPiA+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBEb2N1
bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcG93ZXIvZGE5MTUwLWZnLnR4dA0KPiA+ID4g
IGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL3Bvd2VyL2RhOTE1MC1mZy5jDQo+ID4NCj4gPiBJ
IHN1Z2dlc3QsIHRoYXQgeW91IHRha2UgdGhlIHdob2xlIHBhdGNoc2V0IHZpYSB0aGUgbWZkIHRy
ZWUuDQo+IA0KPiBUaGF0J3MgZmluZSwgYnV0IEknbSBzdGlsbCBtaXNzaW5nIGFuIEFjayBmb3Ig
cGF0Y2ggNC4NCg0KSGkgTGVlLA0KDQpJIGJlbGlldmUgYWxsIHBhdGNoZXMgYXJlIG5vdyBhY2tl
ZC4gSXMgdGhlcmUgYW55dGhpbmcgZWxzZSBuZWVkZWQgdG8gaGVscCB0aGlzDQphbG9uZz8NCg0K
VGhhbmtzDQpBZGFtDQo=
