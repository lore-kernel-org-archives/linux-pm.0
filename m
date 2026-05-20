Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44FC3A9D9F;
	Wed, 20 May 2026 08:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779265349; cv=none; b=kCpeha+UrIg03l044Ju5Ph9jEmTsLtJVhiSUe4ZSBz93PZhWhMs1DL2aRgN9a3w50gqZu2U2rHng/Almm9wVq3XwTy2EPKHsnMR1NUU99ItzW6vTmBoxzMQVCwxnt5JFgqDYF1vY3P/DPjlL8CUv0LQtWzaRI2CXOFd8BB5FG4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779265349; c=relaxed/simple;
	bh=hA4BsjARQyani4hLNM7SCkULLZ2+Auw/DjmXMLy1nnE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=s2fzPwoAZUvihCKqefcYIIRaqIXpfRNvUJuPNkgCrJbhCmXQvcHSJIXVsGGuOneHhfV/u8rg6tV0MDth9jdO4kUhXlCxgVJ8OQDGA50GDyFOsHt9O0z2KlTHZMb/dvlGbl6mhyYVpbvELzAEBEAfvkHYXRPotTwcB0u08Ts4YIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=Zva+iV5G; arc=none smtp.client-ip=113.46.200.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="Zva+iV5G"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=7iP6LNMu1EZGUbwp9bRM6TSZQkNco15M49WuWrxDYAs=;
	b=Zva+iV5GJA1tduZG0qXJs247q6wag6F9HMDzggmUQFGXoRk+VVOn9h0LIlz6b45Fq4b/GsNCz
	0HBUChTVqaEq2KxW6QL3CARw0BdoJ4vlavaBWySP9L1gRTm+qn5Qu1fcFzu77GTCu6I7QfSzIzp
	yzoMT3CzYeX8Ws7wAyP3hCs=
Received: from mail.maildlp.com (unknown [172.19.163.200])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4gL48G3msqz1cyTd;
	Wed, 20 May 2026 16:14:38 +0800 (CST)
Received: from kwepemf100001.china.huawei.com (unknown [7.202.181.215])
	by mail.maildlp.com (Postfix) with ESMTPS id 9E2F54056A;
	Wed, 20 May 2026 16:22:18 +0800 (CST)
Received: from [10.67.121.90] (10.67.121.90) by kwepemf100001.china.huawei.com
 (7.202.181.215) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Wed, 20 May
 2026 16:22:18 +0800
Message-ID: <fc82e05b-db8b-4a15-b46d-332c9f2d95da@huawei.com>
Date: Wed, 20 May 2026 16:22:17 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq: conservative: Fix incorrect frequency decrease
 due to stale target
To: Viresh Kumar <viresh.kumar@linaro.org>, Zhongqiu Han
	<zhongqiu.han@oss.qualcomm.com>
CC: <rafael@kernel.org>, <stratosk@semaphore.gr>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
	<zhanjie9@hisilicon.com>, <lihuisong@huawei.com>, <yubowen8@huawei.com>,
	<zhangpengjie2@huawei.com>, <wangzhi12@huawei.com>,
	<linhongye@h-partners.com>
References: <20260421123545.1745998-1-zhenglifeng1@huawei.com>
 <cb369a6a-5462-4e6b-a132-ee016a4163ea@oss.qualcomm.com>
 <b6d995f7-91c0-4f87-82e7-87cc50faa43d@huawei.com>
 <aoo2k2uzi6zg6owrmi7qgcgjryxzk7l7f2mdo6vtjjdd576hpn@rg6zyqgn7grr>
 <80d32bdb-f661-44cb-b529-3d5ce2142af0@oss.qualcomm.com>
 <pr25udlbea4vwtx27gfzlnqzv3lmmphkjx5xj2ggzdegmd4ntn@kiytfovoifi3>
 <a028421a-de24-43cd-ac80-17de9b2fc523@oss.qualcomm.com>
 <5ivkhopr53lsrnlu62ucdn5yfyeh42nwq3knfifp4ihgv6kpzy@sd6eekl2r45a>
From: "zhenglifeng (A)" <zhenglifeng1@huawei.com>
In-Reply-To: <5ivkhopr53lsrnlu62ucdn5yfyeh42nwq3knfifp4ihgv6kpzy@sd6eekl2r45a>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemf100001.china.huawei.com (7.202.181.215)

On 5/20/2026 3:48 PM, Viresh Kumar wrote:
> On 11-05-26, 12:03, Zhongqiu Han wrote:
>> Just one small concern is that requested_freq may underflow as an
>> unsigned value; perhaps this could be improved by:
>>
>> -		if (requested_freq > freq_step)
>> +		if (requested_freq > policy->min + freq_step)
>>  			requested_freq -= freq_step;
>>  		else
>>  			requested_freq = policy->min;
> 
> Looks fine.
> 
>> or use min() func?
>>
>> Additionally, it seems that dropping the early‑exit checks also appears
>> to be a nice side effect fix for CPUFREQ_NEED_UPDATE_LIMITS drivers when
>> updating internal upper and lower frequency boundaries.
>>
>> As designed in commit 1c534352f47f ("cpufreq: Introduce
>> CPUFREQ_NEED_UPDATE_LIMITS driver flag"), a cpufreq driver may need to
>> update its internal frequency limits when policy min or max changes for
>> drivers setting CPUFREQ_NEED_UPDATE_LIMITS.
>>
>> However, the early‑exit in cs_dbs_update() can prevent
>> __cpufreq_driver_target() from ever being called.
>>
>> For example, when policy->min rises from 200 to 400 kHz while policy
>> ->cur is already at 400 kHz, under low load:
>>
>>   cpufreq_policy_apply_limits():
>>     policy->min(400) > policy->cur(400) ?  NO -> driver not called
>>
>>   cs_limits():
>>     dbs_info->requested_freq = policy->cur = 400
>>
>>   [next sampling period, low load]
>>   cs_dbs_update():
>>     requested_freq = 400
>>     if (requested_freq == policy->min)  /* 400 == 400 -> true */
>>         goto out;  /* __cpufreq_driver_target() never called */
>>
>> With the early‑exit removed, __cpufreq_driver_target() is called with
>> target == policy->cur, and CPUFREQ_NEED_UPDATE_LIMITS ensures the driver
>> is invoked to update its internal performance boundaries.
> 
> I think we are all in agreement on this now ?
> 

For CPUFREQ_NEED_UPDATE_LIMITS drivers, dropping this early-exit checks
means cpufreq_driver->target() will always be called every time when
cs_dbs_update() is called. Is it OK?

