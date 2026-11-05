Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.226
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793862279;
	b=SrVdOLqIQgQjqkJWY9CXiSbfMig8GjJIOSJCE+L53Wy6b3ypQb/WsnMN3tJK6eSMnNvD
	 PZnwqDekmVwabbKtf/g/HYvjpBi/ZknDxxKTow+Tq2PNFusXcgCnekBhgjSgRaALiTwq+
	 WESlKFbDhY2Gy4kNh+unjx1kExzLOYYQcUE/OgwFJRRbC04D06HwROBZ+doaVoOJe5mdr
	 LxgRHpSbbAJrDLK8ryn9au2ixDZpZDFqN0Oc1KE0wis9sn/XrsImkPB2YOObtBbp8WydA
	 fGfQYXIH5CB1Z0EX/8ApsqSrzyfSsmPSVyX2tjHiwFSYfyv0vH5Z5IDJ6Hu6YLQYBEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793862279;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=JdMnDzdRM0/IH9TgjYdXutu31Ec/y4cSsVHoSh1h9ug=;
	b=OPcLzpx1wQhTtYCIqP3Un5tonMpnBIu3E55ue83fbucepe16ARek5Zlqik5jJhZZ2fTM
	 ynxC7vj/toaYib6Y4Rs9e9o4s9aNYsLXexaVPfVAdRNIk95fJTIyS1sdkRIkDfVTauq1b
	 /i3DVW3wTbz/GgynMVpT8RDcB4TSLuU7k4KhlLqgxcnKT0MNmE37jXyquDn3A1qKlAUUJ
	 5asiNq56VBcFaL41GebxWoalp91rF1r0hnTW9ejty9ZugdEkTPZizBhigyaXObo/eTjlN
	 ypx4IlV/KTVM65kwK2u4gRqY9un02xOrHtOT7BlQEN3xzwqW3MpOV9zvl+cEfWS5VYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=A1KP31Ql;
	arc=none smtp.remote-ip=113.46.200.226
Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C5CC606A31B;
	Thu,  5 Nov 2026 07:04:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3C5CC606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=A1KP31Ql
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=JdMnDzdRM0/IH9TgjYdXutu31Ec/y4cSsVHoSh1h9ug=;
	b=A1KP31Ql6Wec4/VA+hU2jHrdRvNBCKGas9J2oBtTyvIAEeLqg149gbLWJp9jl8slSNMkahs2d
	NJ9EWSrcgeQAQeKCyYwWbuUkaSWbU+LNnI+atFKmlHqlMicmk+/tKZFarHxwOZ84/75eB2L0Yr/
	BuiGazHPOKmFvtmEp62Y8xs=
Received: from mail.maildlp.com (unknown [172.19.163.163])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4jKtbG55WBzKm6Y;
	Thu,  5 Nov 2026 15:04:26 +0800 (CST)
Received: from kwepemr200004.china.huawei.com (unknown [7.202.195.241])
	by mail.maildlp.com (Postfix) with ESMTPS id DFB644048B;
	Thu,  5 Nov 2026 15:04:32 +0800 (CST)
Received: from [10.67.121.62] (10.67.121.62) by kwepemr200004.china.huawei.com
 (7.202.195.241) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 5 Nov
 2026 15:04:32 +0800
Message-ID: <02dd34f0-c9fb-4dc5-bc1d-af83ae080724@huawei.com>
Date: Thu, 5 Nov 2026 15:04:31 +0800
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
 <940a9a70-71fb-491d-a1a7-1a7b4d6dc089@huawei.com>
 <f688c3fc-1375-4803-9775-9b4da78536c9@arm.com>
From: Pengjie Zhang <zhangpengjie2@huawei.com>
In-Reply-To: <f688c3fc-1375-4803-9775-9b4da78536c9@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemr200004.china.huawei.com (7.202.195.241)


