Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.216
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793277260;
	b=aM3WbM1yASj9UbQ6VuhwAEAB0TpsyUu3E8XwMLRNnEvgiGEZjGQG+pu/W7SJrKEjzFcW
	 afz4PGMDNqVAIHKIS/ee0oivPdY9mOfyk7yk9HXCjftHpbIprqqYHgWWTg3zB9unN3A2d
	 gDn9xJhJgbTNazjJlqJI/fVfgYMcrViENulRB6Fz4e5uzWS1EJs3NeKseWXhJrR08hXjn
	 sqIhLVxEJaEutOSKcJ4n/WRF+H0mopXJyty0g1gzNrelPboxVL1Ck5mhe/7RUU3nR+zwM
	 RaBi6ELBlYzWamN9Xc2S/wTzZ9W7hsQW4d7b44cM8Ri5E66Dr12lzL7OIi+3sQaHuMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793277260;
	h=DMARC-Filter:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:CC:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=NjjyRBUz9+jz1+MqgP9WavWIYwl4eYuReQuwaoEETnQ=;
	b=zvp+OCiQlvviEh95GkQrHMdpmzJKAYr+HYGB8oR8LTYlwHD0+5AXx/HzmMLkuVjfjBNl
	 IZeZUwPrTxgxapDpqeSK4lNxBhcsxYRwe5rkR1k8rkpYXG6f8G08ssRvSqVXryDZ0Q0I0
	 i8emGMYk97uc6IZcdvxR9uQOVCchAiuX6IDoQLbGtlCx7skWbUE7RLd4hCBzVRiBHNA2q
	 jozzp+NOugCfg0tJq1U+5lngvWIqxpywlAQmld4Tbf2UN1RGLcYjLgs5UIHdxNkTSmANV
	 O0dHlkiyDGjwrPG6+4muuLDRG4GXjXxz+nobDzhz+UlsQi+TY5PXeT0jvZafM11DgQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hisilicon.com;
	spf=pass smtp.mailfrom=hisilicon.com;
	arc=none smtp.remote-ip=113.46.200.216
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68BE0606A321;
	Thu, 29 Oct 2026 12:34:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 68BE0606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4jFkDg6BxCz1T4Fy;
	Thu, 29 Oct 2026 20:33:55 +0800 (CST)
Received: from kwepemf200017.china.huawei.com (unknown [7.202.181.10])
	by mail.maildlp.com (Postfix) with ESMTPS id 2853040538;
	Thu, 29 Oct 2026 20:34:07 +0800 (CST)
Received: from [10.67.121.58] (10.67.121.58) by kwepemf200017.china.huawei.com
 (7.202.181.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 29 Oct
 2026 20:34:06 +0800
Message-ID: <933a389a-5572-4b3b-99c6-88aad9304349@hisilicon.com>
Date: Thu, 29 Oct 2026 20:34:05 +0800
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cpufreq: CPPC: Enable boost by default when supported
To: Christian Loehle <christian.loehle@arm.com>, Pengjie Zhang
	<zhangpengjie2@huawei.com>, <rafael@kernel.org>, <viresh.kumar@linaro.org>
CC: <linuxarm@huawei.com>, <prime.zeng@hisilicon.com>,
	<wanghuiqiang@huawei.com>, <xuwei5@huawei.com>, <zhenglifeng1@huawei.com>,
	<yubowen8@huawei.com>, <pierre.gondois@arm.com>, <sumitg@nvidia.com>,
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<mojunjun4@huawei.com>
References: <20261022075901.3436021-1-zhangpengjie2@huawei.com>
 <d9fa8052-f562-4867-9e9f-1fd2a66fa794@arm.com>
Content-Language: en-US
From: Jie Zhan <zhanjie9@hisilicon.com>
In-Reply-To: <d9fa8052-f562-4867-9e9f-1fd2a66fa794@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemf200017.china.huawei.com (7.202.181.10)



On 10/29/2026 4:51 AM, Christian Loehle wrote:
> On 10/22/26 08:59, Pengjie Zhang wrote:
>> The CPPC driver leaves boost disabled by default when Highest Performance
>> exceeds Nominal Performance. Userspace must explicitly enable boost
>> before governors can use the full advertised performance range.
>>
>> Enable boost by default when at least one possible CPU reports support,
>> while users who prefer to stay within the sustained nominal limit can
>> still disable it via the boost knob without determining scaling_max_freq
>> for each policy.
>>
>> Check the performance capabilities before registering the driver so that
>> the cpufreq core enables boost for each policy that supports it.
>>
>> Signed-off-by: Pengjie Zhang <zhangpengjie2@huawei.com>
> 
> 
> Just to be clear I'm not blocking this per se, but continuing my comments:
> 
> I just wonder if this is a configuration worth keeping.
> You mentioned your platforms have a BIOS to set nominal==highest or not.
> If we removed interpreting highest - nominal as boost entirely that
> would also make that BIOS setting obsolete. Userspace could still
> query nominal and restrict cpufreq to that if it wishes to do that,
> we could add that to cpupower for convenience (i.e. set all policies'
> max to nominal).
> 
> With the changes that are coming with CPCv4 we would save ourselves
> some headache (like keeping track of boost status when ospm_nominal_perf
> is being written).
That would be just some bonus functions.

I think the idea is to give userspace a knob to toggle boost on/off and
check the current status.

As of now, we don't have a better way to achieve this other than taking
highest > nominal.
> 
> The question is also how often the combination of "enable nominal < highest"
> and then explicitly toggling boost at runtime actually happens...
> 
In most cases, it's only set up once on boot.
Some experimental, debugging, or clever userspace strategies may toggle it
more often. Who knows :)

[...]
