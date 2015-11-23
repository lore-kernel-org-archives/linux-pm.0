From: MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: Re: [PATCH 4/6] PM / devfreq: Set the freq_table of devfreq device
Date: Mon, 23 Nov 2015 07:29:43 +0000 (GMT)
Message-ID: <106136506.126661448263783195.JavaMail.weblogic@epmlwas06a>
Reply-To: myungjoo.ham@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:38271 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752413AbbKWH3p (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 23 Nov 2015 02:29:45 -0500
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTP id <0NY9034A8BHJM620@mailout4.samsung.com> for
 linux-pm@vger.kernel.org; Mon, 23 Nov 2015 16:29:43 +0900 (KST)
MIME-version: 1.0
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: =?utf-8?Q?=EC=B5=9C=EC=B0=AC=EC=9A=B0?= <cw00.choi@samsung.com>, =?utf-8?Q?=EB=B0=95=EA=B2=BD=EB=AF=BC?= <kyungmin.park@samsung.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

PiAgIA0KPiAgVGhpcyBwYXRjaCBpbml0aWFsaXplIHRoZSBmcmVxX3RhYmxlIGFycmF5IG9mIGVh
Y2ggZGV2ZnJlcSBkZXZpY2UgYnkgdXNpbmcNCj4gdGhlIGRldmZyZXFfc2V0X2ZyZXFfdGFibGUo
KS4gSWYgZnJlcV90YWJsZSBpcyBOVUxMLCB0aGUgZGV2ZnJlcSBmcmFtZXdvcmsNCj4gaXMgbm90
IGFibGUgdG8gc3VwcG9ydCB0aGUgZnJlcXVlbmN5IHRyYW5zdGlvbiBpbmZvcm1hdGlvbiB0aHJv
dWdoIHN5c2ZzLg0KPiANCj4gVGhlIE9QUCBjb3JlIHVzZXMgdGhlIGludGVnZXIgdHlwZSBmb3Ig
dGhlIG51bWJlciBvZiBvcHBzIGluIHRoZSBvcHAgbGlzdA0KPiBhbmQgdXNlcyB0aGUgJ3Vuc2ln
bmVkIGxvbmcnIHR5cGUgZm9yIGVhY2ggZnJlcXVlbmN5LiBTbywgdGhpcyBwYXRjaCBtb2RpZmll
cw0KPiB0aGUgdHlwZSBvZiBzb21lIHZhcmlhYmxlIGFzIGZvbGxvd2luZzoNCj4gLSB0aGUgdHlw
ZSBvZiBmcmVxX3RhYmxlIDogdW5zaWduZWQgaW50IC0+IHVuc2lnbmVkIGxvbmcNCj4gLSB0aGUg
dHlwZSBvZiBtYXhfc3RhdGUgIDogdW5zaWduZWQgaW50IC0+IGludA0KPiANCj4gU2lnbmVkLW9m
Zi1ieTogQ2hhbndvbyBDaG9pIDxjdzAwLmNob2lAc2Ftc3VuZy5jb20+DQpbXQ0KPiArLyoqDQo+
ICAgKiBkZXZmcmVxX3VwZGF0ZV9zdGF0dXMoKSAtIFVwZGF0ZSBzdGF0aXN0aWNzIG9mIGRldmZy
ZXEgYmVoYXZpb3INCj4gICAqIEBkZXZmcmVxOgl0aGUgZGV2ZnJlcSBpbnN0YW5jZQ0KPiAgICog
QGZyZXE6CXRoZSB1cGRhdGUgdGFyZ2V0IGZyZXF1ZW5jeQ0KPiBAQCAtNDc3LDcgKzUxNiwxMiBA
QCBzdHJ1Y3QgZGV2ZnJlcSAqZGV2ZnJlcV9hZGRfZGV2aWNlKHN0cnVjdCBkZXZpY2UgKmRldiwN
Cj4gIAlkZXZmcmVxLT5wcmV2aW91c19mcmVxID0gcHJvZmlsZS0+aW5pdGlhbF9mcmVxOw0KPiAg
CWRldmZyZXEtPmRhdGEgPSBkYXRhOw0KPiAgCWRldmZyZXEtPm5iLm5vdGlmaWVyX2NhbGwgPSBk
ZXZmcmVxX25vdGlmaWVyX2NhbGw7DQo+ICsJbXV0ZXhfdW5sb2NrKCZkZXZmcmVxLT5sb2NrKTsN
Cj4gIA0KPiArCWlmIChkZXZmcmVxLT5wcm9maWxlLT5tYXhfc3RhdGUgPD0gMCAmJiAhZGV2ZnJl
cS0+cHJvZmlsZS0+ZnJlcV90YWJsZSkNCj4gKwkJZGV2ZnJlcV9zZXRfZnJlcV90YWJsZShkZXZm
cmVxKTsNCj4gKw0KPiArCW11dGV4X2xvY2soJmRldmZyZXEtPmxvY2spOw0KDQpBbnl3YXksIHdo
YXQgYWJvdXQgbW9kaWZ5aW5nIHRoZSBibG9jayBhYm92ZSBhczoNCg0KKwlpZiAoIWRldmZyZXEt
PnByb2ZpbGUtPm1heF9zdGF0ZSAmJiAhZGV2ZnJlcS0+cHJvZmlsZS0+ZnJlcV90YWJsZSkgew0K
KwkJbXV0ZXhfdW5sb2NrKCZkZXZmcmVxLT5sb2NrKTsNCiAJCWRldmZyZXFfc2V0X2ZyZXFfdGFi
bGUoZGV2ZnJlcSk7DQorCQltdXRleF9sb2NrKCZkZXZmcmVxLT5sb2NrKTsNCisJfQ0KDQo+ICAJ
ZGV2ZnJlcS0+dHJhbnNfdGFibGUgPQlkZXZtX2t6YWxsb2MoZGV2LCBzaXplb2YodW5zaWduZWQg
aW50KSAqDQo+ICAJCQkJCQlkZXZmcmVxLT5wcm9maWxlLT5tYXhfc3RhdGUgKg0KPiAgCQkJCQkJ
ZGV2ZnJlcS0+cHJvZmlsZS0+bWF4X3N0YXRlLA0KW10NCg0KSWYgdGhhdCdzIG5vdCBhIHByb2Js
ZW0sIEknbGwgc3F1YXNoDQpodHRwczovL2dpdC5rZXJuZWwub3JnL2NnaXQvbGludXgva2VybmVs
L2dpdC9tengvZGV2ZnJlcS5naXQvY29tbWl0Lz9oPWZvci1yYWZhZWwmaWQ9NTVkZjJiNDNjZGI1
YWM4MmQyNmI2NGQ3MzlmM2Q3NThjOWI3NDg2Yw0Kd2l0aCB0aGUgZ2l2ZW4gcGF0Y2guDQo=


