From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: RE: [PATCH v2 2/3] phy: core: Drop unused runtime PM APIs
Date: Thu, 21 Dec 2017 12:24:09 +0000
Message-ID: <TY1PR06MB0992357759B33F1F3C826439D80D0@TY1PR06MB0992.apcprd06.prod.outlook.com>
References: <1513778960-10073-1-git-send-email-ulf.hansson@linaro.org>
 <1513778960-10073-3-git-send-email-ulf.hansson@linaro.org>
 <TY1PR06MB0992E87FAA770B745DCBA690D80D0@TY1PR06MB0992.apcprd06.prod.outlook.com>
 <CAPDyKFrOONTsm5xiXrvqqy3koG5=11bKk1b2igx+FzSJbzj_Ng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from relmlor2.renesas.com ([210.160.252.172]:29659 "EHLO
        relmlie1.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752400AbdLUMYO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 21 Dec 2017 07:24:14 -0500
In-Reply-To: <CAPDyKFrOONTsm5xiXrvqqy3koG5=11bKk1b2igx+FzSJbzj_Ng@mail.gmail.com>
Content-Language: ja-JP
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Kishon Vijay Abraham I <kishon@ti.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>

DQo+IEZyb206IFVsZiBIYW5zc29uLCBTZW50OiBUaHVyc2RheSwgRGVjZW1iZXIgMjEsIDIwMTcg
Nzo1OCBQTQ0KPiANCj4gT24gMjEgRGVjZW1iZXIgMjAxNyBhdCAxMTozMywgWW9zaGloaXJvIFNo
aW1vZGENCj4gPHlvc2hpaGlyby5zaGltb2RhLnVoQHJlbmVzYXMuY29tPiB3cm90ZToNCj4gPiBI
aSBVbGYtc2FuLA0KPiA+DQo+ID4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4+IEZy
b206IFVsZiBIYW5zc29uLCBTZW50OiBXZWRuZXNkYXksIERlY2VtYmVyIDIwLCAyMDE3IDExOjA5
IFBNDQo+ID4gPHNuaXA+DQo+ID4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L3BoeS9waHku
aCBiL2luY2x1ZGUvbGludXgvcGh5L3BoeS5oDQo+ID4+IGluZGV4IGI0Mjk4YTEuLjA1MGI2MjAg
MTAwNjQ0DQo+ID4+IC0tLSBhL2luY2x1ZGUvbGludXgvcGh5L3BoeS5oDQo+ID4+ICsrKyBiL2lu
Y2x1ZGUvbGludXgvcGh5L3BoeS5oDQo+ID4+IEBAIC0xNyw3ICsxNyw2IEBADQo+ID4+ICAjaW5j
bHVkZSA8bGludXgvZXJyLmg+DQo+ID4+ICAjaW5jbHVkZSA8bGludXgvb2YuaD4NCj4gPj4gICNp
bmNsdWRlIDxsaW51eC9kZXZpY2UuaD4NCj4gPj4gLSNpbmNsdWRlIDxsaW51eC9wbV9ydW50aW1l
Lmg+DQo+ID4NCj4gPiBBZnRlciBJIGFwcGxpZWQgdGhpcyBwYXRjaCwgc29tZSBhdGEgYW5kIGdw
dSBkcml2ZXJzIGNhdXNlcyBidWlsZCBlcnJvciBbMV0uDQo+ID4gU28sIHdlIHNob3VsZCBmaXgg
dGhlIGRyaXZlcnMgYXQgZmlyc3QuLi4NCj4gDQo+IEh1aCwgcmlnaHQsIHRob3NlIGRyaXZlcnMg
c2hvdWxkbid0IGJlIHJlbHlpbmcgb24gdGhlIHBoeS5oIHRvIGluY2x1ZGUNCj4gcG1fcnVudGlt
ZS5oLg0KPiANCj4gVGhlIGVhc2llc3Qgd2F5IGF0IHRoaXMgcG9pbnQgaXMgdG8ganVzdCBwdXQg
YmFjayAiI2luY2x1ZGUNCj4gPGxpbnV4L3BtX3J1bnRpbWUuaD4iIGluIHBoeS5oLCB0aGVuIHdl
IGNhbiBkZWFsIHdpdGggdGhlc2UgcHJvYmxlbXMNCj4gc2VwYXJhdGVseS4gSSBkbyB0aGF0IGlu
IGEgcmUtc3BpbiBzb29uLg0KDQpJIGdvdCBpdC4NCg0KPiBCVFcsIEkgd291bGQgYmUgZ3JlYXQg
aWYgeW91IGNvdWxkIHRlc3QgdGhpcyBvbiB0aGUgUmVuZXNhcyBTb0MgdG8NCj4gbWFrZSBzdXJl
IGl0IHN0aWxsIGZpeGVzIHRoZSBwcm9ibGVtcyAoYXQgbGVhc3QgaGFsZiBvZiB0aGVtIEkgbWVh
bikuDQoNClN1cmUuIEkgcHV0IGJhY2sgdGhlICIjaW5jbHVkZSA8bGludXgvcG1fcnVudGltZS5o
PiIgaW4gdGhlIHBoeS5oIGFuZCB0ZXN0ZWQNCnRoZSBwYXRjaGVzIG9uIG15IGVudmlyb25tZW50
IChyOGE3Nzk1LXNhbHZhdG9yLXguZHRzIHdpdGggdjQuMTUtcmM0KS4gQW5kIHRoZW4sDQp0aGUg
aXNzdWUgWzFdIGRpc2FwcGVhcmVkLg0KWzFdOg0KcHJpbnRlZCAiRW5hYmxpbmcgcnVudGltZSBQ
TSBmb3IgaW5hY3RpdmUgZGV2aWNlIChlZTBhMDIwMC51c2ItcGh5KSB3aXRoIGFjdGl2ZSBjaGls
ZHJlbiINCmluIHJlc3VtZSB0aW1pbmcuDQoNClNvLA0KDQpUZXN0ZWQtYnk6IFlvc2hpaGlybyBT
aGltb2RhIDx5b3NoaWhpcm8uc2hpbW9kYS51aEByZW5lc2FzLmNvbT4NCg0KQmVzdCByZWdhcmRz
LA0KWW9zaGloaXJvIFNoaW1vZGENCg0K
