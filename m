From: "Winkler, Tomas" <tomas.winkler@intel.com>
Subject: RE: Issue with commit de3ef1eb1cd - PM / core: Drop run_wake flag
 from struct dev_pm_info [Was: MEI-related WARN_ON() triggered during
 resume-from-sleep on v4.13-rc2+]
Date: Tue, 1 Aug 2017 13:58:04 +0000
Message-ID: <5B8DA87D05A7694D9FA63FD143655C1B749D55CC@hasmsx108.ger.corp.intel.com>
References: <20170730085908.GA2298@light.dominikbrodowski.net>
 <5B8DA87D05A7694D9FA63FD143655C1B749D3C1C@hasmsx108.ger.corp.intel.com>
 <20170731221645.GA5871@light.dominikbrodowski.net>
 <CAJZ5v0i2MiLv6J+Wo1sUXoCKK9iG_e7pVdb0Uo5uzLXkyxpDUg@mail.gmail.com>
 <CAJZ5v0hMdu3hZoc4YOE6YteHLuXkO7V63cTiCbBENBGT4cLp2g@mail.gmail.com>
 <C980C034A53E0646B96866D6CE3D187A4D9129A0@HASMSX106.ger.corp.intel.com>
 <CAJZ5v0gBpDKpRbhx0tbLWXG1e8Dd4ZPZGDQ5Vq2f8phX2cpFGg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0gBpDKpRbhx0tbLWXG1e8Dd4ZPZGDQ5Vq2f8phX2cpFGg@mail.gmail.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>, "Usyskin, Alexander" <alexander.usyskin@intel.com>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Bjorn Helgaas <bhelgaas@google.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

PiANCj4gSGksDQo+IA0KPiBPbiBUdWUsIEF1ZyAxLCAyMDE3IGF0IDc6MjUgQU0sIFVzeXNraW4s
IEFsZXhhbmRlcg0KPiA8YWxleGFuZGVyLnVzeXNraW5AaW50ZWwuY29tPiB3cm90ZToNCj4gPiBI
aQ0KPiA+DQo+ID4gV2UgdXNpbmcgcGNpX2Rldl9ydW5fd2FrZSB0aGF0IGNoYW5nZWQgaW4gbWVu
dGlvbmVkIHBhdGNoIHRvIGRlY2lkZSBpZg0KPiA+IHRvIHJlcGxhY2UgdXN1YWwgUE0gY2FsbGJh
Y2tzIHdpdGggZG9tYWluIG9uZXMuDQo+ID4gSUlSQywgdGhlIG1laSBkZXZpY2UgaXMgbm90IHJl
bW90ZSB3YWtlYWJsZSBvbiB0aGF0IHBsYXRmb3JtLCBzbyB3ZQ0KPiA+IHNob3VsZCBzZXQgZG9t
YWluIGNhbGxiYWNrcy4NCj4gPiBUaGVyZSB3YXMgYSBwYXRjaCBpbiBQTSBmcmFtZXdvcmsgdGhh
dCBzcXVhc2hlcyBydW50aW1lIHN1c3BlbmQgd2l0aA0KPiA+IHVzdWFsIHN1c3BlbmQgZm9yIHNv
bWUgZGV2aWNlcy4NCj4gPiBNYXkgaXQgYmUgdGhhdCBub3cgcGNpX2Rldl9ydW5fd2FrZSByZXR1
cm5zIHRydWUgZm9ybSBtZWkgYW5kIHdlIGFyZQ0KPiA+IG5vdCBzZXR0aW5nIGRvbWFpbiBjYWxs
YmFja3M/DQo+ID4gSW4gdGhhdCBjYXNlIHdlIGdvaW5nIHRocm91Z2ggUENJIGRldmljZSBsZXZl
bCBQTSBwYXRoIGFuZCBtYXkgdHJpZ2dlcg0KPiB0aGF0IHNxdWFzaC4NCj4gPiBUaGF0IHdpbGwg
ZXhwbGFpbiBsYWNrIG9mIG1laSBsb2dzIG9uIHN1c3BlbmQuDQo+ID4NCj4gPiBEb21pbmlrLCBj
YW4geW91IHRyeSBjb21tZW50IG91dCAiaWYgKCFwY2lfZGV2X3J1bl93YWtlKHBkZXYpKSINCj4g
PiBhdCBkcml2ZXJzL21pc2MvbWVpL3BjaS1tZS5jIChhcm91bmQgbGluZSAyMjMpIHRvIHNldCBk
b21haW4gY2FsbGJhY2tzDQo+ID4gYnkgZm9yY2UgdG8gc2VlIGlmIHRoaXMgaXMgaW5kZWVkIHRo
ZSBjYXNlPw0KPiANCj4gV2h5IGV4YWN0bHkgZG8geW91IG5lZWQgdGhlIHBjaV9kZXZfcnVuX3dh
a2UocGRldikgY2hlY2s/DQoNCldlIG5lZWQgdG8gcmUtcmV2aWV3IHRoaXMgY29kZSBub3csIGJ1
dCBhcyBmYXIgYXMgSSByZW1lbWJlci4NCk9uIHNvbWUgcGxhdGZvcm1zIHdpdGggTkZDIGNvbm5l
Y3RlZCB2aWEgTUVJLCB0aGVyZSB3YXMgbm8gUE1FIGVuYWJsZWQsICBoZW5jZSB3ZSBuZWVkZWQg
dG8ga2VlcCBpbiBiYW5kIGlycSBvcGVuZWQgZm9yIHJ4IHRvIHdha2UgdXMgdXAuDQogDQpUaGFu
a3MNClRvbWFzDQoNCg==
