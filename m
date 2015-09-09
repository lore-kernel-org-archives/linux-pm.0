From: "Chen, Yu C" <yu.c.chen@intel.com>
Subject: RE: [PATCH][rfc] intel_pstate: Fix user input of min/max to legal
 policy region
Date: Wed, 9 Sep 2015 02:15:00 +0000
Message-ID: <36DF59CE26D8EE47B0655C516E9CE6401D4A77CE@SHSMSX101.ccr.corp.intel.com>
References: <1439351359-29532-1-git-send-email-yu.c.chen@intel.com>
 <1972415.RSWZSVEEko@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:7819 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754510AbbIICP0 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 8 Sep 2015 22:15:26 -0400
In-Reply-To: <1972415.RSWZSVEEko@vostro.rjw.lan>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "kristen@linux.intel.com" <kristen@linux.intel.com>
Cc: "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Zhang, Rui" <rui.zhang@intel.com>, "lenb@kernel.org" <lenb@kernel.org>, Seiichi Ikarashi <s.ikarashi@jp.fujitsu.com>

SGkgLFJhZmFlbA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFJhZmFl
bCBKLiBXeXNvY2tpIFttYWlsdG86cmp3QHJqd3lzb2NraS5uZXRdDQo+IFNlbnQ6IFR1ZXNkYXks
IFNlcHRlbWJlciAwOCwgMjAxNSA1OjQ3IEFNDQo+IFRvOiBDaGVuLCBZdSBDOyBrcmlzdGVuQGxp
bnV4LmludGVsLmNvbQ0KPiBDYzogdmlyZXNoLmt1bWFyQGxpbmFyby5vcmc7IGxpbnV4LXBtQHZn
ZXIua2VybmVsLm9yZzsgbGludXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IFpoYW5nLCBS
dWk7IGxlbmJAa2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIXVtyZmNdIGludGVsX3Bz
dGF0ZTogRml4IHVzZXIgaW5wdXQgb2YgbWluL21heCB0byBsZWdhbA0KPiBwb2xpY3kgcmVnaW9u
DQo+IA0KPiBPbiBXZWRuZXNkYXksIEF1Z3VzdCAxMiwgMjAxNSAxMTo0OToxOSBBTSBDaGVuIFl1
IHdyb3RlOg0KPiA+IEluIGN1cnJlbnQgY29kZSwgaWYgc3lzdGVtIGlzIHVzaW5nIHBlcmZvcm1h
bmNlIHBvbGljeSwgdXNlciBjYW4NCj4gPiBtb2RpZnkgdGhlIG1heF9wZXJmX3BjdCB0byBhbnkg
dmFsdWVzIGxvd2VyIHRoYW4gMTAwOg0KPiA+DQo+ID4gJCBncmVwIC4gL3N5cy9kZXZpY2VzL3N5
c3RlbS9jcHUvaW50ZWxfcHN0YXRlL20qX3BlcmZfcGN0DQo+ID4gL3N5cy9kZXZpY2VzL3N5c3Rl
bS9jcHUvaW50ZWxfcHN0YXRlL21heF9wZXJmX3BjdDoxMDANCj4gPiAvc3lzL2RldmljZXMvc3lz
dGVtL2NwdS9pbnRlbF9wc3RhdGUvbWluX3BlcmZfcGN0OjEwMA0KPiA+DQo+ID4gJCBlY2hvIDgw
ID4gL3N5cy9kZXZpY2VzL3N5c3RlbS9jcHUvaW50ZWxfcHN0YXRlL21heF9wZXJmX3BjdA0KPiA+
DQo+ID4gJCBncmVwIC4gL3N5cy9kZXZpY2VzL3N5c3RlbS9jcHUvaW50ZWxfcHN0YXRlL20qX3Bl
cmZfcGN0DQo+ID4gL3N5cy9kZXZpY2VzL3N5c3RlbS9jcHUvaW50ZWxfcHN0YXRlL21heF9wZXJm
X3BjdDo4MA0KPiA+IC9zeXMvZGV2aWNlcy9zeXN0ZW0vY3B1L2ludGVsX3BzdGF0ZS9taW5fcGVy
Zl9wY3Q6MTAwDQo+ID4NCj4gPiB0aGUgbWF4X3BlcmZfcGN0IGFib3ZlIGlzIGxvd2VyIHRoYW4g
bWluX3BlcmZfcGN0LCB3aGljaCBpcyBub3QNCj4gPiByZWFzb25hYmxlLg0KPiA+DQo+ID4gVGhp
cyBwYXRjaCBzb2x2ZXMgdGhpcyBwcm9ibGVtIGJ5IGNsYW1waW5nIG1pbl9wZXJmX3BjdCBhbmQN
Cj4gPiBtYXhfcGVyZl9wY3QgdG8gYmUgc3RyaWN0bHkgaW5zaWRlIFttaW5fcG9saWN5X3BjdCxt
YXhfcG9saWN5X3BjdF0uDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBDaGVuIFl1IDx5dS5jLmNo
ZW5AaW50ZWwuY29tPg0KPiANCj4gTG9va3MgcmVhc29uYWJsZSB0byBtZS4NCj4gDQo+IEtyaXN0
ZW4sIGFueSBvYmplY3Rpb25zPw0KPiANClRoYW5rcyBmb3IgeW91ciByZXBseSEgDQpBY2NvcmRp
bmcgdG8gc3VnZ2VzdGlvbiBmcm9tICBTZWlpY2hpLCB3aWxsIHJlLXNlbmQgYSBWMiB2ZXJzaW9u
IHBhdGNoLA0KdG8gbWFrZSBzb21lIHVwZGF0ZS4NCg0KQmVzdCBSZWdhcmRzLA0KWXUgDQoNCg==
