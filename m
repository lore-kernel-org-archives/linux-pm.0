From: "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
Subject: Re: [RESEND PATCH 0/3 v4] powercap, intel_rapl, implement time
 window checks
Date: Mon, 28 Mar 2016 18:07:36 +0000
Message-ID: <1459188473.13525.33.camel@intel.com>
References: <1458563236-19269-1-git-send-email-prarit@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:5281 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751004AbcC1SHw (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 28 Mar 2016 14:07:52 -0400
In-Reply-To: <1458563236-19269-1-git-send-email-prarit@redhat.com>
Content-Language: en-US
Content-ID: <EBC14A55055F754FAABEA35332EBD282@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "prarit@redhat.com" <prarit@redhat.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "jacob.jun.pan@linux.intel.com" <jacob.jun.pan@linux.intel.com>
Cc: "Jovanovic, Radivoje" <radivoje.jovanovic@intel.com>, "s.ikarashi@jp.fujitsu.com" <s.ikarashi@jp.fujitsu.com>, "David Rajamanickam, Ajay Thomas" <ajay.thomas.david.rajamanickam@intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "minipli@googlemail.com" <minipli@googlemail.com>

K0phY29iDQoNCk9uIE1vbiwgMjAxNi0wMy0yMSBhdCAwODoyNyAtMDQwMCwgUHJhcml0IEJoYXJn
YXZhIHdyb3RlOg0KPiBUaGlzIHdhcyBzdWJtaXR0ZWQgYmFjayBpbiBEZWNlbWJlciBhbmQgbm90
IHBpY2tlZCB1cCBhZnRlciByZXZpZXcuDQo+IA0KPiBQLg0KPiANCj4gLS0tLS04PC0tLS0NCj4g
VGhlIEludGVsIEFTRE0gcHJvdmlkZXMgYSBtYXhpbXVtIHRpbWUgd2luZG93IHRoYXQgY2FuIGJl
IHNwZWNpZmllZA0KPiB3aGVuDQo+IHNldHRpbmcgYSB0aW1lIHdpbmRvdyBpbiB0aGUgUkFQTCBk
cml2ZXIuwqDCoFdoaWxlIHRoZSBBU0RNIGRvZXNuJ3QNCj4gZXhwbGljaXRseQ0KPiBwcm92aWRl
IGEgbWluaW11bSB0aW1lIHdpbmRvdyB2YWx1ZSwgaXQgZG9lcyBwcm92aWRlIGEgbWluaW11bSB0
aW1lDQo+IHdpbmRvdw0KPiB1bml0IHRoYXQgYWxzbyBjYW4gYmUgdXNlZCBhcyBhIG1pbmltdW0g
dmFsdWUuDQo+IA0KPiBUaGlzIHBhdGNoc2V0IGltcGxlbWVudHMgYmFycmllciBjaGVja2luZyBm
b3IgdGhlIHRpbWUgd2luZG93cywgYW5kDQo+IGFkZHMNCj4gcmVwb3J0aW5nIG9mIGEga25vd24g
YnVnIGluIHdoaWNoIHRoZSBtYXhtaW11bSB0aW1lIHdpbmRvdyB2YWx1ZSBtYXkNCj4gYmUNCj4g
ZXJyb25lb3VzbHkgc2V0IHRvIDAsIGFzIHdlbGwgYXMgYSBtb2R1bGUgcGFyYW1ldGVyIHRvIGF2
b2lkIHRoZQ0KPiBtYXhpbXVtDQo+IHdpbmRvdyBjaGVja3Mgb24gYnJva2VuIEJJT1Nlcy4NCj4g
DQo+IENjOiAiUmFmYWVsIEouIFd5c29ja2kiIDxyYWZhZWwuai53eXNvY2tpQGludGVsLmNvbT4N
Cj4gQ2M6IFByYXJpdCBCaGFyZ2F2YSA8cHJhcml0QHJlZGhhdC5jb20+DQo+IENjOiBSYWRpdm9q
ZSBKb3Zhbm92aWMgPHJhZGl2b2plLmpvdmFub3ZpY0BpbnRlbC5jb20+DQo+IENjOiBTZWlpY2hp
IElrYXJhc2hpIDxzLmlrYXJhc2hpQGpwLmZ1aml0c3UuY29tPg0KPiBDYzogTWF0aGlhcyBLcmF1
c2UgPG1pbmlwbGlAZ29vZ2xlbWFpbC5jb20+DQo+IENjOiBBamF5IFRob21hcyA8YWpheS50aG9t
YXMuZGF2aWQucmFqYW1hbmlja2FtQGludGVsLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogUHJhcml0
IEJoYXJnYXZhIDxwcmFyaXRAcmVkaGF0LmNvbT4NCj4gDQo+IFByYXJpdCBCaGFyZ2F2YSAoMyk6
DQo+IMKgIHBvd2VyY2FwLCBpbnRlbF9yYXBsLCBpbXBsZW1lbnQgZ2V0X21heF90aW1lX3dpbmRv
dw0KPiDCoCBwb3dlcmNhcCwgaW50ZWxfcmFwbCwgaW1wbGVtZW50IGNoZWNrIGZvciBtaW5pbXVt
IHRpbWUgd2luZG93DQo+IMKgIHBvd2VyY2FwLCBpbnRlbF9yYXBsLCBBZGQgaWdub3JlX21heF90
aW1lX3dpbmRvd19jaGVjayBtb2R1bGUNCj4gwqDCoMKgwqBwYXJhbWV0ZXIgZm9yIGJyb2tlbiBC
SU9TZXMNCj4gDQo+IMKgZHJpdmVycy9wb3dlcmNhcC9pbnRlbF9yYXBsLmPCoMKgwqB8wqDCoMKg
NTANCj4gKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+IMKgZHJpdmVy
cy9wb3dlcmNhcC9wb3dlcmNhcF9zeXMuYyB8wqDCoMKgwqA2ICsrKy0tDQo+IMKgMiBmaWxlcyBj
aGFuZ2VkLCA1NCBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiA=
