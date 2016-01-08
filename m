From: "Yang, Wenyou" <Wenyou.Yang@atmel.com>
Subject: RE: [PATCH 1/2] power: act8945a: add charger driver for ACT8945A
Date: Fri, 8 Jan 2016 07:58:42 +0000
Message-ID: <B256D81BAE5131468A838E5D7A243641D63E5D8D@penmbx01>
References: <1452219225-10510-1-git-send-email-wenyou.yang@atmel.com>
 <1452219225-10510-2-git-send-email-wenyou.yang@atmel.com>
 <CAJKOXPdzYJP_9DZUTz3EXPu4Z-DwkzYOJKEiR8varKJP3RRymw@mail.gmail.com>
 <B256D81BAE5131468A838E5D7A243641D63E5A3E@penmbx01>
 <568F5F15.8050602@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from eusmtp01.atmel.com ([212.144.249.242]:16586 "EHLO
	eusmtp01.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751213AbcAHH7D (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 8 Jan 2016 02:59:03 -0500
In-Reply-To: <568F5F15.8050602@samsung.com>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, "Ferre, Nicolas" <Nicolas.FERRE@atmel.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

SGVsbG8gS3J6eXN6dG9mLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206
IEtyenlzenRvZiBLb3psb3dza2kgW21haWx0bzprLmtvemxvd3NraUBzYW1zdW5nLmNvbV0NCj4g
U2VudDogMjAxNuW5tDHmnIg45pelIDE1OjAzDQo+IFRvOiBZYW5nLCBXZW55b3UgPFdlbnlvdS5Z
YW5nQGF0bWVsLmNvbT4NCj4gQ2M6IFNlYmFzdGlhbiBSZWljaGVsIDxzcmVAa2VybmVsLm9yZz47
IERtaXRyeSBFcmVtaW4tU29sZW5pa292DQo+IDxkYmFyeXNoa292QGdtYWlsLmNvbT47IERhdmlk
IFdvb2Rob3VzZSA8ZHdtdzJAaW5mcmFkZWFkLm9yZz47IFJvYg0KPiBIZXJyaW5nIDxyb2JoK2R0
QGtlcm5lbC5vcmc+OyBQYXdlbCBNb2xsIDxwYXdlbC5tb2xsQGFybS5jb20+OyBNYXJrDQo+IFJ1
dGxhbmQgPG1hcmsucnV0bGFuZEBhcm0uY29tPjsgSWFuIENhbXBiZWxsIDxpamMrZGV2aWNldHJl
ZUBoZWxsaW9uLm9yZy51az47DQo+IEt1bWFyIEdhbGEgPGdhbGFrQGNvZGVhdXJvcmEub3JnPjsg
RmVycmUsIE5pY29sYXMNCj4gPE5pY29sYXMuRkVSUkVAYXRtZWwuY29tPjsgbGludXgtYXJtLWtl
cm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVsLm9y
ZzsgbGludXgtcG1Admdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMS8yXSBw
b3dlcjogYWN0ODk0NWE6IGFkZCBjaGFyZ2VyIGRyaXZlciBmb3IgQUNUODk0NUENCj4gDQo+IE9u
IDA4LjAxLjIwMTYgMTU6NDMsIFlhbmcsIFdlbnlvdSB3cm90ZToNCj4gDQo+IFsuLi5dDQo+IA0K
PiA+Pj4gK3N0YXRpYyBzdHJ1Y3QgcGxhdGZvcm1fZHJpdmVyIGFjdDg5NDVhX2NoYXJnZXJfZHJp
dmVyID0gew0KPiA+Pj4gKyAgICAgICAuZHJpdmVyID0gew0KPiA+Pj4gKyAgICAgICAgICAgICAg
IC5uYW1lID0gImFjdDg5NDVhLWNoYXJnZXIiLA0KPiA+Pj4gKyAgICAgICB9LA0KPiA+Pj4gKyAg
ICAgICAucHJvYmUgID0gYWN0ODk0NWFfY2hhcmdlcl9wcm9iZSwNCj4gPj4+ICsgICAgICAgLnJl
bW92ZSA9IGFjdDg5NDVhX2NoYXJnZXJfcmVtb3ZlLCB9Ow0KPiA+Pj4gKw0KPiA+Pj4gK3N0YXRp
YyBpbnQgX19pbml0IGFjdDg5NDVhX2NoYXJnZXJfaW5pdCh2b2lkKSB7DQo+ID4+PiArICAgICAg
IHJldHVybiBwbGF0Zm9ybV9kcml2ZXJfcmVnaXN0ZXIoJmFjdDg5NDVhX2NoYXJnZXJfZHJpdmVy
KTsNCj4gPj4+ICt9DQo+ID4+PiArc3Vic3lzX2luaXRjYWxsKGFjdDg5NDVhX2NoYXJnZXJfaW5p
dCk7DQo+ID4+DQo+ID4+IFdoeSBzdWJzeXNfaW5pdGNhbGw/IFRoaXMgc2hvdWxkIGJlIHJlZ3Vs
YXIgbW9kdWxlX3BsYXRmb3JtX2RyaXZlci4NCj4gPg0KPiA+IEkgd2FudCBpdCB0byByZWdpc3Rl
ciBlYXJseSBlbm91Z2ggYXMgTUZELiAgTWF5YmUgSSBhbSB3cm9uZy4NCj4gDQo+IE5vLCB5b3Ug
c2hvdWxkbid0IG1hbnVhbGx5IG9yZGVyIHRoZSBwcm9iaW5nIGJ5IGluaXRjYWxscy4gVGhpcyBz
aG91bGQgYmUNCj4gcmVnaXN0ZXJlZCBhcyB1c3VhbCBhbmQsIGlmIG5lZWRlZCwgc3VwcG9ydCBk
ZWZlcnJlZCBwcm9iaW5nLiBJbiB0aGlzIGNhc2UgSSBldmVuDQo+IGNhbid0IGZpbmQgYW55IHJl
YXNvbiB0byByZWdpc3RlciBpdCBlYXJsaWVyIHRoYW4gdXN1YWwuDQoNCk9LLCBJIHdpbGwgY2hh
bmdlIGl0Lg0KDQpUaGFua3MuDQoNCkJlc3QgUmVnYXJkcywNCldlbnlvdSBZYW5nDQo=
