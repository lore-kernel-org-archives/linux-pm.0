Received: from mailgw1.hygon.cn (unknown [101.204.27.37])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7692D46D562;
	Tue, 15 Sep 2026 12:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.204.27.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789476398; cv=none; b=AlqOdKcl1fVs7SgQ2hxKBPD4xShwwcCsO3fSUX+Zorkn89T7IvXUQfrKUkPD0+IYfuQCe/doyu8nrRQMsLqMUGVvSevSeEFnk26NuugvP9PxHQVuULZaDqVODpLrEyuWEY4FfkcwiM12b+ix2S3osbb1NKZXIhrJKsc5dNMUQyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789476398; c=relaxed/simple;
	bh=L8YPSGCyaFFudq4A/4tOCJdVH8P+Tw0P8u4pGmVjPLU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=t8CQTJ6wYdu+T94d06GpHGv2wJKFxFTZqKFZEuRtquyKAaapS8BlUwt8DhomBjl1mx61OeaVLyyIa8l8XQBmvhyAuHJlniB3FeOwElTowT1Ukj7rZm18nSotFOGSho9hyKsE+bLdEUDjUEaspqYE9idVeu5iOLldv62ODRD+2N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn; spf=pass smtp.mailfrom=hygon.cn; arc=none smtp.client-ip=101.204.27.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hygon.cn
Received: from maildlp1.hygon.cn (unknown [127.0.0.1])
	by mailgw1.hygon.cn (Postfix) with ESMTP id 4hkhbC4DzKz2CZrN;
	Tue, 15 Sep 2026 20:46:15 +0800 (CST)
Received: from maildlp1.hygon.cn (unknown [172.23.18.60])
	by mailgw1.hygon.cn (Postfix) with ESMTP id 4hkhb95jgcz1mw7S;
	Tue, 15 Sep 2026 20:46:13 +0800 (CST)
Received: from cncheex06.Hygon.cn (unknown [172.23.18.116])
	by maildlp1.hygon.cn (Postfix) with ESMTPS id 4C4F51641;
	Tue, 15 Sep 2026 20:46:09 +0800 (CST)
