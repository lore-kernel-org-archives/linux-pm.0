From: "Chen, Yu C" <yu.c.chen@intel.com>
Subject: RE: [PATCH 2/3] Thermal: handle thermal zone device properly during
 system sleep
Date: Mon, 28 Sep 2015 17:36:33 +0000
Message-ID: <36DF59CE26D8EE47B0655C516E9CE64026F22613@SHSMSX101.ccr.corp.intel.com>
References: <1443332915-13988-1-git-send-email-yu.c.chen@intel.com>
 <20150928142847.GA8796@e104805>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:57450 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933540AbbI1Rgy (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 28 Sep 2015 13:36:54 -0400
In-Reply-To: <20150928142847.GA8796@e104805>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Javi Merino <javi.merino@arm.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "edubezval@gmail.com" <edubezval@gmail.com>, "Zhang, Rui" <rui.zhang@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>

SGksIEphdmkNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKYXZpIE1l
cmlubyBbbWFpbHRvOmphdmkubWVyaW5vQGFybS5jb21dDQo+IFNlbnQ6IE1vbmRheSwgU2VwdGVt
YmVyIDI4LCAyMDE1IDEwOjI5IFBNDQo+IFRvOiBDaGVuLCBZdSBDDQo+IENjOiBsaW51eC1wbUB2
Z2VyLmtlcm5lbC5vcmc7IGVkdWJlenZhbEBnbWFpbC5jb207IFpoYW5nLCBSdWk7IGxpbnV4LQ0K
PiBrZXJuZWxAdmdlci5rZXJuZWwub3JnOyBzdGFibGVAdmdlci5rZXJuZWwub3JnDQo+IFN1Ympl
Y3Q6IFJlOiBbUEFUQ0ggMi8zXSBUaGVybWFsOiBoYW5kbGUgdGhlcm1hbCB6b25lIGRldmljZSBw
cm9wZXJseQ0KPiBkdXJpbmcgc3lzdGVtIHNsZWVwDQo+IA0KPiBPbiBTdW4sIFNlcCAyNywgMjAx
NSBhdCAwNjo0ODozNUFNICswMTAwLCBDaGVuIFl1IHdyb3RlOg0KPiA+IEZyb206IFpoYW5nIFJ1
aSA8cnVpLnpoYW5nQGludGVsLmNvbT4NCj4gPg0KPiA+DQo+ID4gKwlyZWdpc3Rlcl9wbV9ub3Rp
ZmllcigmdGhlcm1hbF9wbV9uYik7DQo+IA0KPiBXaGF0IGlmIHJlZ2lzdGVyX3BtX25vdGlmaWVy
KCkgZmFpbHM/ICBJdCBjYW4ndCBmYWlsIG5vdywgYnV0IHRoYXQgbWF5IGluIHRoZQ0KPiBmdXR1
cmUuICBJZiB3ZSBmYWlsIHRvIHJlZ2lzdGVyIHRoZXJtYWwgd2hlbiB3ZSBjYW4ndCByZWdpc3Rl
ciB0aGUgZ2VuZXRsaW5rDQo+IGZhbWlseSwgbWF5YmUgd2Ugc2hvdWxkIGFsc28gZmFpbCB0byBy
ZWdpc3RlciB0aGVybWFsIGlmIHdlIGZhaWwgdG8gcmVnaXN0ZXIgdGhlDQo+IHBtIG5vdGlmaWVy
LCBkb24ndCB5b3UgdGhpbms/DQo+IA0KVGhpcyBwbSBub3RpZmllciBpcyBtYWlubHkgdXNlZCBm
b3Igc3VzcGVuZGluZyBzaXR1YXRpb24sIGJ1dCBpdCdzIG5vdCBzbyAnY3JpdGljYWwnIA0KdG8g
dGVybWluYXRlIHRoZSBpbml0aWFsaXphdGlvbiBvZiB0aGVybWFsIGNvcmUgaWYgaXQgZmFpbGVk
LCBJTU8uIA0KSGksIFJ1aSwgd2hhdCBkbyB5b3UgdGhpbms/IFRoeA0KDQpCZXN0IFJlZ2FyZHMs
DQpZdQ0K
