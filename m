From: "Chen, Yu C" <yu.c.chen@intel.com>
Subject: RE: [PATCH 3/3] Thermal: do thermal zone update after a cooling
 device registered
Date: Mon, 28 Sep 2015 17:52:00 +0000
Message-ID: <36DF59CE26D8EE47B0655C516E9CE64026F22641@SHSMSX101.ccr.corp.intel.com>
References: <1443332924-14028-1-git-send-email-yu.c.chen@intel.com>
 <20150928142902.GA9175@e104805>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:24076 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757357AbbI1RwL (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 28 Sep 2015 13:52:11 -0400
In-Reply-To: <20150928142902.GA9175@e104805>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Javi Merino <javi.merino@arm.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "edubezval@gmail.com" <edubezval@gmail.com>, "Zhang, Rui" <rui.zhang@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>

SGksIEphdmksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSmF2aSBN
ZXJpbm8gW21haWx0bzpqYXZpLm1lcmlub0Bhcm0uY29tXQ0KPiBTZW50OiBNb25kYXksIFNlcHRl
bWJlciAyOCwgMjAxNSAxMDoyOSBQTQ0KPiBUbzogQ2hlbiwgWXUgQw0KPiBDYzogbGludXgtcG1A
dmdlci5rZXJuZWwub3JnOyBlZHViZXp2YWxAZ21haWwuY29tOyBaaGFuZywgUnVpOyBsaW51eC0N
Cj4ga2VybmVsQHZnZXIua2VybmVsLm9yZzsgc3RhYmxlQHZnZXIua2VybmVsLm9yZw0KPiBTdWJq
ZWN0OiBSZTogW1BBVENIIDMvM10gVGhlcm1hbDogZG8gdGhlcm1hbCB6b25lIHVwZGF0ZSBhZnRl
ciBhIGNvb2xpbmcNCj4gZGV2aWNlIHJlZ2lzdGVyZWQNCj4gDQo+IE9uIFN1biwgU2VwIDI3LCAy
MDE1IGF0IDA2OjQ4OjQ0QU0gKzAxMDAsIENoZW4gWXUgd3JvdGU6DQo+ID4gRnJvbTogWmhhbmcg
UnVpIDxydWkuemhhbmdAaW50ZWwuY29tPg0KPiA+DQo+ID4NCj4gDQo+IEkgdGhpbmsgeW91IG5l
ZWQgdG8gaG9sZCBjZGV2LT5sb2NrIGhlcmUsIHRvIG1ha2Ugc3VyZSB0aGF0IG5vIHRoZXJtYWwg
em9uZQ0KPiBpcyBhZGRlZCBvciByZW1vdmVkIGZyb20gY2Rldi0+dGhlcm1hbF9pbnN0YW5jZXMg
d2hpbGUgeW91IGFyZSBsb29waW5nLg0KPiANCkFoIHJpZ2h0LCB3aWxsIGFkZC4gSWYgSSBhZGQg
dGhlIGNkZXYgLT5sb2NrIGhlcmUsIHdpbGwgdGhlcmUgYmUgYSBBQi1CQSBsb2NrIHdpdGggDQp0
aGVybWFsX3pvbmVfdW5iaW5kX2Nvb2xpbmdfZGV2aWNlPw0KDQo+IA0KPiBXaHkgbGlzdF9mb3Jf
ZWFjaF9lbnRyeV9zYWZlKCkgPyAgWW91IGFyZSBub3QgZ29pbmcgdG8gcmVtb3ZlIGFueSBlbnRy
eSwgc28NCj4geW91IGNhbiBqdXN0IHVzZSBsaXN0X2Zvcl9lYWNoX2VudHJ5KCkNCj4gDQo+IA0K
PiBXaHkgaXMgdGhpcyBzbyBjb21wbGljYXRlZD8gIENhbid0IHlvdSBqdXN0IGRvOg0KPiANCj4g
CWxpc3RfZm9yX2VhY2hfZW50cnkocG9zLCAmY2Rldi0+dGhlcm1hbF9pbnN0YW5jZXMsIGNkZXZf
bm9kZSkNCj4gICAgICAgICAJdGhlcm1hbF96b25lX2RldmljZV91cGRhdGUocG9zLT50eik7DQo+
IA0KDQpUaGlzIGlzIGFuIG9wdGltaXphdGlvbiBoZXJlOg0KSWdub3JlIHRoZXJtYWwgaW5zdGFu
Y2UgdGhhdCByZWZlcnMgdG8gdGhlIHNhbWUgdGhlcm1hbCB6b25lIGluIHRoaXMgbG9vcCwNCnRo
aXMgd29ya3MgYmVjYXVzZSBiaW5kX2NkZXYoKSBhbHdheXMgYmluZHMgdGhlIGNvb2xpbmcgZGV2
aWNlIHRvIG9uZSANCnRoZXJtYWwgem9uZSBmaXJzdCwgYW5kIHRoZW4gYmluZHMgdG8gdGhlIG5l
eHQgdGhlcm1hbCB6b25lLg0KDQoNCkJlc3QgUmVnYXJkcywNCll1DQo=
