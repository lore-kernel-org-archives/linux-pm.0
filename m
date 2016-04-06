From: MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: Re: [PATCH v7 06/20] PM / devfreq: exynos: Add support of bus
 frequency of sub-blocks using passive governor
Date: Wed, 06 Apr 2016 10:12:29 +0000 (GMT)
Message-ID: <2100226609.169661459937543742.JavaMail.weblogic@ep2mlwas02a>
Reply-To: myungjoo.ham@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
MIME-version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
To: =?utf-8?Q?=EC=B5=9C=EC=B0=AC=EC=9A=B0?= <cw00.choi@samsung.com>, =?utf-8?Q?=EB=B0=95=EA=B2=BD=EB=AF=BC?= <kyungmin.park@samsung.com>, =?utf-8?Q?=ED=81=AC=EC=89=AC=EC=8B=9C=ED=86=A0=ED=94=84?= <k.kozlowski@samsung.com>, "kgene@kernel.org" <kgene@kernel.org>
Cc: "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "pawel.moll@arm.com" <pawel.moll@arm.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>, "galak@codeaurora.org" <galak@codeaurora.org>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "linux.amoon@gmail.com" <linux.amoon@gmail.com>, "m.reichl@fivetechno.de" <m.reichl@fivetechno.de>, "tjakobi@math.uni-bielefeld.de" <tjakobi@math.uni-bielefeld.de>, =?utf-8?Q?=EB=8C=80=EC=9D=B8=EA=B8=B0?= <inki.dae@samsung.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>"devicetree@vger.kernel.org" <devicetree@>
List-Id: linux-pm@vger.kernel.org

PiAgIA0KPiAgVGhpcyBwYXRjaCBhZGRzIHRoZSBzdXBwb3J0IG9mIGJ1cyBmcmVxdWVuY3kgZmVh
dHVyZSBmb3Igc3ViLWJsb2NrcyB3aGljaCBzaGFyZQ0KPiB0aGUgb25lIHBvd2VyIGxpbmUuIElm
IGVhY2ggYnVzIGRlcGVuZHMgb24gdGhlIHBvd2VyIGxpbmUsIGVhY2ggYnVzIGlzIG5vdCBhYmxl
DQo+IHRvIGNoYW5nZSB0aGUgdm9sdGFnZSBieSBvbmVzZWxmLiBUbyBvcHRpbWl6ZSB0aGUgcG93
ZXItY29uc3VtcHRpb24gb24gcnVudGltZSwNCj4gc29tZSBidXNlcyB1c2luZyB0aGUgc2FtZSBw
b3dlciBsaW5lIHNob3VsZCBjaGFuZ2UgdGhlIHNvdXJjZSBjbG9jayBhbmQNCj4gcmVndWxhdG9y
IGF0IHRoZSBzYW1lIHRpbWUuIFNvLCB0aGlzIHBhdGNoIHVzZXMgdGhlIHBhc3NpdmUgZ292ZXJu
b3IgdG8gc3VwcG9ydA0KPiB0aGUgYnVzIGZyZXF1ZW5jeSBmb3IgYWxsIGJ1c2VzIHdoaWNoIHNo
YXJpbmcgdGhlIG9uZSBwb3dlciBsaW5lLg0KPiANCltdDQo+IFNpZ25lZC1vZmYtYnk6IENoYW53
b28gQ2hvaSA8Y3cwMC5jaG9pQHNhbXN1bmcuY29tPg0KPiBbdGpha29iaTogUmVwb3J0ZWQgZGVi
dWdmcyBlcnJvciBkdXJpbmcgYm9vdGluZyBhbmQgY3cwMC5jaG9pIGZpeCBpdC5dDQo+IFJlcG9y
dGVkLWJ5OiBUb2JpYXMgSmFrb2JpIDx0amFrb2JpQG1hdGgudW5pLWJpZWxlZmVsZC5kZT4NCg0K
U2lnbmVkLW9mZi1ieTogTXl1bmdKb28gSGFtIDxteXVuZ2pvby5oYW1Ac2Ftc3VuZy5jb20+DQoN
Cg==
