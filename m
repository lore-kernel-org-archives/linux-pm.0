From: MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: Re: [linux-next PATCH 6/7] PM / devfreq: allow sysfs governor node to
 switch governor
Date: Tue, 06 Nov 2012 09:02:16 +0000 (GMT)
Message-ID: <31153640.425391352192535931.JavaMail.weblogic@epml11>
Reply-To: myungjoo.ham@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset=euc-kr
Content-Transfer-Encoding: base64
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:8748 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750951Ab2KFJCS (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 6 Nov 2012 04:02:18 -0500
Received: from epcpsbge8.samsung.com (epcpsbge8 [203.254.230.18])
 by mailout4.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0MD2002NQ6E9UZD0@mailout4.samsung.com> for
 linux-pm@vger.kernel.org; Tue, 06 Nov 2012 18:02:16 +0900 (KST)
MIME-version: 1.0
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Nishanth Menon <nm@ti.com>, linux-pm <linux-pm@vger.kernel.org>
Cc: Rajagopal Venkat <rajagopal.venkat@linaro.org>, =?euc-kr?Q?=B9=DA=B0=E6=B9=CE?= <kyungmin.park@samsung.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, Kevin Hilman <khilman@ti.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

PiAtLS0gYS9kcml2ZXJzL2RldmZyZXEvZGV2ZnJlcS5jDQo+ICsrKyBiL2RyaXZlcnMvZGV2ZnJl
cS9kZXZmcmVxLmMNCj4gQEAgLTYyOSw2ICs2MjksNDQgQEAgc3RhdGljIHNzaXplX3Qgc2hvd19n
b3Zlcm5vcihzdHJ1Y3QgZGV2aWNlICpkZXYsDQo+ICAJcmV0dXJuIHNwcmludGYoYnVmLCAiJXNc
biIsIHRvX2RldmZyZXEoZGV2KS0+Z292ZXJub3ItPm5hbWUpOw0KPiAgfQ0KPiAgDQo+ICtzdGF0
aWMgc3NpemVfdCBzdG9yZV9nb3Zlcm5vcihzdHJ1Y3QgZGV2aWNlICpkZXYsIHN0cnVjdCBkZXZp
Y2VfYXR0cmlidXRlICphdHRyLA0KPiArCQkJICAgICAgY29uc3QgY2hhciAqYnVmLCBzaXplX3Qg
Y291bnQpDQo+ICt7DQo+ICsJc3RydWN0IGRldmZyZXEgKmRmID0gdG9fZGV2ZnJlcShkZXYpOw0K
PiArCWludCByZXQgPSAwOw0KPiArCXN0cnVjdCBkZXZmcmVxX2dvdmVybm9yICpnb3Zlcm5vcjsN
Cj4gKw0KPiArCW11dGV4X2xvY2soJmRldmZyZXFfbGlzdF9sb2NrKTsNCg0KUGxlYXNlIHJlbW92
ZSB0aGUgdHJhaWxpbmcgXG4gZnJvbSBidWYgaGVyZS4NCldoZW4gdXNlciBlbnRlcnMgInVzZXJz
cGFjZSIsIGJ1ZiBnZXRzICJ1c2Vyc3BhY2VcbiIuDQoNCldpdGggc29tZSBwcmludGtzIGluIGZp
bmRfZGV2ZnJlcV9nb3Zlcm5vciAocHJpbnRpbmcgdGhlIGJ1ZiBhbmQgZ292ZXJub3IgbmFtZXMp
Og0KDQojIGVjaG8gdXNlcnNwYWNlID4gL3N5cy9jbGFzcy9kZXZmcmVxL2V4eW5vczQyMTAtYnVz
ZnJlcS4wL2dvdmVybm9yDQpbICAgNjUuOTc1MDAwXSBbdXNlcnNwYWNlDQpbICAgNjUuOTc1MDAw
XSBdLlt1c2Vyc3BhY2VdDQpbICAgNjUuOTgwMDAwXSBbdXNlcnNwYWNlDQpbICAgNjUuOTgwMDAw
XSBdLltwb3dlcnNhdmVdDQpbICAgNjUuOTg1MDAwXSBbdXNlcnNwYWNlDQpbICAgNjUuOTg1MDAw
XSBdLltwZXJmb3JtYW5jZV0NClsgICA2NS45OTAwMDBdIFt1c2Vyc3BhY2UNClsgICA2NS45OTAw
MDBdIF0uW3NpbXBsZV9vbmRlbWFuZF0NClsgICA2NS45OTUwMDBdIGVyciBubyA9IC0xOQ0KIyAN
Cg0KDQoNCg0KDQpDaGVlcnMsDQpNeXVuZ0pvbw0KDQo+ICsJZ292ZXJub3IgPSBmaW5kX2RldmZy
ZXFfZ292ZXJub3IoYnVmKTsNCj4gKwlpZiAoSVNfRVJSKGdvdmVybm9yKSkgew0KPiArCQlyZXQg
PSBQVFJfRVJSKGdvdmVybm9yKTsNCj4gKwkJZ290byBvdXQ7DQo+ICsJfQ0KPiArCWlmIChkZi0+
Z292ZXJub3IgPT0gZ292ZXJub3IpDQo+ICsJCWdvdG8gb3V0Ow0KPiArDQo+ICsJaWYgKGRmLT5n
b3Zlcm5vcikgew0KPiArCQlyZXQgPSBkZi0+Z292ZXJub3ItPmV2ZW50X2hhbmRsZXIoZGYsIERF
VkZSRVFfR09WX1NUT1AsIE5VTEwpOw0KPiArCQlpZiAocmV0KSB7DQo+ICsJCQlkZXZfd2Fybihk
ZXYsICIlczogR292ZXJub3IgJXMgbm90IHN0b3BwZWQoJWQpXG4iLA0KPiArCQkJCSBfX2Z1bmNf
XywgZGYtPmdvdmVybm9yLT5uYW1lLCByZXQpOw0KPiArCQkJZ290byBvdXQ7DQo+ICsJCX0NCj4g
Kwl9DQo+ICsJZGYtPmdvdmVybm9yID0gZ292ZXJub3I7DQo+ICsJc3RybmNweShkZi0+Z292ZXJu
b3JfbmFtZSwgZ292ZXJub3ItPm5hbWUsIERFVkZSRVFfTkFNRV9MRU4pOw0KPiArCXJldCA9IGRm
LT5nb3Zlcm5vci0+ZXZlbnRfaGFuZGxlcihkZiwgREVWRlJFUV9HT1ZfU1RBUlQsIE5VTEwpOw0K
PiArCWlmIChyZXQpDQo+ICsJCWRldl93YXJuKGRldiwgIiVzOiBHb3Zlcm5vciAlcyBub3Qgc3Rh
cnRlZCglZClcbiIsDQo+ICsJCQkgX19mdW5jX18sIGRmLT5nb3Zlcm5vci0+bmFtZSwgcmV0KTsN
Cj4gK291dDoNCj4gKwltdXRleF91bmxvY2soJmRldmZyZXFfbGlzdF9sb2NrKTsNCj4gKw0KPiAr
CWlmICghcmV0KQ0KPiArCQlyZXQgPSBjb3VudDsNCj4gKwlyZXR1cm4gcmV0Ow0KPiArfQ0KPiAr
DQpbXQ0K


