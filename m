From: Jun Li <jun.li@nxp.com>
Subject: RE: [PATCH v19 0/4] Introduce usb charger framework to deal with the
 usb gadget power negotation
Date: Tue, 14 Mar 2017 01:10:38 +0000
Message-ID: <HE1PR04MB2972189B0532136078A5221D89240@HE1PR04MB2972.eurprd04.prod.outlook.com>
References: <cover.1487578977.git.baolin.wang@linaro.org>
 <87zih3m73h.fsf@notabene.neil.brown.name>
 <CAMz4ku+98HAgVnMoCg0YaPpcY1NvdKdbK6AuDyzgNOrcbpaz9A@mail.gmail.com>
 <AM5PR04MB29614C707DE344E5A05FAB3889210@AM5PR04MB2961.eurprd04.prod.outlook.com>
 <CAMz4kuJ31wVhbYOV+LB9tu=Wb7x9gRifcUnQPMiQSqRUjER_kQ@mail.gmail.com>
 <AM5PR04MB296177A37D96564D510FA90389210@AM5PR04MB2961.eurprd04.prod.outlook.com>
 <CAMz4ku+wkZ7webuCK+V9DPuDzdT_Tyy6Dso8==bQPyN9m06vGw@mail.gmail.com>
 <AM5PR04MB29610364B8FA56AE7AD8A68989200@AM5PR04MB2961.eurprd04.prod.outlook.com>
 <CAMz4kuLNa=sdYQrzXZspPd9ug-Opn2jfUCGHtq2qNT4Omax4Mw@mail.gmail.com>
 <AM5PR04MB29613EEC7C49426020A538B089200@AM5PR04MB2961.eurprd04.prod.outlook.com>
 <CAMz4ku+jy-Z0L4avYsDGstNnV+f=XhjmP8WS9SLOkB1eGWjjXA@mail.gmail.com>
 <AM5PR04MB29615806A8D175E3BF4BD8B089250@AM5PR04MB2961.eurprd04.prod.outlook.com>
 <CAMz4kuL=h-2BM093t3BQi9f+ygR2GJ=xBVghJe69HX47re_RTQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-he1eur01on0071.outbound.protection.outlook.com ([104.47.0.71]:47547
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753370AbdCNBKp (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 13 Mar 2017 21:10:45 -0400
In-Reply-To: <CAMz4kuL=h-2BM093t3BQi9f+ygR2GJ=xBVghJe69HX47re_RTQ@mail.gmail.com>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Baolin Wang <baolin.wang@linaro.org>
Cc: NeilBrown <neilb@suse.com>, Felipe Balbi <balbi@kernel.org>, Greg KH <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, "robh@kernel.org" <robh@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Ruslan Bilovol <ruslan.bilovol@gmail.com>, Peter Chen <peter.chen@freescale.com>, Alan Stern <stern@rowland.harvard.edu>, "grygorii.strashko@ti.com" <grygorii.strashko@ti.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>, John Stultz <john.stultz@linaro.org>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, "patches@opensource.wolfsonmicro.com" <patches@opensource>

SGksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQmFvbGluIFdhbmcg
W21haWx0bzpiYW9saW4ud2FuZ0BsaW5hcm8ub3JnXQ0KPiBTZW50OiBNb25kYXksIE1hcmNoIDEz
LCAyMDE3IDQ6NDQgUE0NCj4gVG86IEp1biBMaSA8anVuLmxpQG54cC5jb20+DQo+IENjOiBOZWls
QnJvd24gPG5laWxiQHN1c2UuY29tPjsgRmVsaXBlIEJhbGJpIDxiYWxiaUBrZXJuZWwub3JnPjsg
R3JlZyBLSA0KPiA8Z3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc+OyBTZWJhc3RpYW4gUmVpY2hl
bCA8c3JlQGtlcm5lbC5vcmc+OyBEbWl0cnkNCj4gRXJlbWluLVNvbGVuaWtvdiA8ZGJhcnlzaGtv
dkBnbWFpbC5jb20+OyBEYXZpZCBXb29kaG91c2UNCj4gPGR3bXcyQGluZnJhZGVhZC5vcmc+OyBy
b2JoQGtlcm5lbC5vcmc7IE1hcmVrIFN6eXByb3dza2kNCj4gPG0uc3p5cHJvd3NraUBzYW1zdW5n
LmNvbT47IFJ1c2xhbiBCaWxvdm9sIDxydXNsYW4uYmlsb3ZvbEBnbWFpbC5jb20+Ow0KPiBQZXRl
ciBDaGVuIDxwZXRlci5jaGVuQGZyZWVzY2FsZS5jb20+OyBBbGFuIFN0ZXJuDQo+IDxzdGVybkBy
b3dsYW5kLmhhcnZhcmQuZWR1PjsgZ3J5Z29yaWkuc3RyYXNoa29AdGkuY29tOyBZb3NoaWhpcm8g
U2hpbW9kYQ0KPiA8eW9zaGloaXJvLnNoaW1vZGEudWhAcmVuZXNhcy5jb20+OyBMZWUgSm9uZXMg
PGxlZS5qb25lc0BsaW5hcm8ub3JnPjsNCj4gTWFyayBCcm93biA8YnJvb25pZUBrZXJuZWwub3Jn
PjsgSm9obiBTdHVsdHogPGpvaG4uc3R1bHR6QGxpbmFyby5vcmc+Ow0KPiBDaGFybGVzIEtlZXBh
eCA8Y2tlZXBheEBvcGVuc291cmNlLndvbGZzb25taWNyby5jb20+Ow0KPiBwYXRjaGVzQG9wZW5z
b3VyY2Uud29sZnNvbm1pY3JvLmNvbTsgTGludXggUE0gbGlzdCA8bGludXgtDQo+IHBtQHZnZXIu
a2VybmVsLm9yZz47IFVTQiA8bGludXgtdXNiQHZnZXIua2VybmVsLm9yZz47IGRldmljZS0NCj4g
bWFpbmxpbmluZ0BsaXN0cy5saW51eGZvdW5kYXRpb24ub3JnOyBMS01MIDxsaW51eC1rZXJuZWxA
dmdlci5rZXJuZWwub3JnPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYxOSAwLzRdIEludHJvZHVj
ZSB1c2IgY2hhcmdlciBmcmFtZXdvcmsgdG8gZGVhbCB3aXRoDQo+IHRoZSB1c2IgZ2FkZ2V0IHBv
d2VyIG5lZ290YXRpb24NCj4gDQouLi4gLi4uDQo+ID4+IFRoYXQgaXMgc2FtZSB3aGF0IFVTQiBj
aGFyZ2VyIGRpZCwgZnJvbSB0aGlzIHBvaW50LCB3ZSBuZWVkIFVTQg0KPiA+PiBjaGFyZ2VyIHRv
IHNlbmQgb3V0IHZidXMgZHJhdyBpbmZvcm1hdGlvbiBhY2NvcmRpbmcgdG8gc3BlZWQgYW5kIHVz
Yg0KPiA+PiBzdGF0ZS4gQnV0IEkgc2hvdWxkIGxpc3RlbiB0byBvdGhlciBndXlzIHN1Z2dlc3Rp
b24uIFBldGVyIGFuZCBGZWxpcGUsIHdoYXQNCj4gZG8geW91IHRoaW5rPw0KDQpJbnN0ZWFkIG9m
IHdhaXRpbmcgZm9yIG1haW50YWluZXIncyBjb21tZW50cyBvbiB0aGlzIGxvbmcgZGlzY3Vzc2lv
biwgSSdkIHN1Z2dlc3QNCnlvdSBkaXJlY3RseSBwb3N0IHRoZSBwYXRjaGVzIGZvciB0aGUgcmVx
dWlyZWQgY2hhbmdlLCBzbyB0aGV5IGNhbiBlYXNpbHkga25vdw0Kd2hhdCdzIHRoZSBjb25jbHVz
aW9uL3NvbHV0aW9uIGxvb2tzIGxpa2UuDQoNCkxpIEp1bg0KDQo+ID4NCj4gPiBTbyBub3cgdGhl
IG9ubHkgdG8gZG8gd29yayBpcyB0byBmaW5kIGEgY29tbW9uIHBsYWNlIHRvIHNlbmQgdGhlDQo+
ID4gbm90aWZpY2F0aW9uIG91dCAoYmFzZWQgb24gZ2FkZ2V0IHNwZWVkIGFuZCBzYXRlKS4NCj4g
DQo+IFllcy4NCj4gDQo+IC0tDQo+IEJhb2xpbi53YW5nDQo+IEJlc3QgUmVnYXJkcw0K
