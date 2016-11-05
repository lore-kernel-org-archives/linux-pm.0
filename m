From: "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
Subject: Re: v4.8-rc1: thinkpad x60: running at low frequency even during
 kernel build
Date: Sat, 5 Nov 2016 13:33:10 +0000
Message-ID: <1478352782.19557.7.camel@intel.com>
References: <20161104083849.GA32688@amd> <20161104085830.GA4089@amd>
         <1478268311.26953.17.camel@intel.com> <20161104204439.GA2581@amd>
         <20161104221600.GA7007@amd> <1478301649.7947.3.camel@intel.com>
         <20161105132049.GC10310@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20161105132049.GC10310@amd>
Content-Language: en-US
Content-ID: <3AF03E88D496CE4DA191049AC46F86E0@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: "pavel@ucw.cz" <pavel@ucw.cz>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Zhang, Rui" <rui.zhang@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>, "ibm-acpi-devel@lists.sourceforge.net" <ibm-acpi-devel@lists.sourceforge.net>, "ibm-acpi@hmh.eng.br" <ibm-acpi@hmh.eng.br>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

T24gU2F0LCAyMDE2LTExLTA1IGF0IDE0OjIwICswMTAwLCBQYXZlbCBNYWNoZWsgd3JvdGU6DQo+
IE9uIEZyaSAyMDE2LTExLTA0IDIzOjIwOjUzLCBQYW5kcnV2YWRhLCBTcmluaXZhcyB3cm90ZToN
Cj4gPiANCj4gPiBPbiBGcmksIDIwMTYtMTEtMDQgYXQgMjM6MTYgKzAxMDAsIFBhdmVsIE1hY2hl
ayB3cm90ZToNCj4gPiA+IA0KPiA+ID4gSGkhDQo+ID4gPiANCj4gPiANCj4gPiBbLi4uXQ0KPiA+
IA0KPiA+ID4gDQo+ID4gPiBTbyB3ZSBzZWVtIHRvIGhhdmUgdGhlcm1hbCBvciBBQ1BJIHJlZ3Jl
c3Npb24gaW4gdjQuOS1yYzMuDQo+ID4gPiANCj4gPiBJdCBpcyBwb3NzaWJsZS4gQ2FuIHlvdSBh
ZGQgZWl0aGVyIGFkZCBwcmludGsNCj4gPiBpbsKgYWNwaV9wcm9jZXNzb3JfcHBjX2hhc19jaGFu
Z2VkKCkgb3IgdXNlIGZ0cmFjZSBhbmQgc2VlIGRvIHlvdQ0KPiA+IGdldCB0bw0KPiA+IHRoZXNl
IGZ1bmN0aW9ucw0KPiA+IA0KPiA+IGFjcGlfcHJvY2Vzc29yX3BwY19pbml0KCkNCj4gPiBhY3Bp
X3Byb2Nlc3Nvcl9wcGNfaGFzX2NoYW5nZWQoKQ0KPiA+IGFjcGlfcHJvY2Vzc29yX3BwY19ub3Rp
ZmllcigpDQo+ID4gDQo+ID4gPw0KPiANCj4gT2ssIGNhbiBkbywgbGV0IG1lIHJlY29tcGlsZSBh
bmQgcmVib290Lg0KPiANCj4gPiANCj4gPiBXaGVuIHRlbXBlcmF0dXJlIGxpbWl0IGlzIHJlYWNo
ZWTCoGFjcGlfcHJvY2Vzc29yX3BwY19ub3RpZmllcigpDQo+ID4gc2hvdWxkDQo+ID4gYmUgY2Fs
bGVkLg0KPiANCj4gTm8sIHRoYXQncyBub3QgY29ycmVjdCBmb3IgQUNQSSBwYXNzaXZlIHRyaXAg
cG9pbnRzLCBpcyBpdD8gSWYgSQ0KPiByZWNhbGwgY29ycmVjdGx5LCB0aG9zZSBzaG91bGQgYmUg
bW9uaXRvcmVkIGV2ZW4gd2hlbiB0ZW1wZXJhdHVyZSBpcw0KPiBiZWxvdyB0aGVtIHNvIHRoYXQg
aXQgZG9lcyBub3QgcmVhY2ggdGhlbS4uLj8NCk5vIGlmIEJJT1MgaXMgc2VuZGluZyBQUEMsIGl0
IHdpbGwgYmUgY2FsbGVkLiBZb3UgY2FuIHRyeSBmaXJzdCBpbiA0LjguDQoNCkFsc28gdHJ5DQoN
CkRvbid0IHJ1biB3b3JrbG9hZCwganVzdCBvbiBhbiBpZGxlIHN5c3RlbS4NCg0KIyBlY2hvIDEg
PiAvc3lzL2NsYXNzL3RoZXJtYWwvY29vbGluZ19kZXZpY2UyL2N1cl9zdGF0ZQ0KbW9uaXRvciB0
aGUgc2NhbGluZ19tYXhfZnJlcSwgaXQgc2hvdWxkIHJlZHVjZQ0KDQojIGVjaG8gMiA+IC9zeXMv
Y2xhc3MvdGhlcm1hbC9jb29saW5nX2RldmljZTIvY3VyX3N0YXRlDQptb25pdG9yIHRoZSBzY2Fs
aW5nX21heF9mcmVxLCBpdCBzaG91bGQgcmVkdWNlDQoNClRoYW5rcywNClNyaW5pdmFzDQo=
