From: "A.s. Dong" <aisheng.dong@nxp.com>
Subject: RE: [PATCH V4 2/2] thermal: imx: add i.MX7 thermal sensor support
Date: Wed, 28 Feb 2018 02:27:57 +0000
Message-ID: <AM3PR04MB306CAA99F88AE8F580422EF80C70@AM3PR04MB306.eurprd04.prod.outlook.com>
References: <1519459369-29083-1-git-send-email-Anson.Huang@nxp.com>
 <1519459369-29083-2-git-send-email-Anson.Huang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1519459369-29083-2-git-send-email-Anson.Huang@nxp.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Anson Huang <anson.huang@nxp.com>, "rui.zhang@intel.com" <rui.zhang@intel.com>, "edubezval@gmail.com" <edubezval@gmail.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>, "kernel@pengutronix.de" <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>, "linux@armlinux.org.uk" <linux@armlinux.org.uk>
Cc: dl-linux-imx <linux-imx@nxp.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBbnNvbiBIdWFuZyBbbWFpbHRv
OkFuc29uLkh1YW5nQG54cC5jb21dDQo+IFNlbnQ6IFNhdHVyZGF5LCBGZWJydWFyeSAyNCwgMjAx
OCA0OjAzIFBNDQo+IFRvOiBydWkuemhhbmdAaW50ZWwuY29tOyBlZHViZXp2YWxAZ21haWwuY29t
OyByb2JoK2R0QGtlcm5lbC5vcmc7DQo+IG1hcmsucnV0bGFuZEBhcm0uY29tOyBzaGF3bmd1b0Br
ZXJuZWwub3JnOyBrZXJuZWxAcGVuZ3V0cm9uaXguZGU7DQo+IEZhYmlvIEVzdGV2YW0gPGZhYmlv
LmVzdGV2YW1AbnhwLmNvbT47IGxpbnV4QGFybWxpbnV4Lm9yZy51aw0KPiBDYzogZGwtbGludXgt
aW14IDxsaW51eC1pbXhAbnhwLmNvbT47IGxpbnV4LXBtQHZnZXIua2VybmVsLm9yZzsNCj4gZGV2
aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxp
bnV4LWFybS0NCj4ga2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcNCj4gU3ViamVjdDogW1BBVENI
IFY0IDIvMl0gdGhlcm1hbDogaW14OiBhZGQgaS5NWDcgdGhlcm1hbCBzZW5zb3Igc3VwcG9ydA0K
PiANCj4gVGhpcyBwYXRjaCBhZGRzIGkuTVg3IHRoZXJtYWwgc2Vuc29yIHN1cHBvcnQsIG1vc3Qg
b2YgdGhlIGkuTVg3IHRoZXJtYWwNCj4gc2Vuc29yIGZ1bmN0aW9ucyBhcmUgc2FtZSB3aXRoDQo+
IGkuTVg2IGV4Y2VwdCB0aGUgcmVnaXN0ZXJzIG9mZnNldC9sYXlvdXQsIHNvIHdlIG1vdmUgdGhv
c2UgcmVnaXN0ZXJzDQo+IG9mZnNldC9sYXlvdXQgZGVmaW5pdGlvbnMgdG8gc29jIGRhdGEgc3Ry
dWN0dXJlLg0KPiANCj4gaS5NWDcgdXNlcyBzaW5nbGUgY2FsaWJyYXRpb24gZGF0YSBAMjVDLCB0
aGUgY2FsaWJyYXRpb24gZGF0YSBpcyBsb2NhdGVkIGF0DQo+IE9DT1RQIG9mZnNldCAweDRGMCwg
Yml0WzE3OjldLCB0aGUgZm9ybXVsYSBpcyBhcyBiZWxvdzoNCj4gDQo+IFRtZWFzID0gKE5tZWFz
IC0gbjEpICsgMjU7IG4xIGlzIHRoZSBmdXNlIHZhbHVlIGZvciAyNUMuDQo+IA0KPiBTaWduZWQt
b2ZmLWJ5OiBBbnNvbiBIdWFuZyA8QW5zb24uSHVhbmdAbnhwLmNvbT4NCj4gU2lnbmVkLW9mZi1i
eTogQmFpIFBpbmcgPHBpbmcuYmFpQG54cC5jb20+DQoNCkFja2VkLWJ5OiBEb25nIEFpc2hlbmcg
PGFpc2hlbmcuZG9uZ0BueHAuY29tPg0KDQpSZWdhcmRzDQpEb25nIEFpc2hlbmcNCg==
