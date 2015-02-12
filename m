From: MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: Re: Re: [patch] PM / devfreq: event: testing the wrong variable
Date: Thu, 12 Feb 2015 09:00:43 +0000 (GMT)
Message-ID: <808951994.1086901423731642675.JavaMail.weblogic@epmlwas01a>
Reply-To: myungjoo.ham@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:43693 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754985AbbBLJAq (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 12 Feb 2015 04:00:46 -0500
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0NJN000UYID8SVD0@mailout2.samsung.com> for
 linux-pm@vger.kernel.org; Thu, 12 Feb 2015 18:00:44 +0900 (KST)
MIME-version: 1.0
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: =?utf-8?Q?=EC=B5=9C=EC=B0=AC=EC=9A=B0?= <cw00.choi@samsung.com>, Dan Carpenter <dan.carpenter@oracle.com>
Cc: =?utf-8?Q?=EB=B0=95=EA=B2=BD=EB=AF=BC?= <kyungmin.park@samsung.com>, Kukjin Kim <kgene@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>

PiAgIA0KPiAgT24gMDIvMTAvMjAxNSAwNzozNSBQTSwgRGFuIENhcnBlbnRlciB3cm90ZToNCj4g
PiBUaGVyZSBpcyBhIHR5cG8gaGVyZSBzbyB3ZSB0ZXN0ICJlZGV2IiBidXQgd2UgaW50ZW5kZWQg
dG8gdGVzdA0KPiA+ICJlZGV2W2ldIi4NCj4gPiANCj4gPiBGaXhlczogZjI2MmYyOGMxNDcwICgn
UE0gLyBkZXZmcmVxOiBldmVudDogQWRkIGRldmZyZXFfZXZlbnQgY2xhc3MnKQ0KPiA+IFNpZ25l
ZC1vZmYtYnk6IERhbiBDYXJwZW50ZXIgPGRhbi5jYXJwZW50ZXJAb3JhY2xlLmNvbT4NCj4gPiAN
Cj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9kZXZmcmVxL2V2ZW50L2V4eW5vcy1wcG11LmMgYi9k
cml2ZXJzL2RldmZyZXEvZXZlbnQvZXh5bm9zLXBwbXUuYw0KPiA+IGluZGV4IDEzNWJlMGEuLmFk
ODM0NzMgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9kZXZmcmVxL2V2ZW50L2V4eW5vcy1wcG11
LmMNCj4gPiArKysgYi9kcml2ZXJzL2RldmZyZXEvZXZlbnQvZXh5bm9zLXBwbXUuYw0KPiA+IEBA
IC0zMjcsOCArMzI3LDggQEAgc3RhdGljIGludCBleHlub3NfcHBtdV9wcm9iZShzdHJ1Y3QgcGxh
dGZvcm1fZGV2aWNlICpwZGV2KQ0KPiA+IC0JCWlmIChJU19FUlIoZWRldikpIHsNCj4gPiAtCQkJ
cmV0ID0gUFRSX0VSUihlZGV2KTsNCj4gPiArCQlpZiAoSVNfRVJSKGVkZXZbaV0pKSB7DQo+ID4g
KwkJCXJldCA9IFBUUl9FUlIoZWRldltpXSk7DQo+IA0KPiBSZXZpZXdlZC1ieTogQ2hhbndvbyBD
aG9pIDxjdzAwLmNob2lAc2Ftc3VuZy5jb20+DQo+IA0KPiBCdXQsDQo+IFRoaXMgcGF0Y2ggaGFz
IG5vdCB5ZXQgbWVyZ2VkIHRvIGxpbnV4LmdpdCAoaHR0cDovL2dpdC5rZXJuZWwub3JnL2NnaXQv
bGludXgva2VybmVsL2dpdC90b3J2YWxkcy9saW51eC5naXQpLg0KPiBBZnRlciByZWxlYXNpbmcg
TGludXggMy4yMC1yYzEsIHRoaXMgcGF0Y2ggd2lsbCBiZSBoYW5kbGVkLg0KPiANCj4gVGhhbmtz
LA0KPiBDaGFud29vIENob2kNCg0KQWNrZWQtYnk6IE15dW5nSm9vIEhhbSA8bXl1bmdqb28uaGFt
QHNhbXN1bmcuY29tPg0KDQo=


