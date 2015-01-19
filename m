From: MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: Re: [PATCH v4 4/9] clk: samsung: exynos4: Add divider clock id for
 memory bus frequency
Date: Mon, 19 Jan 2015 09:31:34 +0000 (GMT)
Message-ID: <889613260.1254421421659891455.JavaMail.weblogic@epmlwas05d>
Reply-To: myungjoo.ham@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:45983 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751426AbbASJbw (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 19 Jan 2015 04:31:52 -0500
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0NIF00L753SMN9D0@mailout2.samsung.com> for
 linux-pm@vger.kernel.org; Mon, 19 Jan 2015 18:31:34 +0900 (KST)
MIME-version: 1.0
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: =?utf-8?Q?=EC=B5=9C=EC=B0=AC=EC=9A=B0?= <cw00.choi@samsung.com>, "kgene@kernel.org" <kgene@kernel.org>
Cc: =?utf-8?Q?=EB=B0=95=EA=B2=BD=EB=AF=BC?= <kyungmin.park@samsung.com>, "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>, ABHILASH KESAVAN <a.kesavan@samsung.com>, "tomasz.figa@gmail.com" <tomasz.figa@gmail.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, =?utf-8?Q?=EB=8C=80=EC=9D=B8=EA=B8=B0?= <inki.dae@samsung.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>

PiAgIA0KPiAgVGhpcyBwYXRjaCBhZGRzIHRoZSBkaXZpZGVyIGNsb2NrIGlkIGZvciBFeHlub3M0
IG1lbW9yeSBidXMgZnJlcXVlbmN5Lg0KPiBUaGUgY2xvY2sgaWQgaXMgdXNlZCBmbyBEVkZTIChE
eW5hbWljIFZvbHRhZ2UvRnJlcXVlbmN5IFNjYWxpbmcpDQo+IGZlYXR1cmUgb2YgZXh5bm9zIG1l
bW9yeSBidXMgZnJlcXVlbmN5Lg0KPiANCj4gQ2M6IFN5bHdlc3RlciBOYXdyb2NraSA8cy5uYXdy
b2NraUBzYW1zdW5nLmNvbT4NCj4gQ2M6IFRvbWFzeiBGaWdhIDx0b21hc3ouZmlnYUBnbWFpbC5j
b20+DQo+IFNpZ25lZC1vZmYtYnk6IENoYW53b28gQ2hvaSA8Y3cwMC5jaG9pQHNhbXN1bmcuY29t
Pg0KDQpBY2tlZC1ieTogTXl1bmdKb28gSGFtIDxteXVuZ2pvby5oYW1Ac2Ftc3VuZy5jb20+DQoN
CkFueXdheSwgeW91IHdpbGwgbmVlZCByZXZpZXdzIGZyb20gU3lsd2VzdGVyIGFuZC9vciBUb21h
c3ogZm9yIHRoaXMgb25lLg0KDQoNCg0KQ2hlZXJzLA0KTXl1bmdKb28NCg==


