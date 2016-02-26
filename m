From: "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
Subject: Re: [PATCH] cpufreq: acpi_cpufreq: base frequency attribute support
Date: Fri, 26 Feb 2016 01:10:04 +0000
Message-ID: <1456448914.17628.31.camel@intel.com>
References: <1443738317-4224-1-git-send-email-srinivas.pandruvada@linux.intel.com>
	 <20151007172343.GE4557@linux> <4807388.hTIoZIhGRk@vostro.rjw.lan>
	 <20151016054226.GQ19018@linux> <1456344052.8680.208.camel@linux.intel.com>
	 <CAJZ5v0hh20C3vgWfBpRmR+oOjOf7kqP6HMLKjqzYx8h0ka_dVQ@mail.gmail.com>
	 <1456357073.3860.21.camel@linux.intel.com>
	 <20160225032700.GA2822@vireshk-i7>
	 <1456423672.17628.9.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:47132 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753225AbcBZBKI (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 25 Feb 2016 20:10:08 -0500
In-Reply-To: <1456423672.17628.9.camel@linux.intel.com>
Content-Language: en-US
Content-ID: <66CE81D42D0BD544AADE040BA84640A3@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "rafael@kernel.org" <rafael@kernel.org>

T24gVGh1LCAyMDE2LTAyLTI1IGF0IDEwOjA3IC0wODAwLCBTcmluaXZhcyBQYW5kcnV2YWRhIHdy
b3RlOg0KPiBPbiBUaHUsIDIwMTYtMDItMjUgYXQgMDg6NTcgKzA1MzAsIFZpcmVzaCBLdW1hciB3
cm90ZToNCj4gPiBPbiAyNC0wMi0xNiwgMTU6MzcsIFNyaW5pdmFzIFBhbmRydXZhZGEgd3JvdGU6
DQo+ID4gPiBHb29kIEkgdGVzdGVkIGFnYWluLg0KPiA+ID4gDQo+ID4gPiBIaSBWaXJlc2gsDQo+
ID4gPiANCj4gPiA+IEFyZSB3ZSBubyBsb25nZXIgYWxsb3dlZCB0byBjYWxsDQo+ID4gPiAJc3lz
ZnNfY3JlYXRlX2ZpbGUgaW4gY3B1ZnJlcV9kcml2ZXIuaW5pdCgpIGNhbGxiYWNrPw0KPiA+ID4g
DQo+ID4gPiBUaGUgZm9sbG93aW5nIGNhbGwgY3Jhc2hlcyBiZWNhdXNlIG9mIEJVR19PTiBmb3Ig
IWtvYmotPnNkOg0KPiA+ID4gCXN5c2ZzX2NyZWF0ZV9maWxlKCZwb2xpY3ktPmtvYmosDQo+ID4g
PiDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoA0KPiA+
ID4gJihjcHVmcmVxX2F0dHJfYmFzZV9mcmVxdWVuY3kuYXR0cikpOw0KPiA+ID4gDQo+ID4gPiBC
ZWZvcmUgSSBkZWJ1ZyBmdXJ0aGVyLCBJIHdhbnQgdG8gY2hlY2sgd2l0aCB5b3UuDQo+ID4gPiBU
aGlzIHVzZWQgdG8gd29yayBiZWZvcmUuDQo+ID4gDQo+ID4gSGF2ZW4ndCBjaGVja2VkIHRoYXQg
eWV0LCBidXQgeW91IHNob3VsZCBiZSB1c2luZw0KPiA+IGNwdWZyZXFfZHJpdmVyLmF0dHINCj4g
PiBmb3IgdGhpcw0KPiA+IGtpbmQgb2Ygc3R1ZmYsIGlzbid0IGl0ID8NCj4gSWYgSSB1c2XCoGNw
dWZyZXFfZHJpdmVyLmF0dHIsIHRoZW4gaXQgd2lsbCBjcmVhdGUgc3lzZnMgYXR0cmlidXRlIGZv
cg0KPiBldmVyeSBzeXN0ZW0gdXNpbmcgYWNwaS1jcHVmcmVxLCB3aGV0aGVyIHRoZXkgY2FuIHN1
cHBvcnQgaXQgb3Igbm90Lg0KPiBUaGlzIGNoYW5nZSBpcyBvbmx5IG5lZWRlZCBmb3IgdGhlIGxh
dGVyIGdlbmVyYXRpb24gb2YgSW50ZWwgQ1BVcw0KPiAoSXZ5QnJpZGdlIGFuZCBsYXRlcikuwqAN
Cj4gVGhlcmUgaXMgbm8gc3RhbmRhcmQgQUNQSSB3YXkgdG8ga25vdyB0aGUgYmFzZSBmcmVxdWVu
Y3kgaWYgd2UgYWRkDQo+IGF0dHJpYnV0ZSBmb3IgYWxsIHN5c3RlbXMgdXNpbmcgYWNwaS1jcHVm
cmVxLg0KPiANClRoZXJlIGlzIHVzZWQgdG8gYmUNCg0KY3B1ZnJlcV9wb2xpY3lfYWxsb2MoKSB7
DQouLg0KwqAgwqAgcmV0ID0ga29iamVjdF9pbml0X2FuZF9hZGQoJnBvbGljeS0+a29iaiwgJmt0
eXBlX2NwdWZyZXEsDQomZGV2PmtvYmosICJjcHVmcmVxIik7DQp9DQoNCk5vdyBpdCBpcyByZW1v
dmVkLCBzbyB3ZSBkb24ndCBoYXZlIGRpcmVjdG9yeSBlbnRyeSBmb3IgcG9saWN5LT5rb2JqIHRv
DQphZGQgZHVyaW5nIGluaXQoKSBjYWxsYmFjay4gTm93IHdlIGhhdmUga29iamVjdF9hZGQgYWZ0
ZXIgaW5pdCgpDQpjYWxsYmFjayByZXR1cm5zIGZvciBwb2xpY3kldS4NCg0KVGhhbmtzLA0KU3Jp
bml2YXMNCg==
