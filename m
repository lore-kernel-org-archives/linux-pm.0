From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: RE: [PATCH] PM / runtime: Drop children check from
 __pm_runtime_set_status()
Date: Thu, 30 Nov 2017 12:51:45 +0000
Message-ID: <TY1PR06MB09928B145D35E52444F8D462D8380@TY1PR06MB0992.apcprd06.prod.outlook.com>
References: <1713438.irjm9MTSvo@aspire.rjw.lan>
 <CAMuHMdV4LV2Uzh2oGdaPiS4W4dfsZ-pn3rGcJNiZLStfo39How@mail.gmail.com>
 <TY1PR06MB09928D43D4E5E5752A6A604ED83A0@TY1PR06MB0992.apcprd06.prod.outlook.com>
 <CAPDyKFoF0WMSTuK4AAyDzerpVpnfEq=Hn1n9kDJM0fYMkFL_wA@mail.gmail.com>
 <TY1PR06MB09924E4F66C6FCF131EE71CFD83B0@TY1PR06MB0992.apcprd06.prod.outlook.com>
 <CAPDyKFoG2-mVGDtzPyg2FDVbXnsWGy543craKqeBVE_awKpf8Q@mail.gmail.com>
 <CAMuHMdViD3vqzits=th52+01d5y3p5iwbAg0jbUBcoGvYfULuA@mail.gmail.com>
 <CAPDyKFpRrQr3LRXH_CoLSYe2a=2PnUqvuNWUYSuh0wm+rBJ0dw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from relmlor2.renesas.com ([210.160.252.172]:64189 "EHLO
        relmlie1.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751099AbdK3Mvu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 30 Nov 2017 07:51:50 -0500
In-Reply-To: <CAPDyKFpRrQr3LRXH_CoLSYe2a=2PnUqvuNWUYSuh0wm+rBJ0dw@mail.gmail.com>
Content-Language: ja-JP
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Stern <stern@rowland.harvard.edu>, USB list <linux-usb@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>

SGksDQoNCj4gRnJvbTogVWxmIEhhbnNzb24sIFNlbnQ6IFdlZG5lc2RheSwgTm92ZW1iZXIgMjks
IDIwMTcgNjo1OSBQTQ0KPiANCj4gT24gMjkgTm92ZW1iZXIgMjAxNyBhdCAxMDo0MywgR2VlcnQg
VXl0dGVyaG9ldmVuIDxnZWVydEBsaW51eC1tNjhrLm9yZz4gd3JvdGU6DQo+ID4gSGkgVWxmLA0K
PHNuaXA+DQo+IE9rYXksIHNvIHRoZSBwcm9ibGVtIHJlbWFpbnMgbm8gbWF0dGVyIHdoaWNoIHNv
bHV0aW9uIGZvciB3YWtldXAgeW91DQo+IHBpY2sgaW4gZ2VucGQuDQoNClllcy4gVG9kYXkgSSBj
b3VsZCByZXByb2R1Y2UgdGhpcyBpc3N1ZSB3aXRob3V0IHVzYiBob3N0IGRyaXZlci4NCi0gVGhl
IHJlbmVzYXNfdXNiMyB1c2IgcGVyaXBoZXJhbCBkcml2ZXIgaGFzIGdlbmVyaWMgcGh5IGhhbmRs
aW5nLg0KICAoVGhlIHBlcmlwaGVyYWwgZHJpdmVyIHVzZXMgZGlmZmVyZW50IGdlbmVyaWMgcGh5
IGRyaXZlciAocGh5LXJjYXItZ2VuMy11c2IzLmMpIHRob3VnaC4pDQogLS0+IElmIEkgdXNlZCB0
aGUgY3VycmVudCByZW5lc2FzX3VzYjMgKHRoaXMgbWVhbnMgZG9lc24ndCBjYWxsIHBoeV9wb3dl
cl97b24sb2ZmfSgpLA0KICAgICB0aGUgaXNzdWUgZGlkbid0IGhhcHBlbi4NCiAtLT4gSWYgSSBh
ZGRlZCBwaHlfcG93ZXJfe29uLG9mZn0oKSBjYWxsaW5nLCB0aGUgaXNzdWUgaGFwcGVuZWQuDQog
IC0tPiBTbywgSSdtIHRoaW5raW5nIHRoZSBBUElzIGFyZSByZWxhdGVkIHRvIHRoZSBpc3N1ZS4N
Cg0KLSBUaGUgZ2VuZXJpYyBwaHkgQVBJcyBhcmUgaW4gZHJpdmVycy9waHkvcGh5LWNvcmUuYy4N
CiAtLT4gVGhlIHBoeS1yY2FyLWdlbjMtdXNiWzIzXSBkcml2ZXJzIGNhbGwgb25seSBwbV9ydW50
aW1lX2VuYWJsZSgpIGJlZm9yZSBkZXZtX3BoeV9jcmVhdGUoKS4NCiAgLS0+IFRoZSBwaHktY29y
ZSB3aWxsIGNhbGwgcG1fcnVudGltZV97Z2V0X3N5bmMscHV0fSgpIGluIHBoeV97aW5pdCxleGl0
LHBvd2VyX3tvbixvZmZ9fS4NCiAgIC0tPiBTbywgSUlVQywgYm90aCBkZXZpY2VzIG9mIHBoeS08
ZGV2X25hbWU+LjxpZD4gYW5kIDxkZXZfbmFtZT4gd2lsbCBiZSBoYW5kbGVkIGJ5IHJ1bnRpbWUg
UE0gQVBJcy4NCiAtLT4gVGhlIHJ1bnRpbWUgUE0gaW1wbGVtZW50YXRpb24gb2YgcGh5LWNvcmUg
c2VlbXMgZ29vZCB0byBtZS4gQnV0Li4uPw0KDQo+IFRoZW4gdGhpcyBzZWVtcyB0byBwb2ludCB0
byB0aGF0IHRoZSBkcml2ZXIgbWF5IGJlIG1pc2JlaGF2aW5nIGluIHNvbWUNCj4gd2F5LiBJIGNh
biBoZWxwIHRvIGNoZWNrIHdoYXQgaXMgZ29pbmcgb24uDQoNCkkgZ3Vlc3Mgc28uIEJ1dCwgSSBk
b24ndCBmaW5kIHlldC4uLg0KDQpCZXN0IHJlZ2FyZHMsDQpZb3NoaWhpcm8gU2hpbW9kYQ0KDQo+
IEtpbmQgcmVnYXJkcw0KPiBVZmZlDQo=
