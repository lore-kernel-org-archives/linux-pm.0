From: "Luc, Piotr" <Piotr.Luc@intel.com>
Subject: Re: [RESEND PATCH 00/11] Add Knights Mill CPU ID
Date: Mon, 24 Oct 2016 16:13:42 +0000
Message-ID: <1477325307.3927.28.camel@intel.com>
References: <20161013153105.2517-1-piotr.luc@intel.com>
         <1692747.lfetUOsc0x@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:2328 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752030AbcJXQNs (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 24 Oct 2016 12:13:48 -0400
In-Reply-To: <1692747.lfetUOsc0x@vostro.rjw.lan>
Content-Language: en-US
Content-ID: <8E6B024DCCAEC049A71D957D550A94C0@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Brown, Len" <len.brown@intel.com>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "jacob.jun.pan@linux.intel.com" <jacob.jun.pan@linux.intel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "mchehab@kernel.org" <mchehab@kernel.org>, "x86@kernel.org" <x86@kernel.org>, "dougthompson@xmission.com" <dougthompson@xmission.com>, "hpa@zytor.com" <hpa@zytor.com>, "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>, "mingo@redhat.com" <mingo@redhat.com>, "srinivas.pandruvada@linux.intel.com" <srinivas.pandruvada@linux.intel.com>, "bp@alien8.de" <bp@alien8.de>, "lenb@kernel.org" <lenb@kernel.org>, "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>

T24gVGh1LCAyMDE2LTEwLTEzIGF0IDIzOjU2ICswMjAwLCBSYWZhZWwgSi4gV3lzb2NraSB3cm90
ZToNCj4gT24gVGh1cnNkYXksIE9jdG9iZXIgMTMsIDIwMTYgMDU6MzA6NTQgUE0gUGlvdHIgTHVj
IHdyb3RlOg0KPiA+IA0KPiA+IFBpb3RyIEx1YyAoMTEpOg0KPiA+IMKgIEVEQUMsIHNiX2VkYWM6
IFVzZSBJbnRlbCBmYW1pbHkgcHJvY2Vzc29yIG1hY3Jvcw0KPiA+IMKgIHRvb2xzL3Bvd2VyIHR1
cmJvc3RhdDogVXNlIEludGVsIGZhbWlseSBwcm9jZXNzb3IgbWFjcm9zDQo+ID4gwqAgeDg2L2Nw
dS9pbnRlbDogQWRkIEtuaWdodHMgTWlsbCB0byBJbnRlbCBmYW1pbHkNCj4gPiDCoCB4ODYvaW50
ZWxfaWRsZTogQWRkIEtuaWdodHMgTWlsbCBDUFVJRA0KPiA+IMKgIEVEQUMsIHNiX2VkYWM6IEFk
ZCBLbmlnaHRzIE1pbGwgQ1BVSUQNCj4gPiDCoCBjcHVmcmVxOiBpbnRlbF9wc3RhdGU6IEFkZCBL
bmlnaHRzIE1pbGwgQ1BVSUQNCj4gPiDCoCBwZXJmL3g4Ni9pbnRlbDogQWRkIEtuaWdodHMgTWls
bCBDUFVJRA0KPiA+IMKgIHBlcmYveDg2L2ludGVsL3JhcGw6IEFkZCBLbmlnaHRzIE1pbGwgQ1BV
SUQNCj4gPiDCoCBwZXJmL3g4Ni9pbnRlbC91bmNvcmU6IEFkZCBLbmlnaHRzIE1pbGwgQ1BVSUQN
Cj4gPiDCoCBwb3dlcmNhcCAvIFJBUEw6IEFkZCBLbmlnaHRzIE1pbGwgQ1BVSUQNCj4gPiDCoCB0
b29scy9wb3dlciB0dXJib3N0YXQ6IGVuYWJsZSB0dXJib3N0YXQgdG8gc3VwcG9ydCBLbmlnaHRz
IE1pbGwNCj4gPiAoS05NKQ0KPiA+IA0KPiA+IMKgYXJjaC94ODYvZXZlbnRzL2ludGVsL2NvcmUu
Y8KgwqDCoMKgwqDCoMKgwqDCoMKgfMKgwqDCoDMgKy0NCj4gPiDCoGFyY2gveDg2L2V2ZW50cy9p
bnRlbC9yYXBsLmPCoMKgwqDCoMKgwqDCoMKgwqDCoHzCoMKgwqAxICsNCj4gPiDCoGFyY2gveDg2
L2V2ZW50cy9pbnRlbC91bmNvcmUuY8KgwqDCoMKgwqDCoMKgwqB8wqDCoMKgMSArDQo+ID4gwqBh
cmNoL3g4Ni9pbmNsdWRlL2FzbS9pbnRlbC1mYW1pbHkuaMKgwqDCoHzCoMKgwqAxICsNCj4gPiDC
oGRyaXZlcnMvY3B1ZnJlcS9pbnRlbF9wc3RhdGUuY8KgwqDCoMKgwqDCoMKgwqB8wqDCoMKgMSAr
DQo+ID4gwqBkcml2ZXJzL2VkYWMvc2JfZWRhYy5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqB8wqDCoDE0ICstDQo+ID4gwqBkcml2ZXJzL2lkbGUvaW50ZWxfaWRsZS5jwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqB8wqDCoMKgMSArDQo+ID4gwqBkcml2ZXJzL3Bvd2VyY2FwL2ludGVs
X3JhcGwuY8KgwqDCoMKgwqDCoMKgwqDCoHzCoMKgwqAxICsNCj4gPiDCoHRvb2xzL3Bvd2VyL3g4
Ni90dXJib3N0YXQvTWFrZWZpbGXCoMKgwqDCoHzCoMKgwqAzICstDQo+ID4gwqB0b29scy9wb3dl
ci94ODYvdHVyYm9zdGF0L3R1cmJvc3RhdC5jIHwgMjUwICsrKysrKysrKysrKysrKysrKy0tDQo+
ID4gLS0tLS0tLS0tLS0tLS0NCj4gPiDCoDEwIGZpbGVzIGNoYW5nZWQsIDE0NyBpbnNlcnRpb25z
KCspLCAxMjkgZGVsZXRpb25zKC0pDQo+IA0KPiBMZW4sIEphY29iLCBhbnkgcHJvYmxlbXMgd2l0
aCBhbnkgb2YgdGhlIHBhdGNoZXMgaW4gdGhpcyBzZXJpZXM/DQo+IA0KPiBUaGFua3MsDQo+IFJh
ZmFlbA0KDQpIaQ0KDQpJIHdvbmRlciBpZiB5b3UgY291bGQgc2hhcmUgd2l0aCBtZSB3aGF0IEkg
bmVlZCB0byBkbyBtb3JlIHRvIG1ha2UgdGhlDQpwYXRjaGVzIGJlIGFjY2VwdGVkPw0KRG8gSSBu
ZWVkIHRvIHJlc2VuZCB0aGUgb25lcyB0aGF0IGFyZW4ndCBhY2NlcHRlZCB5ZXQ/DQoNClJlZ2Fy
ZHMsDQpQaW90cg0K
