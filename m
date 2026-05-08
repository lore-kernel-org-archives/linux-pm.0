Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com [113.46.200.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049D02DCBF8;
	Fri,  8 May 2026 08:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778230532; cv=none; b=hrLLIZRIB5kulLQHj4JtzaIGkYCftWOTvkIX52Nvmh4UqBILhgkPLSWKHFvFrEV/IpqTbwiFcZhzPjzlVSvE0mDgCmqFRPU8mkpy8kQvaI8zMLPhlusl/jyV+TaseYhkd7buMoFjH4GQtzDWXRz/KJmv4gIk5APdoxfl+Od5A0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778230532; c=relaxed/simple;
	bh=hN/3CgEECt9kh/ppmWWaipu1h27tVyj24LyasVavxx4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=DdNMeFuK9m64jJc0Q0V4kEY9PeylG8UmR06ss7YcS8I6wjNOoEv7KoIfnWUkRGSrfIktmf2iVtKGrsfWQK5Mf2LYYfBPjEzgaAWrRm8b7Oez7LAtWMonK00YlTQirncJPMsUvE83pZZ4JclQfmk0WA49PEkGIL/aqo4hAr7/H6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=113.46.200.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.163.200])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4gBjSB4p7zz1K97g;
	Fri,  8 May 2026 16:47:54 +0800 (CST)
Received: from kwepemf200017.china.huawei.com (unknown [7.202.181.10])
	by mail.maildlp.com (Postfix) with ESMTPS id 4FE4140563;
	Fri,  8 May 2026 16:55:27 +0800 (CST)
Received: from [10.67.121.58] (10.67.121.58) by kwepemf200017.china.huawei.com
 (7.202.181.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 8 May
 2026 16:55:26 +0800
Message-ID: <a1ac9710-44fb-46e9-857d-2c2e9dff5457@hisilicon.com>
Date: Fri, 8 May 2026 16:55:26 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq: cppc: discard out-of-range delivered_perf
 samples
To: Breno Leitao <leitao@debian.org>
CC: "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar
	<viresh.kumar@linaro.org>, Lifeng Zheng <zhenglifeng1@huawei.com>, Pierre
 Gondois <pierre.gondois@arm.com>, Sumit Gupta <sumitg@nvidia.com>,
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<dcostantino@meta.com>, <pjaroszynski@nvidia.com>, <Al.Grant@arm.com>,
	<linux-arm-kernel@lists.infradead.org>, <kernel-team@meta.com>, "zhangpengjie
 (A)" <zhangpengjie2@huawei.com>
References: <20260501-cur_freq-fix-v1-1-f84c9a423366@debian.org>
 <26deca86-44e3-4fd5-950e-59f913d9ee37@hisilicon.com>
 <af2cEiouQbdpoavG@gmail.com>
Content-Language: en-US
From: Jie Zhan <zhanjie9@hisilicon.com>
In-Reply-To: <af2cEiouQbdpoavG@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemf200017.china.huawei.com (7.202.181.10)



On 5/8/2026 4:17 PM, Breno Leitao wrote:
> Hello Jie,
> 
> On Fri, May 08, 2026 at 11:23:18AM +0800, Jie Zhan wrote:
>> On 5/2/2026 12:32 AM, Breno Leitao wrote:
>>> cppc_cpufreq_get_rate() derives delivered_perf as:
>>>
>>>     delivered_perf = reference_perf * delta_delivered / delta_reference
>>>
>>> over a short udelay()-bounded window between two cppc_get_perf_ctrs()
>>> calls. Per-read latency jitter on the underlying CPC register access
>>> can skew the ratio, occasionally producing delivered_perf >
>>> highest_perf. cppc_perf_to_khz() then linearly extrapolates above
>>> (nominal_perf, nominal_freq), so the value reported via
>>> /sys/.../cpufreq/cpuinfo_cur_freq exceeds cpuinfo_max_freq.
>>>
>>> Observed on an arm64 host (governor=performance,
>>> cpuinfo_max_freq=3339 MHz): 15 back-to-back reads returned values
>>> between 2997 and 4230 MHz.
>> Hi Breno,
>>
>> Frequency sampling discrepancy through 'cpuinfo_cur_freq' in the
>> cppc_cpufreq driver has been an issue discussed for a very long time.
> 
> Thanks for the heads-up.
> 
>> If the CPPC feedback counters are FFH on your platform, can you have a look
>> at [1] and see if that helps?
> 
> Have you forgot to get the [1] link here?
Yeah, totally forgot, sorry!

[1] https://lore.kernel.org/lkml/20260410094145.4132082-1-zhangpengjie2@huawei.com/
> 
> Thanks for looking at this,
> --breno