On 11/5/2026 12:12 AM, Christian Loehle wrote:
> On 11/4/26 07:43, Pengjie Zhang wrote:
>> On 10/29/2026 4:51 AM, Christian Loehle wrote:
>>> On 10/22/26 08:59, Pengjie Zhang wrote:
>>>> The CPPC driver leaves boost disabled by default when Highest Performance
>>>> exceeds Nominal Performance. Userspace must explicitly enable boost
>>>> before governors can use the full advertised performance range.
>>>>
>>>> Enable boost by default when at least one possible CPU reports support,
>>>> while users who prefer to stay within the sustained nominal limit can
>>>> still disable it via the boost knob without determining scaling_max_freq
>>>> for each policy.
>>>>
>>>> Check the performance capabilities before registering the driver so that
>>>> the cpufreq core enables boost for each policy that supports it.
>>>>
>>>> Signed-off-by: Pengjie Zhang <zhangpengjie2@huawei.com>
>>> Just to be clear I'm not blocking this per se, but continuing my comments:
>>>
>>> I just wonder if this is a configuration worth keeping.
>>> You mentioned your platforms have a BIOS to set nominal==highest or not.
>>> If we removed interpreting highest - nominal as boost entirely that
>>> would also make that BIOS setting obsolete. Userspace could still
>>> query nominal and restrict cpufreq to that if it wishes to do that,
>>> we could add that to cpupower for convenience (i.e. set all policies'
>>> max to nominal).
>>>
>>> With the changes that are coming with CPCv4 we would save ourselves
>>> some headache (like keeping track of boost status when ospm_nominal_perf
>>> is being written).
>>>
>>> The question is also how often the combination of "enable nominal < highest"
>>> and then explicitly toggling boost at runtime actually happens...
>>>
>>>> ---
>>>> Changes in v2:
>>>> - Drop "even" and clarify the commit message (Christian).
>>>> - Link to v1: https://lore.kernel.org/all/20261015015812.867988-1-zhangpengjie2@huawei.com/
>>>>
>>>>    drivers/cpufreq/cppc_cpufreq.c | 20 ++++++++++++++++++++
>>>>    1 file changed, 20 insertions(+)
>>>>
>>>> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
>>>> index 80893844353c..0a4255a36f60 100644
>>>> --- a/drivers/cpufreq/cppc_cpufreq.c
>>>> +++ b/drivers/cpufreq/cppc_cpufreq.c
>>>> @@ -1052,6 +1052,25 @@ static struct cpufreq_driver cppc_cpufreq_driver = {
>>>>        .name = "cppc_cpufreq",
>>>>    };
>>>>    +static void __init cppc_cpufreq_default_boost_init(void)
>>>> +{
>>>> +    struct cppc_perf_caps caps;
>>>> +    bool enable = false;
>>>> +    int cpu;
>>>> +
>>>> +    for_each_possible_cpu(cpu) {
>>>> +        if (cppc_get_perf_caps(cpu, &caps))
>>>> +            continue;
>>>> +
>>>> +        if (caps.highest_perf > caps.nominal_perf) {
>>>> +            enable = true;
>>>> +            break;
>>>> +        }
>>>> +    }
>>>> +
>>>> +    cppc_cpufreq_driver.boost_enabled = enable;
>>> Any reason for the scan instead of just setting
>>> boost_enabled = true? Platforms without boost would
>>> also expose the toggle, but that's mostly in line with
>>> the other drivers? (also again the ospm_nominal_perf
>>> angle)
>> The reason for scanning here is to keep the initial sysfs state
>> consistent on platforms where highest_perf == nominal_perf on all CPUs
>> (i.e. policy->boost_supported is false everywhere). If we just set
>> boost_enabled = true unconditionally, the global cpufreq/boost file will
>> read 1 on boot while every policyX/boost reads 0 (and rejects writes
>> with -EINVAL).
> FWIW, amd-pstate can already expose global boost=1 while all per-policy
> boost knobs read 0 and writes to either knob then fail with -EINVAL AFAICS?
>
> AFAIU the global sysfs knob represents permission to boost where
> supported, rather than meaning boost is supported, too?

Yes, Documentation/admin-guide/pm/cpufreq.rst also states that 1 in the
global boost file "only means a permission to use the frequency boost
mechanism (which still may never be used for other reasons)", while 0
means it "is disabled and cannot be used at all".

> PS:
> Also another fun one I discovered...
> power-orion-o6-01# cat /sys/devices/system/cpu/cpufreq/boost
> 0
> power-orion-o6-01# echo 1 > /sys/devices/system/cpu/cpufreq/boost
> echo: write error: invalid argument
> power-orion-o6-01# cat /sys/devices/system/cpu/cpufreq/boost
> 0
> power-orion-o6-01# echo 0 > /sys/devices/system/cpu/cpufreq/boost
> echo: write error: invalid argument
> power-orion-o6-01# cat /sys/devices/system/cpu/cpufreq/boost
> 1
>
> I'll go and fix that...
>
>> Also, since ospm_nominal_perf has a valid range of [lowest_perf,
>> nominal_perf], it actually pairs quite well with the boost knob: on
>> platforms with highest_perf > nominal_perf, ospm_nominal_perf will
>> always stay below highest_perf, and even on platforms with
>> nominal_perf == highest_perf, lowering ospm_nominal_perf could
>> dynamically define a nominal ceiling for when boost is disabled.
> I don't think I agree with the latter. OSPM nominal has its own (platform)
> semantics, but making boost=0 impose that value as a frequency ceiling
> is just another way of setting scaling_max_freq.
> I don't see why these two need to be coupled?
>
> Also I think the fact that caps.highest_perf == caps.nominal_perf
> but ospm_nominal_perf can change boost supported later is a reason
> against the boot-time scan? (which would need to exclude
> ospm_nominal_perf platforms?)

Fair enough, ospm_nominal_perf doesn't need to be coupled with boost.

Viresh, Rafael, any preference here? Should we keep the boot-time check
in v2 (so global boost stays 0 on platforms without boost support), or
drop the scan and just set .boost_enabled = true statically in
cppc_cpufreq_driver?

Thanks,
Pengjie

