From: "Opensource [Adam Thomson]" <Adam.Thomson.Opensource@diasemi.com>
Subject: RE: [PATCH v2 3/4] power: Add support for DA9150 Fuel-Gauge
Date: Mon, 6 Jul 2015 14:27:28 +0000
Message-ID: <2E89032DDAA8B9408CB92943514A0337AB55C839@SW-EX-MBX01.diasemi.com>
References: <cover.1435308209.git.Adam.Thomson.Opensource@diasemi.com>
 <596f44407759e2047a02594367116f9c92afee56.1435308209.git.Adam.Thomson.Opensource@diasemi.com>
 <20150703152217.GC10500@x1>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150703152217.GC10500@x1>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>, "Opensource [Adam Thomson]" <Adam.Thomson.Opensource@diasemi.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Support Opensource <Support.Opensource@diasemi.com>
List-Id: linux-pm@vger.kernel.org

T24gSnVseSAzLCAyMDE1IDE2OjIyLCBMZWUgSm9uZXMgd3JvdGU6DQoNCj4gPiArLyoNCj4gPiAr
ICogRnVuY3Rpb24gdGVtcGxhdGUgdG8gcHJvdmlkZSBiYXR0ZXJ5IHRlbXBlcmF0dXJlLiBTaG91
bGQgcHJvdmlkZQ0KPiA+ICsgKiAwLjEgZGVncmVlcyBDIHJlc29sdXRpb24gcmV0dXJuIHZhbHVl
cy4NCj4gPiArICovDQo+ID4gK3R5cGVkZWYgaW50ICgqZGE5MTUwX3JlYWRfdGVtcF90KSh2b2lk
ICpjb250ZXh0KTsNCj4gPiArDQo+ID4gKy8qIFJlZ2lzdGVyIHRlbXAgY2FsbGJhY2sgZnVuY3Rp
b24gKi8NCj4gPiArdm9pZCBkYTkxNTBfZmdfcmVnaXN0ZXJfdGVtcF9jYihzdHJ1Y3QgcG93ZXJf
c3VwcGx5ICpwc3ksDQo+IGRhOTE1MF9yZWFkX3RlbXBfdCBjYiwNCj4gPiArCQkJCXZvaWQgKmNi
X2NvbnRleHQpOw0KPiA+ICsNCj4gPiAgI2VuZGlmIC8qIF9fREE5MTUwX0ZHX0ggKi8NCj4gDQo+
IEkgc3RpbGwgZG9uJ3QgZ2V0IHdoeSB5b3UgdGhpbmsgcG9pbnRlcnMgYXJlIGJldHRlciB0aGFu
IGp1c3QgY2FsbGluZw0KPiB0aGUgZnVuY3Rpb24gZGlyZWN0bHkuICBDYW4gdGhlICpmbigpIGV2
ZXIgcG9pbnQgdG8gZGlmZmVyZW50IGZ1bmN0aW9ucz8NCg0KSGVyZSwgdGhlIGludGVudGlvbiBp
cyB0byBjb3ZlciB0aGUgc2NlbmFyaW8gd2hlcmUgYSBiYXR0ZXJ5IGhhcyBubyBpbnRlcm5hbA0K
dGhlcm1pc3RvciwgYW5kIGNhbm5vdCBwcm92aWRlIHRlbXBlcmF0dXJlIHJlYWRpbmdzIHRvIHRo
ZSBEQTkxNTAgZGV2aWNlLiBJbg0KdGhhdCBzY2VuYXJpbyBJJ3ZlIGFsbG93ZWQgZm9yIHRoZSBv
cHRpb24gb2YgcHJvdmlkaW5nIGFuIGV4dGVybmFsIGZ1bmN0aW9uDQp3aGljaCBjYW4gZ2l2ZSB0
aGUgdGVtcGVyYXR1cmUgcmVhZGluZyBpbnN0ZWFkIGFzIERBOTE1MCB3aWxsIG5vdCBiZSBhYmxl
IHRvDQpwcm92aWRlIGEgY29ycmVjdCByZWFkaW5nIGluIHRoYXQgc2NlbmFyaW8uIFRoaXMgd291
bGQgYmUgcGxhdGZvcm0gZGVwZW5kZW50IGFuZA0Kc3VjaCBhIHBsYXRmb3JtIHVzaW5nIGEgYmF0
dGVyeSBub3QgZW1wbG95aW5nIGFuIE5UQyBpbiB0aGVpciBiYXR0ZXJ5IGNhbg0KcmVnaXN0ZXIg
aXRzIG93biBjYWxsLWJhY2sgZnVuY3Rpb24gdG8gcHJvdmlkZSBiYXR0ZXJ5IHRlbXBlcmF0dXJl
IGluc3RlYWQuDQoNClNvLCBpbiBhbnN3ZXIgdG8geW91ciBxdWVzdGlvbiwgeWVzLg0K
