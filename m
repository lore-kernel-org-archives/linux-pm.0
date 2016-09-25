From: "Chen, Yu C" <yu.c.chen@intel.com>
Subject: RE: [PATCH][v10] PM / hibernate: Verify the consistent of e820
 memory map by md5 digest
Date: Sun, 25 Sep 2016 03:44:03 +0000
Message-ID: <36DF59CE26D8EE47B0655C516E9CE6405E6161F6@shsmsx102.ccr.corp.intel.com>
References: <1473423687-4889-1-git-send-email-yu.c.chen@intel.com>
 <CAJZ5v0j0Vj9DSL0PH+quZAnO5Ns3CxxC2qncM4xHmjsNWehM1A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:5823 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965305AbcIYDoI (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 24 Sep 2016 23:44:08 -0400
In-Reply-To: <CAJZ5v0j0Vj9DSL0PH+quZAnO5Ns3CxxC2qncM4xHmjsNWehM1A@mail.gmail.com>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, the arch/x86 maintainers <x86@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, Pavel Machek <pavel@ucw.cz>, Lee Chun-Yi <jlee@suse.com>, Borislav Petkov <bp@alien8.de>

SGksDQpTb3JyeSBmb3IgbGF0ZSByZXNwb25zZSwgSSBtaXNzZWQgdGhlIHRocmVhZCBpbiBtYWls
Ym94LA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IHJqd3lzb2NraUBn
bWFpbC5jb20gW21haWx0bzpyand5c29ja2lAZ21haWwuY29tXSBPbiBCZWhhbGYgT2YNCj4gUmFm
YWVsIEouIFd5c29ja2kNCj4gU2VudDogTW9uZGF5LCBTZXB0ZW1iZXIgMTksIDIwMTYgNzo0NiBQ
TQ0KPiBUbzogQ2hlbiwgWXUgQw0KPiBDYzogTGludXggUE07IHRoZSBhcmNoL3g4NiBtYWludGFp
bmVyczsgTGludXggS2VybmVsIE1haWxpbmcgTGlzdDsgVGhvbWFzDQo+IEdsZWl4bmVyOyBJbmdv
IE1vbG5hcjsgSC4gUGV0ZXIgQW52aW47IFd5c29ja2ksIFJhZmFlbCBKOyBQYXZlbCBNYWNoZWs7
IExlZQ0KPiBDaHVuLVlpOyBCb3Jpc2xhdiBQZXRrb3YNCj4gU3ViamVjdDogUmU6IFtQQVRDSF1b
djEwXSBQTSAvIGhpYmVybmF0ZTogVmVyaWZ5IHRoZSBjb25zaXN0ZW50IG9mIGU4MjANCj4gbWVt
b3J5IG1hcCBieSBtZDUgZGlnZXN0DQo+IA0KPiBPbiBGcmksIFNlcCA5LCAyMDE2IGF0IDI6MjEg
UE0sIENoZW4gWXUgPHl1LmMuY2hlbkBpbnRlbC5jb20+IHdyb3RlOg0KPiA+IE9uIHNvbWUgcGxh
dGZvcm1zLCB0aGVyZSBpcyBvY2Nhc2lvbmFsIHBhbmljIHRyaWdnZXJlZCB3aGVuIHRyeWluZyB0
bw0KPiA+IHJlc3VtZSBmcm9tIGhpYmVybmF0aW9uLCBhIHR5cGljYWwgcGFuaWMgbG9va3MgbGlr
ZToNCj4gDQo+IFtjdXRdDQo+IA0KPiA+IEBAIC0yMTEsMTAgKzI5MiwxNSBAQCBpbnQgYXJjaF9o
aWJlcm5hdGlvbl9oZWFkZXJfc2F2ZSh2b2lkICphZGRyLA0KPiB1bnNpZ25lZCBpbnQgbWF4X3Np
emUpDQo+ID4gICAqLw0KPiA+ICBpbnQgYXJjaF9oaWJlcm5hdGlvbl9oZWFkZXJfcmVzdG9yZSh2
b2lkICphZGRyKSAgew0KPiA+ICsgICAgICAgYm9vbCBlODIwX21pc21hdGNoID0gZmFsc2U7DQo+
IA0KPiBUaGUgZXh0cmEgbG9jYWwgdmFyaWFibGUgY2FuIGJlIGF2b2lkZWQgaWYgeW91IHN0cnVj
dHVyZSB0aGUgY29kZSBzbGlnaHRseQ0KPiBkaWZmZXJlbnRseS4NCj4gDQo+ID4gICAgICAgICBz
dHJ1Y3QgcmVzdG9yZV9kYXRhX3JlY29yZCAqcmRyID0gYWRkcjsNCj4gPg0KPiA+ICAgICAgICAg
cmVzdG9yZV9qdW1wX2FkZHJlc3MgPSByZHItPmp1bXBfYWRkcmVzczsNCj4gPiAgICAgICAgIGp1
bXBfYWRkcmVzc19waHlzID0gcmRyLT5qdW1wX2FkZHJlc3NfcGh5czsNCj4gPiAgICAgICAgIHJl
c3RvcmVfY3IzID0gcmRyLT5jcjM7DQo+ID4gLSAgICAgICByZXR1cm4gKHJkci0+bWFnaWMgPT0g
UkVTVE9SRV9NQUdJQykgPyAwIDogLUVJTlZBTDsNCj4gPiArDQo+ID4gKyAgICAgICBlODIwX21p
c21hdGNoID0gaGliZXJuYXRpb25fZTgyMF9taXNtYXRjaChyZHItPmU4MjBfZGlnZXN0KTsNCj4g
DQo+IEFsc28gY2FsbGluZyBoaWJlcm5hdGlvbl9lODIwX21pc21hdGNoKCkgYmVmb3JlIGNoZWNr
aW5nIHJkci0+bWFnaWMgbWF5IG5vdA0KPiBiZSB1c2VmdWwgYXQgYWxsLg0KPiANClllcy4NCj4g
PiArDQo+ID4gKyAgICAgICByZXR1cm4gKHJkci0+bWFnaWMgPT0gUkVTVE9SRV9NQUdJQykgPw0K
PiA+ICsgICAgICAgICAgICAgICAoZTgyMF9taXNtYXRjaCA/IC1FTk9ERVYgOiAwKSA6IC1FSU5W
QUw7DQo+IA0KPiBTbyB3aGF0IGFib3V0Og0KPiANCj4gaWYgKHJkci0+bWFnaWMgIT0gUkVTVE9S
RV9NQUdJQykNCj4gICAgICAgICByZXR1cm4gLUVJTlZBTDsNCj4gDQo+IGlmIChoaWJlcm5hdGlv
bl9lODIwX21pc21hdGNoKHJkci0+ZTgyMF9kaWdlc3QpKQ0KPiAgICAgICAgIHJldHVybiAtRU5P
REVWOw0KPiANCj4gcmV0dXJuIDA7DQo+IA0KPiANCk9rLCB3aWxsIGNoYW5nZSBpdCB0byB0aGlz
IG9uZS4gVGhhbmtzLg0KPiA+ICB9DQo+ID4gLS0NCj4gDQo+IFRoYW5rcywNCj4gUmFmYWVsDQoN
Cg0KVGhhbmtzLA0KWXUNCg==
