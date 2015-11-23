From: MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: [PATCH] PM / devfreq: Do not show statistics if it's not ready.
Date: Mon, 23 Nov 2015 06:53:21 +0000 (GMT)
Message-ID: <670532133.123321448261601649.JavaMail.weblogic@epmlwas06a>
Reply-To: myungjoo.ham@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:32879 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751417AbbKWGxX (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 23 Nov 2015 01:53:23 -0500
Received: from epcpsbgr2.samsung.com
 (u142.gpu120.samsung.co.kr [203.254.230.142])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTP id <0NY901RX29SX1Q80@mailout4.samsung.com> for
 linux-pm@vger.kernel.org; Mon, 23 Nov 2015 15:53:21 +0900 (KST)
MIME-version: 1.0
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: =?utf-8?Q?=EC=B5=9C=EC=B0=AC=EC=9A=B0?= <cw00.choi@samsung.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

DQpCZWZvcmUgdGhpcyBwYXRjaCBmb3IgYSBkZXZpY2Ugd2l0aG91dCBzdGF0aXN0aWNzIHN1cHBv
cnQsDQoNCiQgY2F0IHRyYW5zX3N0YXQNCiAgICBGcm9tICA6ICAgVG8NCiAgICAgICAgICA6ICAg
dGltZShtcykNClRvdGFsIHRyYW5zaXRpb25zIDogMA0KJA0KDQpBZnRlciB0aGlzIHBhdGNoIGFw
cGxpZWQgZm9yIHN1Y2ggYSBkZXZpY2UsDQoNCiQgY2F0IHRyYW5zX3N0YXQNCk5vdCBTdXBwb3J0
ZWQuDQokDQoNClNpZ25lZC1vZmYtYnk6IE15dW5nSm9vIEhhbSA8bXl1bmdqb28uaGFtQHNhbXN1
bmcuY29tPg0KLS0tDQogZHJpdmVycy9kZXZmcmVxL2RldmZyZXEuYyB8IDIgKysNCiAxIGZpbGUg
Y2hhbmdlZCwgMiBpbnNlcnRpb25zKCspDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2RldmZyZXEv
ZGV2ZnJlcS5jIGIvZHJpdmVycy9kZXZmcmVxL2RldmZyZXEuYw0KaW5kZXggZmUzZTNkMS4uMWJh
YTU1MCAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvZGV2ZnJlcS9kZXZmcmVxLmMNCisrKyBiL2RyaXZl
cnMvZGV2ZnJlcS9kZXZmcmVxLmMNCkBAIC0xMDQ4LDYgKzEwNDgsOCBAQCBzdGF0aWMgc3NpemVf
dCB0cmFuc19zdGF0X3Nob3coc3RydWN0IGRldmljZSAqZGV2LA0KIAlpZiAoIWRldmZyZXEtPnN0
b3BfcG9sbGluZyAmJg0KIAkJCWRldmZyZXFfdXBkYXRlX3N0YXR1cyhkZXZmcmVxLCBkZXZmcmVx
LT5wcmV2aW91c19mcmVxKSkNCiAJCXJldHVybiAwOw0KKwlpZiAobWF4X3N0YXRlID09IDApDQor
CQlyZXR1cm4gc3ByaW50ZihidWYsICJOb3QgU3VwcG9ydGVkLlxuIik7DQogDQogCWxlbiA9IHNw
cmludGYoYnVmLCAiICAgICBGcm9tICA6ICAgVG9cbiIpOw0KIAlsZW4gKz0gc3ByaW50ZihidWYg
KyBsZW4sICIgICAgICAgICAgIDoiKTsNCi0tIA0KMS45LjENCg0K


