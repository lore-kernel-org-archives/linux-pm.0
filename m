From: "Zhang, Rui" <rui.zhang@intel.com>
Subject: Re: [PATCH] thermal: cpu_cooling: fix improper order during
 initialization
Date: Wed, 1 Jun 2016 14:27:45 +0000
Message-ID: <1464791265.3776.0.camel@rzhang1-mobl4>
References: <1464690722-27996-1-git-send-email-lukasz.luba@arm.com>
	 <20160601111034.GO3725@vireshk-i7> <574EE3B7.1060302@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:25310 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751648AbcFAO26 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 1 Jun 2016 10:28:58 -0400
In-Reply-To: <574EE3B7.1060302@arm.com>
Content-Language: en-US
Content-ID: <646F6078FF2A8442BB0FC322CD850F0C@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "lukasz.luba@arm.com" <lukasz.luba@arm.com>
Cc: "edubezval@gmail.com" <edubezval@gmail.com>, "amit.kachhap@gmail.com" <amit.kachhap@gmail.com>, "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "javi.merino@arm.com" <javi.merino@arm.com>

T24gV2VkLCAyMDE2LTA2LTAxIGF0IDE0OjMxICswMTAwLCBMdWthc3ogTHViYSB3cm90ZToNCj4g
DQo+IE9uIDAxLzA2LzE2IDEyOjEwLCBWaXJlc2ggS3VtYXIgd3JvdGU6DQo+ID4gT24gMzEtMDUt
MTYsIDExOjMyLCBMdWthc3ogTHViYSB3cm90ZToNCj4gPj4gVGhlIGZyZXFfdGFibGUgYXJyYXkg
aXMgbm90IHBvcHVsYXRlZCBiZWZvcmUgY2FsbGluZw0KPiA+PiB0aGVybWFsX29mX2Nvb2xpbmdf
cmVnaXN0ZXIuIFRoZSBjb2RlIHdoaWNoIHBvcHVsYXRlcyB0aGUgZnJlcSB0YWJsZSB3YXMNCj4g
Pj4gaW50cm9kdWNlZCBpbiBjb21taXQgZjY4NTkwMTQuDQo+ID4+IFRoaXMgc2hvdWxkIGJlIGRv
bmUgYmVmb3JlIHJlZ2lzdGVyaW5nIG5ldyB0aGVybWFsIGNvb2xpbmcgZGV2aWNlLg0KPiA+PiBU
aGUgbG9nIHNob3dzIGVmZmVjdHMgb2YgdGhpcyB3cm9uZyBkZWNpc2lvbi4NCj4gPj4gWyAgICAy
LjE3MjYxNF0gY3B1IGNwdTE6IEZhaWxlZCB0byBnZXQgdm9sdGFnZSBmb3IgZnJlcXVlbmN5IDE5
ODQ1MTg2NTYwMDA6IC0zNA0KPiA+PiBbICAgIDIuMjIwODYzXSBjcHUgY3B1MDogRmFpbGVkIHRv
IGdldCB2b2x0YWdlIGZvciBmcmVxdWVuY3kgMTk4NDUyNDQxNjAwMDogLTM0DQo+ID4+DQo+ID4N
Cj4gPiBZb3Ugc2hvdWxkIGhhdmUgYWRkZWQgdGhpcyBhcyB3ZWxsOg0KPiA+DQo+ID4gQ2M6IDQu
MTkrIDxzdGFibGVAdmdlci5rZXJuZWwub3JnPiAjIDQuMTkrDQo+IA0KPiBZb3UgbWVhbiAzLjE5
Kw0KPiBDYzogPHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+ICMgMy4xOSsNCj4gDQo+ID4gRml4ZXM6
IGY2ODU5MDE0YzdlNyAoInRoZXJtYWw6IGNwdV9jb29saW5nOiBTdG9yZSBmcmVxdWVuY2llcyBp
biBkZXNjZW5kaW5nIG9yZGVyIikNCj4gPg0KPiA+PiBTaWduZWQtb2ZmLWJ5OiBMdWthc3ogTHVi
YSA8bHVrYXN6Lmx1YmFAYXJtLmNvbT4NCj4gPj4gLS0tDQo+ID4+ICAgZHJpdmVycy90aGVybWFs
L2NwdV9jb29saW5nLmMgfCAxNiArKysrKysrKy0tLS0tLS0tDQo+ID4+ICAgMSBmaWxlIGNoYW5n
ZWQsIDggaW5zZXJ0aW9ucygrKSwgOCBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IEFja2VkLWJ5OiBW
aXJlc2ggS3VtYXIgPHZpcmVzaC5rdW1hckBsaW5hcm8ub3JnPg0KPiA+DQo+IEVkdWFyZG8gY2Fu
IHlvdSBwaWNrIHRoZXNlIHRhZ3Mgd2hlbiB5b3UgbWVyZ2UgaXQ/DQoNClBhdGNoIHF1ZXVlZCBm
b3IgLXJjMi4gOikNCg0KdGhhbmtzLA0KcnVpDQo=
