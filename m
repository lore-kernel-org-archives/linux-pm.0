From: "Ong, Boon Leong" <boon.leong.ong@intel.com>
Subject: RE: [PATCH v2 1/1] x86/platform/iosf_mbi: Remove duplicate
 definitions
Date: Fri, 4 Dec 2015 02:05:35 +0000
Message-ID: <AF233D1473C1364ABD51D28909A1B1B733D8FC80@PGSMSX104.gar.corp.intel.com>
References: <1447264769-21981-1-git-send-email-andriy.shevchenko@linux.intel.com>
	 <alpine.DEB.2.11.1511251514580.12555@nanos>
 <1448461984.15393.53.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-i2c-owner@vger.kernel.org>
In-Reply-To: <1448461984.15393.53.camel@linux.intel.com>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>, "Zhang, Rui" <rui.zhang@intel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, Peter Anvin <hpa@zytor.com>, Wolfram Sang <wsa@the-dreams.de>, Eduardo Valentin <edubezval@gmail.com>, "Kweh, Hock Leong" <hock.leong.kweh@intel.com>
List-Id: linux-pm@vger.kernel.org

DQo+LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj5Gcm9tOiBsaW51eC1rZXJuZWwtb3duZXJA
dmdlci5rZXJuZWwub3JnIFttYWlsdG86bGludXgta2VybmVsLQ0KPm93bmVyQHZnZXIua2VybmVs
Lm9yZ10gT24gQmVoYWxmIE9mIEFuZHkgU2hldmNoZW5rbw0KPlNlbnQ6IFdlZG5lc2RheSwgTm92
ZW1iZXIgMjUsIDIwMTUgMTA6MzMgUE0NCj5UbzogVGhvbWFzIEdsZWl4bmVyIDx0Z2x4QGxpbnV0
cm9uaXguZGU+DQo+Q2M6IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWkyY0B2
Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LQ0KPnBtQHZnZXIua2VybmVsLm9yZzsgSW5nbyBNb2xuYXIg
PG1pbmdvQHJlZGhhdC5jb20+OyBQZXRlciBBbnZpbg0KPjxocGFAenl0b3IuY29tPjsgV29sZnJh
bSBTYW5nIDx3c2FAdGhlLWRyZWFtcy5kZT47IFpoYW5nLCBSdWkNCj48cnVpLnpoYW5nQGludGVs
LmNvbT47IEVkdWFyZG8gVmFsZW50aW4gPGVkdWJlenZhbEBnbWFpbC5jb20+OyBLd2VoLCBIb2Nr
DQo+TGVvbmcgPGhvY2subGVvbmcua3dlaEBpbnRlbC5jb20+DQo+U3ViamVjdDogUmU6IFtQQVRD
SCB2MiAxLzFdIHg4Ni9wbGF0Zm9ybS9pb3NmX21iaTogUmVtb3ZlIGR1cGxpY2F0ZSBkZWZpbml0
aW9ucw0KPg0KPk9uIFdlZCwgMjAxNS0xMS0yNSBhdCAxNToyMCArMDEwMCwgVGhvbWFzIEdsZWl4
bmVyIHdyb3RlOg0KPj4gT24gV2VkLCAxMSBOb3YgMjAxNSwgQW5keSBTaGV2Y2hlbmtvIHdyb3Rl
Og0KPj4NCj4+ID4gVGhlIHJlYWQgYW5kIHdyaXRlIG9wY29kZXMgYXJlIGdsb2JhbCBmb3IgYWxs
IHVuaXRzIG9uIFNvQyBhbmQgZXZlbg0KPj4gYWNyb3NzDQo+PiA+IEludGVsIFNvQ3MuIFJlbW92
ZSBkdXBsaWNhdGlvbiBvZiBjb3JyZXNwb25kaW5nIGNvbnN0YW50cy4gQXQgdGhlDQo+PiBzYW1l
IHRpbWUNCj4+ID4gY29udmVydCBhbGwgY3VycmVudCB1c2Vycy4NCj4+ID4NCj4+ID4gTm8gZnVu
Y3Rpb25hbCBjaGFuZ2UuDQo+PiA+DQo+PiA+IENjOiBUaG9tYXMgR2xlaXhuZXIgPHRnbHhAbGlu
dXRyb25peC5kZT4NCj4+ID4gQ2M6IEluZ28gTW9sbmFyIDxtaW5nb0ByZWRoYXQuY29tPg0KPj4g
PiBDYzogUGV0ZXIgQW52aW4gPGhwYUB6eXRvci5jb20+DQo+PiA+IENjOiBXb2xmcmFtIFNhbmcg
PHdzYUB0aGUtZHJlYW1zLmRlPg0KPj4gPiBDYzogWmhhbmcgUnVpIDxydWkuemhhbmdAaW50ZWwu
Y29tPg0KPj4gPiBDYzogRWR1YXJkbyBWYWxlbnRpbiA8ZWR1YmV6dmFsQGdtYWlsLmNvbT4NCj4+
ID4gQ2M6IEhvY2sgTGVvbmcgS3dlaCA8aG9jay5sZW9uZy5rd2VoQGludGVsLmNvbT4NCj4NCj5F
ZHVhcmRvLCBSdWksIGNhbiB5b3UgcHJvdmlkZSB5b3VyIEFDS3Mgb3IgY29tbWVudHMgYWJvdXQg
dGhlIHBhdGNoPw0KPg0KUnVpLA0KSSBoYXZlIHJldmlld2VkIHRoZSBjaGFuZ2Ugb24gZHJpdmVy
cy90aGVybWFsL2ludGVsX3F1YXJrX2R0c190aGVybWFsLmMuDQpZZXMsIEkgZ2F2ZSBteSBBQ0sg
aGVyZS4NCiANCg==
