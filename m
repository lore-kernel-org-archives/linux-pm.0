From: "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
Subject: Re: [PATCH] cpufreq: intel_pstate: fix
 intel_pstate_use_acpi_profile helper
Date: Mon, 14 Nov 2016 17:53:02 +0000
Message-ID: <1479145979.6544.19.camel@intel.com>
References: <20161114164216.2657919-1-arnd@arndb.de>
         <1479143663.6544.11.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:64178 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752781AbcKNRxF (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 14 Nov 2016 12:53:05 -0500
In-Reply-To: <1479143663.6544.11.camel@linux.intel.com>
Content-Language: en-US
Content-ID: <5084DB92D244C143AB2954DD85749832@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "arnd@arndb.de" <arnd@arndb.de>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>
Cc: "lenb@kernel.org" <lenb@kernel.org>, "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>, "Gasparini, Stephane" <stephane.gasparini@intel.com>, "philippe.longepe@linux.intel.com" <philippe.longepe@linux.intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

T24gTW9uLCAyMDE2LTExLTE0IGF0IDA5OjE0IC0wODAwLCBTcmluaXZhcyBQYW5kcnV2YWRhIHdy
b3RlOg0KPiBPbiBNb24sIDIwMTYtMTEtMTQgYXQgMTc6NDEgKzAxMDAsIEFybmQgQmVyZ21hbm4g
d3JvdGU6DQo+ID4gDQo+ID4gVGhlIG5ld2x5IGFkZGVkIGZ1bmN0aW9uIHVzZXMgdHdvIGRpZmZl
cmVudCBwcm90b3R5cGVzIGRlcGVuZGluZw0KPiA+IG9uIGNvbmZpZ3VyYXRpb24sIGFuZCBvbmUg
b2YgdGhlbSBkb2VzIG5vdCBtYXRjaCB0aGUgY2FsbGVyOg0KPiA+IA0KPiA+IGRyaXZlcnMvY3B1
ZnJlcS9pbnRlbF9wc3RhdGUuYzogSW4gZnVuY3Rpb24g4oCYY29weV9jcHVfZnVuY3PigJk6DQo+
ID4gZHJpdmVycy9jcHVmcmVxL2ludGVsX3BzdGF0ZS5jOjE3OTg6MjogZXJyb3I6IHRvbyBmZXcg
YXJndW1lbnRzIHRvDQo+ID4gZnVuY3Rpb24g4oCYaW50ZWxfcHN0YXRlX3VzZV9hY3BpX3Byb2Zp
bGXigJkNCj4gPiANCj4gPiBUaGlzIGNoYW5nZXMgaXQgdG8gbG9vayBsaWtlIHRoZSBvdGhlciBv
bmUuDQo+IFNvcnJ5IGFib3V0IHRoYXQuDQoNClNpbmNlIHRoaXMgaXMgYSBjb21waWxlIGlzc3Vl
IGZvciB4ODYgbm9uIEFDUEkgc3lzdGVtcywgd2hpY2ggd2lsbCBiZSBhDQpwcm9ibGVtIGZvciBn
aXQgYmlzZWN0LCBpdCBpcyBiZXR0ZXIgdG8gcmVzdWJtaXQgbXkgcGF0Y2ggd2l0aCB0aGUgZml4
Lg0KDQpUaGFua3MsDQpTcmluaXZhcw0K
