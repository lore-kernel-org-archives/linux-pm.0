From: MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: Re: [PATCH] PM / devfreq: fix double kfree
Date: Fri, 02 Oct 2015 02:11:27 +0000 (GMT)
Message-ID: <361552041.487551443751886669.JavaMail.weblogic@epmlwas01a>
Reply-To: myungjoo.ham@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:43178 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750924AbbJBCLb (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 1 Oct 2015 22:11:31 -0400
Received: from epcpsbgr4.samsung.com
 (u144.gpu120.samsung.co.kr [203.254.230.144])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTP id <0NVK02QZUM34TA90@mailout2.samsung.com> for
 linux-pm@vger.kernel.org; Fri, 02 Oct 2015 11:11:28 +0900 (KST)
MIME-version: 1.0
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Geliang Tang <geliangtang@163.com>, =?utf-8?Q?=EB=B0=95=EA=B2=BD=EB=AF=BC?= <kyungmin.park@samsung.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

PiBXaGVuIGRldmljZV9yZWdpc3RlcigpIGZhaWxzLCBrZnJlZShkZXZmcmVxKSBpcyBjYWxsZWQg
YWxyZWFkeSBpbg0KPiBkZXZmcmVxX2Rldl9yZWxlYXNlKCksIGhlbmNlIHRoZXJlIGlzIG5vIG5l
ZWQgdG8gY2FsbCBrZnJlZShkZXZmcmVxKQ0KPiBpbiBlcnJfZGV2IGFnYWluLg0KPiANCj4gU2ln
bmVkLW9mZi1ieTogR2VsaWFuZyBUYW5nIDxnZWxpYW5ndGFuZ0AxNjMuY29tPg0KDQpUaGFuayB5
b3UgZm9yIHBvaW50aW5nIG91dCB0aGF0IHB1dF9kZXZpY2UoKSB3aWxsIGV2ZW50dWFsbHkgY2Fs
bCBrZnJlZSBhbnl3YXkuDQoNClNpZ25lZC1vZmYtYnk6IE15dW5nSm9vIEhhbSA8bXl1bmdqb28u
aGFtQHNhbXN1bmcuY29tPg0KDQoNCg0KQ2hlZXJzLA0KTXl1bmdKb28NCg0KPiAtLS0NCj4gIGRy
aXZlcnMvZGV2ZnJlcS9kZXZmcmVxLmMgfCAzICstLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5z
ZXJ0aW9uKCspLCAyIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZGV2
ZnJlcS9kZXZmcmVxLmMgYi9kcml2ZXJzL2RldmZyZXEvZGV2ZnJlcS5jDQo+IGluZGV4IDM5Mjdl
ZDkuLjliMzUyZGEgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZGV2ZnJlcS9kZXZmcmVxLmMNCj4g
KysrIGIvZHJpdmVycy9kZXZmcmVxL2RldmZyZXEuYw0KPiBAQCAtNDkyLDcgKzQ5Miw3IEBAIHN0
cnVjdCBkZXZmcmVxICpkZXZmcmVxX2FkZF9kZXZpY2Uoc3RydWN0IGRldmljZSAqZGV2LA0KPiAg
CWlmIChlcnIpIHsNCj4gIAkJcHV0X2RldmljZSgmZGV2ZnJlcS0+ZGV2KTsNCj4gIAkJbXV0ZXhf
dW5sb2NrKCZkZXZmcmVxLT5sb2NrKTsNCj4gLQkJZ290byBlcnJfZGV2Ow0KPiArCQlnb3RvIGVy
cl9vdXQ7DQo+ICAJfQ0KPiAgDQo+ICAJbXV0ZXhfdW5sb2NrKCZkZXZmcmVxLT5sb2NrKTsNCj4g
QEAgLTUxOCw3ICs1MTgsNiBAQCBzdHJ1Y3QgZGV2ZnJlcSAqZGV2ZnJlcV9hZGRfZGV2aWNlKHN0
cnVjdCBkZXZpY2UgKmRldiwNCj4gIGVycl9pbml0Og0KPiAgCWxpc3RfZGVsKCZkZXZmcmVxLT5u
b2RlKTsNCj4gIAlkZXZpY2VfdW5yZWdpc3RlcigmZGV2ZnJlcS0+ZGV2KTsNCj4gLWVycl9kZXY6
DQo+ICAJa2ZyZWUoZGV2ZnJlcSk7DQo+ICBlcnJfb3V0Og0KPiAgCXJldHVybiBFUlJfUFRSKGVy
cik7DQo+IC0tIA0KPiAyLjUuMA0K


