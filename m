From: MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: Re: [PATCH RESEND v2 03/10] power: charger-manager: Remove deprecated
 function, cm_notify_event().
Date: Fri, 19 Dec 2014 07:52:04 +0000 (GMT)
Message-ID: <1255984171.39711418975524329.JavaMail.weblogic@epmlwas08d>
Reply-To: myungjoo.ham@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:40479 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751003AbaLSHwI (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 19 Dec 2014 02:52:08 -0500
Received: from epcpsbgr3.samsung.com
 (u143.gpu120.samsung.co.kr [203.254.230.143])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0NGT00FOMKITJLB0@mailout3.samsung.com> for
 linux-pm@vger.kernel.org; Fri, 19 Dec 2014 16:52:05 +0900 (KST)
MIME-version: 1.0
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: =?utf-8?Q?=EC=9D=B4=EC=A2=85=ED=99=94?= <jonghwa3.lee@samsung.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "sre@kernel.org" <sre@kernel.org>, "dbaryshkov@gmail.com" <dbaryshkov@gmail.com>, "dwmw2@infradead.org" <dwmw2@infradead.org>, "anton@enomsg.org" <anton@enomsg.org>, "pavel@ucw.cz" <pavel@ucw.cz>, =?utf-8?Q?=EC=B5=9C=EC=B0=AC=EC=9A=B0?= <cw00.choi@samsung.com>

PiAgIA0KPiAgY21fbm90aWZ5X2V2ZW50KCkgaXMgaW50cm9kdWNlZCB0byBnZXQgZXZlbnQgYXNz
b2NpYXRlZCB3aXRoIGJhdHRlcnkgc3RhdHVzDQo+IGV4dGVybmFsbHksIGJ1dCBubyBvbmUgaGFk
IGJlZW4gdXNlZC4gTW9yZW92ZXIgaXQgbWFrZXMgY2hhcmdlciBtYW5hZ2VyDQo+IGRyaXZlciBt
b3JlIGNvbXBsaWNhdGVkLiBUaGlzIHBhdGNoIHRyaWVzIHRvIGRyb3AgdGhlIGZ1bmN0aW9uIGFu
ZCBhbGwgZGF0YQ0KPiByZWxhdGVkIHRvIHNpbXBsaWZ5IHRoZSBkcml2ZXIuDQo+IA0KPiBTaWdu
ZWQtb2ZmLWJ5OiBKb25naHdhIExlZSA8am9uZ2h3YTMubGVlQHNhbXN1bmcuY29tPg0KDQpZb3Ug
YXJlIG5vdCBqdXN0IHJlbW92aW5nIGNtX25vdGlmeV9ldmVudCgpIGFuZCBpdHMgcmVsYXRlZC4N
Cg0KWW91IGFyZSBoZXJlYnkgcmVtb3ZpbmcgdGhlIG11Y2ggb2Ygc29mdHdhcmUgY2hhcmdlciBj
b250cm9sDQphbmQgc3VzcGVuZC1yZWxhdGVkIG9wZXJhdGlvbnMuIENvdWxkIHlvdSBwbGVhc2Ug
YmUgbW9yZSBzcGVjaWZpYw0Kb24gd2h5PyAobWFueSBvZiBzdWNoIGZlYXR1cmVzIGFyZSB0byBj
b21wbHkgd2l0aCBvcGVyYXRvcnMnIHJlcXVpcmVtZW50cykNCg0KKE9yIHdlIG1heSBtZWV0IG5l
eHQgTW9uZGF5IGZvciBzb21lIGRpc2N1c3Npb25zIDopICkNCg0KPiAtLS0NCj4gIC4uLi9iaW5k
aW5ncy9wb3dlcl9zdXBwbHkvY2hhcmdlci1tYW5hZ2VyLnR4dCAgICAgIHwgICAgMSAtDQo+ICBk
cml2ZXJzL3Bvd2VyL2NoYXJnZXItbWFuYWdlci5jICAgICAgICAgICAgICAgICAgICB8ICAxOTYg
Ky0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gIGluY2x1ZGUvbGludXgvcG93ZXIvY2hhcmdlci1tYW5h
Z2VyLmggICAgICAgICAgICAgIHwgICAxOSArLQ0KPiAgMyBmaWxlcyBjaGFuZ2VkLCA4IGluc2Vy
dGlvbnMoKyksIDIwOCBkZWxldGlvbnMoLSkNCj4gDQo=


