Received: from mailgw1.hygon.cn (unknown [101.204.27.37])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC407140E5F;
	Fri, 18 Sep 2026 04:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.204.27.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789704552; cv=none; b=l8GJJ9M7DOaQna44BGy3HV9lz8oVzjH8jLHLoGXfLSIZTG0wx6qQ7nR69HQe9zfp7X7Sw8Qqr2/uEpRct4TWBFEiG8PriBndVzqhv+7LnNl83vDjiaTIZ6iuVSoHzgW2YZKwMBYRIwWP02Wi8tH+pnu1d9cgfNpoacAbaUKVyeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789704552; c=relaxed/simple;
	bh=8pzLUd9k5b+qBeH7Wtidx6o3EKNEy6VMXT6cnIaOPlk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TSbbcGUDwKFhR5gS8khSBFHLQSEZpSRpzTl3wmIgBHY9nuaEXtpMByyOXwgEsF2D3ynZMMw+I8cltK3ZqzugB0sWCiUdKecHUaE3MTlXjHWKwh1kYPgMQnQXC4VQGIWxLGYhcqQDAqmKXKWJh5alRPClyySeD0zh8iuP81V5mFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn; spf=pass smtp.mailfrom=hygon.cn; arc=none smtp.client-ip=101.204.27.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hygon.cn
Received: from maildlp1.hygon.cn (unknown [127.0.0.1])
	by mailgw1.hygon.cn (Postfix) with ESMTP id 4hmJyp3gVdzvRj9;
	Fri, 18 Sep 2026 12:08:50 +0800 (CST)
Received: from maildlp1.hygon.cn (unknown [172.23.18.60])
	by mailgw1.hygon.cn (Postfix) with ESMTP id 4hmJyn02pPzvRj9;
	Fri, 18 Sep 2026 12:08:49 +0800 (CST)
Received: from cncheex03.Hygon.cn (unknown [172.23.18.113])
	by maildlp1.hygon.cn (Postfix) with ESMTPS id 96B55164E;
	Fri, 18 Sep 2026 12:08:40 +0800 (CST)
