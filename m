From: "Chen, Yu C" <yu.c.chen@intel.com>
Subject: RE: [PATCH][v3] ACPI / PM: Fix incorrect wakeup irq setting before
 suspend-to-idle
Date: Wed, 14 Oct 2015 17:44:12 +0000
Message-ID: <36DF59CE26D8EE47B0655C516E9CE6402865BC19@shsmsx102.ccr.corp.intel.com>
References: <1444378813-17857-1-git-send-email-yu.c.chen@intel.com>
 <1AE640813FDE7649BE1B193DEA596E883BAC6884@SHSMSX101.ccr.corp.intel.com>
 <36DF59CE26D8EE47B0655C516E9CE6402865A448@shsmsx102.ccr.corp.intel.com>
 <4932550.izVA1bjiZk@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <4932550.izVA1bjiZk@vostro.rjw.lan>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "Zheng, Lv" <lv.zheng@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Zhang, Rui" <rui.zhang@intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Brown, Len" <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

SGkgLFJhZmFlbCwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBSYWZh
ZWwgSi4gV3lzb2NraSBbbWFpbHRvOnJqd0Byand5c29ja2kubmV0XQ0KPiBTZW50OiBUdWVzZGF5
LCBPY3RvYmVyIDEzLCAyMDE1IDQ6MjAgQU0NCj4gVG86IENoZW4sIFl1IEMNCj4gQ2M6IFpoZW5n
LCBMdjsgbGludXgtcG1Admdlci5rZXJuZWwub3JnOyBsaW51eC1hY3BpQHZnZXIua2VybmVsLm9y
ZzsgbGludXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IFpoYW5nLCBSdWk7IFd5c29ja2ks
IFJhZmFlbCBKOyBCcm93biwgTGVuDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdW3YzXSBBQ1BJIC8g
UE06IEZpeCBpbmNvcnJlY3Qgd2FrZXVwIGlycSBzZXR0aW5nIGJlZm9yZQ0KPiBzdXNwZW5kLXRv
LWlkbGUNCj4gDQo+IE9uIEZyaWRheSwgT2N0b2JlciAwOSwgMjAxNSAwOTo1MDoyMSBBTSBDaGVu
LCBZdSBDIHdyb3RlOg0KPiA+IEhpLCBMVg0KPiA+DQo+ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3Nh
Z2UtLS0tLQ0KPiA+ID4gRnJvbTogWmhlbmcsIEx2DQo+ID4gPiBTZW50OiBGcmlkYXksIE9jdG9i
ZXIgMDksIDIwMTUgNDozMyBQTQ0KPiA+ID4gVG86IENoZW4sIFl1IEM7IHJqd0Byand5c29ja2ku
bmV0OyBsZW5iQGtlcm5lbC5vcmcNCj4gPiA+IENjOiBsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmc7
IGxpbnV4LWFjcGlAdmdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4gPiA+IGtlcm5lbEB2Z2VyLmtl
cm5lbC5vcmc7IFpoYW5nLCBSdWkNCj4gPiA+IFN1YmplY3Q6IFJFOiBbUEFUQ0hdW3YzXSBBQ1BJ
IC8gUE06IEZpeCBpbmNvcnJlY3Qgd2FrZXVwIGlycSBzZXR0aW5nDQo+ID4gPiBiZWZvcmUgc3Vz
cGVuZC10by1pZGxlDQo+ID4gPg0KPiA+ID4gSGksIFl1DQo+ID4gPg0KPiA+ID4gPiBGcm9tOiBD
aGVuLCBZdSBDDQo+ID4gPiA+IFNlbnQ6IEZyaWRheSwgT2N0b2JlciAwOSwgMjAxNSA0OjIwIFBN
DQo+ID4gPiA+DQo+ID4gPiA+DQo+ID4gPiA+ICBhY3BpX3N0YXR1cyBhY3BpX29zX3JlbW92ZV9p
bnRlcnJ1cHRfaGFuZGxlcih1MzIgaXJxLA0KPiA+ID4gPiBhY3BpX29zZF9oYW5kbGVyIGhhbmRs
ZXIpDQo+ID4gPg0KPiA+ID4gV2h5IGRvbid0IHlvdSByZW5hbWUgaXJxIGhlcmUgdG8gZ3NpIHRv
IGltcHJvdmUgdGhlIHJlYWRhYmlsaXR5Pw0KPiA+ID4gVGhlIGZhbHNlIG5hbWluZyBhbmQgdGhl
IHdyb25nIGV4YW1wbGUgd3JpdHRlbiBmb3IgdGhpcyBmdW5jdGlvbiBhcmUNCj4gPiA+IHByb2Jh
Ymx5IHRoZSByb290IGNhdXNlcyBvZiBhbGwgb3RoZXIgYmFkIGNvZGUuDQo+ID4gPiBTbyBpZiB3
ZSB3YW50IHRvIHN0b3AgcGVvcGxlIG1ha2luZyBmdXR1cmUgbWlzdGFrZXMsIHdlIG5lZWQgdG8N
Cj4gPiA+IGNsZWFudXAgb3Vyc2VsdmVzLg0KPiA+ID4NCj4gPiBPSywgd2lsbCByZXdyaXRlIGlu
IG5leHQgdmVyc2lvbi4NCj4gDQo+IEl0IHdvdWxkIGJlIGdvb2QgdG8gY2hhbmdlIHRoZSBzdWJq
ZWN0IG9mIHRoZSBwYXRjaCB0b28gSSB0aGluaywgYmVjYXVzZSBpdCBpcw0KPiBub3QgYWJvdXQg
d2FrZXVwIElSUXMgb25seSBhbnkgbW9yZS4NCj4gDQpPSywgd2lsbCBzZW5kIGFub3RoZXIgc2Vy
aWVzIG9mIHBhdGNoZXMuDQoNCkJlc3QgUmVnYXJkcywNCll1DQoNCg==
