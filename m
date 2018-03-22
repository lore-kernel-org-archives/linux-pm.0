From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Subject: RE: [PATCH v5 4/5] typec: tcpm: Represent source supply through
 power_supply
Date: Thu, 22 Mar 2018 10:40:01 +0000
Message-ID: <2E89032DDAA8B9408CB92943514A0337014C1E28A3@SW-EX-MBX01.diasemi.com>
References: <cover.1521552959.git.Adam.Thomson.Opensource@diasemi.com>
 <510c0897961f234daca295b273bf4e5047498c55.1521552959.git.Adam.Thomson.Opensource@diasemi.com>
 <b2d508dc-c344-6447-1c50-69f268fdbb83@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <b2d508dc-c344-6447-1c50-69f268fdbb83@roeck-us.net>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>, Adam Thomson <Adam.Thomson.Opensource@diasemi.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, Hans de Goede <hdegoede@redhat.com>, Jun Li <jun.li@nxp.com>
Cc: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Support Opensource <Support.Opensource@diasemi.com>
List-Id: linux-pm@vger.kernel.org

T24gMjIgTWFyY2ggMjAxOCAwNDowOSwgR3VlbnRlciBSb2VjayB3cm90ZToNCg0KPiA+ICtzdGF0
aWMgaW50IHRjcG1fcHN5X3NldF9wcm9wKHN0cnVjdCBwb3dlcl9zdXBwbHkgKnBzeSwNCj4gPiAr
CQkJICAgICBlbnVtIHBvd2VyX3N1cHBseV9wcm9wZXJ0eSBwc3AsDQo+ID4gKwkJCSAgICAgY29u
c3QgdW5pb24gcG93ZXJfc3VwcGx5X3Byb3B2YWwgKnZhbCkNCj4gPiArew0KPiA+ICsJc3RydWN0
IHRjcG1fcG9ydCAqcG9ydCA9IHBvd2VyX3N1cHBseV9nZXRfZHJ2ZGF0YShwc3kpOw0KPiA+ICsJ
aW50IHJldCA9IDA7DQo+ID4gKw0KPiA+ICsJc3dpdGNoIChwc3ApIHsNCj4gPiArCWNhc2UgUE9X
RVJfU1VQUExZX1BST1BfT05MSU5FOg0KPiA+ICsJCXJldCA9IHRjcG1fcHN5X3NldF9vbmxpbmUo
cG9ydCwgdmFsKTsNCj4gPiArCQlicmVhazsNCj4gPiArCWNhc2UgUE9XRVJfU1VQUExZX1BST1Bf
Vk9MVEFHRV9OT1c6DQo+ID4gKwkJaWYgKCh2YWwtPmludHZhbCA8IChwb3J0LT5wcHNfZGF0YS5t
aW5fdm9sdCAqIDEwMDApKSB8fA0KPiA+ICsJCSAgICAodmFsLT5pbnR2YWwgPiAocG9ydC0+cHBz
X2RhdGEubWF4X3ZvbHQgKiAxMDAwKSkpDQo+ID4gKwkJCXJldCA9IC1FSU5WQUw7DQo+ID4gKwkJ
ZWxzZQ0KPiA+ICsJCQlyZXQgPSB0Y3BtX3Bwc19zZXRfb3V0X3ZvbHQocG9ydCwgKHZhbC0+aW50
dmFsIC8gMTAwMCkpOw0KPiA+ICsJCWJyZWFrOw0KPiA+ICsJY2FzZSBQT1dFUl9TVVBQTFlfUFJP
UF9DVVJSRU5UX05PVzoNCj4gPiArCQlpZiAodmFsLT5pbnR2YWwgPiAocG9ydC0+cHBzX2RhdGEu
bWF4X2N1cnIgKiAxMDAwKSkNCj4gPiArCQkJcmV0ID0gLUVJTlZBTDsNCj4gPiArCQllbHNlDQo+
ID4gKwkJCXJldCA9IHRjcG1fcHBzX3NldF9vcF9jdXJyKHBvcnQsICh2YWwtPmludHZhbCAvIDEw
MDApKTsNCj4gDQo+IEkgYW0gcmVhbGx5IG5vdCBhIGZyaWVuZCBvZiBleGNlc3NpdmUgKCApLg0K
DQpZZXMsIEkgZ290IHRoYXQuIDopIEkgYW0gb2YgdGhlIG9waW5pb24gdGhhdCB0aGV5IHNob3Vs
ZCBiZSB1c2VkIHRvIGVuZm9yY2UNCnByZWNlZGVuY2UuIFRoaXMgdG8gbWUgaXMgZ29vZCBjb2Rp
bmcgcHJhY3RpY2UgYW5kIG1ha2VzIGl0IHVuYW1iaWd1b3VzIGZvciB0aGUNCnJlYWRlci4gVGhh
dCdzIHdoeSBJIHVzZSB0aGVtIGFzIGFib3ZlLiBEbyB5b3UgdGhpbmsgdGhlIGFib3ZlIHVzZXMg
bWFrZSBpdA0KaGFyZGVyIHRvIHVuZGVyc3RhbmQgb3IgbW9yZSBkaWZmaWN1bHQgdG8gbWFpbnRh
aW4/DQo=