Received: from cncheex04.Hygon.cn (172.23.18.114) by cncheex03.Hygon.cn
 (172.23.18.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Fri, 18 Sep
 2026 12:08:49 +0800
Received: from cncheex04.Hygon.cn ([fe80::1b6f:6c58:58a4:430d]) by
 cncheex04.Hygon.cn ([fe80::1b6f:6c58:58a4:430d%10]) with mapi id
 15.02.1544.036; Fri, 18 Sep 2026 12:08:49 +0800
From: Jianyong Wu <wujianyong@hygon.cn>
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>, Vincent Guittot
	<vincent.guittot@linaro.org>
CC: "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
	"kprateek.nayak@amd.com" <kprateek.nayak@amd.com>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "ray.huang@amd.com" <ray.huang@amd.com>,
	"mario.limonciello@amd.com" <mario.limonciello@amd.com>, "perry.yuan@amd.com"
	<perry.yuan@amd.com>, "zhanjie9@hisilicon.com" <zhanjie9@hisilicon.com>,
	"zhenglifeng1@huawei.com" <zhenglifeng1@huawei.com>, "pierre.gondois@arm.com"
	<pierre.gondois@arm.com>, "sumitg@nvidia.com" <sumitg@nvidia.com>,
	"srinivas.pandruvada@linux.intel.com" <srinivas.pandruvada@linux.intel.com>,
	"hongyan.xia@transsion.com" <hongyan.xia@transsion.com>,
	"zhongqiu.han@oss.qualcomm.com" <zhongqiu.han@oss.qualcomm.com>, Fengyu Wang
	<wangfengyu@hygon.cn>, Yuan Zhong <zhongyuan@hygon.cn>, Huangsj
	<huangsj@hygon.cn>, Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Subject: Re: [PATCH] cpufreq: Use a non-boost reference frequency for pressure
 calculation
Thread-Topic: [PATCH] cpufreq: Use a non-boost reference frequency for
 pressure calculation
Thread-Index: AQHdROA84sx4SsqcvEWfPOLMo4juUrbShuMAgACwkgA=
Date: Fri, 18 Sep 2026 04:08:49 +0000
Message-ID: <B5C2AA60-4A07-45B6-AF06-3C5810E19F8C@hygon.cn>
References: <20260915065747.1671965-1-wujianyong@hygon.cn>
 <CAJZ5v0g2d6fY8hM0FVH8tiOUhXm0PZM+Qn7OxM9YNXm8i0pYmg@mail.gmail.com>
In-Reply-To: <CAJZ5v0g2d6fY8hM0FVH8tiOUhXm0PZM+Qn7OxM9YNXm8i0pYmg@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <56198BE12078074BAC1E942D2DA0899F@Hygon.cn>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

SGkgUmFmYWVsLA0KDQo+IA0KPiBPbiBTZXAgMTgsIDIwMjYsIGF0IDAxOjM4LCBSYWZhZWwgSi4g
V3lzb2NraSAoSW50ZWwpIDxyYWZhZWxAa2VybmVsLm9yZz4gd3JvdGU6DQo+IE9uIFR1ZSwgU2Vw
IDE1LCAyMDI2IGF0IDk6MDPigK9BTSBKaWFueW9uZyBXdSA8d3VqaWFueW9uZ0BoeWdvbi5jbj4g
d3JvdGU6DQo+PiANCj4+IENvbW1pdCBkMmQ1YzEyOWQwN2UgKCJjcHVmcmVxOiBNYWtlIGNwdWZy
ZXFfdXBkYXRlX3ByZXNzdXJlKCkgZmFsbA0KPj4gYmFjayB0byBjcHVpbmZvLm1heF9mcmVxIikg
aW50cm9kdWNlZCBjcHVpbmZvLm1heF9mcmVxIGFzIHRoZSByZWZlcmVuY2UNCj4+IGZyZXF1ZW5j
eSBmb3IgY3B1ZnJlcSBwcmVzc3VyZSB3aGVuIGFyY2hfc2NhbGVfZnJlcV9yZWYoKSByZXR1cm5z
IHplcm8uDQo+PiANCj4+IEhvd2V2ZXIsIGNwdWluZm8ubWF4X2ZyZXEgbWF5IGluY2x1ZGUgYm9v
c3QgZnJlcXVlbmNpZXMgYW5kIHRoZXJlZm9yZQ0KPj4gZG9lcyBub3QgbmVjZXNzYXJpbHkgcmVw
cmVzZW50IHRoZSBtYXhpbXVtIHN1c3RhaW5hYmxlIGZyZXF1ZW5jeS4NCj4gDQo+IEFuZCB0aGVu
IGl0IHJlYWxseSBtYXR0ZXJzIHdoYXQgaXMgc3VzdGFpbmFibGUgYW5kIGZvciBob3cgbG9uZy4N
Cg0KSSB0aGluayBpdCdzIGNvbmZ1c2luZyB0byBzYXkgInN1c3RhaW5hYmxlIGZyZXEiIGluIGNw
dWZyZXEgcGFydC4gSSBtZWFuIHRoZSBtYXhpbXVtDQpjcHUgZnJlcXVlbmN5IGJlbG93IGJvb3N0
IGhlcmUuIEZvciBhY3BpLWNwdWZyZXEsIGl04oCZcyBQMC4gRm9yIGFtZC1wc3RhdGUsIGl04oCZ
cw0Kbm9taW5hbCBmcmVxdWVuY3kuIEJ1dCBJIGNhbid0IGZpbmQgYSBiZXR0ZXIgd29yZC4NCg0K
PiANCj4+IE9uIHNvbWUgc3lzdGVtcyB1c2luZyBhY3BpLWNwdWZyZXEsIGNwdWluZm8ubWF4X2Zy
ZXEgaW5jbHVkZXMgYm9vc3Qgd2hpbGUNCj4+IHRoZSBmcmVxdWVuY3kgdGFibGUgb25seSBjb250
YWlucyBub24tYm9vc3QgZnJlcXVlbmNpZXMuDQo+IA0KPiBJbiB3aGljaCBjYXNlIHNlbGVjdGlu
ZyBmcmVxX3RhYmxlWzBdIG1heSBnaXZlIHRoZSBwcm9jZXNzb3IgYSBsaWNlbnNlDQo+IHRvIGdv
IHRvIHRoZSB0dXJibyAob3IgYm9vc3QpIGZyZXF1ZW5jeSByYW5nZS4NCg0KWWVhaCwgc2VsZWN0
aW5nIGZyZXFfdGFibGVbMF0gbWF5IGFsc28gbWVhbiBjcHUgY2FuIGdvIHRvIGJvb3N0IGZyZXF1
ZW5jeS4gDQpCdXQgdGhlIHZhbHVlIGRvZXNuJ3QgZGVub3RlIHRoYXQuIGZyZXFfdGFibGVbMF0g
aXMgYXNzaWduZWQgIHRvIHBvbGljeS0+bWF4IHdoaWNoDQppcyBjb21wYXJlZCB3aXRoIHBvbGlj
eS0+Y3B1aW5mby5tYXhfZnJlcS4gVGhlIGRpZmZlcmVuY2UgYmV0d2VlbiB0aGVtIG1ha2VzDQp0
aGUgY3B1IHByZXNzdXJlIHdoaWNoIGlzIG5vdCBpbnRlbmRlZC4NCiANCj4gDQo+PiBDb25zZXF1
ZW50bHksIGNwdWZyZXEgcHJlc3N1cmUgcmVtYWlucyBub256ZXJvIGV2ZW4gd2l0aG91dCBhbiBh
ZGRpdGlvbmFsDQo+PiBmcmVxdWVuY3kgbGltaXQuDQo+IA0KPiBTbyB3aGVuIGFuZCB3aGVyZSBk
b2VzIHRoaXMgbWF0dGVyPw0KDQpJIHRlc3QgaXQgb24gYW1kLCBpbnRlbCBhbmQgaHlnb24gYm94
LiBPbmNlIGFjcGktY3B1ZnJlcSBpcyB1c2VkLCB0aGUgdW5leHBlY3RlZA0KY3B1IHByZXNzdXJl
IGFwcGVhcnMgd2hlbiB0aGVyZSBpcyBubyBjcHUgZnJlcXVlbmN5IGNhcHBlZCBhbmQgYm9vc3Qg
aXMgZW5hYmxlZC4NCg0KVGhlIHdyb25nIGNwdSBwcmVzc3VyZSBhZmZlY3RzIGxvYWQgYmFsYW5j
aW5nLiBGb3IgZXhhbXBsZSwgQ2FjaGUgYXdhcmUNCnNjaGVkdWxpbmcgd2FudHMgdG8gYWdncmVn
YXRlIHRhc2sgaW4gYSBMTEMgdXNpbmcgNTAlIG9mIHRoZSB3aG9sZSBMTEMgY2FwYWNpdHkuDQpC
ZWZvcmUgY29tbWl0IGQyZDVjMTI5ZDA3ZSwgZXZlcnl0aGluZyBpcyBPSy4gQnV0IHdpdGggdGhh
dCBjb21taXQgYW5kIHVzaW5nDQphY3BpLWNwdWZyZXEgYW5kIHdpdGggYm9vc3Qgb24sIGNhY2hl
IGF3YXJlIHNjaGVkdWxpbmcgY2Fu4oCZdCBhZ2dyZWdhdGUNCnRhc2sgdG8gb2NjdXB5IDUwJSBv
ZiB0aGUgTExDIGJ5IGRlZmF1bHQgYXMgdGhlIGNwdSBjYXBhY2l0eSBpbiB0aGUgTExDIGlzIHJl
ZHVjZWQuIA0KPiANCj4+IEZ1cnRoZXJtb3JlLCBkcml2ZXJzIG1heSB1cGRhdGUgY3B1aW5mby5t
YXhfZnJlcSB3aGVuIGJvb3N0IGlzIGVuYWJsZWQNCj4+IG9yIGRpc2FibGVkLiBXaXRoIGEgZml4
ZWQgcG9saWN5IGxpbWl0IGJlbG93IHRoZSBtYXhpbXVtIG5vbi1ib29zdA0KPj4gZnJlcXVlbmN5
LCB0aGlzIGNoYW5nZXMgdGhlIHByZXNzdXJlIHJlZmVyZW5jZSBhbmQgaGVuY2UgdGhlIHJlcG9y
dGVkDQo+PiBwcmVzc3VyZSwgYWx0aG91Z2ggdGhlIG5vbi1ib29zdCBmcmVxdWVuY3kgbGltaXQg
cmVtYWlucyB1bmNoYW5nZWQuDQo+IA0KPiBJZiB0aGUgY2FwYWNpdHkgaXMgdXBkYXRlZCB0aG91
Z2ggYWxvbmcgd2l0aCB0aGUgY3B1aW5mby5tYXhfZnJlcQ0KPiBjaGFuZ2UsIHRoZW4gdGhpcyBp
cyBhbGwgZmluZSBiZWNhdXNlIHRoZSBwcmVzc3VyZSBpcyB0aGVuIGNvbXB1dGVkDQo+IHJlbGF0
aXZlIHRvIHRoZSBuZXcgY2FwYWNpdHkuICBpbnRlbF9wc3RhdGUgZG9lcyB0aGF0Lg0KDQpUaGlz
IGZvbGxvd3MgVmluY2VudC4gUmVmZXJlbmNlIFZpbmNlbnTigJlzIHdvcmRzIFsxXToNCg0KIkFz
IGxvbmcgYXMgdGhlIHJlZmVyZW5jZSBmcmVxdWVuY3kgdXNlZCBpbiBjcHVmcmVxX3VwZGF0ZV9w
cmVzc3VyZQ0KcmVtYWlucyBmaXhlZCB3aGV0ZXZlciBib29zdCBpcyBlbmFibGVkIG9yIG5vdCB0
aGlzIGlzIG9rLiBXZSBkb24ndA0Kd2FudCB0aGUgcHJlc3N1cmUgdG8gY2hhbmdlIHdoZW4gYm9v
c3QgaXMgZW5hYmxlZCBvciBkaXNhYmxlZCBvbmx5DQp3aGVuIHBvbGljeS0+bWF4IGNoYW5nZXMu
Ig0KDQpJZiBpbnRlbF9wc3RhdGUgbGV0IHRoZSBjcHUgcHJlc3N1cmUgdmFyeSB3aXRoIHRoZSBi
b29zdCBvbiBvciBvZmYsIHdoYXQNCmFib3V0IGFjcGktY3B1ZnJlcS4gSXTigJlzIG5vdCBlYXN5
IHRvIGRvIHRoZSBzYW1lIHRoaW5nIHRoZXJlLiBJIHRoaW5rIGl0DQppcyBiZXR0ZXIgdG8gZ2l2
ZSBhIHVuaWZvcm0gYmVoYXZpb3IgYWNyb3NzIGRpZmZlcmVudCBjcHVmcmVxIGRyaXZlci4NCg0K
WzFdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC9DQUtmVFB0QmppOGRrcjVpeGh0WmpreXJX
TEE2OFRGLUtITHJOWVdvZXdQV0x5dVVkNEFAbWFpbC5nbWFpbC5jb20vDQo+IA0KPj4gQWRkIG1h
eF9zdXN0YWluYWJsZV9mcmVxIHRvIHN0cnVjdCBjcHVmcmVxX2NwdWluZm8gdG8gcHJvdmlkZSBh
IHJlZmVyZW5jZQ0KPj4gZnJlcXVlbmN5IGV4Y2x1ZGluZyBib29zdC4gUG9wdWxhdGUgaXQgZnJv
bSB0aGUgbm9taW5hbCBmcmVxdWVuY3kgaW4NCj4+IGFtZC1wc3RhdGUgYW5kIGNwcGNfY3B1ZnJl
cSwgdGhlIG1heGltdW0gbm9uLXR1cmJvIGZyZXF1ZW5jeSBpbg0KPj4gaW50ZWxfcHN0YXRlLCBh
bmQgdGhlIGhpZ2hlc3QgZnJlcXVlbmN5LXRhYmxlIGVudHJ5IGluIGFjcGktY3B1ZnJlcS4NCj4+
IA0KPj4gVXNlIHRoaXMgdmFsdWUgd2hlbiBhcmNoX3NjYWxlX2ZyZXFfcmVmKCkgcmV0dXJucyB6
ZXJvLiBQcmVzZXJ2ZSB0aGUNCj4+IGV4aXN0aW5nIGNwdWluZm8ubWF4X2ZyZXEgZmFsbGJhY2sg
Zm9yIGRyaXZlcnMgdGhhdCBsZWF2ZSB0aGUgbmV3IGZpZWxkDQo+PiBhdCB6ZXJvLg0KPj4gDQo+
PiBUZXN0ZWQgd2l0aCBhY3BpLWNwdWZyZXEsIGludGVsX3BzdGF0ZSwgYW5kIGFtZC1wc3RhdGUg
aW4gYWN0aXZlIGFuZA0KPj4gcGFzc2l2ZSBtb2Rlcy4gV2l0aCBubyBhZGRpdGlvbmFsIGZyZXF1
ZW5jeSBsaW1pdCwgcHJlc3N1cmUgaXMgemVyby4NCj4+IFdpdGggYSBmaXhlZCBsaW1pdCBiZWxv
dyB0aGUgbm9uLWJvb3N0IHJlZmVyZW5jZSBmcmVxdWVuY3ksIHByZXNzdXJlDQo+PiByZW1haW5z
IHVuY2hhbmdlZCBhY3Jvc3MgYm9vc3QgdHJhbnNpdGlvbnMuDQo+IA0KPiBXaGljaCBtYXkgbm90
IGJlIHdoYXQgaXMgaW50ZW5kZWQuDQoNClNhbWUgYXMgYWJvdmU6IElNTywgd2l0aCBhIGZpeGVk
IGNhcCwgdGhlIHByZXNzdXJlIHNob3VsZCBub3QgY2hhbmdlDQpqdXN0IGJlY2F1c2UgYm9vc3Qg
aXMgdG9nZ2xlZC4NCg0KVGhhbmtzDQpKaWFueW9uZw0KDQo=

