From: Anson Huang <anson.huang-3arQi8VN3Tc@public.gmane.org>
Subject: RE: [PATCH 2/2] cpufreq: imx6q: add 696MHz operating point for
 i.mx6ul
Date: Wed, 3 Jan 2018 02:10:26 +0000
Message-ID: <AM3PR04MB1315CC6739E309610D29A45DF51E0@AM3PR04MB1315.eurprd04.prod.outlook.com>
References: <1514912859-17691-1-git-send-email-Anson.Huang@nxp.com>
 <1514912859-17691-2-git-send-email-Anson.Huang@nxp.com>
 <CAOMZO5Do-tyR0ruqfSeJm2FDP7_chNeroFStTF85GnSt_2g5Uw@mail.gmail.com>
 <A2F3BA8B-361A-4809-83FE-4067CD868D5B@nxp.com>
 <CAOMZO5DvKi4nXfoSBWbe6qedoWO7RiSP5CvJEkBAVUioyVBN=Q@mail.gmail.com>
 <6FFDB281-8293-4D2C-891F-B376B52EFECF@nxp.com>
 <CAOMZO5ADWdbDoCO8b4JVDag=PH2MgLsLbQ6DJU8VvJh6G6qMkQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAOMZO5ADWdbDoCO8b4JVDag=PH2MgLsLbQ6DJU8VvJh6G6qMkQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "A.s. Dong" <aisheng.dong-3arQi8VN3Tc@public.gmane.org>, Jacky Bai <ping.bai-3arQi8VN3Tc@public.gmane.org>, viresh kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Russell King - ARM Linux <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Fabio Estevam <fabio.estevam-3arQi8VN3Tc@public.gmane.org>, Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

UG9zdCB0aGUgZGlzY3Vzc2lvbiBtYWlsIHRvIGFybSBrZXJuZWwgbWFpbCBsaXN0LCBzaW5jZSBs
YXN0IG1haWwgaXMgcmVqZWN0ZWQgZHVlIHRvIGluY29ycmVjdCBmb3JtYXQsIHNvcnJ5IGZvciB0
aGUgY29uZnVzaW9uLg0KDQpCZXN0IFJlZ2FyZHMhDQpBbnNvbiBIdWFuZw0KDQoNCj4gLS0tLS1P
cmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRmFiaW8gRXN0ZXZhbSBbbWFpbHRvOmZlc3Rl
dmFtQGdtYWlsLmNvbV0NCj4gU2VudDogMjAxOC0wMS0wMiAxMTozMyBQTQ0KPiBUbzogQW5zb24g
SHVhbmcgPGFuc29uLmh1YW5nQG54cC5jb20+DQo+IENjOiBtb2RlcmF0ZWQgbGlzdDpBUk0vRlJF
RVNDQUxFIElNWCAvIE1YQyBBUk0gQVJDSElURUNUVVJFIDxsaW51eC0NCj4gYXJtLWtlcm5lbEBs
aXN0cy5pbmZyYWRlYWQub3JnPjsgb3BlbiBsaXN0Ok9QRU4gRklSTVdBUkUgQU5EIEZMQVRURU5F
RA0KPiBERVZJQ0UgVFJFRSBCSU5ESU5HUyA8ZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc+OyBs
aW51eC0NCj4gcG1Admdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWwgPGxpbnV4LWtlcm5lbEB2
Z2VyLmtlcm5lbC5vcmc+OyBNYXJrDQo+IFJ1dGxhbmQgPG1hcmsucnV0bGFuZEBhcm0uY29tPjsg
QS5zLiBEb25nIDxhaXNoZW5nLmRvbmdAbnhwLmNvbT47IEphY2t5DQo+IEJhaSA8cGluZy5iYWlA
bnhwLmNvbT47IHZpcmVzaCBrdW1hciA8dmlyZXNoLmt1bWFyQGxpbmFyby5vcmc+Ow0KPiByandA
cmp3eXNvY2tpLm5ldDsgUnVzc2VsbCBLaW5nIC0gQVJNIExpbnV4IDxsaW51eEBhcm1saW51eC5v
cmcudWs+OyBSb2INCj4gSGVycmluZyA8cm9iaCtkdEBrZXJuZWwub3JnPjsgU2FzY2hhIEhhdWVy
IDxrZXJuZWxAcGVuZ3V0cm9uaXguZGU+Ow0KPiBGYWJpbyBFc3RldmFtIDxmYWJpby5lc3RldmFt
QG54cC5jb20+OyBTaGF3biBHdW8NCj4gPHNoYXduZ3VvQGtlcm5lbC5vcmc+DQo+IFN1YmplY3Q6
IFJlOiBbUEFUQ0ggMi8yXSBjcHVmcmVxOiBpbXg2cTogYWRkIDY5Nk1IeiBvcGVyYXRpbmcgcG9p
bnQgZm9yDQo+IGkubXg2dWwNCj4gDQo+IE9uIFR1ZSwgSmFuIDIsIDIwMTggYXQgMToxNyBQTSwg
QW5zb24gSHVhbmcgPGFuc29uLmh1YW5nQG54cC5jb20+IHdyb3RlOg0KPiANCj4gPiBUaGlzIGNo
YW5nZSBpcyBvbmx5IHZhbGlkIGZvciBteDZ1bCBhbmQgbXg2dWxsLCBvdGhlciBTb0NzIGxpa2UN
Cj4gPiA2cS9kbC9xcCBhcmUgTk9UIGltcGFjdGVkLg0KPiANCj4gVGhhbmtzIGZvciB0aGUgY2xh
cmlmaWNhdGlvbjoNCj4gDQo+IFJldmlld2VkLWJ5OiBGYWJpbyBFc3RldmFtIDxmYWJpby5lc3Rl
dmFtQG54cC5jb20+DQo=
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
