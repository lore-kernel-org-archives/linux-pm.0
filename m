From: "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
Subject: Re: [PATCH] cpufreq: intel_pstate: Check cpuid for MSR_HWP_INTERRUPT
Date: Tue, 19 Jul 2016 23:40:50 +0000
Message-ID: <1468971545.4150.10.camel@intel.com>
References: <1468971284-17686-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:32156 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752406AbcGSXkw (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 19 Jul 2016 19:40:52 -0400
In-Reply-To: <1468971284-17686-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Content-Language: en-US
Content-ID: <947BD01EF8B2D74BAC55992CD016942E@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "rjw@rjwysocki.net" <rjw@rjwysocki.net>
Cc: "spandruv@spandruv-mobl.jf.intel.com" <spandruv@spandruv-mobl.jf.intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

DQpPbiBUdWUsIDIwMTYtMDctMTkgYXQgMTY6MzQgLTA3MDAsIFNyaW5pdmFzIFBhbmRydXZhZGEg
d3JvdGU6DQo+IEZyb206IHNwYW5kcnV2IDxzcGFuZHJ1dkBzcGFuZHJ1di1tb2JsLmpmLmludGVs
LmNvbT4NCj4gDQpQbGVhc2UgaWdub3JlIHRoaXMgcGF0Y2guIFRyaWVkIGZyb20gd3JvbmcgY29t
cHV0ZXIuDQoNCg0KDQo+IFRoZSBNU1IgTVNSX0hXUF9JTlRFUlJVUFQgaXMgdmFsaWQgb25seSB3
aGVuIENQVUlELjA2SDpFQVhbOF0gPSAxLCBzbw0KPiBjaGVjayBmb3IgZmVhdHVyZSBiZWZvcmUg
YWNjZXNzaW5nIHRoaXMgTVNSLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogc3BhbmRydXYgPHNwYW5k
cnV2QHNwYW5kcnV2LW1vYmwuamYuaW50ZWwuY29tPg0KPiAtLS0NCj4gwqBkcml2ZXJzL2NwdWZy
ZXEvaW50ZWxfcHN0YXRlLmMgfCA0ICsrKy0NCj4gwqAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRp
b25zKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9jcHVmcmVx
L2ludGVsX3BzdGF0ZS5jDQo+IGIvZHJpdmVycy9jcHVmcmVxL2ludGVsX3BzdGF0ZS5jDQo+IGlu
ZGV4IDJmZTlhZjEuLjcxMmFmYmQgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvY3B1ZnJlcS9pbnRl
bF9wc3RhdGUuYw0KPiArKysgYi9kcml2ZXJzL2NwdWZyZXEvaW50ZWxfcHN0YXRlLmMNCj4gQEAg
LTgyMiw4ICs4MjIsMTAgQEAgc3RhdGljIHZvaWQgX19pbml0DQo+IGludGVsX3BzdGF0ZV9zeXNm
c19leHBvc2VfcGFyYW1zKHZvaWQpDQo+IMKgDQo+IMKgc3RhdGljIHZvaWQgaW50ZWxfcHN0YXRl
X2h3cF9lbmFibGUoc3RydWN0IGNwdWRhdGEgKmNwdWRhdGEpDQo+IMKgew0KPiArDQo+IMKgCS8q
IEZpcnN0IGRpc2FibGUgSFdQIG5vdGlmaWNhdGlvbiBpbnRlcnJ1cHQgYXMgd2UgZG9uJ3QNCj4g
cHJvY2VzcyB0aGVtICovDQo+IC0Jd3Jtc3JsX29uX2NwdShjcHVkYXRhLT5jcHUsIE1TUl9IV1Bf
SU5URVJSVVBULCAweDAwKTsNCj4gKwlpZiAoc3RhdGljX2NwdV9oYXMoWDg2X0ZFQVRVUkVfSFdQ
X05PVElGWSkpDQo+ICsJCXdybXNybF9vbl9jcHUoY3B1ZGF0YS0+Y3B1LCBNU1JfSFdQX0lOVEVS
UlVQVCwNCj4gMHgwMCk7DQo+IMKgDQo+IMKgCXdybXNybF9vbl9jcHUoY3B1ZGF0YS0+Y3B1LCBN
U1JfUE1fRU5BQkxFLCAweDEpOw0KPiDCoH0=
