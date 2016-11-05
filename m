From: "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
Subject: Re: v4.8-rc1: thinkpad x60: running at low frequency even during
 kernel build
Date: Sat, 5 Nov 2016 14:19:13 +0000
Message-ID: <1478355545.22182.1.camel@intel.com>
References: <20161104083849.GA32688@amd> <20161104085830.GA4089@amd>
         <1478268311.26953.17.camel@intel.com> <20161104204439.GA2581@amd>
         <20161104221600.GA7007@amd> <1478301649.7947.3.camel@intel.com>
         <20161105132049.GC10310@amd> <1478352782.19557.7.camel@intel.com>
         <20161105135313.GB3933@amd> <20161105140434.GA3755@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161105140434.GA3755@amd>
Content-Language: en-US
Content-ID: <90D3E5104A78D041A7DBAED7458C83B0@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "pavel@ucw.cz" <pavel@ucw.cz>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Zhang, Rui" <rui.zhang@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>, "ibm-acpi-devel@lists.sourceforge.net" <ibm-acpi-devel@lists.sourceforge.net>, "ibm-acpi@hmh.eng.br" <ibm-acpi@hmh.eng.br>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

T24gU2F0LCAyMDE2LTExLTA1IGF0IDE1OjA0ICswMTAwLCBQYXZlbCBNYWNoZWsgd3JvdGU6DQo+
IE9uIFNhdCAyMDE2LTExLTA1IDE0OjUzOjEzLCBQYXZlbCBNYWNoZWsgd3JvdGU6DQo+ID4gDQo+
ID4gSGkhDQo+ID4gDQo+ID4gPiANCj4gPiA+ID4gDQo+ID4gPiA+IE9rLCBjYW4gZG8sIGxldCBt
ZSByZWNvbXBpbGUgYW5kIHJlYm9vdC4NCj4gPiA+ID4gDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4g
DQo+ID4gPiA+ID4gV2hlbiB0ZW1wZXJhdHVyZSBsaW1pdCBpcw0KPiA+ID4gPiA+IHJlYWNoZWTC
oGFjcGlfcHJvY2Vzc29yX3BwY19ub3RpZmllcigpDQo+ID4gPiA+ID4gc2hvdWxkDQo+ID4gPiA+
ID4gYmUgY2FsbGVkLg0KPiA+ID4gPiANCj4gPiA+ID4gTm8sIHRoYXQncyBub3QgY29ycmVjdCBm
b3IgQUNQSSBwYXNzaXZlIHRyaXAgcG9pbnRzLCBpcyBpdD8gSWYNCj4gPiA+ID4gSQ0KPiA+ID4g
PiByZWNhbGwgY29ycmVjdGx5LCB0aG9zZSBzaG91bGQgYmUgbW9uaXRvcmVkIGV2ZW4gd2hlbg0K
PiA+ID4gPiB0ZW1wZXJhdHVyZSBpcw0KPiA+ID4gPiBiZWxvdyB0aGVtIHNvIHRoYXQgaXQgZG9l
cyBub3QgcmVhY2ggdGhlbS4uLj8NCj4gPiA+IE5vIGlmIEJJT1MgaXMgc2VuZGluZyBQUEMsIGl0
IHdpbGwgYmUgY2FsbGVkLiBZb3UgY2FuIHRyeSBmaXJzdA0KPiA+ID4gaW4gNC44Lg0KPiA+ID4g
DQo+ID4gPiBBbHNvIHRyeQ0KPiA+ID4gDQo+ID4gPiBEb24ndCBydW4gd29ya2xvYWQsIGp1c3Qg
b24gYW4gaWRsZSBzeXN0ZW0uDQo+ID4gPiANCj4gPiA+ICMgZWNobyAxID4gL3N5cy9jbGFzcy90
aGVybWFsL2Nvb2xpbmdfZGV2aWNlMi9jdXJfc3RhdGUNCj4gPiA+IG1vbml0b3IgdGhlIHNjYWxp
bmdfbWF4X2ZyZXEsIGl0IHNob3VsZCByZWR1Y2UNCj4gPiA+IA0KPiA+ID4gIyBlY2hvIDIgPiAv
c3lzL2NsYXNzL3RoZXJtYWwvY29vbGluZ19kZXZpY2UyL2N1cl9zdGF0ZQ0KPiA+ID4gbW9uaXRv
ciB0aGUgc2NhbGluZ19tYXhfZnJlcSwgaXQgc2hvdWxkIHJlZHVjZQ0KPiA+IA0KPiA+IFllcywg
dGhpcyBzZWVtcyB0byB3b3JrLiBzY2FsaW5nX21heCBnb2VzIHRvIDEuNSwgdGhlbiAxLjEuIEFs
c28NCj4gPiB1bmRlcg0KPiA+IGxvYWQsIHNjYWxpbmdfbWF4X2ZyZXEgY2hhbmdlcy4gQnV0IGF0
IHRoYXQgcG9pbnQsIHdlIGFyZSBhbHJlYWR5DQo+ID4gYXJvdW5kIDk4Qy4uLiBhbmQgYmlvc19s
aW1pdCBzdGF5cyB0aGUgc2FtZSBhbGwgdGhlIHRpbWUgaW4gdjQuOS4NCj4gDQo+IC4uLndoaWxl
IGluIHY0LjgtcmMxLCBiaW9zIGxpbWl0IGdvZXMgdG8gMS4wIEdIeiBhdCA5MEMsIGFuZA0KPiB0
ZW1wZXJhdHVyZSBqdXN0IGRvZXNuJ3QgZ28gYWJvdmUgdGhhdC4NCj4gDQo+IERvZXMgaXQgbWFr
ZSBzZW5zZSB0byB0cnkgd2l0aCB2NC44LWZpbmFsPw0KSSBzZW50IHNvbWUgc3VnZ2VzdGlvbiB0
byB0cnkgaW4gcHJldmlvdXMgZW1haWwgdG8gYWRkIG1vcmUgcHJpbnRzIGFuZA0KZW5hYmxlIGRl
YnVnIGluIGFjcGktY3B1ZnJlcS4gTGV0J3MgdHJ5IHRoYXQgZmlyc3QuIFdlIG5lZWQgdG8gZml4
DQphbnl3YXkgZXZlbiBpZiA0LjgtZmluYWwgaGFzIHRoaXMgaXNzdWUuDQoNClRoYW5rcywNClNy
aW5pdmFzDQoNCg0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiAJCQkJCQkJCVBhdmVs
