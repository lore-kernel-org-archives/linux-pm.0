From: MyungJoo Ham <myungjoo.ham-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v7 05/20] PM / devfreq: Add new passive governor
Date: Wed, 06 Apr 2016 10:06:12 +0000 (GMT)
Message-ID: <1156624937.169371459937164322.JavaMail.weblogic@ep2mlwas02a>
Reply-To: myungjoo.ham-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
MIME-version: 1.0
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?utf-8?Q?=EC=B5=9C=EC=B0=AC=EC=9A=B0?= <cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, =?utf-8?Q?=EB=B0=95=EA=B2=BD=EB=AF=BC?= <kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, =?utf-8?Q?=ED=81=AC=EC=89=AC=EC=8B=9C=ED=86=A0=ED=94=84?= <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: "rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, "robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "pawel.moll-5wv7dgnIgG8@public.gmane.org" <pawel.moll-5wv7dgnIgG8@public.gmane.org>, "mark.rutland-5wv7dgnIgG8@public.gmane.org" <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org" <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, "galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org" <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org" <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, "linux.amoon-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <linux.amoon-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "m.reichl-SRyzfwRm/0rPTwkrwQOX7A@public.gmane.org" <m.reichl-SRyzfwRm/0rPTwkrwQOX7A@public.gmane.org>, "tjakobi-o02PS0xoJP9W0yFyLvAVXMxlOr/tl8fh@public.gmane.org" <tjakobi-o02PS0xoJP9W0yFyLvAVXMxlOr/tl8fh@public.gmane.org>, =?utf-8?Q?=EB=8C=80=EC=9D=B8=EA=B8=B0?= <inki.dae-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree@>
List-Id: linux-pm@vger.kernel.org

