From: "Liu, Chuansheng" <chuansheng.liu@intel.com>
Subject: RE: [PATCH V3] suspend: enable freeze timeout configuration through
 sys
Date: Fri, 1 Feb 2013 02:02:21 +0000
Message-ID: <27240C0AC20F114CBF8149A2696CBE4A2212E8@SHSMSX101.ccr.corp.intel.com>
References: <1359428300.3211.3.camel@fli24-HP-Compaq-8100-Elite-CMT-PC>
 <BEC9F67575FA1E429CA7CF5AE9BE36343F0D19@SHSMSX102.ccr.corp.intel.com>
 <CAK7N6vpdmLv-G3q-m9nbWs1jV-s=k9c4gQ-wKOZsMGZrm4AhVw@mail.gmail.com>
 <1503699.1Mx8Tt0bYE@vostro.rjw.lan>
 <BEC9F67575FA1E429CA7CF5AE9BE36343F0F00@SHSMSX102.ccr.corp.intel.com>
 <510B20B5.20900@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:24407 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751650Ab3BACC1 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 31 Jan 2013 21:02:27 -0500
In-Reply-To: <510B20B5.20900@jp.fujitsu.com>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>, "Li, Fei" <fei.li@intel.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, anish singh <anish198519851985@gmail.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

PiA+Pj4+Pj4gLSNkZWZpbmUgVElNRU9VVCAgICAoMjAgKiBIWikNCj4gPj4+Pj4+ICt1bnNpZ25l
ZCBpbnQgX19yZWFkX21vc3RseSBzeXNfZnJlZXplX3Byb2Nlc3NfdGltZW91dF9tc2VjcyA9DQo+
ID4+IDIwMDAwOw0KPiA+Pj4+Pg0KPiA+Pj4+PiAyMDAwMCBkb2VzIG5vdCBtZWFuIDIwIHNlY29u
ZHMgc2luY2Ugd2UgY2FuIHNlbGVjdCBIWiBvdGhlciB0aGFuDQo+IDEwMDAuDQo+ID4+Pj4+IFNv
ICgyMCAqIEhaKSBpcyBiZXR0ZXIgdGhhbiAyMDAwMC4NCj4gPj4+Pj4NCj4gPj4+PiBbTGksIEZl
aV0NCj4gPj4+PiBBcmUgeW91IHN1cmUgYWJvdXQgdGhpcywgKDIwKkhaKSBiZXR0ZXIgdGhhbiAy
MDAwMCwgb3IgeW91IG1lYW4gMjAgKg0KPiA+PiBNU0VDX1BFUl9TRUM/DQo+ID4+PiBZYXN1YWtp
ICBtZWFuIEhaIHZhbHVlIHdpbGwgbm90IGFsd2F5cyBiZSAxMDAwLlRoZSB2YWx1ZSBvZiBIWiBk
aWZmZXJzIGZvcg0KPiA+PiBlYWNoDQo+ID4+PiAgIHN1cHBvcnRlZCBhcmNoaXRlY3R1cmUuIElu
IGZhY3QsIG9uIHNvbWUgc3VwcG9ydGVkIGFyY2hpdGVjdHVyZXMsDQo+ID4+PiBpdCBldmVuIGRp
ZmZlcnMgYmV0d2VlbiBtYWNoaW5lIHR5cGVzLg0KPiA+Pj4gV2hlbiB3cml0aW5nIGtlcm5lbCBj
b2RlLCBuZXZlciBhc3N1bWUgdGhhdCBIWiBoYXMgYW55IGdpdmVuIHZhbHVlLg0KPiA+Pj4gUmln
aHQgbm93IHlvdSBhcmUgYXNzdW1pbmcgdGhhdCB0aGUgZGVsYXkgd2lsbCBiZSBhbHdheXMgMjAg
c2Vjb25kcw0KPiBiZWNhdXNlDQo+ID4+IG9mDQo+ID4+PiB5b3VyIGFzc3VtcHRpb24gb2YgSFou
DQo+ID4+DQo+ID4+IFRoYXQncyBjb3JyZWN0LCB0aGUgaW5pdGlhbCB2YWx1ZSBzaG91bGQgYmUg
MjAgKiBIWiAoaS5lLiBhcyBiZWZvcmUpLg0KPiA+IFtMaSwgRmVpXQ0KPiA+IFllcywgeW91IGFy
ZSByaWdodCwgYW5kIElNSE8gaXQncyBhbHJlYWR5IGFzIHRoaXMgaW4gdGhlIHBhdGNoLA0KPiA+
IGFzIDIwICogSFogPT0gbXNlY3NfdG9famlmZmllcygyMDAwMCksIHdpdGggdGhlIGN1cnJlbnQg
ZGVmaW5pdGlvbg0KPiBNU0VDX1BFUl9TRUMNCj4gPiBvZiAxMDAwTC4gSSdsbCB1cGRhdGUgdGhl
IGRlZmF1bHQgdmFsdWUgYXMgMjAgKiBNU0VDX1BFUl9TRUMgaW4gcGF0Y2ggVjQuDQo+IA0KPiAy
MCAqIE1TRUNfUEVSX1NFQyBpcyBub3QgMjAgc2Vjb25kcy4gSW4gTGludXgsIDEgKiBIWiBpcyAx
IHNlY29uZHMuDQpTdXJlLg0KDQo+IFRodXMsDQo+ICAgLSBJZiBIWiBpcyBkZWZpbmVkIGFzIDEw
MDAsIDEwMDAgaXMgMSBzZWNvbmRzLg0KPiAgIC0gSWYgSFogaXMgZGVmaW5lZCBhcyAyNTAsIDI1
MCBpcyAxIHNlY29uZHMuDQo+IA0KPiAyMCAqIE1TRUNfUEVSX1NFQyBpcyBhbHdheXMgMjAwMDAu
DQoNCj4gVGh1cywNCj4gICAtIElmIEhaIGlzIGRlZmluZWQgYXMgMTAwMCwgMjAgKiBNU0VDX1BF
Ul9TRUMgaXMgMjAgc2Vjb25kcy4NCj4gICAtIElmIEhaIGlzIGRlZmluZWQgYXMgMjUwLCAyMCAq
IE1TRUNfUEVSX1NFQyBpcyA4MCBzZWNvbmRzLg0KQ291bGQgeW91IGNoZWNrIHRoZSBwYXRjaCBh
Z2Fpbj8NClRoZSBwYXRjaCBhcmUgdXNpbmcgbXNlY3NfdG9famlmZmllcygyMCAqIE1TRUNfUEVS
X1NFQyksIG5vdCAyMCAqIE1TRUNfUEVSX1NFQy4NCm1zZWNzX3RvX2ppZmZpZXMoKSBoYXMgZG9u
ZSB0aGUgY29udmVyc2lvbiBmcm9tIE1TRUNfUEVSX1NFQyB0byBIWi4NCg0KPiANCj4gU28geW91
IHNob3VsZCB1c2UgMjAgKiBIWiBpZiB5b3UgZGVmaW5lIHRpbWVvdXQgYXQgMjAgc2Vjb25kcy4N
Cj4gDQo+IFRoYW5rcywNCj4gWWFzdWFraSBJc2hpbWF0c3UuDQoNCg==
