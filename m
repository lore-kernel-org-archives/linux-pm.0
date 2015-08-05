From: MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: [PATCH] PM / devfreq: exynos-ppmu: bit-wise operation bugfix.
Date: Wed, 05 Aug 2015 02:15:31 +0000 (GMT)
Message-ID: <1139776636.447211438740931685.JavaMail.weblogic@epmlwas03c>
Reply-To: myungjoo.ham@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:55555 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751469AbbHECPd (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 4 Aug 2015 22:15:33 -0400
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTP id <0NSL01JKH7LVO970@mailout3.samsung.com> for
 linux-pm@vger.kernel.org; Wed, 05 Aug 2015 11:15:31 +0900 (KST)
MIME-version: 1.0
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Cc: =?utf-8?Q?=EC=B5=9C=EC=B0=AC=EC=9A=B0?= <cw00.choi@samsung.com>

DQpNYWtlIGl0IHU2NCBiZWZvcmUgbGVmdC1zaGlmdGluZyAzMmJpdHMuDQoNClNpZ25lZC1vZmYt
Ynk6IE15dW5nSm9vIEhhbSA8bXl1bmdqb28uaGFtQHNhbXN1bmcuY29tPg0KLS0tDQogZHJpdmVy
cy9kZXZmcmVxL2V2ZW50L2V4eW5vcy1wcG11LmMgfCAzICsrLQ0KIDEgZmlsZSBjaGFuZ2VkLCAy
IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvZGV2
ZnJlcS9ldmVudC9leHlub3MtcHBtdS5jIGIvZHJpdmVycy9kZXZmcmVxL2V2ZW50L2V4eW5vcy1w
cG11LmMNCmluZGV4IGY5OTAxZjUuLmYzMTI0ODUgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2RldmZy
ZXEvZXZlbnQvZXh5bm9zLXBwbXUuYw0KKysrIGIvZHJpdmVycy9kZXZmcmVxL2V2ZW50L2V4eW5v
cy1wcG11LmMNCkBAIC0zMTksNyArMzE5LDggQEAgc3RhdGljIGludCBleHlub3NfcHBtdV92Ml9n
ZXRfZXZlbnQoc3RydWN0IGRldmZyZXFfZXZlbnRfZGV2ICplZGV2LA0KIAljYXNlIFBQTVVfUE1O
Q05UMzoNCiAJCXBtY250X2hpZ2ggPSBfX3Jhd19yZWFkbChpbmZvLT5wcG11LmJhc2UgKyBQUE1V
X1YyX1BNQ05UM19ISUdIKTsNCiAJCXBtY250X2xvdyA9IF9fcmF3X3JlYWRsKGluZm8tPnBwbXUu
YmFzZSArIFBQTVVfVjJfUE1DTlQzX0xPVyk7DQotCQlsb2FkX2NvdW50ID0gKHU2NCkoKHBtY250
X2hpZ2ggJiAweGZmKSA8PCAzMikgKyAodTY0KXBtY250X2xvdzsNCisJCWxvYWRfY291bnQgPSAo
KHU2NCkoKHBtY250X2hpZ2ggJiAweGZmKSkgPDwgMzIpDQorCQkJICAgKyAodTY0KXBtY250X2xv
dzsNCiAJCWJyZWFrOw0KIAl9DQogCWVkYXRhLT5sb2FkX2NvdW50ID0gbG9hZF9jb3VudDsNCi0t
IA0KMS45LjENCg0K


