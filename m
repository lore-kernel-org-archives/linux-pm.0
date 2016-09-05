From: Khiem Nguyen <khiem.nguyen.xt-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Subject: RE: [PATCH 1/5 v2] thermal: rcar_gen3_thermal: Document the R-Car
 Gen3
Date: Mon, 5 Sep 2016 12:23:38 +0000
Message-ID: <SIXPR06MB09066A89EFCBB42C0EA49F3AA8E60@SIXPR06MB0906.apcprd06.prod.outlook.com>
References: <SIXPR06MB0906D63F01A4C5C79823EED0A8E40@SIXPR06MB0906.apcprd06.prod.outlook.com>
 <CAMuHMdUO1XptoeW6m1XOPigt5vtNq8eN5sLaTHhbnTRLb47tzA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAMuHMdUO1XptoeW6m1XOPigt5vtNq8eN5sLaTHhbnTRLb47tzA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Cc: Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>, Magnus Damm <damm+renesas-yzvPICuk2ACczHhG9Qg4qA@public.gmane.org>, Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Thao Phuong Le. Nguyen" <thao.nguyen.yb-NdPGGYSbX7otW8iMtHSHnA@public.gmane.org>, Hien Dang <hien.dang.eb-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, Toru Oishi <toru.oishi.zj-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, Khiem Nguyen <khiem.nguyen.xt-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

SGkgR2VlcnQsDQoNClRoYW5rcyBmb3IgeW91ciBjb21tZW50Lg0KDQo+ID4gLS0tIC9kZXYvbnVs
bA0KPiA+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy90aGVybWFsL3Jj
YXItZ2VuMy10aGVybWFsLnR4dA0KPiA+IEBAIC0wLDAgKzEsNzkgQEANCj4gPiArKiBEVCBiaW5k
aW5ncyBmb3IgUmVuZXNhcyBSLUNhciBHZW4zIFRoZXJtYWwgU2Vuc29yIGRyaXZlcg0KPiA+ICsN
Cj4gPiArT24gUi1DYXIgR2VuMyBTb0NzLCB0aGUgdGhlcm1hbCBzZW5zb3IgY29udHJvbGxlcnMg
KFRTQykgY29udHJvbCB0aGUNCj4gPiArdGhlcm1hbCBzZW5zb3JzIChUSFMpIHdoaWNoIGFyZSB0
aGUgYW5hbG9nIGNpcmN1aXRzIGZvciBtZWFzdXJpbmcgdGVtcGVyYXR1cmUNCj4gKFRqKSBpbnNp
ZGUgdGhlIExTSS4NCj4gPiArDQo+ID4gK1JlcXVpcmVkIHByb3BlcnRpZXM6DQo+ID4gKy0gY29t
cGF0aWJsZSAgICAgICAgICAgOiAicmVuZXNhcyw8c29jdHlwZT4tdGhlcm1hbCIsDQo+ID4gKyAg
ICAgICAgICAgICAgICAgICAgICAgICBFeGFtcGxlcyB3aXRoIHNvY3R5cGVzIGFyZToNCj4gPiAr
ICAgICAgICAgICAgICAgICAgICAgICAgICAgLSAicmVuZXNhcyxyOGE3Nzk1LXRoZXJtYWwiIChS
LUNhciBIMykNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgLSAicmVuZXNhcyxyOGE3
Nzk2LXRoZXJtYWwiIChSLUNhciBNMykNCj4gDQo+IE0zLVcNCg0KT0suDQpJIHdpbGwgZm9sbG93
IHVwc3RyZWFtIHN0eWxlLiBXaWxsIHVwZGF0ZSBpbiB2My4NCg0KQmVzdCByZWdhcmRzLA0KS0hJ
RU0gTmd1eWVuDQo=
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
