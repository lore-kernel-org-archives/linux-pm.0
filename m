From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Subject: RE: [PATCH v5 5/5] typec: tcpm: Add support for sink PPS related
 messages
Date: Thu, 22 Mar 2018 09:37:44 +0000
Message-ID: <2E89032DDAA8B9408CB92943514A0337014C1E284C@SW-EX-MBX01.diasemi.com>
References: <cover.1521552959.git.Adam.Thomson.Opensource@diasemi.com>
 <cb45050153fa8304584441a7a7401a138514ddc1.1521552959.git.Adam.Thomson.Opensource@diasemi.com>
 <58c2a5eb-4811-eb14-d977-674b06524d71@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <58c2a5eb-4811-eb14-d977-674b06524d71@roeck-us.net>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>, Adam Thomson <Adam.Thomson.Opensource@diasemi.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, Hans de Goede <hdegoede@redhat.com>, Jun Li <jun.li@nxp.com>
Cc: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Support Opensource <Support.Opensource@diasemi.com>
List-Id: linux-pm@vger.kernel.org

T24gMjIgTWFyY2ggMjAxOCAwMzo1MywgR3VlbnRlciBSb2VjayB3cm90ZToNCg0KPiA+ICtzdGF0
aWMgdm9pZCB0Y3BtX3BkX2V4dF9tc2dfcmVxdWVzdChzdHJ1Y3QgdGNwbV9wb3J0ICpwb3J0LA0K
PiA+ICsJCQkJICAgIGNvbnN0IHN0cnVjdCBwZF9tZXNzYWdlICptc2cpDQo+ID4gK3sNCj4gPiAr
CWVudW0gcGRfZXh0X21zZ190eXBlIHR5cGUgPSBwZF9oZWFkZXJfdHlwZV9sZShtc2ctPmhlYWRl
cik7DQo+ID4gKwl1bnNpZ25lZCBpbnQgZGF0YV9zaXplID0gcGRfZXh0X2hlYWRlcl9kYXRhX3Np
emVfbGUobXNnLQ0KPiA+ZXh0X21zZy5oZWFkZXIpOw0KPiA+ICsJdTggKmRhdGE7DQo+ID4gKw0K
PiA+ICsJaWYgKCEobXNnLT5leHRfbXNnLmhlYWRlciAmJiBQRF9FWFRfSERSX0NIVU5LRUQpKSB7
DQo+ID4gKwkJdGNwbV9sb2cocG9ydCwgIlVuY2h1bmtlZCBleHRlbmRlZCBtZXNzYWdlcyB1bnN1
cHBvcnRlZCIpOw0KPiA+ICsJCXJldHVybjsNCj4gPiArCX0NCj4gPiArDQo+ID4gKwlpZiAoZGF0
YV9zaXplID4gKFBEX0VYVF9NQVhfQ0hVTktfREFUQSkpIHsNCj4gPiArCQl0Y3BtX2xvZyhwb3J0
LCAiQ2h1bmsgaGFuZGxpbmcgbm90IHlldCBzdXBwb3J0ZWQiKTsNCj4gPiArCQlyZXR1cm47DQo+
ID4gKwl9DQo+ID4gKw0KPiA+ICsJZGF0YSA9IGt6YWxsb2MoZGF0YV9zaXplLCBHRlBfS0VSTkVM
KTsNCj4gPiArCWlmICghZGF0YSkgew0KPiA+ICsJCXRjcG1fbG9nKHBvcnQsICJGYWlsZWQgdG8g
YWxsb2NhdGUgbWVtb3J5IGZvciBleHQgbXNnIGRhdGEiKTsNCj4gPiArCQlyZXR1cm47DQo+ID4g
Kwl9DQo+ID4gKwltZW1jcHkoZGF0YSwgbXNnLT5leHRfbXNnLmRhdGEsIGRhdGFfc2l6ZSk7DQo+
ID4gKw0KPiA+ICsJc3dpdGNoICh0eXBlKSB7DQo+ID4gKwljYXNlIFBEX0VYVF9TVEFUVVM6DQo+
ID4gKwkJLyoNCj4gPiArCQkgKiBJZiBQUFMgcmVsYXRlZCBldmVudHMgcmFpc2VkIHRoZW4gZ2V0
IFBQUyBzdGF0dXMgdG8gY2xlYXINCj4gPiArCQkgKiAoc2VlIFVTQiBQRCAzLjAgU3BlYywgNi41
LjIuNCkNCj4gPiArCQkgKi8NCj4gPiArCQlpZiAoZGF0YVtVU0JfUERfRVhUX1NEQl9FVkVOVF9G
TEFHU10gJg0KPiBVU0JfUERfRVhUX1NEQl9QUFNfRVZFTlRTKQ0KPg0KPiBUaGlzIHNlZW1zIHRv
IGJlIHRoZSBvbmx5IHVzZSBvZiAnZGF0YScuIENhbiB5b3UgZXhwbGFpbiB3aHkgaXQgaXMgbmVl
ZGVkDQo+IGluIHRoZSBmaXJzdCBwbGFjZSA/IEFtIEkgbWlzc2luZyBzb21ldGhpbmcgPw0KDQpB
Y3R1YWxseSBpdCdzIGEgZmFpciBwb2ludC4gUmlnaHQgbm93IGl0J3Mgbm90IG5lZWRlZCBzbyB3
aWxsIHJlbW92ZSBpdCBhbmQNCmRpcmVjdGx5IHJlZmVyZW5jZSB0aGUgZXh0X21zZy5kYXRhIGFy
cmF5Lg0K
