From: MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: Re: Re: [PATCH 03/15] drivers: devfreq: Drop unlikely before
 IS_ERR(_OR_NULL)
Date: Mon, 03 Aug 2015 05:50:18 +0000 (GMT)
Message-ID: <1197027641.344961438581016329.JavaMail.weblogic@epmlwas06d>
Reply-To: myungjoo.ham@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:44568 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751453AbbHCFuU (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 3 Aug 2015 01:50:20 -0400
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTP id <0NSH01C0WS7UIBC0@mailout4.samsung.com> for
 linux-pm@vger.kernel.org; Mon, 03 Aug 2015 14:50:18 +0900 (KST)
MIME-version: 1.0
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, =?utf-8?Q?=EB=B0=95=EA=B2=BD=EB=AF=BC?= <kyungmin.park@samsung.com>, "open list:DEVICE FREQUENCY (DEVFREQ)" <linux-pm@vger.kernel.org>

PiBPbiAwMy0wOC0xNSwgMDU6MTAsIE15dW5nSm9vIEhhbSB3cm90ZToNCj4gPiA+IElTX0VSUihf
T1JfTlVMTCkgYWxyZWFkeSBjb250YWluIGFuICd1bmxpa2VseScgY29tcGlsZXIgZmxhZyBhbmQg
dGhlcmUNCj4gPiA+IGlzIG5vIG5lZWQgdG8gZG8gdGhhdCBhZ2FpbiBmcm9tIGl0cyBjYWxsZXJz
LiBEcm9wIGl0Lg0KPiA+ID4gDQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBWaXJlc2ggS3VtYXIgPHZp
cmVzaC5rdW1hckBsaW5hcm8ub3JnPg0KPiA+IA0KPiA+IEAgZnJvbSBpbmNsdWRlL2xpbnV4L2Vy
ci5oDQo+ID4gI2RlZmluZSBJU19FUlJfVkFMVUUoeCkgdW5saWtlbHkoKHgpID49ICh1bnNpZ25l
ZCBsb25nKS1NQVhfRVJSTk8pDQo+ID4gLi4uDQo+ID4gc3RhdGljIGlubGluZSBib29sIF9fbXVz
dF9jaGVjayBJU19FUlJfT1JfTlVMTChfX2ZvcmNlIGNvbnN0IHZvaWQgKnB0cikNCj4gPiB7DQo+
ID4gCXJldHVybiAhcHRyIHx8IElTX0VSUl9WQUxVRSgodW5zaWduZWQgbG9uZylwdHIpOw0KPiA+
IH0NCj4gPiANCj4gPiAiIXB0ciIgYXBwZWFycyBub3QgY292ZXJlZCB3aXRoIElTX0VSUl9PUl9O
VUxMLg0KPiA+IChvbmx5IHRoZSBJU19FUlIgcGFydCBzZWVtcyBjb3ZlcmVkKQ0KPiANCj4gUmln
aHQsIHRoZSBmaXJzdCBwYXRjaCBvZiB0aGUgc2VyaWVzIGhhcyBmaXhlZCB0aGF0Lg0KPiANCj4g
aHR0cDovL3Blcm1hbGluay5nbWFuZS5vcmcvZ21hbmUubGludXgua2VybmVsLzIwMDkxNTENCg0K
QWguLiBvaywgdGhlbiwNCg0KDQpBY2tlZC1ieTogTXl1bmdKb28gSGFtIDxteXVuZ2pvby5oYW1A
c2Ftc3VuZy5jb20+DQoNCg0KcGxlYXNlIGxldCBtZSBrbm93IHdoZW4gdGhlIHNlcmllcyBpcyBy
ZWFkeSB0byBnby4NCg0KDQpDaGVlcnMsDQpNeXVuZ0pvbw0KDQo+IA0KPiAtLSANCj4gdmlyZXNo
DQo+IA0K


