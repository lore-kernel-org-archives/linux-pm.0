Received: from mailgw1.hygon.cn (unknown [101.204.27.37])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB88ABA45;
	Mon, 21 Sep 2026 08:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.204.27.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789980924; cv=none; b=AtEtpxr9IR1KqTuqR8pFCa+7/uNJavPaZcf7kYla0PaYRatpKKCRd1ye9NUzVDdSGJhiYj0NJ0oU3vzMRm+2WVi6ruCOqWbaThphRpPuLmkRydi+6BKiqKH/M+jy9eg+Mm0d1tdnqIsVfQna7Pgl810jxEfI7fzEjiMzboXwxFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789980924; c=relaxed/simple;
	bh=2Ju4KUTJ/eMZzCz/WuyxqkPjXN1wH0Fau0qR+e+Fl6w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RmDgWGtKawJJDzwosTfa/opeXx3szFNlIqEDhd0zcCmzhJ+k7+q+KsHXLaKh9Vn7NWobGyrS3ZVxLNnvtEazf+g9hV7ifTgRiYrxkxGWNzGD/HpHC//EcbVDZ96yM6P4vwFLnmuVMf5ZQjQ4XiJwJZrU27hTyCJKF5ZAXdJnLaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn; spf=pass smtp.mailfrom=hygon.cn; arc=none smtp.client-ip=101.204.27.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hygon.cn
Received: from maildlp2.hygon.cn (unknown [127.0.0.1])
	by mailgw1.hygon.cn (Postfix) with ESMTP id 4hpH9f2TVWzTSdl;
	Mon, 21 Sep 2026 16:55:02 +0800 (CST)
Received: from maildlp2.hygon.cn (unknown [172.23.18.61])
	by mailgw1.hygon.cn (Postfix) with ESMTP id 4hpH9c5CJdzTSdm;
	Mon, 21 Sep 2026 16:55:00 +0800 (CST)
Received: from cncheex05.Hygon.cn (unknown [172.23.18.115])
	by maildlp2.hygon.cn (Postfix) with ESMTPS id 117D430004D0;
	Mon, 21 Sep 2026 16:50:33 +0800 (CST)
Received: from cncheex04.Hygon.cn (172.23.18.114) by cncheex05.Hygon.cn
 (172.23.18.115) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Mon, 21 Sep
 2026 16:55:00 +0800
Received: from cncheex04.Hygon.cn ([fe80::1b6f:6c58:58a4:430d]) by
 cncheex04.Hygon.cn ([fe80::1b6f:6c58:58a4:430d%10]) with mapi id
 15.02.1544.036; Mon, 21 Sep 2026 16:55:00 +0800
From: Jianyong Wu <wujianyong@hygon.cn>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Ricardo Neri
	<ricardo.neri-calderon@linux.intel.com>
CC: Vincent Guittot <vincent.guittot@linaro.org>, "viresh.kumar@linaro.org"
	<viresh.kumar@linaro.org>, "kprateek.nayak@amd.com" <kprateek.nayak@amd.com>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"ray.huang@amd.com" <ray.huang@amd.com>, "mario.limonciello@amd.com"
	<mario.limonciello@amd.com>, "perry.yuan@amd.com" <perry.yuan@amd.com>,
	"zhanjie9@hisilicon.com" <zhanjie9@hisilicon.com>, "zhenglifeng1@huawei.com"
	<zhenglifeng1@huawei.com>, "pierre.gondois@arm.com" <pierre.gondois@arm.com>,
	"sumitg@nvidia.com" <sumitg@nvidia.com>,
	"srinivas.pandruvada@linux.intel.com" <srinivas.pandruvada@linux.intel.com>,
	"hongyan.xia@transsion.com" <hongyan.xia@transsion.com>,
	"zhongqiu.han@oss.qualcomm.com" <zhongqiu.han@oss.qualcomm.com>, Fengyu Wang
	<wangfengyu@hygon.cn>, Yuan Zhong <zhongyuan@hygon.cn>, Huangsj
	<huangsj@hygon.cn>
Subject: RE: [PATCH] cpufreq: Use a non-boost reference frequency for pressure
 calculation
Thread-Topic: [PATCH] cpufreq: Use a non-boost reference frequency for
 pressure calculation
