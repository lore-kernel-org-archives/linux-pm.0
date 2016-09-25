From: "Chen, Yu C" <yu.c.chen@intel.com>
Subject: RE: [PATCH][v10] PM / hibernate: Verify the consistent of e820
 memory map by md5 digest
Date: Sun, 25 Sep 2016 03:41:43 +0000
Message-ID: <36DF59CE26D8EE47B0655C516E9CE6405E6161D0@shsmsx102.ccr.corp.intel.com>
References: <1473423687-4889-1-git-send-email-yu.c.chen@intel.com>
 <CAJZ5v0j0Vj9DSL0PH+quZAnO5Ns3CxxC2qncM4xHmjsNWehM1A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:54963 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1032943AbcIYDlr (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 24 Sep 2016 23:41:47 -0400
In-Reply-To: <CAJZ5v0j0Vj9DSL0PH+quZAnO5Ns3CxxC2qncM4xHmjsNWehM1A@mail.gmail.com>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, the arch/x86 maintainers <x86@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, Pavel Machek <pavel@ucw.cz>, Lee Chun-Yi <jlee@suse.com>, Borislav Petkov <bp@alien8.de>

SGksDQpTb3JyeSBmb3IgbGF0ZSByZXNwb25zZSwgSSBtaXNzZWQgdGhpcyB0aHJlYWQgaW4gbWFp
bGJveCwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiByand5c29ja2lA
Z21haWwuY29tIFttYWlsdG86cmp3eXNvY2tpQGdtYWlsLmNvbV0gT24gQmVoYWxmIE9mDQo+IFJh
ZmFlbCBKLiBXeXNvY2tpDQo+IFNlbnQ6IE1vbmRheSwgU2VwdGVtYmVyIDE5LCAyMDE2IDc6NDYg
UE0NCj4gVG86IENoZW4sIFl1IEMNCj4gQ2M6IExpbnV4IFBNOyB0aGUgYXJjaC94ODYgbWFpbnRh
aW5lcnM7IExpbnV4IEtlcm5lbCBNYWlsaW5nIExpc3Q7IFRob21hcw0KPiBHbGVpeG5lcjsgSW5n
byBNb2xuYXI7IEguIFBldGVyIEFudmluOyBXeXNvY2tpLCBSYWZhZWwgSjsgUGF2ZWwgTWFjaGVr
OyBMZWUNCj4gQ2h1bi1ZaTsgQm9yaXNsYXYgUGV0a292DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hd
W3YxMF0gUE0gLyBoaWJlcm5hdGU6IFZlcmlmeSB0aGUgY29uc2lzdGVudCBvZiBlODIwDQo+IG1l
bW9yeSBtYXAgYnkgbWQ1IGRpZ2VzdA0KPiANCj4gT24gRnJpLCBTZXAgOSwgMjAxNiBhdCAyOjIx
IFBNLCBDaGVuIFl1IDx5dS5jLmNoZW5AaW50ZWwuY29tPiB3cm90ZToNCj4gPiBPbiBzb21lIHBs
YXRmb3JtcywgdGhlcmUgaXMgb2NjYXNpb25hbCBwYW5pYyB0cmlnZ2VyZWQgd2hlbiB0cnlpbmcg
dG8NCj4gPiByZXN1bWUgZnJvbSBoaWJlcm5hdGlvbiwgYSB0eXBpY2FsIHBhbmljIGxvb2tzIGxp
a2U6DQo+IA0KPiBbY3V0XQ0KPiANCj4gPiBAQCAtMjExLDEwICsyOTIsMTUgQEAgaW50IGFyY2hf
aGliZXJuYXRpb25faGVhZGVyX3NhdmUodm9pZCAqYWRkciwNCj4gdW5zaWduZWQgaW50IG1heF9z
aXplKQ0KPiA+ICAgKi8NCj4gPiAgaW50IGFyY2hfaGliZXJuYXRpb25faGVhZGVyX3Jlc3RvcmUo
dm9pZCAqYWRkcikgIHsNCj4gPiArICAgICAgIGJvb2wgZTgyMF9taXNtYXRjaCA9IGZhbHNlOw0K
PiANCj4gVGhlIGV4dHJhIGxvY2FsIHZhcmlhYmxlIGNhbiBiZSBhdm9pZGVkIGlmIHlvdSBzdHJ1
Y3R1cmUgdGhlIGNvZGUgc2xpZ2h0bHkNCj4gZGlmZmVyZW50bHkuDQo+IA0KPiA+ICAgICAgICAg
c3RydWN0IHJlc3RvcmVfZGF0YV9yZWNvcmQgKnJkciA9IGFkZHI7DQo+ID4NCj4gPiAgICAgICAg
IHJlc3RvcmVfanVtcF9hZGRyZXNzID0gcmRyLT5qdW1wX2FkZHJlc3M7DQo+ID4gICAgICAgICBq
dW1wX2FkZHJlc3NfcGh5cyA9IHJkci0+anVtcF9hZGRyZXNzX3BoeXM7DQo+ID4gICAgICAgICBy
ZXN0b3JlX2NyMyA9IHJkci0+Y3IzOw0KPiA+IC0gICAgICAgcmV0dXJuIChyZHItPm1hZ2ljID09
IFJFU1RPUkVfTUFHSUMpID8gMCA6IC1FSU5WQUw7DQo+ID4gKw0KPiA+ICsgICAgICAgZTgyMF9t
aXNtYXRjaCA9IGhpYmVybmF0aW9uX2U4MjBfbWlzbWF0Y2gocmRyLT5lODIwX2RpZ2VzdCk7DQo+
IA0KPiBBbHNvIGNhbGxpbmcgaGliZXJuYXRpb25fZTgyMF9taXNtYXRjaCgpIGJlZm9yZSBjaGVj
a2luZyByZHItPm1hZ2ljIG1heSBub3QNCj4gYmUgdXNlZnVsIGF0IGFsbC4NClllcy4NCj4gDQo+
ID4gKw0KPiA+ICsgICAgICAgcmV0dXJuIChyZHItPm1hZ2ljID09IFJFU1RPUkVfTUFHSUMpID8N
Cj4gPiArICAgICAgICAgICAgICAgKGU4MjBfbWlzbWF0Y2ggPyAtRU5PREVWIDogMCkgOiAtRUlO
VkFMOw0KPiANCj4gU28gd2hhdCBhYm91dDoNCj4gDQo+IGlmIChyZHItPm1hZ2ljICE9IFJFU1RP
UkVfTUFHSUMpDQo+ICAgICAgICAgcmV0dXJuIC1FSU5WQUw7DQo+IA0KPiBpZiAoaGliZXJuYXRp
b25fZTgyMF9taXNtYXRjaChyZHItPmU4MjBfZGlnZXN0KSkNCj4gICAgICAgICByZXR1cm4gLUVO
T0RFVjsNCj4gDQo+IHJldHVybiAwOw0KPiANCk9LLCB3aWxsIGNoYW5nZSBpdCB0byB0aGlzIG9u
ZS4gVGhhbmtzIQ0KPiA+ICB9DQo+ID4gLS0NCj4gDQo+IFRoYW5rcywNCj4gUmFmYWVsDQoNClRo
YW5rcywNCll1DQo=
