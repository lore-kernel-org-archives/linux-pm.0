From: MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: [PATCH] PM / devfreq: fix duplicated kfree on devfreq pointer
Date: Mon, 16 May 2016 02:46:13 +0000 (GMT)
Message-ID: <1782450689.743721463366773827.JavaMail.weblogic@ep2mlwas03c>
Reply-To: myungjoo.ham@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:35295 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751895AbcEPCqQ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 15 May 2016 22:46:16 -0400
Received: from epcpsbgr3.samsung.com
 (u143.gpu120.samsung.co.kr [203.254.230.143])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTP id <0O7902HEN111LOE0@mailout2.samsung.com> for
 linux-pm@vger.kernel.org; Mon, 16 May 2016 11:46:13 +0900 (KST)
MIME-version: 1.0
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: myungjoo.ham@gmail.com

DQpkZXZpY2VfdW5yZWdpc3RlcigpIGNhbGxzIGtmcmVlIGFscmVhZHkuDQoNClNpZ25lZC1vZmYt
Ynk6IE15dW5nSm9vIEhhbSA8bXl1bmdqb28uaGFtQHNhbXN1bmcuY29tPg0KLS0tDQogZHJpdmVy
cy9kZXZmcmVxL2RldmZyZXEuYyB8IDEgLQ0KIDEgZmlsZSBjaGFuZ2VkLCAxIGRlbGV0aW9uKC0p
DQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2RldmZyZXEvZGV2ZnJlcS5jIGIvZHJpdmVycy9kZXZm
cmVxL2RldmZyZXEuYw0KaW5kZXggMzFmYWY4NS4uMjBlOGFjMSAxMDA2NDQNCi0tLSBhL2RyaXZl
cnMvZGV2ZnJlcS9kZXZmcmVxLmMNCisrKyBiL2RyaXZlcnMvZGV2ZnJlcS9kZXZmcmVxLmMNCkBA
IC01NjUsNyArNTY1LDYgQEAgc3RydWN0IGRldmZyZXEgKmRldmZyZXFfYWRkX2RldmljZShzdHJ1
Y3QgZGV2aWNlICpkZXYsDQogZXJyX2luaXQ6DQogCWxpc3RfZGVsKCZkZXZmcmVxLT5ub2RlKTsN
CiAJZGV2aWNlX3VucmVnaXN0ZXIoJmRldmZyZXEtPmRldik7DQotCWtmcmVlKGRldmZyZXEpOw0K
IGVycl9vdXQ6DQogCXJldHVybiBFUlJfUFRSKGVycik7DQogfQ0KLS0gDQoxLjkuMQ0KDQo=


