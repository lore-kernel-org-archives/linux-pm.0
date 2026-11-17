Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.219
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794907327;
	b=WnTiXPB4kheSZFP4Kg5r4j8cyex/DI1xVp2O9+LUACbDmmBv28WJYnywMZCTfinO1NCc
	 yoQUxNdN5WNE1XfskrVXcE9mjLzdXC1CJ5RRLPBX3SwCmVQmS+sWiBfBKslXlkdPqRJNq
	 YFhrzVSqapgK6SbOrUPyhmdmILW95zwrHmtNexvek95GKqrJokj0lU5DwTyJOcZaGk2f+
	 3OIjeL9pi9mRChRax+PXa5oGf/lDIkU7YthIb3W6YOJnXfgnRZtMJQBUw5+++Ay4vMkWL
	 6F8KAIIqm7dnil9NhDosBhG3zTiQaSg1XYVNT4FZthpFpGnDa2mnCUYy0zmTrB+gEjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794907327;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=/g9AewCRH5AzZ1WihxLZHJwjpR3BmtCYU3NtfZedlqQ=;
	b=BnGpYMHobRrHfDJ8tVHIQTWm+mMOBBUwVymAOHJhG3lGzVw9oqcWPt0OnlbS9AesC95O
	 WKY/r/El8Xc8z7/rT1YlDLrMr4DjVigXIAJwexy9uOuK5vbLoKviZcBTinIN7+3vUlZzO
	 e523GAhjESv+VjcdeqBJZemCHzzSwvCXcg5Q/TD5GabVs76fIS08raRQXozh7Q36gz3aU
	 jRrhl5v34v++adofJyGe6Q4lQwV4ql5Ufh/Qk7kNyQasj7Z1MvSgBmZKCWFCPVNyfx5vt
	 byQEDxooDwRPXXyM5Xxm+EGr7UYa/bUkCtj2iaoyj9Xn4XKXMApI+b1vfYFRi55Idbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=ERsPlNrj;
	arc=none smtp.remote-ip=113.46.200.219
Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01FC3606A32A;
	Tue, 17 Nov 2026 09:22:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 01FC3606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=ERsPlNrj
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=/g9AewCRH5AzZ1WihxLZHJwjpR3BmtCYU3NtfZedlqQ=;
	b=ERsPlNrjN36Q17RXpU+ORRYxqFYD52+CRQ22PB7m8DvdwdHP01XVOxF6iv2Ak+TKCcB2sKiAy
	y025yuUFVj/T+bEmyJNOj1nzoQu1V53lRuW2141maFaOzxhqD6TInffrjQM1aUD3Joq1G6BSK4M
	YAxcgmyQ/9DWxvK7N5ma4UI=
Received: from mail.maildlp.com (unknown [172.19.163.104])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4jTK4G6Z0pz1prk0;
	Tue, 17 Nov 2026 17:21:50 +0800 (CST)
Received: from kwepemr200004.china.huawei.com (unknown [7.202.195.241])
	by mail.maildlp.com (Postfix) with ESMTPS id 3DB744056E;
	Tue, 17 Nov 2026 17:22:03 +0800 (CST)
Received: from [10.67.121.62] (10.67.121.62) by kwepemr200004.china.huawei.com
 (7.202.195.241) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 17 Nov
 2026 17:22:02 +0800
Message-ID: <977b71ab-a639-40bc-95fb-6965f79d7a4d@huawei.com>
Date: Tue, 17 Nov 2026 17:22:01 +0800
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
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
CC: Christian Loehle <christian.loehle@arm.com>, <viresh.kumar@linaro.org>,
	<linuxarm@huawei.com>, <zhanjie9@hisilicon.com>, <prime.zeng@hisilicon.com>,
	<wanghuiqiang@huawei.com>, <xuwei5@huawei.com>, <zhenglifeng1@huawei.com>,
	<yubowen8@huawei.com>, <pierre.gondois@arm.com>, <sumitg@nvidia.com>,
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<mojunjun4@huawei.com>
References: <20261022075901.3436021-1-zhangpengjie2@huawei.com>
 <d9fa8052-f562-4867-9e9f-1fd2a66fa794@arm.com>
 <940a9a70-71fb-491d-a1a7-1a7b4d6dc089@huawei.com>
 <f688c3fc-1375-4803-9775-9b4da78536c9@arm.com>
 <02dd34f0-c9fb-4dc5-bc1d-af83ae080724@huawei.com>
 <CAJZ5v0j1YpOu9SnjAF4VFVOVFEr6bLzRWaqCJ3jmFP4-01s1LQ@mail.gmail.com>
