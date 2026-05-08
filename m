Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4E02FE58C;
	Fri,  8 May 2026 03:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778210606; cv=none; b=Ez2T4VKkEdp4hRXJXdXugh4EeUsdhjlNGu0//ovgO64tBvYbELZh/bN94L2irblRjBJFzelQlNupz9GKL0XmnedBahO/kR8hs2WDPSSpe2GV/1j2sm1FucRjQHF5zsrqNArFrsAh+sHjVtNl/8o3ZSdTuPYxjpicqhhCKhEuGwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778210606; c=relaxed/simple;
	bh=+f8rg+d/X7/VwbU2lqyTWTZLvlzGG3wpfVYYfabsHNQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=AhHydsLdth8JQMX+WtpV5Dbzd16vBeS96t2os36bHw8piZu2nwxvGIhbvtbejmGEfiHViAuxNbNjtMNN4dHDoET8OjTXmfv6ggLsv+5PN6Njk1gDB4Pj/wPueD+wj2NYBwIUnPYdQxHSVQLq2bX5uQk76+QFwP2pyoVUh0iz8dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=113.46.200.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.163.15])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4gBZ5V0pXLznTVY;
	Fri,  8 May 2026 11:16:14 +0800 (CST)
Received: from kwepemf200017.china.huawei.com (unknown [7.202.181.10])
	by mail.maildlp.com (Postfix) with ESMTPS id E0B3D40539;
	Fri,  8 May 2026 11:23:19 +0800 (CST)
Received: from [10.67.121.58] (10.67.121.58) by kwepemf200017.china.huawei.com
 (7.202.181.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 8 May
 2026 11:23:19 +0800
Message-ID: <26deca86-44e3-4fd5-950e-59f913d9ee37@hisilicon.com>
Date: Fri, 8 May 2026 11:23:18 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq: cppc: discard out-of-range delivered_perf
 samples
To: Breno Leitao <leitao@debian.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>, Lifeng Zheng
	<zhenglifeng1@huawei.com>, Pierre Gondois <pierre.gondois@arm.com>, Sumit
 Gupta <sumitg@nvidia.com>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<dcostantino@meta.com>, <pjaroszynski@nvidia.com>, <Al.Grant@arm.com>,
	<linux-arm-kernel@lists.infradead.org>, <kernel-team@meta.com>
References: <20260501-cur_freq-fix-v1-1-f84c9a423366@debian.org>
Content-Language: en-US
From: Jie Zhan <zhanjie9@hisilicon.com>
In-Reply-To: <20260501-cur_freq-fix-v1-1-f84c9a423366@debian.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemf200017.china.huawei.com (7.202.181.10)



On 5/2/2026 12:32 AM, Breno Leitao wrote:
> cppc_cpufreq_get_rate() derives delivered_perf as:
> 
>     delivered_perf = reference_perf * delta_delivered / delta_reference
> 
> over a short udelay()-bounded window between two cppc_get_perf_ctrs()
> calls. Per-read latency jitter on the underlying CPC register access
> can skew the ratio, occasionally producing delivered_perf >
> highest_perf. cppc_perf_to_khz() then linearly extrapolates above
> (nominal_perf, nominal_freq), so the value reported via
> /sys/.../cpufreq/cpuinfo_cur_freq exceeds cpuinfo_max_freq.
> 
> Observed on an arm64 host (governor=performance,
> cpuinfo_max_freq=3339 MHz): 15 back-to-back reads returned values
> between 2997 and 4230 MHz.
Hi Breno,

Frequency sampling discrepancy through 'cpuinfo_cur_freq' in the
cppc_cpufreq driver has been an issue discussed for a very long time.

If the CPPC feedback counters are FFH on your platform, can you have a look
at [1] and see if that helps?

Thanks,
Jie
> 
> Treat an out-of-range sample as invalid and reuse the existing
> out_invalid_counters fallback, which returns the platform's
> desired_perf. This keeps cpuinfo_cur_freq within
> [0, cpuinfo_max_freq] without reporting a value the hardware did
> not deliver.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  drivers/cpufreq/cppc_cpufreq.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
...
