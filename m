From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Subject: RE: [PATCH v5 3/5] power: supply: Add 'usb_type' property and
 supporting code
Date: Thu, 22 Mar 2018 10:27:37 +0000
Message-ID: <2E89032DDAA8B9408CB92943514A0337014C1E2892@SW-EX-MBX01.diasemi.com>
References: <cover.1521552959.git.Adam.Thomson.Opensource@diasemi.com>
 <3774272cd49908e88b56a1c4bbf3b363b851ebdd.1521552959.git.Adam.Thomson.Opensource@diasemi.com>
 <225f9a2f-48cc-e6e4-1240-28507f7b3ab7@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <225f9a2f-48cc-e6e4-1240-28507f7b3ab7@roeck-us.net>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>, Adam Thomson <Adam.Thomson.Opensource@diasemi.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, Hans de Goede <hdegoede@redhat.com>, Jun Li <jun.li@nxp.com>
Cc: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Support Opensource <Support.Opensource@diasemi.com>
List-Id: linux-pm@vger.kernel.org

T24gMjIgTWFyY2ggMjAxOCAwNDowOCwgR3VlbnRlciBSb2VjayB3cm90ZToNCg0KPiA+ICtzdGF0
aWMgc3NpemVfdCBwb3dlcl9zdXBwbHlfc2hvd191c2JfdHlwZShzdHJ1Y3QgZGV2aWNlICpkZXYs
DQo+ID4gKwkJCQkJICBlbnVtIHBvd2VyX3N1cHBseV91c2JfdHlwZQ0KPiAqdXNiX3R5cGVzLA0K
PiA+ICsJCQkJCSAgc3NpemVfdCBudW1fdXNiX3R5cGVzLA0KPiA+ICsJCQkJCSAgdW5pb24gcG93
ZXJfc3VwcGx5X3Byb3B2YWwgKnZhbHVlLA0KPiA+ICsJCQkJCSAgY2hhciAqYnVmKQ0KPiA+ICt7
DQo+ID4gKwllbnVtIHBvd2VyX3N1cHBseV91c2JfdHlwZSB1c2JfdHlwZTsNCj4gPiArCXNzaXpl
X3QgY291bnQgPSAwOw0KPiA+ICsJYm9vbCBtYXRjaCA9IGZhbHNlOw0KPiA+ICsJaW50IGk7DQo+
ID4gKw0KPiA+ICsJaWYgKCghdXNiX3R5cGVzKSB8fCAobnVtX3VzYl90eXBlcyA8PSAwKSkgew0K
Pg0KPiBVbm5lY2Vzc2FyeSAoICkNCg0KRmluZSwgY2FuIHJlbW92ZS4NCg0KPg0KPiA+ICsJCWRl
dl93YXJuKGRldiwgImRyaXZlciBoYXMgbm8gdmFsaWQgY29ubmVjdGVkIHR5cGVzXG4iKTsNCj4N
Cj4gQXJlIHRob3NlIHdhcm5pbmdzIHVzZWZ1bCBvciBkbyB0aGV5IGp1c3QgY2xvZyB0aGUgbG9n
ID8gRWl0aGVyIGNhc2UsIGlmIHRoYXQgaGFwcGVucywNCj4gd291bGRuJ3QgaXQgYmUgYmV0dGVy
IHRvIGRldGVjdCB0aGUgc2l0dWF0aW9uIGR1cmluZyByZWdpc3RyYXRpb24gYW5kIGFib3J0ID8N
Cg0KVGhpcyBpcyBhZGRlZCBhcyBhbiBvcHRpb25hbCBwcm9wZXJ0eSBmb3Igc3VwcGx5IGRyaXZl
cnMuIFRoaXMgd2lsbCBvbmx5IHNob3cNCnVwIGlmIGEgc3VwcGx5IGRyaXZlciBhZGRzIHRoZSBV
U0JfVFlQRSBwcm9wZXJ0eSB0byBpdHMgbGlzdCwgYW5kIHRoZW4gc29tZW9uZQ0KYXR0ZW1wdHMg
dG8gYWNjZXNzIGl0LiBBY3R1YWxseSB0aGVyZSdzIG5vIGN1cnJlbnQgY2hlY2tpbmcgZm9yIHRo
ZSBwc3lfZGVzYw0KaW5mb3JtYXRpb24gcHJvdmlkZWQgdG8gdGhlIHJlZ2lzdGVyIGZ1bmN0aW9u
LCBzbyBmb3IgZXhhbXBsZSBpZiBpdCdzIE5VTEwgdGhlbg0KdGhlIGtlcm5lbCB3aWxsIGR1bXAg
d2hlbiBpdCB0cmllcyB0byBkZXJlZmVyZW5jZS4gSSdsbCB0YWtlIGEgbG9vayBhdCB0aGlzIGFu
ZA0Kc2VlIGlmIEkgY2FuIGFkZCBzb21ldGhpbmcsIGluY2x1ZGluZyBjaGVja3Mgb24gdGhlIHVz
Yl90eXBlIHByb3BlcnR5Lg0K
