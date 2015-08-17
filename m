From: "Chen, Yu C" <yu.c.chen@intel.com>
Subject: Re: [PATCH] x86, suspend: Save/restore THERM_CONTROL register for
 suspend
Date: Mon, 17 Aug 2015 11:43:02 +0000
Message-ID: <1439811991.15722.26.camel@localhost>
References: <1439800192-3034-1-git-send-email-yu.c.chen@intel.com>
	 <20150817101115.GA27204@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:58461 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751073AbbHQLnP (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 17 Aug 2015 07:43:15 -0400
In-Reply-To: <20150817101115.GA27204@gmail.com>
Content-Language: en-US
Content-ID: <F39DC34F7104AB40B966BE0189D90A4A@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "mingo@kernel.org" <mingo@kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Zhang, Rui" <rui.zhang@intel.com>, "tglx@linutronix.de" <tglx@linutronix.de>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "pavel@ucw.cz" <pavel@ucw.cz>, "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "mingo@redhat.com" <mingo@redhat.com>

SGksIEluZ28sIHRoYW5rcyBmb3IgeW91ciByZXZpZXcsDQpPbiBNb24sIDIwMTUtMDgtMTcgYXQg
MTI6MTEgKzAyMDAsIEluZ28gTW9sbmFyIHdyb3RlOg0KPiBTbyB3aGF0IHlvdXIgY2hhbmdlbG9n
IGZhaWxzIHRvIG1lbnRpb246DQo+IA0KPiAgLSBZb3Ugb25seSBhZGQgdGhpcyBjb2RlIHRvIHRo
ZSA2NC1iaXQga2VybmVsLiBBcmUgMzItYml0IGtlcm5lbHMgbm90IGFmZmVjdGVkPw0KWWVzLCAz
Mi1iaXQga2VybmVsIHNob3VsZCBhbHNvIGRvIHRoZSBzYXZlL3Jlc3RvcmUgb3BlcmF0aW9uLiAN
CkknbGwgYWRqdXN0IHRoZW0gdG8gNjQvMzItYml0IGNvbW1vbiBwYXRoLiANCj4gDQo+ICAtIHRo
ZSBNU1IgcmVhZCBpcyBkb25lIHVuY29uZGl0aW9uYWxseS4gSXMgTVNSX0lBMzJfVEhFUk1fQ09O
VFJPTCBhdmFpbGFibGUNCj4gICAgYXJjaGl0ZWN0dXJhbGx5IGFuZCByZWFkYWJsZSAoYW5kIGhh
cyBzZW5zaWJsZSB2YWx1ZXMpIG9uIGFsbCA2NC1iaXQgY2FwYWJsZQ0KPiAgICB4ODYgQ1BVcyB0
aGF0IHJ1biB0aGlzIGNvZGUgcGF0aD8NCk1TUl9JQTMyX1RIRVJNX0NPTlRST0wgaXMgYXZhaWxh
YmxlIG9uIEludGVsIFBlbnRpdW0gNCwgWGVvbiwgUGVudGl1bSBNIGFuZCBsYXRlcg0KcHJvY2Vz
c29ycywgc28gSSB0aGluayBub3QgYWxsIHRoZSA2NC8zMi1iaXQgY2FwYWJsZSB4ODYgQ1BVcyBo
YXZlIHRoaXMNCnJlZ2lzdGVyLiBNYXliZSBjb2RlcyBsaWtlIHRoZSBmb2xsb3dpbmcgd291bGQg
YmUgbW9yZSByZWFzb25hYmxlPw0KDQpzYXZlOg0KY3R4dC0+Y2xvY2tfbW9kdWxhdGlvbl9zYXZl
ZCA9ICFyZG1zcmxfc2FmZShNU1JfSUEzMl9USEVSTV9DT05UUk9MLA0KCSZjdHh0LT5jbG9ja19t
b2R1bGF0aW9uKTsNCg0KcmVzdG9yZToNCmlmIChjdHh0LT5jbG9ja19tb2R1bGF0aW9uX3NhdmVk
KQ0KCXdybXNybChNU1JfSUEzMl9USEVSTV9DT05UUk9MLCBjdHh0LT5jbG9ja19tb2R1bGF0aW9u
KTsNCg0KVGhhbmtzIGEgbG90Lg0KDQpCZXN0IFJlZ2FyZHMsDQpZdQ0K
