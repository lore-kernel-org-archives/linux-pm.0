From: "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
Subject: Re: v4.8-rc1: thinkpad x60: running at low frequency even during
 kernel build
Date: Sat, 5 Nov 2016 13:55:22 +0000
Message-ID: <1478354115.19557.17.camel@intel.com>
References: <20161104083849.GA32688@amd> <20161104085830.GA4089@amd>
         <1478268311.26953.17.camel@intel.com> <20161104204439.GA2581@amd>
         <20161104221600.GA7007@amd> <1478301649.7947.3.camel@intel.com>
         <20161105133719.GA3933@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161105133719.GA3933@amd>
Content-Language: en-US
Content-ID: <ACE17AE67D7682419003C1F7CD3F36B3@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "pavel@ucw.cz" <pavel@ucw.cz>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Zhang, Rui" <rui.zhang@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>, "ibm-acpi-devel@lists.sourceforge.net" <ibm-acpi-devel@lists.sourceforge.net>, "ibm-acpi@hmh.eng.br" <ibm-acpi@hmh.eng.br>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

T24gU2F0LCAyMDE2LTExLTA1IGF0IDE0OjM3ICswMTAwLCBQYXZlbCBNYWNoZWsgd3JvdGU6DQo+
IEhpIQ0KPiANCj4gPiANCj4gPiBbLi4uXQ0KPiA+IA0KPiA+ID4gDQo+ID4gPiBTbyB3ZSBzZWVt
IHRvIGhhdmUgdGhlcm1hbCBvciBBQ1BJIHJlZ3Jlc3Npb24gaW4gdjQuOS1yYzMuDQo+ID4gPiAN
Cj4gPiBJdCBpcyBwb3NzaWJsZS4gQ2FuIHlvdSBhZGQgZWl0aGVyIGFkZCBwcmludGsNCj4gPiBp
bsKgYWNwaV9wcm9jZXNzb3JfcHBjX2hhc19jaGFuZ2VkKCkgb3IgdXNlIGZ0cmFjZSBhbmQgc2Vl
IGRvIHlvdQ0KPiA+IGdldCB0bw0KPiA+IHRoZXNlIGZ1bmN0aW9ucw0KPiA+IA0KPiA+IGFjcGlf
cHJvY2Vzc29yX3BwY19pbml0KCkNCj4gPiBhY3BpX3Byb2Nlc3Nvcl9wcGNfaGFzX2NoYW5nZWQo
KQ0KPiA+IGFjcGlfcHJvY2Vzc29yX3BwY19ub3RpZmllcigpDQo+ID4gDQo+ID4gPw0KPiANCj4g
WWVzLCB0aGVzZSBzZWVtIHRvIGJlIGNhbGxlZC4gSGVyZSdzIHRoZSBsb2c6DQoNClRyeSB0aGlz
DQoNCjEuIEVpdGhlciBlbmFibGUgZHluZGVidWcgb3IgYWRkwqANCg0KI2RlZmluZSBERUJVRyAx
wqANCmF0IHRoZSB0b3Agb2YgYWNwaS1jcHVmcmVxLmMNCg0KDQoyLg0KDQpkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9hY3BpL3Byb2Nlc3Nvcl9wZXJmbGliLmMNCmIvZHJpdmVycy9hY3BpL3Byb2Nlc3Nv
cl9wZXJmbGliLmMNCmluZGV4IGJiMDFkZWEuLjYwNzQ5OTUgMTAwNjQ0DQotLS0gYS9kcml2ZXJz
L2FjcGkvcHJvY2Vzc29yX3BlcmZsaWIuYw0KKysrIGIvZHJpdmVycy9hY3BpL3Byb2Nlc3Nvcl9w
ZXJmbGliLmMNCkBAIC05NCw5ICs5NCwxNCBAQCBzdGF0aWMgaW50IGFjcGlfcHJvY2Vzc29yX3Bw
Y19ub3RpZmllcihzdHJ1Y3QNCm5vdGlmaWVyX2Jsb2NrICpuYiwNCsKgDQrCoMKgwqDCoMKgwqDC
oMKgcHBjID0gKHVuc2lnbmVkIGludClwci0+cGVyZm9ybWFuY2VfcGxhdGZvcm1fbGltaXQ7DQrC
oA0KK8KgwqDCoMKgwqDCoMKgcHJpbnRrKEtFUk5fRVJSICJwcGMgPSAlZFxuIiwgcHBjKTsNCisN
CsKgwqDCoMKgwqDCoMKgwqBpZiAocHBjID49IHByLT5wZXJmb3JtYW5jZS0+c3RhdGVfY291bnQp
DQrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGdvdG8gb3V0Ow0KwqANCivCoMKgwqDC
oMKgwqDCoHByaW50ayhLRVJOX0VSUiAicHBjID0gJWQgZnJlcS1saW1pdCAlZFxuIiwgcHBjLCBw
ci0NCj5wZXJmb3JtYW5jZS0+c3RhdGVzW3BwY10uDQorwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBjb3JlX2Zy
ZXF1ZW5jeSAqIDEwMDApOw0KKw0KwqDCoMKgwqDCoMKgwqDCoGNwdWZyZXFfdmVyaWZ5X3dpdGhp
bl9saW1pdHMocG9saWN5LCAwLA0KwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBwci0+cGVyZm9ybWFuY2UtPnN0
YXRlc1twcGNdLg0KwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBjb3JlX2ZyZXF1ZW5jeSAqIDEwMDApOw0KDQpU
aGFua3MsDQpTcmluaXZhcw==
