Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.227
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793778237;
	b=2NcqlbfmaBjs8nYkLEvFJWGUvjtpvENmEeFvJGPs44XQ6cDcx2Henryy22O16CgXtZrn
	 SsRCqkzMDbdAZ6lD9mVQYoaNf2XXaMf2N4JFm7OJghiiTjZEd4vjrIbn2a4CKcbPoXzYZ
	 QMhtaR78dAMO7/V7YocRmq/FWWRghQhY/PI83hVX8bkCtpGRRZ4qj/ez4SpjV6Zv/hebA
	 /j0pylZkZ8PtTNM6HLOXsfogXNTYzWxkEWgIfuQJx0tf7MIgBd6BKw8yuITD4u+sCEmE/
	 mwzklllFzolCnW45jyamv/27NL9JnoyMhPkbavxgRin9g2hbF4ZjWJ86NDMaskB8pgg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793778237;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=YHUT0Fm167PmfeLdlFM2wA64Z+AWupzEC9KdA2EtWHk=;
	b=Jj5ltPYYXmONT0BElJ8vs0DmrESckiReOVYnzZOWHuxFJ8zPVx77F18cDAPPb3nSbz+E
	 os3FkNIaAfQGNNVOiFHRTTM+pHKXqtBQ5HP7AKVnkurx+lhbUge15UwOc1q9ynxvlpo8m
	 aJrcWyhdi8I8ctYu4BzAriib+bKeQMULoxaIvNQF0ejh0yIyoKBqYyA3pROHaoaGpl9ff
	 zQH5XoR96duI6xs3XQ5IzYc6aONwlNwoAzk+dYVf8CedK9PJWTsYf+iG4spjq4hvikUfp
	 UdW68S4l6u3e8YzEen8+xVKuBWwNYNr088qxvhE60NsC4xJHq6NGCM7107F746/Ru7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=a5z7OOaP;
	arc=none smtp.remote-ip=113.46.200.227
Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60709606A31B;
	Wed,  4 Nov 2026 07:43:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 60709606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=a5z7OOaP
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=YHUT0Fm167PmfeLdlFM2wA64Z+AWupzEC9KdA2EtWHk=;
	b=a5z7OOaPq4SZdOXk3cB+VBztOqNAC1sX1sYieYLONdZ3F5pNnvk0HyFMqiHDsXi0HOyY4g4Q7
	2EsfKpHqzDBYi54mM2tvYElbWG/W9O9BMiuVTraTa+ir4iAwb3QRG/7NjwqDAr9XTtmL1RMvCK/
	bC4uogR4Vale28EiAx7es7M=
Received: from mail.maildlp.com (unknown [172.19.163.200])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4jKHW70h6YznTWc;
	Wed,  4 Nov 2026 15:43:47 +0800 (CST)
Received: from kwepemr200004.china.huawei.com (unknown [7.202.195.241])
	by mail.maildlp.com (Postfix) with ESMTPS id F3FB94055B;
	Wed,  4 Nov 2026 15:43:45 +0800 (CST)
Received: from [10.67.121.62] (10.67.121.62) by kwepemr200004.china.huawei.com
 (7.202.195.241) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 4 Nov
 2026 15:43:45 +0800
Message-ID: <940a9a70-71fb-491d-a1a7-1a7b4d6dc089@huawei.com>
Date: Wed, 4 Nov 2026 15:43:44 +0800
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
To: Christian Loehle <christian.loehle@arm.com>, <rafael@kernel.org>,
	<viresh.kumar@linaro.org>
CC: <linuxarm@huawei.com>, <zhanjie9@hisilicon.com>,
	<prime.zeng@hisilicon.com>, <wanghuiqiang@huawei.com>, <xuwei5@huawei.com>,
	<zhenglifeng1@huawei.com>, <yubowen8@huawei.com>, <pierre.gondois@arm.com>,
	<sumitg@nvidia.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <mojunjun4@huawei.com>
References: <20261022075901.3436021-1-zhangpengjie2@huawei.com>
 <d9fa8052-f562-4867-9e9f-1fd2a66fa794@arm.com>
From: Pengjie Zhang <zhangpengjie2@huawei.com>
In-Reply-To: <d9fa8052-f562-4867-9e9f-1fd2a66fa794@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemr200004.china.huawei.com (7.202.195.241)


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
>
> The question is also how often the combination of "enable nominal < highest"
> and then explicitly toggling boost at runtime actually happens...
>
>> ---
>> Changes in v2:
>> - Drop "even" and clarify the commit message (Christian).
>> - Link to v1: https://lore.kernel.org/all/20261015015812.867988-1-zhangpengjie2@huawei.com/
>>
>>   drivers/cpufreq/cppc_cpufreq.c | 20 ++++++++++++++++++++
>>   1 file changed, 20 insertions(+)
>>
>> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
>> index 80893844353c..0a4255a36f60 100644
>> --- a/drivers/cpufreq/cppc_cpufreq.c
>> +++ b/drivers/cpufreq/cppc_cpufreq.c
>> @@ -1052,6 +1052,25 @@ static struct cpufreq_driver cppc_cpufreq_driver = {
>>   	.name = "cppc_cpufreq",
>>   };
>>   
>> +static void __init cppc_cpufreq_default_boost_init(void)
>> +{
>> +	struct cppc_perf_caps caps;
>> +	bool enable = false;
>> +	int cpu;
>> +
>> +	for_each_possible_cpu(cpu) {
>> +		if (cppc_get_perf_caps(cpu, &caps))
>> +			continue;
>> +
>> +		if (caps.highest_perf > caps.nominal_perf) {
>> +			enable = true;
>> +			break;
>> +		}
>> +	}
>> +
>> +	cppc_cpufreq_driver.boost_enabled = enable;
> Any reason for the scan instead of just setting
> boost_enabled = true? Platforms without boost would
> also expose the toggle, but that's mostly in line with
> the other drivers? (also again the ospm_nominal_perf
> angle)

The reason for scanning here is to keep the initial sysfs state
consistent on platforms where highest_perf == nominal_perf on all CPUs
(i.e. policy->boost_supported is false everywhere). If we just set
boost_enabled = true unconditionally, the global cpufreq/boost file will
read 1 on boot while every policyX/boost reads 0 (and rejects writes
with -EINVAL).

Also, since ospm_nominal_perf has a valid range of [lowest_perf,
nominal_perf], it actually pairs quite well with the boost knob: on
platforms with highest_perf > nominal_perf, ospm_nominal_perf will
always stay below highest_perf, and even on platforms with
nominal_perf == highest_perf, lowering ospm_nominal_perf could
dynamically define a nominal ceiling for when boost is disabled.

Thanks,
Pengjie

>> +}
>> +
>>   static int __init cppc_cpufreq_init(void)
>>   {
>>   	int ret;
>> @@ -1061,6 +1080,7 @@ static int __init cppc_cpufreq_init(void)
>>   
>>   	cppc_freq_invariance_init();
>>   	populate_efficiency_class();
>> +	cppc_cpufreq_default_boost_init();
>>   
>>   	ret = cpufreq_register_driver(&cppc_cpufreq_driver);
>>   	if (ret)
>
