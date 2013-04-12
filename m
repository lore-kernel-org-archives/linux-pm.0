From: =?euc-kr?B?x9S47cHW?= <myungjoo.ham@samsung.com>
Subject: Re: Re: [RESEND][PATCH 1/3] PM / devfreq: exynos4_bus: Fix missing
 mutex_unlock if opp_find_freq_floor fails
Date: Fri, 12 Apr 2013 11:52:00 +0000 (GMT)
Message-ID: <15500134.204421365767518757.JavaMail.weblogic@epv6ml01>
Reply-To: myungjoo.ham@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset=euc-kr
Content-Transfer-Encoding: base64
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:44668 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755366Ab3DLLwD (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 12 Apr 2013 07:52:03 -0400
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0ML5003N24YM7SU0@mailout2.samsung.com> for
 linux-pm@vger.kernel.org; Fri, 12 Apr 2013 20:52:00 +0900 (KST)
MIME-version: 1.0
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, Axel Lin <axel.lin@ingics.com>, =?euc-kr?Q?=B9=DA=B0=E6=B9=CE?= <kyungmin.park@samsung.com>, =?euc-kr?Q?=B1=E8=B1=B9=C1=F8?= <kgene.kim@samsung.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

PiBPbiBGcmlkYXksIEFwcmlsIDEyLCAyMDEzIDAxOjU0OjE4IFBNIEF4ZWwgTGluIHdyb3RlOg0K
PiA+IFdlIG5lZWQgdG8gY2FsbCBtdXRleF91bmxvY2soKSBpbiB0aGUgZXJyb3IgcGF0aC4NCj4g
PiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBBeGVsIExpbiA8YXhlbC5saW5AaW5naWNzLmNvbT4NCj4g
DQo+IEFsbCB0aHJlZSBwYXRjaGVzIGFwcGxpZWQgdG8gbGludXgtcG0uZ2l0L2xpbnV4LW5leHQu
DQo+IA0KPiBFeHlub3MgbWFpbnRhaW5lcnMsIGlmIHlvdSBoYXZlIGFueSBvYmplY3Rpb25zLCBw
bGVhc2UgaG9sbGVyLg0KPiANCj4gVGhhbmtzLA0KPiBSYWZhZWwNCg0KVGhpcyBwYXRjaCB3YXMg
aW5jbHVkZWQgaW4gdGhlIGxhc3QgcHVsbC1yZXF1ZXN0IHBhdGNoc2V0DQp0aG91Z2ggdGhlIHBh
dGggd2FzIHVwZGF0ZWQuIChpdHMgcHJlY2VkZXNzb3IgcGF0Y2ggbW92ZWQNCmV4eW5vcyBkcml2
ZXJzIHRvIC9kcml2ZXJzL2RldmZyZXEvZXh5bm9zLyogYWZ0ZXIgYWRkaW5nDQpFeHlub3MgY29t
bW9uIGRyaXZlciBmaWxlcykNCg0KDQpDaGVlcnMsDQpNeXVuZ0pvby4NCg0KPiANCj4gPiAtLS0N
Cj4gPiAgZHJpdmVycy9kZXZmcmVxL2V4eW5vczRfYnVzLmMgfCAgICAzICsrLQ0KPiA+ICAxIGZp
bGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4gDQo+ID4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvZGV2ZnJlcS9leHlub3M0X2J1cy5jIGIvZHJpdmVycy9kZXZmcmVx
L2V4eW5vczRfYnVzLmMNCj4gPiBpbmRleCAxZGVlZTA5Li41NGI5NjE1IDEwMDY0NA0KPiA+IC0t
LSBhL2RyaXZlcnMvZGV2ZnJlcS9leHlub3M0X2J1cy5jDQo+ID4gKysrIGIvZHJpdmVycy9kZXZm
cmVxL2V4eW5vczRfYnVzLmMNCj4gPiBAQCAtOTc0LDcgKzk3NCw4IEBAIHN0YXRpYyBpbnQgZXh5
bm9zNF9idXNmcmVxX3BtX25vdGlmaWVyX2V2ZW50KHN0cnVjdCBub3RpZmllcl9ibG9jayAqdGhp
cywNCj4gPiAgCQkJcmN1X3JlYWRfdW5sb2NrKCk7DQo+ID4gIAkJCWRldl9lcnIoZGF0YS0+ZGV2
LCAiJXM6IHVuYWJsZSB0byBmaW5kIGEgbWluIGZyZXFcbiIsDQo+ID4gIAkJCQlfX2Z1bmNfXyk7
DQo+ID4gLQkJCXJldHVybiBQVFJfRVJSKG9wcCk7DQo+ID4gKwkJCWVyciA9IFBUUl9FUlIob3Bw
KTsNCj4gPiArCQkJZ290byB1bmxvY2s7DQo+ID4gIAkJfQ0KPiA+ICAJCW5ld19vcHBpbmZvLnJh
dGUgPSBvcHBfZ2V0X2ZyZXEob3BwKTsNCj4gPiAgCQluZXdfb3BwaW5mby52b2x0ID0gb3BwX2dl
dF92b2x0YWdlKG9wcCk7DQo+ID4gDQo+IC0tIA0KPiBJIHNwZWFrIG9ubHkgZm9yIG15c2VsZi4N
Cj4gUmFmYWVsIEouIFd5c29ja2ksIEludGVsIE9wZW4gU291cmNlIFRlY2hub2xvZ3kgQ2VudGVy
Lg0KPiANCj4gDQo+IA0KPiAgICAgICAgDQo+ICAgDQo+ICAgICAgICAgIA0KPiANCg==


