From: "Zhang, Rui" <rui.zhang@intel.com>
Subject: RE: [PATCH] intel powerclamp: support Knights Landing
Date: Wed, 24 Jun 2015 01:46:35 +0000
Message-ID: <744357E9AAD1214791ACBA4B0B9092630153079C@SHSMSX101.ccr.corp.intel.com>
References: <1429309866-63063-1-git-send-email-dasaratharaman.chandramouli@intel.com>
	 <20150424145835.53888d75@ultegra>
	 <56FD0D4EC3679746A2BD9228E7E608363E2A974D@ORSMSX114.amr.corp.intel.com>
	 <1461618.eAjGphZVRG@vostro.rjw.lan> <1435085188.29834.9.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:60718 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752459AbbFXBqk (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 23 Jun 2015 21:46:40 -0400
In-Reply-To: <1435085188.29834.9.camel@localhost>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Chandramouli, Dasaratharaman" <dasaratharaman.chandramouli@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>, Eduardo Valentin <edubezval@gmail.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Pan, Jacob jun" <jacob.jun.pan@intel.com>, "Rao, Nikhil" <nikhil.rao@intel.com>

SXQgaGFzIGJlZW4gaW4gbXkgIC1uZXh0IGJyYW5jaCBhbmQgSSB3aWxsIHNlbmQgaXQgb3V0IGZv
ciA0LjItcmMxLg0KDQpUaGFua3MsDQpydWkNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0t
LQ0KPiBGcm9tOiBDaGFuZHJhbW91bGksIERhc2FyYXRoYXJhbWFuDQo+IFNlbnQ6IFdlZG5lc2Rh
eSwgSnVuZSAyNCwgMjAxNSAyOjQ2IEFNDQo+IFRvOiBSYWZhZWwgSi4gV3lzb2NraQ0KPiBDYzog
SmFjb2IgUGFuOyBaaGFuZywgUnVpOyBFZHVhcmRvIFZhbGVudGluOyBsaW51eC1wbUB2Z2VyLmtl
cm5lbC5vcmc7DQo+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IFBhbiwgSmFjb2IganVu
OyBSYW8sIE5pa2hpbA0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBpbnRlbCBwb3dlcmNsYW1wOiBz
dXBwb3J0IEtuaWdodHMgTGFuZGluZw0KPiBJbXBvcnRhbmNlOiBIaWdoDQo+IA0KPiBPbiBUdWUs
IDIwMTUtMDYtMjMgYXQgMDE6MzkgKzAyMDAsIFJhZmFlbCBKLiBXeXNvY2tpIHdyb3RlOg0KPiA+
IE9uIE1vbmRheSwgSnVuZSAyMiwgMjAxNSAwNDo1MToxMyBQTSBDaGFuZHJhbW91bGksIERhc2Fy
YXRoYXJhbWFuDQo+IHdyb3RlOg0KPiA+ID4gQ2FuIHdlIG1ha2UgdGhpcyBwYXRjaCBhdmFpbGFi
bGUgZm9yIDQuMg0KPiA+DQo+ID4gSXQgaXMgaW5jbHVkZWQgaW4gdGhlIHBvd2VyIG1hbmFnZW1l
bnQgYW5kIEFDUEkgcHVsbCByZXF1ZXN0IGZvcg0KPiA+IDQuMS1yYzEgSSd2ZSBqdXN0IHNlbnQu
DQo+IA0KPiBJIGp1c3QgY2hlY2tlZCB0aGUgYnJhbmNoIHBtK2FjcGktNC4yLXJjMSBhbmQgaSBk
b24ndCBzZWUgdGhlIEtuaWdodHMgTGFuZGluZw0KPiBwYXRjaCBmb3IgdGhlIHBvd2VyY2xhbXAg
ZHJpdmVyIGluIHRoYXQuIEtpbmRseSB2ZXJpZnkgdGhhdCBpdCB3YXMgYWRkZWQuDQo+IA0KPiBo
dHRwczovL2xrbWwub3JnL2xrbWwvMjAxNS80LzE3Lzc5NQ0KPiANCj4gPg0KPiA+DQo+IA0KDQo=
