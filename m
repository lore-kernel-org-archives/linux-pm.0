From: "Luc, Piotr" <Piotr.Luc@intel.com>
Subject: RE: [RESEND PATCH 06/11] cpufreq: intel_pstate: Add Knights Mill
 CPUID
Date: Wed, 30 Nov 2016 22:16:10 +0000
Message-ID: <0BC42268B923E242A424F71EDDF4784F74ACF307@IRSMSX106.ger.corp.intel.com>
References: <20161013153105.2517-1-piotr.luc@intel.com>
 <20161013153105.2517-7-piotr.luc@intel.com>
 <1476381119.114531.61.camel@linux.intel.com>
 <1477392172.9496.2.camel@intel.com>
 <CAJZ5v0jDGaM9M_aZz_8mHD1UpY3khRrWNVXR_BQwnMYDx+t0xw@mail.gmail.com>
 <1477395555.26677.2.camel@intel.com> <1480522710.10089.9.camel@intel.com>
 <CAJZ5v0jS+VDEqbqTMv6-KzYSVRxnjv5qFcZUNaR5iFhf7XJ9Ug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:11516 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756512AbcK3WQP (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 30 Nov 2016 17:16:15 -0500
In-Reply-To: <CAJZ5v0jS+VDEqbqTMv6-KzYSVRxnjv5qFcZUNaR5iFhf7XJ9Ug@mail.gmail.com>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "srinivas.pandruvada@linux.intel.com" <srinivas.pandruvada@linux.intel.com>, "lenb@kernel.org" <lenb@kernel.org>, "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "x86@kernel.org" <x86@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

VGhhbmtzIQ0KUGlvdHINCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBy
and5c29ja2lAZ21haWwuY29tIFttYWlsdG86cmp3eXNvY2tpQGdtYWlsLmNvbV0gT24gQmVoYWxm
IE9mDQo+IFJhZmFlbCBKLiBXeXNvY2tpDQo+IFNlbnQ6IFdlZG5lc2RheSwgTm92ZW1iZXIgMzAs
IDIwMTYgMTE6MDIgUE0NCj4gVG86IEx1YywgUGlvdHIgPFBpb3RyLkx1Y0BpbnRlbC5jb20+DQo+
IENjOiByYWZhZWxAa2VybmVsLm9yZzsgc3Jpbml2YXMucGFuZHJ1dmFkYUBsaW51eC5pbnRlbC5j
b207DQo+IGxlbmJAa2VybmVsLm9yZzsgdmlyZXNoLmt1bWFyQGxpbmFyby5vcmc7IGxpbnV4LWtl
cm5lbEB2Z2VyLmtlcm5lbC5vcmc7DQo+IHJqd0Byand5c29ja2kubmV0OyB4ODZAa2VybmVsLm9y
ZzsgbGludXgtcG1Admdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUkVTRU5EIFBBVENI
IDA2LzExXSBjcHVmcmVxOiBpbnRlbF9wc3RhdGU6IEFkZCBLbmlnaHRzIE1pbGwNCj4gQ1BVSUQN
Cj4gDQo+IE9uIFdlZCwgTm92IDMwLCAyMDE2IGF0IDU6MTkgUE0sIEx1YywgUGlvdHIgPFBpb3Ry
Lkx1Y0BpbnRlbC5jb20+IHdyb3RlOg0KPiA+IEhpIFJhZmFlbCwNCj4gPg0KPiA+PiA+ID4NCj4g
Pj4gPiA+IFRoZSBtZW50aW9uZWQgcGF0aCAwMy8xMSBpcyBhbHJlYWR5IG1lcmdlZCBpbiA0Ljku
cmMyLg0KPiA+PiA+DQo+ID4+ID4gSWYgaXQncyBhbHJlYWR5IHRoZXJlLCBJIGNhbiBwaWNrIHVw
IHRoZSBpbnRlbF9wc3RhdGUgb25lLg0KPiA+PiA+DQo+ID4+ID4gVGhhbmtzLA0KPiA+PiA+ID4N
Cj4gPj4gPiA+IFJhZmFlbA0KPiA+Pg0KPiA+PiBIZXJlIGlzIHRoZSBjb21taXQgaHR0cDovL2dp
dC5rZXJuZWwub3JnL2NnaXQvbGludXgva2VybmVsL2dpdC90b3J2YWwNCj4gPj4gZHMNCj4gPj4g
L2xpbnV4LmdpdC9jb21taXQvP2lkPTAwNDdmNTk4MzRlNTk0N2Q0NWYzNGY1ZjEyZWIzMzBkMTU4
ZjcwMGINCj4gPj4NCj4gPg0KPiA+IENvdWxkIHlvdSBjb25maXJtIHRoYXQgaXQgaXMgaW4geW91
ciBxdWV1ZSBvciB0cmVlIGZvciB2NC4xMD8NCj4gDQo+IEluIGZhY3QgaXQgd2Fzbid0LCBzbyBx
dWV1aW5nIGl0IHVwIG5vdy4NCj4gDQo+IFRoYW5rcyBmb3IgdGhlIHJlbWluZGVyIQ0KPiANCj4g
UmFmYWVsDQo=