From: Pengjie Zhang <zhangpengjie2@huawei.com>
In-Reply-To: <CAJZ5v0j1YpOu9SnjAF4VFVOVFEr6bLzRWaqCJ3jmFP4-01s1LQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemr200004.china.huawei.com (7.202.195.241)


On 11/5/2026 8:21 PM, Rafael J. Wysocki (Intel) wrote:
> On Thu, Nov 5, 2026 at 8:04 AM Pengjie Zhang <zhangpengjie2@huawei.com> wrote:
>>
>> On 11/5/2026 12:12 AM, Christian Loehle wrote:
>>> On 11/4/26 07:43, Pengjie Zhang wrote:
>>>> On 10/29/2026 4:51 AM, Christian Loehle wrote:
>>>>> On 10/22/26 08:59, Pengjie Zhang wrote:
>>>>>> The CPPC driver leaves boost disabled by default when Highest Performance
>>>>>> exceeds Nominal Performance. Userspace must explicitly enable boost
>>>>>> before governors can use the full advertised performance range.
>>>>>>
>>>>>> Enable boost by default when at least one possible CPU reports support,
>>>>>> while users who prefer to stay within the sustained nominal limit can
>>>>>> still disable it via the boost knob without determining scaling_max_freq
>>>>>> for each policy.
>>>>>>
>>>>>> Check the performance capabilities before registering the driver so that
>>>>>> the cpufreq core enables boost for each policy that supports it.
>>>>>>
>>>>>> Signed-off-by: Pengjie Zhang <zhangpengjie2@huawei.com>
>>>>> Just to be clear I'm not blocking this per se, but continuing my comments:
>>>>>
>>>>> I just wonder if this is a configuration worth keeping.
>>>>> You mentioned your platforms have a BIOS to set nominal==highest or not.
>>>>> If we removed interpreting highest - nominal as boost entirely that
>>>>> would also make that BIOS setting obsolete. Userspace could still
>>>>> query nominal and restrict cpufreq to that if it wishes to do that,
>>>>> we could add that to cpupower for convenience (i.e. set all policies'
>>>>> max to nominal).
>>>>>
>>>>> With the changes that are coming with CPCv4 we would save ourselves
>>>>> some headache (like keeping track of boost status when ospm_nominal_perf
>>>>> is being written).
>>>>>
>>>>> The question is also how often the combination of "enable nominal < highest"
>>>>> and then explicitly toggling boost at runtime actually happens...
>>>>>
>>>>>> ---
>>>>>> Changes in v2:
>>>>>> - Drop "even" and clarify the commit message (Christian).
>>>>>> - Link to v1: https://lore.kernel.org/all/20261015015812.867988-1-zhangpengjie2@huawei.com/
>>>>>>
>>>>>>     drivers/cpufreq/cppc_cpufreq.c | 20 ++++++++++++++++++++
>>>>>>     1 file changed, 20 insertions(+)
>>>>>>
>>>>>> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
>>>>>> index 80893844353c..0a4255a36f60 100644
>>>>>> --- a/drivers/cpufreq/cppc_cpufreq.c
>>>>>> +++ b/drivers/cpufreq/cppc_cpufreq.c
>>>>>> @@ -1052,6 +1052,25 @@ static struct cpufreq_driver cppc_cpufreq_driver = {
>>>>>>         .name = "cppc_cpufreq",
>>>>>>     };
>>>>>>     +static void __init cppc_cpufreq_default_boost_init(void)
>>>>>> +{
>>>>>> +    struct cppc_perf_caps caps;
>>>>>> +    bool enable = false;
>>>>>> +    int cpu;
>>>>>> +
>>>>>> +    for_each_possible_cpu(cpu) {
>>>>>> +        if (cppc_get_perf_caps(cpu, &caps))
>>>>>> +            continue;
>>>>>> +
>>>>>> +        if (caps.highest_perf > caps.nominal_perf) {
>>>>>> +            enable = true;
>>>>>> +            break;
>>>>>> +        }
>>>>>> +    }
>>>>>> +
>>>>>> +    cppc_cpufreq_driver.boost_enabled = enable;
>>>>> Any reason for the scan instead of just setting
>>>>> boost_enabled = true? Platforms without boost would
>>>>> also expose the toggle, but that's mostly in line with
>>>>> the other drivers? (also again the ospm_nominal_perf
>>>>> angle)
>>>> The reason for scanning here is to keep the initial sysfs state
>>>> consistent on platforms where highest_perf == nominal_perf on all CPUs
>>>> (i.e. policy->boost_supported is false everywhere). If we just set
>>>> boost_enabled = true unconditionally, the global cpufreq/boost file will
>>>> read 1 on boot while every policyX/boost reads 0 (and rejects writes
>>>> with -EINVAL).
>>> FWIW, amd-pstate can already expose global boost=1 while all per-policy
>>> boost knobs read 0 and writes to either knob then fail with -EINVAL AFAICS?
>>>
>>> AFAIU the global sysfs knob represents permission to boost where
>>> supported, rather than meaning boost is supported, too?
>> Yes, Documentation/admin-guide/pm/cpufreq.rst also states that 1 in the
>> global boost file "only means a permission to use the frequency boost
>> mechanism (which still may never be used for other reasons)", while 0
>> means it "is disabled and cannot be used at all".
>>
>>> PS:
>>> Also another fun one I discovered...
>>> power-orion-o6-01# cat /sys/devices/system/cpu/cpufreq/boost
>>> 0
>>> power-orion-o6-01# echo 1 > /sys/devices/system/cpu/cpufreq/boost
>>> echo: write error: invalid argument
>>> power-orion-o6-01# cat /sys/devices/system/cpu/cpufreq/boost
>>> 0
>>> power-orion-o6-01# echo 0 > /sys/devices/system/cpu/cpufreq/boost
>>> echo: write error: invalid argument
>>> power-orion-o6-01# cat /sys/devices/system/cpu/cpufreq/boost
>>> 1
>>>
>>> I'll go and fix that...
>>>
>>>> Also, since ospm_nominal_perf has a valid range of [lowest_perf,
>>>> nominal_perf], it actually pairs quite well with the boost knob: on
>>>> platforms with highest_perf > nominal_perf, ospm_nominal_perf will
>>>> always stay below highest_perf, and even on platforms with
>>>> nominal_perf == highest_perf, lowering ospm_nominal_perf could
>>>> dynamically define a nominal ceiling for when boost is disabled.
>>> I don't think I agree with the latter. OSPM nominal has its own (platform)
>>> semantics, but making boost=0 impose that value as a frequency ceiling
>>> is just another way of setting scaling_max_freq.
>>> I don't see why these two need to be coupled?
>>>
>>> Also I think the fact that caps.highest_perf == caps.nominal_perf
>>> but ospm_nominal_perf can change boost supported later is a reason
>>> against the boot-time scan? (which would need to exclude
>>> ospm_nominal_perf platforms?)
>> Fair enough, ospm_nominal_perf doesn't need to be coupled with boost.
>>
>> Viresh, Rafael, any preference here? Should we keep the boot-time check
>> in v2 (so global boost stays 0 on platforms without boost support), or
>> drop the scan and just set .boost_enabled = true statically in
>> cppc_cpufreq_driver?
Hi Rafael,
> I have no specific opinions regarding boost support other than it's
> better be made consistent across all drivers and the core.
Thanks. I agree with Christian's reading of the global boost knob as
permission for policies that support boost.

For v3, I'd set .boost_enabled = true in cppc_cpufreq_driver and rely on
the existing highest_perf > nominal_perf check in cppc_cpufreq_cpu_init().
That would avoid the extra scan before driver registration.

On a system with no boost-capable policy, the global file would start
at 1 while the per-policy files remain at 0 (and reject writes with
-EINVAL), similar to what amd-pstate already does.

As Christian pointed out, defaulting to .boost_enabled = true also fits
the OSPM Nominal Performance series. If OSPM lowers the nominal
performance after boot and creates a boost range, boost permission is
already enabled globally by default.


Thanks,
     Pengjie

