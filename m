Received: from outbound.baidu.com (mx14.baidu.com [220.181.3.101])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 140CF42379A
	for <linux-pm@vger.kernel.org>; Wed, 12 Aug 2026 12:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.181.3.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786536386; cv=none; b=o6dGfuZcUIRtmFM0RGA/PbNpfVKQUJLCsvxOztxhQlbn//knnW2qhhO+TGdNwTVmQ5cBYT3cSJ53rv5kBMy81EeHoDTjIl8X9j5vMUpHBv5W9CexznbCwmg1NLk+7LnHPDsSTiyti26LSCkNGVaQIqGlM3qIcsiqr24EwbGGes0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786536386; c=relaxed/simple;
	bh=b5LYsj9lc8gMBOEVrqpCzZIDumfmcImGpMkrfSUja6g=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ksKCZMNP/d+Dgp9kYsj3I4LoshltbwxGvoYo9p1lhI+sBFZzQU2FjKUIbBaprxdqCaakFdPrkJl4X/9mHpfiT8KzopMJ6q1gvPQyZ0yjmy8NZs53GB2mZVWwoXK95IqnDwP3KNv0bmOg6pKLAwsQlz/OSS3A3xiZ7zOhROa3PMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; dkim=pass (2048-bit key) header.d=baidu.com header.i=@baidu.com header.b=VK/Q6J8I; arc=none smtp.client-ip=220.181.3.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baidu.com header.i=@baidu.com header.b="VK/Q6J8I"
X-MD-Sfrom: lirongqing@baidu.com
X-MD-SrcIP: 172.31.50.48
From: "Li,Rongqing" <lirongqing@baidu.com>
To: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>, "Rafael J . Wysocki"
	<rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: =?utf-8?B?562U5aSNOiBb5aSW6YOo6YKu5Lu2XSBSZTogW1BBVENIXSBjcHVmcmVxOiBh?=
 =?utf-8?B?Y3BpLWNwdWZyZXE6IGFkZCBOVUxMIGNoZWNrIGZvciBhY3BpX3BlcmZfZGF0?=
 =?utf-8?Q?a_before_freeing?=
Thread-Topic: =?utf-8?B?W+WklumDqOmCruS7tl0gUmU6IFtQQVRDSF0gY3B1ZnJlcTogYWNwaS1jcHVm?=
 =?utf-8?B?cmVxOiBhZGQgTlVMTCBjaGVjayBmb3IgYWNwaV9wZXJmX2RhdGEgYmVmb3Jl?=
 =?utf-8?Q?_freeing?=
Thread-Index: AQHdKI8Cln1etqt6Vk69uVeR3qrM8baWnXgAgAO24hA=
Date: Wed, 12 Aug 2026 12:06:12 +0000
Message-ID: <342485f49c66426c930d38fa19718ba1@baidu.com>
References: <20260810061045.2397-1-lirongqing@baidu.com>
 <3c7c27f1-8ccd-4b1a-a21e-9bde219bd9d0@oss.qualcomm.com>
In-Reply-To: <3c7c27f1-8ccd-4b1a-a21e-9bde219bd9d0@oss.qualcomm.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=baidu.com;
	s=selector1; t=1786536374;
	bh=b5LYsj9lc8gMBOEVrqpCzZIDumfmcImGpMkrfSUja6g=;
	h=From:To:Subject:Date:Message-ID:Content-Type;
	b=VK/Q6J8IPl/2QyTBIuwRJmAWaZCV2+Dl79/VtMEa9+RuUXWXV2cjYx4XoMN1JPZ47
	 TSmRvO63U1FyKpM6zummBZ0oo1MjPUsWFru0zaKvpLOiG1rvrXllGYZ3yAhTZ1+V1q
	 u5T4jyd4rhDwMBlOX7Wsh/J2L3IP2Ab3O5Hq/FWLsxP2bD+mmzFjs3oZp/yhHW0LYN
	 7GArgNJKIs8Xvr0XMERlzvXwCGIzSnX9dV5qEOgXmP4H6sJ6R7Bmt2q3xGg8zUIW91
	 vXKQOwJq8NXmG6A+RZ44UmPfnkAoIfU7enXAQgkNtKi6/qgj5yAlSbOgorgFa1N4E4
	 O1/4313gSPH0g==

