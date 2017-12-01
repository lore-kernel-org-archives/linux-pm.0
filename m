From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: RE: [PATCH] PM / runtime: Drop children check from
 __pm_runtime_set_status()
Date: Fri, 1 Dec 2017 11:54:39 +0000
Message-ID: <TY1PR06MB0992A6FD8D85E0345EF198D2D8390@TY1PR06MB0992.apcprd06.prod.outlook.com>
References: <1713438.irjm9MTSvo@aspire.rjw.lan>
 <CAMuHMdV4LV2Uzh2oGdaPiS4W4dfsZ-pn3rGcJNiZLStfo39How@mail.gmail.com>
 <TY1PR06MB09928D43D4E5E5752A6A604ED83A0@TY1PR06MB0992.apcprd06.prod.outlook.com>
 <CAPDyKFoF0WMSTuK4AAyDzerpVpnfEq=Hn1n9kDJM0fYMkFL_wA@mail.gmail.com>
 <TY1PR06MB09924E4F66C6FCF131EE71CFD83B0@TY1PR06MB0992.apcprd06.prod.outlook.com>
 <CAPDyKFoG2-mVGDtzPyg2FDVbXnsWGy543craKqeBVE_awKpf8Q@mail.gmail.com>
 <CAMuHMdViD3vqzits=th52+01d5y3p5iwbAg0jbUBcoGvYfULuA@mail.gmail.com>
 <CAPDyKFpRrQr3LRXH_CoLSYe2a=2PnUqvuNWUYSuh0wm+rBJ0dw@mail.gmail.com>
 <TY1PR06MB09928B145D35E52444F8D462D8380@TY1PR06MB0992.apcprd06.prod.outlook.com>
 <CAPDyKFr8D4jL2vwO5tdBJnNVP=DoAD6H_K=4SQbu7rFAZFd3Xg@mail.gmail.com>
 <TY1PR06MB09929CD76E67B64FDE54B170D8390@TY1PR06MB0992.apcprd06.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <TY1PR06MB09929CD76E67B64FDE54B170D8390@TY1PR06MB0992.apcprd06.prod.outlook.com>
Content-Language: ja-JP
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Stern <stern@rowland.harvard.edu>, USB list <linux-usb@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Kishon Vijay Abraham I <kishon@ti.com>
List-Id: linux-pm@vger.kernel.org

SGkgYWdhaW4sDQoNCj4gRnJvbTogWW9zaGloaXJvIFNoaW1vZGEsIFNlbnQ6IEZyaWRheSwgRGVj
ZW1iZXIgMSwgMjAxNyA4OjA0IFBNDQo+IA0KPiBIaSwNCj4gDQo8c25pcD4NCj4gSG93ZXZlciwg
dGhlIGZvbGxvd2luZyBtZXNzYWdlIHN0aWxsIGV4aXN0cy4NCj4gDQo+ICAgIEVuYWJsaW5nIHJ1
bnRpbWUgUE0gZm9yIGluYWN0aXZlIGRldmljZSAoZWUwODAwMDAudXNiKSB3aXRoIGFjdGl2ZSBj
aGlsZHJlbg0KPiANCj4gU28sIEkgZ3Vlc3Mgb2hjaS1wbGF0Zm9ybS5jIGFsc28gaGFzIHNpbWls
YXIgaXNzdWUuDQo+IA0KPiBKRllJLCB0aGUgZWhjaS1wbGF0Zm9ybS5jIGRvZXNuJ3QgaGF2ZSBy
dW50aW1lIFBNIGhhbmRsaW5nLg0KPiBTbywgSSB0aGluayB0aGF0IGVycm9yIG1lc3NhZ2UgZG9l
c24ndCBvdXRwdXQgZnJvbSBlaGNpIGRldmljZXMuDQoNCkkgaGF2ZSB1cGRhdGUuDQpJZiBJIGFk
ZGVkIHRvIGNhbGwgcG1fcnVudGltZV9mb3JiaWQoKSBpbiBvaGNpLXBsYXRmb3JtLmMgbGlrZSB4
aGNpLXBsYXQuYywNCnRoZSBpc3N1ZSBkaXNhcHBlYXJlZC4gSSBkb24ndCB1bmRlcnN0YW5kIHRo
ZSBwbV9ydW50aW1lX2ZvcmJpZCgpIGJlaGF2aW9yIHlldCwNCmJ1dCBpcyB0aGlzIGFjY2VwdGFi
bGU/DQoNCkJlc3QgcmVnYXJkcywNCllvc2hpaGlybyBTaGltb2RhDQoNCj4gQmVzdCByZWdhcmRz
LA0KPiBZb3NoaWhpcm8gU2hpbW9kYQ0KDQo=