PiAgIA0KPiAgVGhpcyBwYXRjaCBhZGRzIHRoZSBuZXcgcGFzc2l2ZSBnb3Zlcm5vciBmb3IgREVW
RlJFUSBmcmFtZXdvcmsuIFRoZSBmb2xsb3dpbmcNCj4gZ292ZXJub3JzIGFyZSBhbHJlYWR5IHBy
ZXNlbnQgYW5kIHVzZWQgZm9yIERWRlMgKER5bmFtaWMgVm9sdGFnZSBhbmQgRnJlcXVlbmN5DQo+
IFNjYWxpbmcpIGRyaXZlcnMuIFRoZSBmb2xsb3dpbmcgZ292ZXJub3JzIGFyZSBpbmRlcGVuZGVu
dGx5IHVzZWQgZm9yIG9uZSBkZXZpY2UNCltdDQo+IFN1Z2dlc3RlZC1ieTogTXl1bmdqb28gSGFt
IDxteXVuZ2pvby5oYW1Ac2Ftc3VuZy5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IENoYW53b28gQ2hv
aSA8Y3cwMC5jaG9pQHNhbXN1bmcuY29tPg0KPiBbdGpha29iaTogUmVwb3J0ZWQgUkNVIGxvY2tp
bmcgaXNzdWUgYW5kIGN3MDAuY2hvaSBmaXggaXQuXQ0KPiBSZXBvcnRlZC1ieTogVG9iaWFzIEph
a29iaSA8dGpha29iaUBtYXRoLnVuaS1iaWVsZWZlbGQuZGU+DQoNClNpZ25lZC1vZmYtYnk6IE15
dW5nSm9vIEhhbSA8bXl1bmdqb28uaGFtQHNhbXN1bmcuY29tPg0KDQpQbGVhc2UganVzdCBlZGl0
IHRoZSBjb21tZW50IGJlbG93IGFuZCBwdXNoIHRvIHlvdXIgZ2l0IHJlcG8gc28gdGhhdA0KSSBj
YW4gc2ltcGx5IHB1bGwgeW91ciByZXBvIGEgZGF5IG9yIHR3byBsYXRlci4NCg0KPiAtLS0NCj4g
IGRyaXZlcnMvZGV2ZnJlcS9LY29uZmlnICAgICAgICAgICAgfCAgIDggKysNCj4gIGRyaXZlcnMv
ZGV2ZnJlcS9NYWtlZmlsZSAgICAgICAgICAgfCAgIDEgKw0KPiAgZHJpdmVycy9kZXZmcmVxL2dv
dmVybm9yX3Bhc3NpdmUuYyB8IDIwNiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrDQo+ICBpbmNsdWRlL2xpbnV4L2RldmZyZXEuaCAgICAgICAgICAgIHwgIDMzICsrKysrKw0K
PiAgNCBmaWxlcyBjaGFuZ2VkLCAyNDggaW5zZXJ0aW9ucygrKQ0KPiAgY3JlYXRlIG1vZGUgMTAw
NjQ0IGRyaXZlcnMvZGV2ZnJlcS9nb3Zlcm5vcl9wYXNzaXZlLmMNCj4gDQo+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL2RldmZyZXEvS2NvbmZpZyBiL2RyaXZlcnMvZGV2ZnJlcS9LY29uZmlnDQo+IGlu
ZGV4IGNlZGRhOGYxZTVlYi4uZDI2MGNkMDIxOWY2IDEwMDY0NA0KW10NCj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvZGV2ZnJlcS9NYWtlZmlsZSBiL2RyaXZlcnMvZGV2ZnJlcS9NYWtlZmlsZQ0KPiBp
bmRleCA4YWY4YWFmOTIyYTguLjI2MzMwODdkNWM2MyAxMDA2NDQNCltdDQo+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL2RldmZyZXEvZ292ZXJub3JfcGFzc2l2ZS5jIGIvZHJpdmVycy9kZXZmcmVxL2dv
dmVybm9yX3Bhc3NpdmUuYw0KPiArCS8qDQo+ICsJICogSWYgdGhlIHBhcmVudCBhbmQgcGFzc2l2
ZSBkZXZmcmVxIGRldmljZSB1c2VzIHRoZSBPUFAgdGFibGUsDQo+ICsJICogZ2V0IHRoZSBuZXh0
IGZyZXF1ZW5jeSBieSB1c2luZyB0aGUgT1BQIHRhYmxlLg0KDQpEb2Vzbid0IG5lZWQgY29tbWVu
dHMgZnJvbSBoZXJlDQo+ICsJICogLSBwYXJlbnQgZGV2ZnJlcSBkZXZpY2UgdXNlcyB0aGUgZ292
ZXJub3JzIGV4Y2VwdCBmb3IgcGFzc2l2ZS4NCj4gKwkgKiAtIHBhc3NpdmUgZGV2ZnJlcSBkZXZp
Y2UgdXNlcyB0aGUgcGFzc2l2ZSBnb3Zlcm5vci4NCj4gKwkgKi8NCj4gKw0KPiArCS8qDQpUbyBo
ZXJlLg0KDQo+ICsJICogRWFjaCBkZXZmcmVxIGhhcyB0aGUgT1BQIHRhYmxlLiBBZnRlciBkZWNp
ZGluZyB0aGUgbmV3IGZyZXF1ZW5jeQ0KPiArCSAqIGZyb20gdGhlIGdvdmVybm9yIG9mIHBhcmVu
dCBkZXZmcmVxIGRldmljZSwgdGhlIHBhc3NpdmUgZ292ZXJub3INCj4gKwkgKiBuZWVkIHRvIGdl
dCB0aGUgaW5kZXggb2YgbmV3IGZyZXF1ZW5jeSBvbiBPUFAgdGFibGUgb2YgcGFyZW50DQo+ICsJ
ICogZGV2aWNlLiBBbmQgdGhlbiB0aGUgaW5kZXggaXMgdXNlZCBmb3IgZ2V0dGluZyB0aGUgc3Vp
dGFibGUNCj4gKwkgKiBuZXcgZnJlcXVlbmN5IGZvciBwYXNzaXZlIGRldmZyZXEgZGV2aWNlLg0K
PiArCSAqLw0KDQpbXQ0KDQo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L2RldmZyZXEuaCBi
L2luY2x1ZGUvbGludXgvZGV2ZnJlcS5oDQo+IGluZGV4IDk4YzY5OTMwNGUxMi4uMmRlNGUyZWVh
MTgwIDEwMDY0NA0KW10NCg==


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