DQoNCj4gPg0KPiA+IElmIGFsbG9jX3BlcmNwdSgpIGZhaWxzIGluIGFjcGlfY3B1ZnJlcV9lYXJs
eV9pbml0KCksIGFjcGlfcGVyZl9kYXRhDQo+ID4gaXMgTlVMTC4gIENhbGxpbmcgZnJlZV9hY3Bp
X3BlcmZfZGF0YSgpIHdpbGwgZXhlY3V0ZSBwZXJfY3B1X3B0cihOVUxMLA0KPiA+IGkpLCB3aGlj
aCBkb2VzIG5vdCByZXR1cm4gTlVMTCBidXQgYW4gb2Zmc2V0IHBvaW50ZXIuDQo+IA0KPiBIaSBS
b25nUWluZywNCj4gDQo+IENvdWxkIHlvdSBwbGVhc2UgY29uZmlybSBpZiBhY3BpX3BlcmZfZGF0
YSgpIGNhbiBldmVyIGJlIGV4ZWN1dGVkIHdoZW4NCj4gYWxsb2NfcGVyY3B1KCkgZmFpbHM/DQoN
CllvdSBhcmUgcmlnaHQsIGFjcGlfcGVyZl9kYXRhKCkgY2FuIG5vdCBiZSBjYWxsZWQgd2hlbiBh
bGxvY19wZXJjcHUoKSBmYWlscw0KDQpQbGVhc2UgZHJvcCB0aGlzIHBhdGNoDQoNCnRoYW5rcyAN
Cg0KW0xpLFJvbmdxaW5nXSANCg0KDQoNCj4gDQo+IA0KPiA+IERlcmVmZXJlbmNpbmcgLT5zaGFy
ZWRfY3B1X21hcCBvbiB0aGlzIGludmFsaWQgcG9pbnRlciBsZWFkcyB0byBhIGtlcm5lbA0KPiA+
IGNyYXNoLg0KPiA+DQo+ID4gRml4IHRoZXNlIGlzc3VlcyBieSBhZGRpbmcgYSBOVUxMIGNoZWNr
IGF0IHRoZSBzdGFydCBvZg0KPiA+IGZyZWVfYWNwaV9wZXJmX2RhdGEoKSBhbmQgc2V0dGluZyBh
Y3BpX3BlcmZfZGF0YSB0byBOVUxMIGFmdGVyIGZyZWVpbmcuDQo+ID4NCj4gPiBTaWduZWQtb2Zm
LWJ5OiBMaSBSb25nUWluZyA8bGlyb25ncWluZ0BiYWlkdS5jb20+DQo+ID4gLS0tDQo+ID4gICBk
cml2ZXJzL2NwdWZyZXEvYWNwaS1jcHVmcmVxLmMgfCA1ICsrKystDQo+ID4gICAxIGZpbGUgY2hh
bmdlZCwgNCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9jcHVmcmVxL2FjcGktY3B1ZnJlcS5jIGIvZHJpdmVycy9jcHVmcmVxL2FjcGkt
Y3B1ZnJlcS5jDQo+ID4gaW5kZXggODdlNDkyMy4uY2QyY2E4NyAxMDA2NDQNCj4gPiAtLS0gYS9k
cml2ZXJzL2NwdWZyZXEvYWNwaS1jcHVmcmVxLmMNCj4gPiArKysgYi9kcml2ZXJzL2NwdWZyZXEv
YWNwaS1jcHVmcmVxLmMNCj4gPiBAQCAtNTE3LDExICs1MTcsMTQgQEAgc3RhdGljIHZvaWQgZnJl
ZV9hY3BpX3BlcmZfZGF0YSh2b2lkKQ0KPiA+ICAgew0KPiA+ICAgCXVuc2lnbmVkIGludCBpOw0K
PiA+DQo+ID4gLQkvKiBGcmVlaW5nIGEgTlVMTCBwb2ludGVyIGlzIE9LLCBhbmQgYWxsb2NfcGVy
Y3B1IHplcm9lcy4gKi8NCj4gPiArCWlmICghYWNwaV9wZXJmX2RhdGEpDQo+ID4gKwkJcmV0dXJu
Ow0KPiA+ICsNCj4gPiAgIAlmb3JfZWFjaF9wb3NzaWJsZV9jcHUoaSkNCj4gPiAgIAkJZnJlZV9j
cHVtYXNrX3ZhcihwZXJfY3B1X3B0cihhY3BpX3BlcmZfZGF0YSwgaSkNCj4gPiAgIAkJCQkgLT5z
aGFyZWRfY3B1X21hcCk7DQo+ID4gICAJZnJlZV9wZXJjcHUoYWNwaV9wZXJmX2RhdGEpOw0KPiA+
ICsJYWNwaV9wZXJmX2RhdGEgPSBOVUxMOw0KPiA+ICAgfQ0KPiA+DQo+ID4gICBzdGF0aWMgaW50
IGNwdWZyZXFfYm9vc3RfZG93bl9wcmVwKHVuc2lnbmVkIGludCBjcHUpDQo+IA0KPiANCj4gLS0N
Cj4gVGh4IGFuZCBCUnMsDQo+IFpob25ncWl1IEhhbg0K
