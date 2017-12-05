From: Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Subject: RE: [PATCH] PM / runtime: Drop children check from
 __pm_runtime_set_status()
Date: Tue, 5 Dec 2017 03:23:06 +0000
Message-ID: <TY1PR06MB0992214C75585618A1400A1CD83D0@TY1PR06MB0992.apcprd06.prod.outlook.com>
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
 <CAPDyKFr4=Vct_-w1euOsEnb3WdeBvH9mz12zNTUfX7Z6nEwRuw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAPDyKFr4=Vct_-w1euOsEnb3WdeBvH9mz12zNTUfX7Z6nEwRuw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: ja-JP
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Linux PM <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-Renesas <linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

SGksDQoNCj4gRnJvbTogVWxmIEhhbnNzb24sIFNlbnQ6IE1vbmRheSwgRGVjZW1iZXIgNCwgMjAx
NyA3OjQxIFBNDQo+IA0KPiBPbiAxIERlY2VtYmVyIDIwMTcgYXQgMTI6MDMsIFlvc2hpaGlybyBT
aGltb2RhDQo+IDx5b3NoaWhpcm8uc2hpbW9kYS51aEByZW5lc2FzLmNvbT4gd3JvdGU6DQo8c25p
cD4NCj4gPiBTdXJlISBJIHRlc3RlZCB5b3VyIHBhdGNoLCBhbmQgdGhlbiB0aGUgZm9sbG93aW5n
IG1lc3NhZ2UgZGlzYXBwZWFyZWQhDQo+ID4NCj4gPiAgICBFbmFibGluZyBydW50aW1lIFBNIGZv
ciBpbmFjdGl2ZSBkZXZpY2UgKGVlMDgwMjAwLnVzYi1waHkpIHdpdGggYWN0aXZlIGNoaWxkcmVu
DQo+IA0KPiBHcmVhdCwgdGhhdCBjb25maXJtcyBteSB0aGVvcnkuDQo+IA0KPiBJIHdpbGwgcmUt
d29yayB0aGUgcGF0Y2ggYW5kIHJlLXBvc3QgaXQgdG8gc2VlIHdoYXQgcGVvcGxlIHRoaW5rcyBh
Ym91dCBpdC4NCg0KVGhhbmsgeW91IQ0KDQo+ID4NCj4gPiBIb3dldmVyLCB0aGUgZm9sbG93aW5n
IG1lc3NhZ2Ugc3RpbGwgZXhpc3RzLg0KPiA+DQo+ID4gICAgRW5hYmxpbmcgcnVudGltZSBQTSBm
b3IgaW5hY3RpdmUgZGV2aWNlIChlZTA4MDAwMC51c2IpIHdpdGggYWN0aXZlIGNoaWxkcmVuDQo+
ID4NCj4gPiBTbywgSSBndWVzcyBvaGNpLXBsYXRmb3JtLmMgYWxzbyBoYXMgc2ltaWxhciBpc3N1
ZS4NCj4gDQo+IFllcywgdmVyeSBsaWtlbHkhDQo+IA0KPiBIb3dldmVyLCBJIG5lZWQgc29tZSBt
b3JlIHRpbWUgdG8gbG9vayBpbnRvIHRoaXMgdG8gYmUgYWJsZSB0byBzdWdnZXN0DQo+IGEgc29s
dXRpb24uDQoNCkkgZm91bmQgYSBzb2x1dGlvbiBhbmQgc2VudCBhIHJlcG9ydCBhcyBiZWxvdzoN
Cmh0dHBzOi8vd3d3Lm1haWwtYXJjaGl2ZS5jb20vbGludXgta2VybmVsQHZnZXIua2VybmVsLm9y
Zy9tc2cxNTUxMTQ2Lmh0bWwNCg0KV2hhdCBkbyB5b3UgdGhpbmsgYWJvdXQgdXNpbmcgcG1fcnVu
dGltZV9mb3JiaWQoKT8NCg0KQmVzdCByZWdhcmRzLA0KWW9zaGloaXJvIFNoaW1vZGENCg0K
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
