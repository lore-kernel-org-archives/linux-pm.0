From: MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: Re: [PATCH v3 1/3] PM / devfreq: cache the last call to
 get_dev_status()
Date: Mon, 03 Aug 2015 05:30:54 +0000 (GMT)
Message-ID: <453349609.343761438579853672.JavaMail.weblogic@epmlwas06d>
Reply-To: myungjoo.ham@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:53763 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751360AbbHCFa6 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 3 Aug 2015 01:30:58 -0400
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTP id <0NSH00JQPRBICYD0@mailout3.samsung.com> for
 linux-pm@vger.kernel.org; Mon, 03 Aug 2015 14:30:54 +0900 (KST)
MIME-version: 1.0
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Javi Merino <javi.merino@arm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Cc: =?utf-8?Q?=EC=B5=9C=EC=B0=AC=EC=9A=B0?= <cw00.choi@samsung.com>, =?utf-8?Q?=EB=B0=95=EA=B2=BD=EB=AF=BC?= <kyungmin.park@samsung.com>

PiBUaGUgcmV0dXJuIHZhbHVlIG9mIGdldF9kZXZfc3RhdHVzKCkgY2FuIGJlIHJldXNlZC4gIENh
Y2hlIGl0IHNvIHRoYXQNCj4gb3RoZXIgcGFydHMgb2YgdGhlIGtlcm5lbCBjYW4gcmV1c2UgaXQg
aW5zdGVhZCBvZiBoYXZpbmcgdG8gY2FsbCB0aGUNCj4gc2FtZSBmdW5jdGlvbiBhZ2Fpbi4NCj4g
DQo+IENjOiBNeXVuZ0pvbyBIYW0gPG15dW5nam9vLmhhbUBzYW1zdW5nLmNvbT4NCj4gQ2M6IEt5
dW5nbWluIFBhcmsgPGt5dW5nbWluLnBhcmtAc2Ftc3VuZy5jb20+DQo+IFNpZ25lZC1vZmYtYnk6
IEphdmkgTWVyaW5vIDxqYXZpLm1lcmlub0Bhcm0uY29tPg0KDQpZb3VyIHBhdGNoIGludHJvZHVj
ZXMgYnVpbGQgZXJyb3JzIGlmIHlvdSB0cnkgdG8gY29tcGlsZSBnb3Zlcm5vcnMgYXMNCm1vZHVs
ZXMuIFBsZWFzZSBmaXggaXQuDQoNCg0KQW5kLi4NCj4gK2ludCBkZXZmcmVxX3VwZGF0ZV9zdGF0
cyhzdHJ1Y3QgZGV2ZnJlcSAqZGYpDQo+ICt7DQo+ICsJcmV0dXJuIGRmLT5wcm9maWxlLT5nZXRf
ZGV2X3N0YXR1cyhkZi0+ZGV2LnBhcmVudCwgJmRmLT5sYXN0X3N0YXR1cyk7DQo+ICt9DQpUaGlz
IHNlZW1zIGEgZ29vZCBjYW5kaWRhdGUgZm9yIGEgbWFjcm8gb3IgYSBzdGF0aWMgaW5saW5lIGZ1
bmN0aW9uLg0KDQpNb2RpZmljYXRpb25zIGluIGdvdmVybm9yX3NpbXBsZW9uZGVtYW5kLmMgbG9v
a3MgZ29vZC4NCg0KDQpQbGVhc2UgYWRkIHNvbWUgZXhwbGFuYXRpb25zIGF0IHRoZSBkZWZpbml0
aW9uIG9mIGRldmZyZXFfdXBkYXRlX3N0YXRzKCkNCmFzIHdlbGwgaW4gZGV2ZnJlcS5jDQoNCg0K
Q2hlZXJzLA0KTXl1bmdKb28uDQoNCg==