Thread-Index: AQHdROA84sx4SsqcvEWfPOLMo4juUrbShuMAgACwkgCAAO00gIADDYtA
Date: Mon, 21 Sep 2026 08:55:00 +0000
Message-ID: <ddf15b0e0f4b4c7290e6324b963a234f@hygon.cn>
References: <20260915065747.1671965-1-wujianyong@hygon.cn>
 <CAJZ5v0g2d6fY8hM0FVH8tiOUhXm0PZM+Qn7OxM9YNXm8i0pYmg@mail.gmail.com>
 <B5C2AA60-4A07-45B6-AF06-3C5810E19F8C@hygon.cn>
 <5135696.31r3eYUQgx@rafael.j.wysocki>
In-Reply-To: <5135696.31r3eYUQgx@rafael.j.wysocki>
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

DQoNCk9uIEZyaSwgU2VwIDE4LCAyMDI2LCBSYWZhZWwgSi4gV3lzb2NraSB3cm90ZToNCj4gU28g
YWN0dWFsbHkgdGhlIHByb2JsZW0gaXMgdGhhdCBub3cgdGhlIHByZXNzdXJlIGlzIGFwcGxpZWQg
d2hlbiBpdCBpcyBub3QNCj4gZXhwZWN0ZWQgdG8gYmUgYXBwbGllZCBpbiBnZW5lcmFsLg0KPiAN
Clllcy4NCg0KPiBDbGVhcmx5LCB0aGUgc2NoZWR1bGVyIGFzc3VtZXMgdGhhdCB0aGUgcHJlc3N1
cmUgd2lsbCBiZSB6ZXJvIHdoZW4NCj4gYXJjaF9zY2FsZV9mcmVxX3JlZigpIGlzIHplcm8gYW5k
IHRoZSBjb21taXQgaW4gcXVlc3Rpb24gdmlvbGF0ZXMgdGhhdA0KPiBhc3N1bXB0aW9uLg0KPiAN
Cj4gVGhpcyBhY3R1YWxseSBoYXMgYSBsaXR0bGUgdG8gZG8gd2l0aCBib29zdCBhbmQgbWFraW5n
IGl0IGRlcGVuZCBvbiBib29zdA0KPiBkb2Vzbid0IHJlYWxseSBoZWxwLiAgSW4gZmFjdCwgdGhl
IHJlYXNvbiBmb3IgbWFraW5nIHRoZSBjaGFuZ2Ugd2FzIHNvbWUNCj4gaW5hZGVxdWF0ZSBiZWhh
dmlvciB3aGVuIGludGVsX3BzdGF0ZSByYW4gd2l0aCBhc3ltIGNhcGFjaXR5LCBzbw0KPiBzb21l
dGhpbmcNCj4gbGlrZSB0aGUgcGF0Y2ggYmVsb3cgKGNvbXBsZXRlbHkgdW50ZXN0ZWQpIGNhbiBi
ZSB1c2VkIHRvIGxpbWl0IHRoZSBzY29wZQ0KPiBvZiBpdCB0byB0aGUgY2FzZSBpbiBxdWVzdGlv
bi4NCj4gDQo+IENhbiB5b3UgcGxlYXNlIGNoZWNrIGlmIGl0IGhlbHBzPw0KDQpZZXMgaXQgaGVs
cHMuDQoNCkkgdGVzdGVkIGl0IG9uIEh5Z29uIGFuZCBhbiBBTUQgc3lzdGVtIHVzaW5nIGFjcGkt
Y3B1ZnJlcS4gVGhlIGNwdQ0KcHJlc3N1cmUgaXMgemVybyBhZ2FpbiwgYW5kIGNhY2hlIGF3YXJl
IHNjaGVkdWxpbmcgY2FuIG9uY2UgbW9yZQ0KYWdncmVnYXRlIHRhc2tzIHVwIHRvIDUwJSBvZiB0
aGUgTExDIGNhcGFjaXR5LCBhcyBpdCBkaWQgYmVmb3JlDQpkMmQ1YzEyOWQwN2UuDQoNClRlc3Rl
ZC1ieTogSmlhbnlvbmcgV3UgPHd1amlhbnlvbmdAaHlnb24uY24+DQoNClRoYW5rcw0KSmlhbnlv
bmcNCg==

