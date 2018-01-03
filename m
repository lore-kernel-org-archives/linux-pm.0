From: Anson Huang <anson.huang-3arQi8VN3Tc@public.gmane.org>
Subject: RE: [PATCH 1/2] ARM: dts: imx6ul: add 696MHz operating point
Date: Wed, 3 Jan 2018 02:09:11 +0000
Message-ID: <AM3PR04MB13157F7EFCEEFE030104C87DF51E0@AM3PR04MB1315.eurprd04.prod.outlook.com>
References: <1514912859-17691-1-git-send-email-Anson.Huang@nxp.com>
 <CAOMZO5C-qgyCJPBHYwjD9zjHqu4eoGDfoB5-BcFdnvSy01MKiQ@mail.gmail.com>
 <E5B0DB53-D0E5-430B-BBCC-EF3899C70DAE@nxp.com>
 <CAOMZO5BGmnNzv7YobtB+KOi0PM+qzyYi97q_NZtT1PU_e+Bcbg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAOMZO5BGmnNzv7YobtB+KOi0PM+qzyYi97q_NZtT1PU_e+Bcbg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "A.s. Dong" <aisheng.dong-3arQi8VN3Tc@public.gmane.org>, Jacky Bai <ping.bai-3arQi8VN3Tc@public.gmane.org>, viresh kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Russell King - ARM Linux <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Fabio Estevam <fabio.estevam-3arQi8VN3Tc@public.gmane.org>, Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

UG9zdCB0aGlzIGRpc2N1c3Npb24gbWFpbCB0byBrZXJuZWwgbWFpbCBsaXN0LCBzaW5jZSBsYXN0
IG1haWwgaXMgcmVqZWN0ZWQgZHVlIHRvIGluY29ycmVjdCBmb3JtYXQsIHNvcnJ5IGZvciBjb25m
dXNpb24uIA0KDQpCZXN0IFJlZ2FyZHMhDQpBbnNvbiBIdWFuZw0KDQoNCj4gLS0tLS1PcmlnaW5h
bCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRmFiaW8gRXN0ZXZhbSBbbWFpbHRvOmZlc3RldmFtQGdt
YWlsLmNvbV0NCj4gU2VudDogMjAxOC0wMS0wMiAxMTozMiBQTQ0KPiBUbzogQW5zb24gSHVhbmcg
PGFuc29uLmh1YW5nQG54cC5jb20+DQo+IENjOiBtb2RlcmF0ZWQgbGlzdDpBUk0vRlJFRVNDQUxF
IElNWCAvIE1YQyBBUk0gQVJDSElURUNUVVJFIDxsaW51eC0NCj4gYXJtLWtlcm5lbEBsaXN0cy5p
bmZyYWRlYWQub3JnPjsgb3BlbiBsaXN0Ok9QRU4gRklSTVdBUkUgQU5EIEZMQVRURU5FRA0KPiBE
RVZJQ0UgVFJFRSBCSU5ESU5HUyA8ZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc+OyBsaW51eC0N
Cj4gcG1Admdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWwgPGxpbnV4LWtlcm5lbEB2Z2VyLmtl
cm5lbC5vcmc+OyBNYXJrDQo+IFJ1dGxhbmQgPG1hcmsucnV0bGFuZEBhcm0uY29tPjsgQS5zLiBE
b25nIDxhaXNoZW5nLmRvbmdAbnhwLmNvbT47IEphY2t5DQo+IEJhaSA8cGluZy5iYWlAbnhwLmNv
bT47IHZpcmVzaCBrdW1hciA8dmlyZXNoLmt1bWFyQGxpbmFyby5vcmc+Ow0KPiByandAcmp3eXNv
Y2tpLm5ldDsgUnVzc2VsbCBLaW5nIC0gQVJNIExpbnV4IDxsaW51eEBhcm1saW51eC5vcmcudWs+
OyBSb2INCj4gSGVycmluZyA8cm9iaCtkdEBrZXJuZWwub3JnPjsgU2FzY2hhIEhhdWVyIDxrZXJu
ZWxAcGVuZ3V0cm9uaXguZGU+Ow0KPiBGYWJpbyBFc3RldmFtIDxmYWJpby5lc3RldmFtQG54cC5j
b20+OyBTaGF3biBHdW8NCj4gPHNoYXduZ3VvQGtlcm5lbC5vcmc+DQo+IFN1YmplY3Q6IFJlOiBb
UEFUQ0ggMS8yXSBBUk06IGR0czogaW14NnVsOiBhZGQgNjk2TUh6IG9wZXJhdGluZyBwb2ludA0K
PiANCj4gT24gVHVlLCBKYW4gMiwgMjAxOCBhdCAxOjEyIFBNLCBBbnNvbiBIdWFuZyA8YW5zb24u
aHVhbmdAbnhwLmNvbT4gd3JvdGU6DQo+IA0KPiA+IFRoZXJlIGlzIGEgY29tbWVudCBpbiBWRERf
QVJNLCBWRERfU09DIG11c3QgTk9UIGxvd2VyIHRoYW4gVkREX0FSTS4NCj4gPg0KPiA+IE91dHB1
dCB2b2x0YWdlIG11c3QgYmUgc2V0IHRvIHRoZSBmb2xsb3dpbmcgcnVsZXM6DQo+ID4g4oCiIFZE
RF9BUk1fQ0FQIDw9IFZERF9TT0NfQ0FQDQo+ID4g4oCiIFZERF9TT0NfQ0FQIC0gVkREX0FSTV9D
QVAgPCAzMzAgbVYNCj4gDQo+IFRoYW5rcyBmb3IgdGhlIGNsYXJpZmNhdGlvbi4NCj4gDQo+IFJl
dmlld2VkLWJ5OiBGYWJpbyBFc3RldmFtIDxmYWJpby5lc3RldmFtQG54cC5jb20+DQo=
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
