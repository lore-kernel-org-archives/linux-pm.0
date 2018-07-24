From: Leonard Crestez <leonard.crestez@nxp.com>
Subject: Re: [PATCH v2 1/3] Revert "ARM: dts: imx7d: Invert legacy PCI irq
 mapping"
Date: Tue, 24 Jul 2018 11:34:48 +0000
Message-ID: <dfad19eec11f7f3affc51f1ecc41d3f6eaa65e7c.camel@nxp.com>
References: <cover.1532090446.git.leonard.crestez@nxp.com>
         <221deb47d7d38ecd6e0c7636f9a87ab693a3c539.1532090446.git.leonard.crestez@nxp.com>
         <CAHQ1cqF6TphuN8Ls54YA6bjty-bJF8twYboaG-RM=jox8CeQPA@mail.gmail.com>
         <42ff53eeea3067b19e3e16bed8392706502c8f23.camel@nxp.com>
         <CAHQ1cqF7u2gjwYt1-16u-uimXHZ2SWsquabZSDftQn_yRurhSQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHQ1cqF7u2gjwYt1-16u-uimXHZ2SWsquabZSDftQn_yRurhSQ@mail.gmail.com>
Content-Language: en-US
Content-ID: <7CB98957E755AB458DAF840794A11F46@eurprd04.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>
Cc: Richard Zhu <hongxing.zhu@nxp.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>, "jingoohan1@gmail.com" <jingoohan1@gmail.com>, "A.s. Dong" <aisheng.dong@nxp.com>, "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Fabio Estevam <fabio.estevam@nxp.com>, "Joao.Pinto@synopsys.com" <Joao.Pinto@synopsys.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "bhelgaas@google.com" <bhelgaas@google.com>, "l.stach@pengutronix.de" <l.stach@pengutronix.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

T24gTW9uLCAyMDE4LTA3LTIzIGF0IDExOjM4IC0wNzAwLCBBbmRyZXkgU21pcm5vdiB3cm90ZToN
Cj4gT24gTW9uLCBKdWwgMjMsIDIwMTggYXQgNTo0MSBBTSBMZW9uYXJkIENyZXN0ZXogPGxlb25h
cmQuY3Jlc3RlekBueHAuY29tPiB3cm90ZToNCj4gPiBPbiBGcmksIDIwMTgtMDctMjAgYXQgMDg6
MzMgLTA3MDAsIEFuZHJleSBTbWlybm92IHdyb3RlOg0KPiA+ID4gT24gRnJpLCBKdWwgMjAsIDIw
MTggYXQgNTo0OCBBTSBMZW9uYXJkIENyZXN0ZXogPGxlb25hcmQuY3Jlc3RlekBueHAuY29tPiB3
cm90ZToNCj4gPiA+ID4gDQo+ID4gPiA+IFRoaXMgcmV2ZXJ0cyBjb21taXQgMWM4NmM5ZGQ4MmY4
NTliNDc0NDc0YTdmZWUwZDUxOTVkYTJjOWMxZC4NCj4gPiA+ID4gDQo+ID4gPiA+IFRoYXQgY29t
bWl0IGZvbGxvd2VkIHRoZSByZWZlcmVuY2UgbWFudWFsIGJ1dCB1bmZvcnR1bmF0ZWx5IHRoZSBp
bXg3ZA0KPiA+ID4gPiBtYW51YWwgaXMgaW5jb3JyZWN0Lg0KPiA+ID4gDQo+ID4gPiBJJ2QgYWxz
byBhZGQgc2ltaWxhciBjb21tZW50IHRvIERUIGZpbGUgdG8gcHJldmVudCBwZW9wbGUgZnJvbSB0
cnlpbmcNCj4gPiA+IHRvICJmaXgiIHRoaXMgaW4gdGhlIGZ1dHVyZS4NCj4gPiANCj4gPiBJJ2xs
IHRyeSB0byBzZWUgaWYgSSBjYW4gZm9sbG93IHVwIGludGVybmFsbHkgd2l0aCBkb2NzIHRlYW0g
dG8gZ2V0DQo+ID4gdGhpcyB1cGRhdGVkIGluIHRoZSBuZXh0IHJldmlzaW9uIG9mIHRoZSByZWZl
cmVuY2UgbWFudWFsLg0KPiANCj4gTm90IHN1cmUgaWYgd2UgYXJlIG9uIHRoZSBzYW1lIHBhZ2Ug
aGVyZSwgYnV0IHdoYXQgSSBtZWFudCBpcyBhZGRpbmcNCj4gdGhlIHNhbWUgZXhwbGFuYXRpb24g
dGhhdCBpcyBpbiB5b3VyIGNvbW1pdCBtZXNzYWdlIHRvIERldmljZSBUcmVlDQo+IGZpbGUgYXMg
d2VsbCBzbyB0aGF0IGlmIGFueW9uZSBsb29rcyBhdCBEVCBjb2RlIGFuZCBnb2VzICJIdWg/IiBp
biB0aGUNCj4gZnV0dXJlLCB0aGV5IHdvdWxkbid0IGhhdmUgdG8gcmVzZWFyY2ggY29tbWl0IGhp
c3RvcnkgdG8gc2VlIHRoZQ0KPiByZWFzb24gd2h5IHRoaW5ncyB0aGUgd2F5IHRoZXkgYXJlLg0K
DQpPSywgSSB3aWxsIGFkZCBhIGNvbW1lbnQgb24gaXJxIG1hcHBpbmdzIGluIHRoZSBuZXh0IHZl
cnNpb24gZXhwbGFpbmluZw0KdGhhdCB0aGUgcmVmZXJlbmNlIG1hbnVhbCBpcyBpbmNvcnJlY3Qu
DQoNCj4gPiA+IEFsc28sIHRoaXMgY2hhbmdlIGlzIGdvaW5nIHRvIGJyZWFrIFFFTVUncyBtYXBw
aW5nIGZvdW5kIGhlcmU6DQo+ID4gDQo+ID4gSSBoYWQgbm8gaWRlYSB0aGF0IGV4aXN0ZWQsIEkg
Z3Vlc3Mgc29tZWJvZHkgbmVlZHMgdG8gZml4IHRoYXQgYXMgd2VsbC4NCj4gDQo+IEkgdGFrZSBp
dCBpdCdzIGEgbm8gdG8gbXkgImFueSBjaGFuY2UgeW91IGNhbiBmaXggdGhhdCBhcyB3ZWxsPyIg
Oy0pLg0KPiBJJ2xsIHNlZSBpZiBJIGNhbiBmaW5kIHRpbWUgdG8gZG8gdGhhdCB0aGlzIHdlZWsu
DQoNClNvcnJ5LCBJJ20gbm90IGZhbWlsaWFyIHdpdGggcWVtdSBzb3VyY2UgYXQgYWxsLg==
