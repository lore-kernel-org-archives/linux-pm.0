From: =?utf-8?B?6rCV7J247ZiBL+yxheyehOyXsOq1rOybkC9TVyBQbGF0Zm9ybSjsl7ApQU9U?=
         =?utf-8?B?7YyAKGh1Z2gua2FuZ0BsZ2UuY29tKQ==?= <hugh.kang@lge.com>
Subject: RE: [PATCH] thermal: cpu_cooling: Fix wrong comment call function
 name
Date: Mon, 19 Sep 2016 09:12:41 +0900
Message-ID: <C80AB6F618D91B4E8F391CB202C12DFD1122F76EA5@LGEVEXMBHQSVC1.LGE.NET>
References: <1473208539-17685-1-git-send-email-hugh.kang@lge.com>
 <20160908082600.GA3112@e104805>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from LGEAMRELO13.lge.com ([156.147.23.53]:46700 "EHLO
        lgeamrelo13.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755407AbcISAMq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 18 Sep 2016 20:12:46 -0400
In-Reply-To: <20160908082600.GA3112@e104805>
Content-Language: ko-KR
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Javi Merino <javi.merino@arm.com>, =?utf-8?B?6rCV7J247ZiBL+yxheyehOyXsOq1rOybkC9TVyBQbGF0Zm9ybSjsl7ApQU9U?= =?utf-8?B?7YyAKGh1Z2gua2FuZ0BsZ2UuY29tKQ==?= <hugh.kang@lge.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, "amit.kachhap@gmail.com" <amit.kachhap@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>, Rui Zhang <rui.zhang@intel.com>, =?utf-8?B?7KCV7LCs6regL+yImOyEneyXsOq1rOybkC9TVyBQbGF0Zm9ybSjsl7ApQU9U?= =?utf-8?B?7YyAKGNoYW4uamVvbmdAbGdlLmNvbSkgKGNoYW4uamVvbmdAbA==?= =?utf-8?B?Z2UuY29tKQ==?= <chan.jeong@lge.com>

WW91J3JlIHdlbGNvbWUuIFdpbGwgYmUgbWVyZ2VkIHRoaXMgcGF0Y2g/DQpUaGFuayB5b3UNCg0K
SHVnaCBLYW5nDQoNCk5vIE9uZSBldmVyIGlzIGRlZmVhdGVkIHVudGlsIGRlZmVhdCBoYXMgYmVl
biBhY2NlcHRlZCBhcyBhIHJlYWxpdHkuDQrqsJXsnbjtmIEgKEh1Z2ggS2FuZykgQ2hpZWYgRW5n
aW5lZXINClNXIFBsYXRmb3JtKOyXsCkgQWR2YW5jZWQgT1MgVGVjaG5vbG9neSBURUFNIChBT1Qp
DQpNb2JpbGU6ICs4Mi0xMC01NTEzLTc5NTcNCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0N
CkZyb206IEphdmkgTWVyaW5vIFttYWlsdG86amF2aS5tZXJpbm9AYXJtLmNvbV0gDQpTZW50OiBU
aHVyc2RheSwgU2VwdGVtYmVyIDA4LCAyMDE2IDU6MjYgUE0NClRvOiBJbmh5dWsgS2FuZw0KQ2M6
IFZpcmVzaCBLdW1hcjsgYW1pdC5rYWNoaGFwQGdtYWlsLmNvbTsgbGludXgta2VybmVsQHZnZXIu
a2VybmVsLm9yZzsgbGludXgtcG1Admdlci5rZXJuZWwub3JnOyBFZHVhcmRvIFZhbGVudGluOyBS
dWkgWmhhbmcNClN1YmplY3Q6IFJlOiBbUEFUQ0hdIHRoZXJtYWw6IGNwdV9jb29saW5nOiBGaXgg
d3JvbmcgY29tbWVudCBjYWxsIGZ1bmN0aW9uIG5hbWUNCg0KT24gV2VkLCBTZXAgMDcsIDIwMTYg
YXQgMDk6MzU6MzlBTSArMDkwMCwgSW5oeXVrIEthbmcgd3JvdGU6DQo+IFRoZSBsYXN0X2xvYWQg
aXMgdXBkYXRlZCBub3QgY3B1ZnJlcV9nZXRfYWN0dWFsX3Bvd2VyKCkgZnVuY3Rpb24gY2FsbCAN
Cj4gYnV0IGNwdWZyZXFfZ2V0X3JlcXVlc3RlZF9wb3dlcigpIGZ1bmN0aW9uIGNhbGwuDQoNClll
cCwgbXkgYmFkLiAgVGhhbmtzIGZvciBmaXhpbmcgaXQhDQoNCj4gU2lnbmVkLW9mZi1ieTogSW5o
eXVrIEthbmcgPGh1Z2gua2FuZ0BsZ2UuY29tPg0KDQpBY2tlZC1ieTogSmF2aSBNZXJpbm8gPGph
dmkubWVyaW5vQGFybS5jb20+DQoNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdGhlcm1hbC9jcHVf
Y29vbGluZy5jIA0KPiBiL2RyaXZlcnMvdGhlcm1hbC9jcHVfY29vbGluZy5jIGluZGV4IGEzMmI0
MTcuLjljZTBlOWUgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvdGhlcm1hbC9jcHVfY29vbGluZy5j
DQo+ICsrKyBiL2RyaXZlcnMvdGhlcm1hbC9jcHVfY29vbGluZy5jDQo+IEBAIC03NCw3ICs3NCw3
IEBAIHN0cnVjdCBwb3dlcl90YWJsZSB7DQo+ICAgKgljcHVmcmVxIGZyZXF1ZW5jaWVzLg0KPiAg
ICogQGFsbG93ZWRfY3B1czogYWxsIHRoZSBjcHVzIGludm9sdmVkIGZvciB0aGlzIGNwdWZyZXFf
Y29vbGluZ19kZXZpY2UuDQo+ICAgKiBAbm9kZTogbGlzdF9oZWFkIHRvIGxpbmsgYWxsIGNwdWZy
ZXFfY29vbGluZ19kZXZpY2UgdG9nZXRoZXIuDQo+IC0gKiBAbGFzdF9sb2FkOiBsb2FkIG1lYXN1
cmVkIGJ5IHRoZSBsYXRlc3QgY2FsbCB0byANCj4gY3B1ZnJlcV9nZXRfYWN0dWFsX3Bvd2VyKCkN
Cj4gKyAqIEBsYXN0X2xvYWQ6IGxvYWQgbWVhc3VyZWQgYnkgdGhlIGxhdGVzdCBjYWxsIHRvIA0K
PiArIGNwdWZyZXFfZ2V0X3JlcXVlc3RlZF9wb3dlcigpDQo+ICAgKiBAdGltZV9pbl9pZGxlOiBw
cmV2aW91cyByZWFkaW5nIG9mIHRoZSBhYnNvbHV0ZSB0aW1lIHRoYXQgdGhpcyBjcHUgd2FzIGlk
bGUNCj4gICAqIEB0aW1lX2luX2lkbGVfdGltZXN0YW1wOiB3YWxsIHRpbWUgb2YgdGhlIGxhc3Qg
aW52b2NhdGlvbiBvZg0KPiAgICoJZ2V0X2NwdV9pZGxlX3RpbWVfdXMoKQ0KPiAtLQ0KPiAxLjku
MQ0KPiANCg==
