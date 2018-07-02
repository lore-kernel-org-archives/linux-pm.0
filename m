From: Leonard Crestez <leonard.crestez@nxp.com>
Subject: Re: [PATCH 0/2] soc: imx: gpc: Power off PU domain in suspend/resume
 on 6qp
Date: Mon, 2 Jul 2018 13:49:47 +0000
Message-ID: <8dc9a2359f65b570a8a94aad5e8113dfd642e441.camel@nxp.com>
References: <cover.1530530881.git.leonard.crestez@nxp.com>
         <1530533718.22468.87.camel@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1530533718.22468.87.camel@pengutronix.de>
Content-Language: en-US
Content-ID: <1D0E96E428DA1F47A8635340D6F04BA9@eurprd04.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "l.stach@pengutronix.de" <l.stach@pengutronix.de>
Cc: dl-linux-imx <linux-imx@nxp.com>, "A.s. Dong" <aisheng.dong@nxp.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Fabio Estevam <fabio.estevam@nxp.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>, "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>, Anson Huang <anson.huang@nxp.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Robin Gong <yibin.gong@nxp.com>, "kernel@pengutronix.de" <kernel@pengutronix.de>
List-Id: linux-pm@vger.kernel.org

T24gTW9uLCAyMDE4LTA3LTAyIGF0IDE0OjE1ICswMjAwLCBMdWNhcyBTdGFjaCB3cm90ZToNCj4g
QW0gTW9udGFnLCBkZW4gMDIuMDcuMjAxOCwgMTQ6NTIgKzAzMDAgc2NocmllYiBMZW9uYXJkIENy
ZXN0ZXo6DQoNCj4gPiBXaXRoIGN1cnJlbnQgY29kZSAoZXZlbiB3aXRob3V0IG15IHBhdGNoZXMp
IGF0dGVtcHRpbmcgdG8gZHluYW1pY2FsbHkNCj4gPiByZW1vdmUvcHJvYmUgdGhlIEdQQyBmaWxz
IHNpbmNlIHNpbmNlIHRoZSBwZXItcGdjIHBsYXRmb3JtX2RldmljZQ0KPiA+IGluc3RhbmNlcyBh
cmUgbm90IHJlbW92ZWQuIEknbSB0cnlpbmcgc29tZXRoaW5nIGxpa2UgdGhpczoNCj4gPiANCj4g
PiBlY2hvIDEzMDAwMC5ncHUgPiAvc3lzL2J1cy9wbGF0Zm9ybS9kcml2ZXJzL2V0bmF2aXYtZ3B1
L3VuYmluZA0KPiA+IGVjaG8gMTM0MDAwLmdwdSA+IC9zeXMvYnVzL3BsYXRmb3JtL2RyaXZlcnMv
ZXRuYXZpdi1ncHUvdW5iaW5kDQo+ID4gZWNobyAyMGRjMDAwLmdwYyAgPiAvc3lzL2J1cy9wbGF0
Zm9ybS9kcml2ZXJzL2lteC1ncGMvdW5iaW5kDQo+ID4gZWNobyAyMGRjMDAwLmdwYyAgPiAvc3lz
L2J1cy9wbGF0Zm9ybS9kcml2ZXJzL2lteC1ncGMvYmluZA0KPiA+IA0KPiA+IEJ1dCBpcyB0aGVy
ZSBhbnkgdXNlY2FzZSBmb3IgZHluYW1pY2FsbHkgcmVtb3ZpbmcgdGhlIEdQQz8gSW5zdGVhZCBv
Zg0KPiA+IHRyeWluZyB0byBmaXggaXQgSSdkIHJhdGhlciBkZWxldGUgaW14X2dwY19kcml2ZXIu
cmVtb3ZlLCBqdXN0IGxpa2UNCj4gPiBmb3IgZ3BjdjIuIFdvdWxkIGFueW9uZSBvYmplY3QgdG8g
YSBwYXRjaCBkb2luZyB0aGlzPw0KPiANCj4gWWVzLCBhcyB0aGlzIGlzIHRha2luZyB0aGluZ3Mg
aW4gd3JvbmcgZGlyZWN0aW9uLiBXaXRoIGRldmljZS1saW5rcyB3ZQ0KPiBhcmUgYWJsZSB0byB1
bmJpbmQgY29uc3VtZXIgZGV2aWNlcyB3aGVuIGEgcHJvdmlkZXIgaXMgcmVtb3ZlZC4gQXMgdGhl
DQo+IEdQQyBpcyBhIGNvbnN1bWVyIG9mIGEgcmVndWxhdG9yLCBub3QgaGF2aW5nIHRoZSBhYmls
aXR5IHRvIHVuYmluZCBpdA0KPiB3b3VsZCBicmVhayB0aGF0IHVzZSBjYXNlLg0KDQpUaGUgR1BD
IGlzIGEgImNvbnN1bWVyIiBvZiB0aGUgTERPIHJlZ3VsYXRvcnMgd2hpY2ggYXJlIGJ1aWx0IGlu
dG8gdGhlDQpTT0MuIFdoeSB3b3VsZCB5b3Ugd2FudCB0byB1bmJpbmQgYW55IG9mIHRoaXMgc3R1
ZmY/DQoNCkkgZG9uJ3QgdW5kZXJzdGFuZCB0aGUgdXNlY2FzZSwgbWF5YmUgeW91IGNhbiBlbGFi
b3JhdGU/
