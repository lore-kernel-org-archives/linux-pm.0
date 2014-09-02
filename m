From: Yuantian Tang <Yuantian.Tang@freescale.com>
Subject: RE: [PATCH 2/2] cpufreq: ppc-corenet: remove per-cpu variable
 'cpu_mask'
Date: Tue, 2 Sep 2014 08:08:17 +0000
Message-ID: <e53a6d0e067e4d1f85f95891031cf989@BY2PR03MB570.namprd03.prod.outlook.com>
References: <09092df3d8b03df99ee475357c5f5c9cc439c61c.1409629117.git.viresh.kumar@linaro.org>
	<3d467a39ab1b96dc24ed8a71139d5e030239477f.1409629117.git.viresh.kumar@linaro.org>
	<6a145a322bd64e14a2d94e8c40151bbe@BY2PR03MB570.namprd03.prod.outlook.com>
	<CAKohpokQo=Jqgj2CzTH41WbD6F1GpdhksWdg0dm8WLN_CT5KkA@mail.gmail.com>
	<9fde1bf81522480484897416019b0ee9@BY2PR03MB570.namprd03.prod.outlook.com>
 <CAKohpo=skCssnm0AZi2rMDUTKg0Xo0p9Sz0KwO1iuapLks=nyg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-bn1lp0145.outbound.protection.outlook.com ([207.46.163.145]:1871
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750778AbaIBIIV (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 2 Sep 2014 04:08:21 -0400
In-Reply-To: <CAKohpo=skCssnm0AZi2rMDUTKg0Xo0p9Sz0KwO1iuapLks=nyg@mail.gmail.com>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Hongbo Zhang <hongbo.zhang@freescale.com>, "LeoLi@freescale.com" <LeoLi@freescale.com>

SWYgcG9saWN5LT5jcHVzIGlzIHNhbWUgZm9yIGFsbCBjcHVzIGluIGEgY2x1c3RlciB0aGF0IHNo
b3VsZCBub3QgYmUgYSBwcm9ibGVtLg0KUHJvYmFibHkgdGhlcmUncyBzb21ldGhpbmcgZWxzZSB0
aGF0IG5lZWQgdG8gY2hlY2suDQpJIGhhdmUgZmVlbGluZ3MgdGhhdCB5b3VyIHBhdGNoIG1heSBu
b3QgYmUgY29ycmVjdC4gSSBob3BlIGl0IHdvcmtzIHRob3VnaC4NCg0KVGhhbmtzLA0KWXVhbnRp
YW4NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBWaXJlc2ggS3VtYXIg
W21haWx0bzp2aXJlc2gua3VtYXJAbGluYXJvLm9yZ10NCj4gU2VudDogVHVlc2RheSwgU2VwdGVt
YmVyIDAyLCAyMDE0IDM6MTAgUE0NCj4gVG86IFRhbmcgWXVhbnRpYW4tQjI5OTgzDQo+IENjOiBS
YWZhZWwgV3lzb2NraTsgbGluYXJvLWtlcm5lbEBsaXN0cy5saW5hcm8ub3JnOyBsaW51eC1wbUB2
Z2VyLmtlcm5lbC5vcmc7DQo+IFpoYW5nIEhvbmdiby1CNDU5Mzk7IExpIFlhbmctTGVvLVI1ODQ3
Mg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDIvMl0gY3B1ZnJlcTogcHBjLWNvcmVuZXQ6IHJlbW92
ZSBwZXItY3B1IHZhcmlhYmxlDQo+ICdjcHVfbWFzaycNCj4gDQo+IE9uIDIgU2VwdGVtYmVyIDIw
MTQgMTI6MzIsIFl1YW50aWFuIFRhbmcgPFl1YW50aWFuLlRhbmdAZnJlZXNjYWxlLmNvbT4NCj4g
d3JvdGU6DQo+ID4gSSBhbSBzYXlpbmcgeW91ciBwYXRjaCAyIHByb2JhYmx5IGlzIHdyb25nLCBu
b3QgcGF0Y2ggMS4NCj4gDQo+IE9rYXksIGl0IGxvb2tlZCBpbml0aWFsbHkgdGhhdCBib3RoIGFy
ZSBzY3Jld2VkIHVwIDopDQo+IA0KPiA+IENvbnNpZGVyIGZvbGxvd2luZyBjYXNlOg0KPiA+IE9u
IFQ0MjQwIHBsYXRmb3JtLCB3ZSBoYXZlIDMgY2x1c3RlciB3aXRoIDggY3B1IGluIGVhY2ggY2x1
c3Rlci4NCj4gPiBXZSBvZmZsaW5lIDQgNSA2IDcgY3B1IGFuZCB0aGVuIG9ubGluZSB0aGVtIGJh
Y2suDQo+IA0KPiBpLmUuIGxhc3QgZm91ciBDUFVzIG9mIGZpcnN0IGNsdXN0ZXIuLg0KPiANCj4g
PiBDcHUgNCdzIHBvbGljeS0+Y3B1cyBpcyAwLCAxLCAyLCAzLCA0DQo+ID4gQ3B1IDUncyBwb2xp
Y3ktPmNwdXMgaXMgMCwgMSwgMiwgMywgNCwgNS4NCj4gDQo+IEhvdz8gQW5kIGhvdyBpcyB0aGlz
IHBhdGNoIGdvaW5nIHRvIHRvdWNoIHBvbGljeS0+Y3B1cz8NCj4gQ1BVIDAtNyBzaG91bGQgYmUg
c2hhcmluZyBhIHNpbmdsZSAnc3RydWN0IGNwdWZyZXFfcG9saWN5Jw0KPiBhbmQgc28gcG9saWN5
LT5jcHVzIHNob3VsZCBiZSBzYW1lIGZvciBhbGwuLg0K
