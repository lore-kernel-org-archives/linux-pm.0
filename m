From: Shuah Khan <shuah.kh@samsung.com>
Subject: Re: [PATCH] PM: Fix dev_pm_put_subsys_data() to not call kfree()
 while holding device power lock
Date: Mon, 6 May 2013 19:10:47 +0000
Message-ID: <1367867448.2953.52.camel@lorien>
References: <1367614010.8452.2.camel@lorien>
	 <20130504125116.GA13770@amd.pavel.ucw.cz>
	 <1882177.s6zpHZ6crc@vostro.rjw.lan>
	 <20130506120925.GA25542@amd.pavel.ucw.cz> <1367848858.2953.1.camel@lorien>
Reply-To: Shuah Khan <shuah.kh@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.sisa.samsung.com ([63.166.156.249]:58056 "EHLO
	mx1.sisa.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755573Ab3EFTKu (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 6 May 2013 15:10:50 -0400
In-Reply-To: <1367848858.2953.1.camel@lorien>
Content-Language: en-US
Content-ID: <73C7366FA079764D84C1949EDE0B10DC@sisa.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, "len.brown@intel.com" <len.brown@intel.com>, "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "shuahkhan@gmail.com" <shuahkhan@gmail.com>

T24gTW9uLCAyMDEzLTA1LTA2IGF0IDA4OjAwIC0wNjAwLCBTaHVhaCBLaGFuIHdyb3RlOg0KPiBP
biBNb24sIDIwMTMtMDUtMDYgYXQgMTQ6MDkgKzAyMDAsIFBhdmVsIE1hY2hlayB3cm90ZToNCj4g
PiBIaSENCj4gPiANCj4gPiA+ID4gV293LCB0aGF0IGZ1bmN0aW9uIGlzIGZyYWdpbGUuIEl0IHJl
dHVybnMgMC8xLy1FSU5WQUwsIHdoaWxlIGJlaW5nDQo+ID4gPiA+IGRvY3VtZW50ZWQgZm9yIDAv
MS4uLg0KPiA+ID4gDQo+ID4gPiBPaCwgaXQgZ2VuZXJhbGx5IHNob3VsZCByZXR1cm4gMSBmb3Ig
IXBzZC4NCj4gPiA+IA0KPiA+ID4gPiBQYXRjaCBkb2VzIG5vdCBsb29rIG9idmlvdXNseSB3cm9u
ZywgYnV0IG1heWJlIA0KPiA+ID4gPiANCj4gPiA+ID4gQEAgLTczLDEzICs3MywxNyBAQCBpbnQg
ZGV2X3BtX3B1dF9zdWJzeXNfZGF0YShzdHJ1Y3QgZGV2aWNlICpkZXYpDQo+ID4gPiA+ICANCj4g
PiA+ID4gIAlpZiAoLS1wc2QtPnJlZmNvdW50ID09IDApIHsNCj4gPiA+ID4gIAkJZGV2LT5wb3dl
ci5zdWJzeXNfZGF0YSA9IE5VTEw7DQo+ID4gPiA+ICsJCXNwaW5fdW5sb2NrX2lycSgmZGV2LT5w
b3dlci5sb2NrKTsNCj4gPiA+ID4gLQkJa2ZyZWUocHNkKTsNCj4gPiA+ID4gLSAJCXJldCA9IDE7
DQo+ID4gPiA+ICsJCXJldHVybiAxOw0KPiA+ID4gPiAgCX0NCj4gPiA+ID4gDQo+ID4gPiA+IFdv
dWxkIGJlIGNsZWFuZXIuDQo+ID4gPiANCj4gPiA+IFdoYXQgYWJvdXQgdGhpczoNCj4gPiANCj4g
PiBMb29rcyBnb29kIHRvIG1lLg0KPiA+IA0KPiA+IFJldmlld2VkLWJ5OiBQYXZlbCBNYWNoZWsg
PHBhdmVsQHVjdy5jej4NCj4gDQo+IFJhZmFlbC9QYXZlbCwNCj4gDQo+IEkgcmVkaWQgdGhlIHBh
dGNoIGJhc2VkIG9uIFBhdmVsJ3MgY29tbWVudHMgYW5kIGp1c3QgYWJvdXQgdG8gc2VuZCBpdA0K
PiBhbmQgdGhlbiBJIHNhdyB5b3VyIGV4Y2hhbmdlLiBUaGlzIHZlcnNpb24gbG9va3MgZ29vZCB0
byBtZS4gRG8geW91IHdhbnQNCj4gbWUgdG8gdGVzdCB0aGUgcGF0Y2ggYW5kIHJlc2VuZD8NCj4g
DQo+IHRoYW5rcywNCj4gLS0gU2h1YWgNCg0KSSBzZW50IHYyIHBhdGNoIHRoYXQgaW5jb3Jwb3Jh
dGVzIHRoZSBjb21tZW50cyBmcm9tIFJhZmFlbCBhbmQgUGF2ZWwuDQoNCnRoYW5rcywNCg0KLS0g
U2h1YWgNCg0KU2h1YWggS2hhbiBMZWFkIEtlcm5lbCBEZXZlbG9wZXIgLSBPcGVuIFNvdXJjZSBH
cm91cCANClNhbXN1bmcgUmVzZWFyY2ggQW1lcmljYSAoU2lsaWNvbiBWYWxsZXkpDQpzaHVhaC5r
aEBzYW1zdW5nLmNvbSB8ICg5NzApIDY3Mi0wNjU4DQo=
