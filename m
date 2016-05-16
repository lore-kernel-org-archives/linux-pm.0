From: MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: [PATCH] PM / devfreq: remove double put_device
Date: Mon, 16 May 2016 02:47:01 +0000 (GMT)
Message-ID: <531029804.743801463366821536.JavaMail.weblogic@ep2mlwas03c>
Reply-To: myungjoo.ham@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:38538 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751921AbcEPCrD (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 15 May 2016 22:47:03 -0400
Received: from epcpsbgr2.samsung.com
 (u142.gpu120.samsung.co.kr [203.254.230.142])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTP id <0O79035A612D9JB0@mailout3.samsung.com> for
 linux-pm@vger.kernel.org; Mon, 16 May 2016 11:47:01 +0900 (KST)
MIME-version: 1.0
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: myungjoo.ham@gmail.com

DQpXaGVuIGRldmljZV9yZWdpc3RlcigpIHJldHVybnMgd2l0aCBlcnJvciwgaXQgaGFzIGFscmVh
ZHkNCmRvbmUgcHV0X2RldmljZSgpIG9uIHRoZSBpbnB1dCBkZXZpY2UgcG9pbnRlci4NCg0KU2ln
bmVkLW9mZi1ieTogTXl1bmdKb28gSGFtIDxteXVuZ2pvby5oYW1Ac2Ftc3VuZy5jb20+DQotLS0N
CiBkcml2ZXJzL2RldmZyZXEvZGV2ZnJlcS5jIHwgMSAtDQogMSBmaWxlIGNoYW5nZWQsIDEgZGVs
ZXRpb24oLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvZGV2ZnJlcS9kZXZmcmVxLmMgYi9kcml2
ZXJzL2RldmZyZXEvZGV2ZnJlcS5jDQppbmRleCA0ZjYwNzllLi41MjAwNzI4IDEwMDY0NA0KLS0t
IGEvZHJpdmVycy9kZXZmcmVxL2RldmZyZXEuYw0KKysrIGIvZHJpdmVycy9kZXZmcmVxL2RldmZy
ZXEuYw0KQEAgLTUyOCw3ICs1MjgsNiBAQCBzdHJ1Y3QgZGV2ZnJlcSAqZGV2ZnJlcV9hZGRfZGV2
aWNlKHN0cnVjdCBkZXZpY2UgKmRldiwNCiAJZGV2X3NldF9uYW1lKCZkZXZmcmVxLT5kZXYsICIl
cyIsIGRldl9uYW1lKGRldikpOw0KIAllcnIgPSBkZXZpY2VfcmVnaXN0ZXIoJmRldmZyZXEtPmRl
dik7DQogCWlmIChlcnIpIHsNCi0JCXB1dF9kZXZpY2UoJmRldmZyZXEtPmRldik7DQogCQltdXRl
eF91bmxvY2soJmRldmZyZXEtPmxvY2spOw0KIAkJZ290byBlcnJfb3V0Ow0KIAl9DQotLSANCjEu
OS4xDQoNCg==