Received: from cncheex04.Hygon.cn (172.23.18.114) by cncheex06.Hygon.cn
 (172.23.18.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Tue, 15 Sep
 2026 20:46:14 +0800
Received: from cncheex04.Hygon.cn ([fe80::1b6f:6c58:58a4:430d]) by
 cncheex04.Hygon.cn ([fe80::1b6f:6c58:58a4:430d%10]) with mapi id
 15.02.1544.036; Tue, 15 Sep 2026 20:46:14 +0800
From: Jianyong Wu <wujianyong@hygon.cn>
To: Hongyan Xia <hongyan.xia@transsion.com>
CC: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"ray.huang@amd.com" <ray.huang@amd.com>, "mario.limonciello@amd.com"
	<mario.limonciello@amd.com>, "perry.yuan@amd.com" <perry.yuan@amd.com>,
	"zhanjie9@hisilicon.com" <zhanjie9@hisilicon.com>, "zhenglifeng1@huawei.com"
	<zhenglifeng1@huawei.com>, "pierre.gondois@arm.com" <pierre.gondois@arm.com>,
	"sumitg@nvidia.com" <sumitg@nvidia.com>,
	"srinivas.pandruvada@linux.intel.com" <srinivas.pandruvada@linux.intel.com>,
	"lenb@kernel.org" <lenb@kernel.org>, "zhongqiu.han@oss.qualcomm.com"
	<zhongqiu.han@oss.qualcomm.com>, "jianyong.wu@outlook.com"
	<jianyong.wu@outlook.com>, Fengyu Wang <wangfengyu@hygon.cn>, Yuan Zhong
	<zhongyuan@hygon.cn>, Huangsj <huangsj@hygon.cn>, "rafael@kernel.org"
	<rafael@kernel.org>, "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
	"kprateek.nayak@amd.com" <kprateek.nayak@amd.com>,
	"vincent.guittot@linaro.org" <vincent.guittot@linaro.org>
Subject: RE: [PATCH] cpufreq: Use a non-boost reference frequency for pressure
 calculation
Thread-Topic: [PATCH] cpufreq: Use a non-boost reference frequency for
 pressure calculation
Thread-Index: AQHdROA84sx4SsqcvEWfPOLMo4juUrbO2oeAgAC6S/A=
Date: Tue, 15 Sep 2026 12:46:14 +0000
Message-ID: <0f30cfed358847e88f36f3833924dd25@hygon.cn>
References: <20260915065747.1671965-1-wujianyong@hygon.cn>
 <b10f5ad9-c91d-446d-a382-e6b2ce0ff7fb@transsion.com>
In-Reply-To: <b10f5ad9-c91d-446d-a382-e6b2ce0ff7fb@transsion.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

SGkgSG9uZ3lhbiwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBIb25n
eWFuIFhpYSA8aG9uZ3lhbi54aWFAdHJhbnNzaW9uLmNvbT4NCj4gU2VudDogVHVlc2RheSwgU2Vw
dGVtYmVyIDE1LCAyMDI2IDU6MzMgUE0NCj4gVG86IEppYW55b25nIFd1IDx3dWppYW55b25nQGh5
Z29uLmNuPjsgcmFmYWVsQGtlcm5lbC5vcmc7DQo+IHZpcmVzaC5rdW1hckBsaW5hcm8ub3JnOyBr
cHJhdGVlay5uYXlha0BhbWQuY29tOw0KPiB2aW5jZW50Lmd1aXR0b3RAbGluYXJvLm9yZw0KPiBD
YzogbGludXgtcG1Admdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3Jn
Ow0KPiByYXkuaHVhbmdAYW1kLmNvbTsgbWFyaW8ubGltb25jaWVsbG9AYW1kLmNvbTsgcGVycnku
eXVhbkBhbWQuY29tOw0KPiB6aGFuamllOUBoaXNpbGljb24uY29tOyB6aGVuZ2xpZmVuZzFAaHVh
d2VpLmNvbTsNCj4gcGllcnJlLmdvbmRvaXNAYXJtLmNvbTsgc3VtaXRnQG52aWRpYS5jb207DQo+
IHNyaW5pdmFzLnBhbmRydXZhZGFAbGludXguaW50ZWwuY29tOyBsZW5iQGtlcm5lbC5vcmc7DQo+
IHpob25ncWl1LmhhbkBvc3MucXVhbGNvbW0uY29tOyBqaWFueW9uZy53dUBvdXRsb29rLmNvbTsg
RmVuZ3l1DQo+IFdhbmcgPHdhbmdmZW5neXVAaHlnb24uY24+OyBZdWFuIFpob25nIDx6aG9uZ3l1
YW5AaHlnb24uY24+Ow0KPiBIdWFuZ3NqIDxodWFuZ3NqQGh5Z29uLmNuPg0KPiBTdWJqZWN0OiBS
ZTogW1BBVENIXSBjcHVmcmVxOiBVc2UgYSBub24tYm9vc3QgcmVmZXJlbmNlIGZyZXF1ZW5jeSBm
b3INCj4gcHJlc3N1cmUgY2FsY3VsYXRpb24NCj4gDQo+IE9uIDkvMTUvMjAyNiAyOjU3IFBNLCBK
aWFueW9uZyBXdSB3cm90ZToNCj4gPiBDb21taXQgZDJkNWMxMjlkMDdlICgiY3B1ZnJlcTogTWFr
ZSBjcHVmcmVxX3VwZGF0ZV9wcmVzc3VyZSgpIGZhbGwNCj4gPiBiYWNrIHRvIGNwdWluZm8ubWF4
X2ZyZXEiKSBpbnRyb2R1Y2VkIGNwdWluZm8ubWF4X2ZyZXEgYXMgdGhlIHJlZmVyZW5jZQ0KPiA+
IGZyZXF1ZW5jeSBmb3IgY3B1ZnJlcSBwcmVzc3VyZSB3aGVuIGFyY2hfc2NhbGVfZnJlcV9yZWYo
KSByZXR1cm5zIHplcm8uDQo+ID4NCj4gPiBIb3dldmVyLCBjcHVpbmZvLm1heF9mcmVxIG1heSBp
bmNsdWRlIGJvb3N0IGZyZXF1ZW5jaWVzIGFuZCB0aGVyZWZvcmUNCj4gPiBkb2VzIG5vdCBuZWNl
c3NhcmlseSByZXByZXNlbnQgdGhlIG1heGltdW0gc3VzdGFpbmFibGUgZnJlcXVlbmN5LiBPbg0K
PiA+IHNvbWUgc3lzdGVtcyB1c2luZyBhY3BpLWNwdWZyZXEsIGNwdWluZm8ubWF4X2ZyZXEgaW5j
bHVkZXMgYm9vc3Qgd2hpbGUNCj4gPiB0aGUgZnJlcXVlbmN5IHRhYmxlIG9ubHkgY29udGFpbnMg
bm9uLWJvb3N0IGZyZXF1ZW5jaWVzLiBDb25zZXF1ZW50bHksDQo+ID4gY3B1ZnJlcSBwcmVzc3Vy
ZSByZW1haW5zIG5vbnplcm8gZXZlbiB3aXRob3V0IGFuIGFkZGl0aW9uYWwgZnJlcXVlbmN5DQo+
ID4gbGltaXQuDQo+ID4NCj4gPiBGdXJ0aGVybW9yZSwgZHJpdmVycyBtYXkgdXBkYXRlIGNwdWlu
Zm8ubWF4X2ZyZXEgd2hlbiBib29zdCBpcw0KPiBlbmFibGVkDQo+ID4gb3IgZGlzYWJsZWQuIFdp
dGggYSBmaXhlZCBwb2xpY3kgbGltaXQgYmVsb3cgdGhlIG1heGltdW0gbm9uLWJvb3N0DQo+ID4g
ZnJlcXVlbmN5LCB0aGlzIGNoYW5nZXMgdGhlIHByZXNzdXJlIHJlZmVyZW5jZSBhbmQgaGVuY2Ug
dGhlIHJlcG9ydGVkDQo+ID4gcHJlc3N1cmUsIGFsdGhvdWdoIHRoZSBub24tYm9vc3QgZnJlcXVl
bmN5IGxpbWl0IHJlbWFpbnMgdW5jaGFuZ2VkLg0KPiA+DQo+ID4gQWRkIG1heF9zdXN0YWluYWJs
ZV9mcmVxIHRvIHN0cnVjdCBjcHVmcmVxX2NwdWluZm8gdG8gcHJvdmlkZSBhDQo+IHJlZmVyZW5j
ZQ0KPiA+IGZyZXF1ZW5jeSBleGNsdWRpbmcgYm9vc3QuIFBvcHVsYXRlIGl0IGZyb20gdGhlIG5v
bWluYWwgZnJlcXVlbmN5IGluDQo+ID4gYW1kLXBzdGF0ZSBhbmQgY3BwY19jcHVmcmVxLCB0aGUg
bWF4aW11bSBub24tdHVyYm8gZnJlcXVlbmN5IGluDQo+ID4gaW50ZWxfcHN0YXRlLCBhbmQgdGhl
IGhpZ2hlc3QgZnJlcXVlbmN5LXRhYmxlIGVudHJ5IGluIGFjcGktY3B1ZnJlcS4NCj4gPg0KPiA+
IFVzZSB0aGlzIHZhbHVlIHdoZW4gYXJjaF9zY2FsZV9mcmVxX3JlZigpIHJldHVybnMgemVyby4g
UHJlc2VydmUgdGhlDQo+ID4gZXhpc3RpbmcgY3B1aW5mby5tYXhfZnJlcSBmYWxsYmFjayBmb3Ig
ZHJpdmVycyB0aGF0IGxlYXZlIHRoZSBuZXcgZmllbGQNCj4gPiBhdCB6ZXJvLg0KPiANCj4gQWN0
dWFsbHksIHdoYXQgcmVtYWluaW5nIHBsYXRmb3JtcyBhcmUgb3V0IHRoZXJlIHRoYXQgY2FuIGhp
dCB0aGlzIHBhdGg/DQo+ICBGcm9tIGEgcXVpY2sgbG9vayBJIHRoaW5rIG5vIHg4NiBvciBBcm0g
cGxhdGZvcm1zIGNhbiBoaXQgdGhlIGZhbGxiYWNrLg0KPiANClRoYW5rcyBmb3IgcmV2aWV3IQ0K
DQpUaGVyZSBhcmUgbWFueSBjcHVmcmVxIGRyaXZlcnMsIGFuZCBJIGRvbid0IGhhdmUgYWNjZXNz
IHRvIGhhcmR3YXJlIGNvdmVyaW5nDQphbGwgb2YgdGhlbS4gVGhpcyBwYXRjaCB0aGVyZWZvcmUg
bGltaXRzIHRoZSBjaGFuZ2VzIHRvIGRyaXZlcnMgcmVsZXZhbnQgdG8NCnRoZSByZXBvcnRlZCBp
c3N1ZS4NCg0KU29tZSBsZWdhY3kgeDg2IGRyaXZlcnMsIHN1Y2ggYXMgcHQtY2xvY2ttb2QsIGRv
IG5vdCBwb3B1bGF0ZSB0aGUgbmV3IGZpZWxkDQphbmQgc3RpbGwgdXNlIHRoZSBmYWxsYmFjay4g
VGhlIGZhbGxiYWNrIHByZXNlcnZlcyB0aGVpciBleGlzdGluZyBiZWhhdmlvci4NCg0KU3VwcG9y
dCBmb3IgdGhlIG5ldyBmaWVsZCBpbiBvdGhlciBkcml2ZXJzIGNhbiBiZSBhZGRlZCBzZXBhcmF0
ZWx5LCBhZnRlcg0KdmVyaWZ5aW5nIGVhY2ggZHJpdmVyJ3MgZnJlcXVlbmN5IHNlbWFudGljcyBh
bmQgdmFsaWRhdGluZyB0aGUgY2hhbmdlcyBvbg0KdGhlIHJlbGV2YW50IGhhcmR3YXJlLg0KDQpU
aGFua3MNCkppYW55b25nDQo+ID4gVGVzdGVkIHdpdGggYWNwaS1jcHVmcmVxLCBpbnRlbF9wc3Rh
dGUsIGFuZCBhbWQtcHN0YXRlIGluIGFjdGl2ZSBhbmQNCj4gPiBwYXNzaXZlIG1vZGVzLiBXaXRo
IG5vIGFkZGl0aW9uYWwgZnJlcXVlbmN5IGxpbWl0LCBwcmVzc3VyZSBpcyB6ZXJvLg0KPiA+IFdp
dGggYSBmaXhlZCBsaW1pdCBiZWxvdyB0aGUgbm9uLWJvb3N0IHJlZmVyZW5jZSBmcmVxdWVuY3ks
IHByZXNzdXJlDQo+ID4gcmVtYWlucyB1bmNoYW5nZWQgYWNyb3NzIGJvb3N0IHRyYW5zaXRpb25z
Lg0KPiA+DQo+ID4gRml4ZXM6IGQyZDVjMTI5ZDA3ZSAoImNwdWZyZXE6IE1ha2UgY3B1ZnJlcV91
cGRhdGVfcHJlc3N1cmUoKSBmYWxsDQo+IGJhY2sgdG8gY3B1aW5mby5tYXhfZnJlcSIpDQo+ID4g
U2lnbmVkLW9mZi1ieTogSmlhbnlvbmcgV3UgPHd1amlhbnlvbmdAaHlnb24uY24+DQo+IA0KPiBM
b29rcyBva2F5IHRvIG1lLg0KPiANCj4gUmV2aWV3ZWQtYnk6IEhvbmd5YW4gWGlhIDxob25neWFu
LnhpYUB0cmFuc3Npb24uY29tPg0KPiANCj4gPiAtLS0NCj4gPiBbLi4uXQ0K

