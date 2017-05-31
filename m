From: "Kushwaha, Priyalee" <priyalee.kushwaha@intel.com>
Subject: RE: [PATCH v1 1/1] intel_telemetry_debugfs: fix oops found while
 load/unload module test
Date: Wed, 31 May 2017 19:21:57 +0000
Message-ID: <D3EC02A5926B1B45AA54D922FFAA8B367F5172A0@ORSMSX112.amr.corp.intel.com>
References: <6718d6200ee45ae58b496225d148d275a2776756.1495897832.git.priyalee.kushwaha@intel.com>
 <20170527054929.GA118811@localhost.localdomain> <20170527065430.GA24739@amd>
 <CAHp75VecHUoxP2cYv3chTmJL=ok5_TMUMirdcH8pmcJEgdSFdw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <CAHp75VecHUoxP2cYv3chTmJL=ok5_TMUMirdcH8pmcJEgdSFdw@mail.gmail.com>
Content-Language: en-US
Sender: platform-driver-x86-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>, Pavel Machek <pavel@ucw.cz>
Cc: Darren Hart <dvhart@infradead.org>, "Chakravarty, Souvik K" <souvik.k.chakravarty@intel.com>, Andy Shevchenko <andy@infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Platform Driver <platform-driver-x86@vger.kernel.org>, Rafael Wysocki <rjw@rjwysocki.net>, "Brown, Len" <len.brown@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

SSB3aWxsIHJlc3VibWl0IHRoZSBwYXRjaCB3aXRoIHN1Z2dlc3RlZCBjaGFuZ2VzLiANCg0KLS0t
LS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IEFuZHkgU2hldmNoZW5rbyBbbWFpbHRvOmFu
ZHkuc2hldmNoZW5rb0BnbWFpbC5jb21dIA0KU2VudDogU2F0dXJkYXksIE1heSAyNywgMjAxNyAz
OjUyIEFNDQpUbzogUGF2ZWwgTWFjaGVrIDxwYXZlbEB1Y3cuY3o+DQpDYzogRGFycmVuIEhhcnQg
PGR2aGFydEBpbmZyYWRlYWQub3JnPjsgS3VzaHdhaGEsIFByaXlhbGVlIDxwcml5YWxlZS5rdXNo
d2FoYUBpbnRlbC5jb20+OyBDaGFrcmF2YXJ0eSwgU291dmlrIEsgPHNvdXZpay5rLmNoYWtyYXZh
cnR5QGludGVsLmNvbT47IEFuZHkgU2hldmNoZW5rbyA8YW5keUBpbmZyYWRlYWQub3JnPjsgbGlu
dXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgUGxhdGZvcm0gRHJpdmVyIDxwbGF0Zm9ybS1kcml2
ZXIteDg2QHZnZXIua2VybmVsLm9yZz47IFJhZmFlbCBXeXNvY2tpIDxyandAcmp3eXNvY2tpLm5l
dD47IEJyb3duLCBMZW4gPGxlbi5icm93bkBpbnRlbC5jb20+OyBsaW51eC1wbUB2Z2VyLmtlcm5l
bC5vcmcNClN1YmplY3Q6IFJlOiBbUEFUQ0ggdjEgMS8xXSBpbnRlbF90ZWxlbWV0cnlfZGVidWdm
czogZml4IG9vcHMgZm91bmQgd2hpbGUgbG9hZC91bmxvYWQgbW9kdWxlIHRlc3QNCg0KT24gU2F0
LCBNYXkgMjcsIDIwMTcgYXQgOTo1NCBBTSwgUGF2ZWwgTWFjaGVrIDxwYXZlbEB1Y3cuY3o+IHdy
b3RlOg0KPj4gT24gU2F0LCBNYXkgMjcsIDIwMTcgYXQgMDg6MTc6MzlBTSAtMDcwMCwgcHJpeWFs
ZWUua3VzaHdhaGFAaW50ZWwuY29tIHdyb3RlOg0KDQo+PiArUmFmYWVsLCBMZW4sIFBhdmVsLCBs
aW51eC1wbTogSXMgdGhlcmUgYSBwcmVmZXJyZWQgYXBwcm9hY2ggZm9yIA0KPj4gK2RlYWxpbmcg
d2l0aA0KPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIENPTkZJR19QTV9TTEVFUD8N
Cj4NCj4gWWVhaCwgZW1wdHkgInVucmVnaXN0ZXJfcG1fbm90aWZpZXIiIGluICFDT05GSUdfUE1f
U0xFRVAgY2FzZSBzb3VuZHMgDQo+IGxpa2UgYSBnb29kIGlkZWEuDQoNCkkgbGlrZSB0aGUgaWRl
YSwgdGhvdWdoIEkgd291bGQgbGV0IFJhZmFlbCB0byBzcGVhayB1cC4NCg0KLS0NCldpdGggQmVz
dCBSZWdhcmRzLA0KQW5keSBTaGV2Y2hlbmtvDQo=
