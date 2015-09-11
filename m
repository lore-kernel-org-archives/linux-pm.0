From: MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: Re: [PATCH] PM / devfreq: Fix incorrect type issue.
Date: Fri, 11 Sep 2015 04:44:44 +0000 (GMT)
Message-ID: <2087694045.934751441946684139.JavaMail.weblogic@ep2mlwas04a>
Reply-To: myungjoo.ham@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:49063 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750862AbbIKEow (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 11 Sep 2015 00:44:52 -0400
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTP id <0NUH028NBX6KN640@mailout1.samsung.com> for
 linux-pm@vger.kernel.org; Fri, 11 Sep 2015 13:44:44 +0900 (KST)
MIME-version: 1.0
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Xiaolong Ye <yexl@marvell.com>, =?utf-8?Q?=EB=B0=95=EA=B2=BD=EB=AF=BC?= <kyungmin.park@samsung.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "yizhang@marvell.com" <yizhang@marvell.com>, "kliu5@marvell.com" <kliu5@marvell.com>

ICANCj4gdGltZV9pbl9zdGF0ZSBpbiBzdHJ1Y3QgZGV2ZnJlcSBpcyBkZWZpbmVkIGFzIHVuc2ln
bmVkIGxvbmcsIHNvDQo+IGRldm1fa3phbGxvYyBzaG91bGQgdXNlIHNpemVvZih1bnNpZ25lZCBs
b25nKSBhcyBhcmd1bWVudCBpbnN0ZWFkDQo+IG9mIHNpemVvZih1bnNpZ25lZCBpbnQpLCBvdGhl
cndpc2UgaXQgd2lsbCBjYXVzZSB1bmV4cGVjdGVkIHJlc3VsdA0KPiBpbiA2NGJpdCBzeXN0ZW0u
DQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBYaWFvbG9uZyBZZSA8eWV4bEBtYXJ2ZWxsLmNvbT4NCj4g
U2lnbmVkLW9mZi1ieTogS2V2aW4gTGl1IDxrbGl1NUBtYXJ2ZWxsLmNvbT4NCg0KVGhhbmtzIQ0K
DQpTaWduZWQtb2ZmLWJ5OiBNeXVuZ0pvbyBIYW0gPG15dW5nam9vLmhhbUBzYW1zdW5nLmNvbT4N
Cg0KDQpXaGljaCBTb0MgYXJlIHlvdSB3b3JraW5nIHdpdGg/DQpBcmUgeW91IGdvaW5nIHRvIHVw
c3RyZWFtIHlvdXIgNjRiaXQgZGV2ZnJlcSBkcml2ZXIgc29vbj8NCg0KDQpDaGVlcnMsDQpNeXVu
Z0pvbw0KDQo+IC0tLQ0KPiAgZHJpdmVycy9kZXZmcmVxL2RldmZyZXEuYyB8ICAgIDIgKy0NCj4g
IDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvZGV2ZnJlcS9kZXZmcmVxLmMgYi9kcml2ZXJzL2RldmZyZXEvZGV2
ZnJlcS5jDQo+IGluZGV4IGNhMWIzNjIuLmFjOTg0NWEgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMv
ZGV2ZnJlcS9kZXZmcmVxLmMNCj4gKysrIGIvZHJpdmVycy9kZXZmcmVxL2RldmZyZXEuYw0KPiBA
QCAtNDgyLDcgKzQ4Miw3IEBAIHN0cnVjdCBkZXZmcmVxICpkZXZmcmVxX2FkZF9kZXZpY2Uoc3Ry
dWN0IGRldmljZSAqZGV2LA0KPiAgCQkJCQkJZGV2ZnJlcS0+cHJvZmlsZS0+bWF4X3N0YXRlICoN
Cj4gIAkJCQkJCWRldmZyZXEtPnByb2ZpbGUtPm1heF9zdGF0ZSwNCj4gIAkJCQkJCUdGUF9LRVJO
RUwpOw0KPiAtCWRldmZyZXEtPnRpbWVfaW5fc3RhdGUgPSBkZXZtX2t6YWxsb2MoZGV2LCBzaXpl
b2YodW5zaWduZWQgaW50KSAqDQo+ICsJZGV2ZnJlcS0+dGltZV9pbl9zdGF0ZSA9IGRldm1fa3ph
bGxvYyhkZXYsIHNpemVvZih1bnNpZ25lZCBsb25nKSAqDQo+ICAJCQkJCQlkZXZmcmVxLT5wcm9m
aWxlLT5tYXhfc3RhdGUsDQo+ICAJCQkJCQlHRlBfS0VSTkVMKTsNCj4gIAlkZXZmcmVxLT5sYXN0
X3N0YXRfdXBkYXRlZCA9IGppZmZpZXM7DQo+IC0tIA0KPiAxLjcuOS41DQo=


