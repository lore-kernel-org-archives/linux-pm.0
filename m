From: =?euc-kr?B?x9S47cHW?= <myungjoo.ham@samsung.com>
Subject: Re: Re: [PATCH] PM / devfreq: Use freq_table for available_frequencies
Date: Tue, 15 Apr 2014 06:30:10 +0000 (GMT)
Message-ID: <1368716.232331397543409452.JavaMail.weblogic@epv6ml06>
Reply-To: myungjoo.ham@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset=euc-kr
Content-Transfer-Encoding: base64
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:29195 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752008AbaDOGaU (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 15 Apr 2014 02:30:20 -0400
Received: from epcpsbgr2.samsung.com
 (u142.gpu120.samsung.co.kr [203.254.230.142])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N4200J0J7EAZJ00@mailout2.samsung.com> for
 linux-pm@vger.kernel.org; Tue, 15 Apr 2014 15:30:10 +0900 (KST)
MIME-version: 1.0
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Saravana Kannan <skannan@codeaurora.org>
Cc: =?euc-kr?Q?=B9=DA=B0=E6=B9=CE?= <kyungmin.park@samsung.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

PiBPbiAwNC8xNC8yMDE0IDA2OjM2IFBNLCDH1LjtwdYgd3JvdGU6DQo+ID4+IE15dW5nSm9vL0t5
dW5nbWluLA0KPiA+Pg0KPiA+PiBCdW1wLiBDYW4gd2UgYWNjZXB0IHRoaXMgcGF0Y2ggcGxlYXNl
Pw0KPiA+Pg0KPiA+PiAtU2FyYXZhbmENCj4gPiANCj4gPiBOYWNrLg0KPiA+IA0KPiA+IFBsZWFz
ZSBub3RlIHRoYXQgZnJlcV90YWJsZSBpcyBhbHNvIGFuIG9wdGlvbmFsIHZhbHVlLCB3aGljaCBt
YXkNCj4gPiBiZSBudWxsLg0KPiANCj4gQWgsIEkgc2F3IHRoYXQgdGhlIG1heF9mcmVxIHdvdWxk
IGJlIHplcm8gaWYgZnJlcV90YWJsZSB3YXMgTlVMTCBhbmQgSQ0KPiBhc3N1bWVkIHRoYXQgaXQg
Y2FuJ3QgYmUgTlVMTC4gQnV0IEkgc2VlIHRoYXQgdGhlIG1heF9mcmVxIGxpbWl0IGlzIG5vdA0K
PiBhcHBsaWVkIGlmIGl0J3MgemVyby4gVGhhbmtzIGZvciBjYXRjaGluZyBpdC4NCj4gDQo+ID4g
QmVzaWRlcywgcGxlYXNlIGJlIGF3YXJlIHRoYXQgeW91ciBjb2RlIGlzIHVuZGVyIHJjdV9yZWFk
X2xvY2soKS4NCj4gDQo+IFZhbGlkIHBvaW50LiBJIHdhcyBqdXN0IHRyeWluZyB0byBrZWVwIHRo
ZSBkaWZmIHNpbXBsZS4gTm8gb25lJ3MgcmVhbGx5DQo+IGdvaW5nIHRvIGJlIGNhdHRpbmcgdGhp
cyBmaWxlIG9mdGVuIHdoZW4gcGVyZm9ybWFuY2UgbWF0dGVycy4NCj4gDQo+ID4gDQo+ID4gDQo+
ID4gQ2hlZXJzLA0KPiA+IE15dW5nSm9vLg0KPiA+IA0KPiA+IHBzLiBJJ2xsIHNlbmQgYSByZWxh
dGVkIHBhdGNoIChhdm9pZCBhY2Nlc3NpbmcgbnVsbCBidXQgbm90LWFuLWVycm9yDQo+ID4gcG9p
bnRlciBhdCBvdGhlciBzeXNmcyBub2RlcykuIFRoYW5rIHlvdSBmb3IgbGV0dGluZyBtZSBjYXRj
aCBzdWNoIGJ1Z3MgYW55d2F5Lg0KPiANCj4gSSBjYW4gZ28gYWhlYWQgYW5kIGRvIHRoaXMgbXlz
ZWxmIGlmIHlvdSBkb24ndCBtaW5kLg0KDQpObywgd2UgZG9uJ3QgbmVlZCBpdC4gSXQgd2FzIGEg
ZmFsc2UgYWxhcm0uDQpSZWFkaW5nIGFnYWluLCBJJ3ZlIGZvdW5kIHRoYXQgd2UndmUgYWxyZWFk
eSBtYWRlIG90aGVyIHN5c2ZzIG5vZGVzDQpjaGVjayBpZiBlaXRoZXIgZnJlcV90YWJsZSBpcyBu
dWxsIG9yIGl0cyBzaXplIGlzIDAuDQoNClNvLCB3ZSBvbmx5IG5lZWQgdG8gbG9vayBhdCB0aGlz
IGF2YWlsYWJsZV9mcmVxdWVuY2llcyBub2RlIG5vdy4NCg0KSSdsbCBhZGQgc29tZSBub3RlcyBv
biB0aGUgQUJJIGRvYyBmb3IgYXZhaWxhYmxlX2ZyZXF1ZW5jaWVzIHNvb24uDQoNCkNoZWVycywN
Ck15dW5nSm9vLg0KDQo+IA0KPiAtU2FyYXZhbmENCj4gDQo+IC0tIA0KPiBUaGUgUXVhbGNvbW0g
SW5ub3ZhdGlvbiBDZW50ZXIsIEluYy4gaXMgYSBtZW1iZXIgb2YgdGhlIENvZGUgQXVyb3JhIEZv
cnVtLA0KPiBob3N0ZWQgYnkgVGhlIExpbnV4IEZvdW5kYXRpb24NCj4gDQo+IA0KPiANCj4gICAg
ICAgIA0KPiAgIA0KPiAgICAgICAgICANCj4gDQo=


