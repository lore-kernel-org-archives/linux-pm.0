From: Shuah Khan <shuah.kh@samsung.com>
Subject: Re: [PATCH] PM: Fix dev_pm_put_subsys_data() to not call kfree()
 while holding device power lock
Date: Mon, 6 May 2013 14:01:03 +0000
Message-ID: <1367848858.2953.1.camel@lorien>
References: <1367614010.8452.2.camel@lorien>
	 <20130504125116.GA13770@amd.pavel.ucw.cz>
	 <1882177.s6zpHZ6crc@vostro.rjw.lan>
	 <20130506120925.GA25542@amd.pavel.ucw.cz>
Reply-To: Shuah Khan <shuah.kh@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.sisa.samsung.com ([63.166.156.249]:51279 "EHLO
	mx1.sisa.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751923Ab3EFOBK (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 6 May 2013 10:01:10 -0400
In-Reply-To: <20130506120925.GA25542@amd.pavel.ucw.cz>
Content-Language: en-US
Content-ID: <92158966F363BD40ACCD5DAAB0E255EF@sisa.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, "len.brown@intel.com" <len.brown@intel.com>, "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "shuahkhan@gmail.com" <shuahkhan@gmail.com>

T24gTW9uLCAyMDEzLTA1LTA2IGF0IDE0OjA5ICswMjAwLCBQYXZlbCBNYWNoZWsgd3JvdGU6DQo+
IEhpIQ0KPiANCj4gPiA+IFdvdywgdGhhdCBmdW5jdGlvbiBpcyBmcmFnaWxlLiBJdCByZXR1cm5z
IDAvMS8tRUlOVkFMLCB3aGlsZSBiZWluZw0KPiA+ID4gZG9jdW1lbnRlZCBmb3IgMC8xLi4uDQo+
ID4gDQo+ID4gT2gsIGl0IGdlbmVyYWxseSBzaG91bGQgcmV0dXJuIDEgZm9yICFwc2QuDQo+ID4g
DQo+ID4gPiBQYXRjaCBkb2VzIG5vdCBsb29rIG9idmlvdXNseSB3cm9uZywgYnV0IG1heWJlIA0K
PiA+ID4gDQo+ID4gPiBAQCAtNzMsMTMgKzczLDE3IEBAIGludCBkZXZfcG1fcHV0X3N1YnN5c19k
YXRhKHN0cnVjdCBkZXZpY2UgKmRldikNCj4gPiA+ICANCj4gPiA+ICAJaWYgKC0tcHNkLT5yZWZj
b3VudCA9PSAwKSB7DQo+ID4gPiAgCQlkZXYtPnBvd2VyLnN1YnN5c19kYXRhID0gTlVMTDsNCj4g
PiA+ICsJCXNwaW5fdW5sb2NrX2lycSgmZGV2LT5wb3dlci5sb2NrKTsNCj4gPiA+IC0JCWtmcmVl
KHBzZCk7DQo+ID4gPiAtIAkJcmV0ID0gMTsNCj4gPiA+ICsJCXJldHVybiAxOw0KPiA+ID4gIAl9
DQo+ID4gPiANCj4gPiA+IFdvdWxkIGJlIGNsZWFuZXIuDQo+ID4gDQo+ID4gV2hhdCBhYm91dCB0
aGlzOg0KPiANCj4gTG9va3MgZ29vZCB0byBtZS4NCj4gDQo+IFJldmlld2VkLWJ5OiBQYXZlbCBN
YWNoZWsgPHBhdmVsQHVjdy5jej4NCg0KUmFmYWVsL1BhdmVsLA0KDQpJIHJlZGlkIHRoZSBwYXRj
aCBiYXNlZCBvbiBQYXZlbCdzIGNvbW1lbnRzIGFuZCBqdXN0IGFib3V0IHRvIHNlbmQgaXQNCmFu
ZCB0aGVuIEkgc2F3IHlvdXIgZXhjaGFuZ2UuIFRoaXMgdmVyc2lvbiBsb29rcyBnb29kIHRvIG1l
LiBEbyB5b3Ugd2FudA0KbWUgdG8gdGVzdCB0aGUgcGF0Y2ggYW5kIHJlc2VuZD8NCg0KdGhhbmtz
LA0KLS0gU2h1YWgNCg==
