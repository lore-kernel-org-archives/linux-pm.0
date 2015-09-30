From: MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: Re: [PATCH] PM / devfreq: Fix governor_store()
Date: Wed, 30 Sep 2015 05:06:57 +0000 (GMT)
Message-ID: <1450775314.375691443589617008.JavaMail.weblogic@epmlwas03d>
Reply-To: myungjoo.ham@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:44465 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751512AbbI3FG7 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 30 Sep 2015 01:06:59 -0400
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTP id <0NVH030604VL60E0@mailout3.samsung.com> for
 linux-pm@vger.kernel.org; Wed, 30 Sep 2015 14:06:57 +0900 (KST)
MIME-version: 1.0
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Cc: =?utf-8?Q?=EB=B0=95=EA=B2=BD=EB=AF=BC?= <kyungmin.park@samsung.com>

PiBXcml0aW5nIHRoZSBjdXJyZW50bHkgc2V0IGdvdmVybm9yIGludG8gc3lzZnMgY3VycmVudGx5
DQo+IHNlZW1zIHRvIGZhaWwuDQo+IEZpeCB0aGlzIGJ5IHNldHRpbmcgdGhlIHJldHVybiBjb2Rl
IHRvIHplcm8gYmVmb3JlDQo+IGxlYXZpbmcgZ292ZXJub3Jfc3RvcmUoKS4NCj4gDQo+IFNpZ25l
ZC1vZmYtYnk6IFRvYmlhcyBKYWtvYmkgPHRqYWtvYmlAbWF0aC51bmktYmllbGVmZWxkLmRlPg0K
DQpUaGFuayB5b3UgZm9yIHBvaW50aW5nIHRoYXQgb3V0Lg0KDQpBcHBsaWVkLg0KDQoNCkNoZWVy
cywNCk15dW5nSm9vDQoNCj4gLS0tDQo+ICBkcml2ZXJzL2RldmZyZXEvZGV2ZnJlcS5jIHwgNCAr
KystDQo+ICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+
IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9kZXZmcmVxL2RldmZyZXEuYyBiL2RyaXZlcnMvZGV2
ZnJlcS9kZXZmcmVxLmMNCj4gaW5kZXggMzkyN2VkOS4uNGYxYjBjZSAxMDA2NDQNCj4gLS0tIGEv
ZHJpdmVycy9kZXZmcmVxL2RldmZyZXEuYw0KPiArKysgYi9kcml2ZXJzL2RldmZyZXEvZGV2ZnJl
cS5jDQo+IEBAIC03OTUsOCArNzk1LDEwIEBAIHN0YXRpYyBzc2l6ZV90IGdvdmVybm9yX3N0b3Jl
KHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0IGRldmljZV9hdHRyaWJ1dGUgKmF0dHIsDQo+ICAJ
CXJldCA9IFBUUl9FUlIoZ292ZXJub3IpOw0KPiAgCQlnb3RvIG91dDsNCj4gIAl9DQo+IC0JaWYg
KGRmLT5nb3Zlcm5vciA9PSBnb3Zlcm5vcikNCj4gKwlpZiAoZGYtPmdvdmVybm9yID09IGdvdmVy
bm9yKSB7DQo+ICsJCXJldCA9IDA7DQo+ICAJCWdvdG8gb3V0Ow0KPiArCX0NCj4gIA0KPiAgCWlm
IChkZi0+Z292ZXJub3IpIHsNCj4gIAkJcmV0ID0gZGYtPmdvdmVybm9yLT5ldmVudF9oYW5kbGVy
KGRmLCBERVZGUkVRX0dPVl9TVE9QLCBOVUxMKTsNCj4gLS0gDQo+IDIuMC41DQo=


