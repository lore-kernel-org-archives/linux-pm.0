From: "R, Durgadoss" <durgadoss.r@intel.com>
Subject: RE: [PATCH 2/8] Thermal: Create zone level APIs
Date: Fri, 8 Feb 2013 08:54:12 +0000
Message-ID: <4D68720C2E767A4AA6A8796D42C8EB5927AAB1@BGSMSX101.gar.corp.intel.com>
References: <1360061183-14137-1-git-send-email-durgadoss.r@intel.com>
	 <1360061183-14137-3-git-send-email-durgadoss.r@intel.com>
 <1360311092.2242.28.camel@rzhang1-mobl4>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:28123 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1946115Ab3BHIyR (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 8 Feb 2013 03:54:17 -0500
In-Reply-To: <1360311092.2242.28.camel@rzhang1-mobl4>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Zhang, Rui" <rui.zhang@intel.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "eduardo.valentin@ti.com" <eduardo.valentin@ti.com>, "hongbo.zhang@linaro.org" <hongbo.zhang@linaro.org>, "wni@nvidia.com" <wni@nvidia.com>

SGkgUnVpLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFpoYW5nLCBS
dWkNCj4gU2VudDogRnJpZGF5LCBGZWJydWFyeSAwOCwgMjAxMyAxOjQyIFBNDQo+IFRvOiBSLCBE
dXJnYWRvc3MNCj4gQ2M6IGxpbnV4LXBtQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZn
ZXIua2VybmVsLm9yZzsNCj4gZWR1YXJkby52YWxlbnRpbkB0aS5jb207IGhvbmdiby56aGFuZ0Bs
aW5hcm8ub3JnOyB3bmlAbnZpZGlhLmNvbQ0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDIvOF0gVGhl
cm1hbDogQ3JlYXRlIHpvbmUgbGV2ZWwgQVBJcw0KPiANCj4gT24gVHVlLCAyMDEzLTAyLTA1IGF0
IDE2OjE2ICswNTMwLCBEdXJnYWRvc3MgUiB3cm90ZToNCj4gPiBUaGlzIHBhdGNoIGFkZHMgYSBu
ZXcgdGhlcm1hbF96b25lIHN0cnVjdHVyZSB0bw0KPiA+IHRoZXJtYWwuaC4gQWxzbywgYWRkcyB6
b25lIGxldmVsIEFQSXMgdG8gdGhlIHRoZXJtYWwNCj4gPiBmcmFtZXdvcmsuDQo+ID4NCg0KW3Nu
aXAuXQ0KDQo+ID4gKw0KPiA+ICtzdHJ1Y3QgdGhlcm1hbF9zZW5zb3IgKmdldF9zZW5zb3JfYnlf
bmFtZShjb25zdCBjaGFyICpuYW1lKQ0KPiA+ICt7DQo+ID4gKwlzdHJ1Y3QgdGhlcm1hbF9zZW5z
b3IgKnBvczsNCj4gPiArCXN0cnVjdCB0aGVybWFsX3NlbnNvciAqdHMgPSBOVUxMOw0KPiA+ICsN
Cj4gPiArCW11dGV4X2xvY2soJnNlbnNvcl9saXN0X2xvY2spOw0KPiA+ICsJZm9yX2VhY2hfdGhl
cm1hbF9zZW5zb3IocG9zKSB7DQo+ID4gKwkJaWYgKCFzdHJuaWNtcChwb3MtPm5hbWUsIG5hbWUs
IFRIRVJNQUxfTkFNRV9MRU5HVEgpKQ0KPiB7DQo+ID4gKwkJCXRzID0gcG9zOw0KPiA+ICsJCQli
cmVhazsNCj4gDQo+IHRoaXMgZnVuY3Rpb24gZGVwZW5kcyBvbiB0aGUgYXNzdW1wdGlvbiB0aGF0
IGFsbCB0aGUgc2Vuc29yIG5hbWVzIGFyZQ0KPiB1bmlxdWUuDQo+IHRodXMgSSBwcmVmZXIgdG8g
Z28gdGhyb3VnaCBhbGwgdGhlIGxpc3QgYW5kIHJldHVybiAtRUlOVkFMIGlmIGR1cGxpY2F0ZQ0K
PiBuYW1lcyBmb3VuZCwgYmVjYXVzZSBpbiB0aGlzIGNhc2UsIHRoZSBwb2ludGVyIHJldHVybmVk
IG1heSBiZSBub3QgdGhlDQo+IHNlbnNvciB3ZSB3YW50IHRvIGdldC4NCg0KWWVzLCBJIGFncmVl
IHdpdGggeW91LiBCdXQgSSBwcmVmZXIgaGF2aW5nIHRoaXMgY2hlY2sgaW4gdGhlIHJlZ2lzdGVy
IEFQSQ0KaXRzZWxmLCB3aGljaCB0aGVuIHdpbGwgbm90IGFsbG93IGR1cGxpY2F0ZXMuDQoNClRo
ZSByZWFzb24gYmVpbmcsIHdlIHVzZSB0aGlzIGdldCogQVBJIChjb21wYXJhdGl2ZWx5KSBhIGxv
dCBtb3JlIHRoYW4NCnRoZSByZWdpc3RlciBBUElzLiBBbmQgcHV0dGluZyB0aGlzIGNoZWNrIGlu
IHRoZSByZWdpc3RlciBBUElzIG1lYW5zIGRvaW5nDQp0aGlzIGNoZWNrIG9ubHkgb25jZS4gTGV0
IG1lIGtub3cgd2hhdCB5b3UgdGhpbmsuDQoNCkFuZCB0aGUgc2FtZSBmb3IgY29vbGluZyBkZXZp
Y2VzIHRvby4NCg0KVGhhbmtzLA0KRHVyZ2ENCg==
