Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793808780;
	b=otNR7aXeLcxdQ/+6k8WQtSNRVdn7dg86uc93XsNIz1Y5r1BVWqkkEQVWDcP5KEBr00ei
	 FdP0WNluoFjQXpa0r/NjyoTSpVYwh4w/42a3/BtRI5j8LkGc6VWovcLKeZIK1FHOvY1Fh
	 O7YXVDeU6/VDW3z8I5Iq14YeYOn36WRJyUNrf/eq6ssdXEFe+Y6jbcQRuZOuWNwN2FVri
	 moSWZLIao5bXalEsEo4HD7iyE+uykplu263Cisxv/kgbfZeTi5oc90ROZPzgLXeW8TSIk
	 y9K1hlsJa5uAB6Wpynaox/ae0gdG6FTg1haJL8tX+3j8RUrNUgiSQuMr4QQmROlEEDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793808780;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=DpaTYVQzq+BvXYocdGsHDtOiPkT7kERXmyJ4Zdmz+0s=;
	b=YpzOjFQWxXzVSOYBwU8C+iyXRMTWmDalDjPDmphqHZG0H0E2YuJGDibBw4tCMGjLeIWJ
	 HSTq+emsqBmcD+YudB7ct7crzHJHlUfFouTnSy5MdbFBw/87E7bVaW+QJhyx2ZeRCkY56
	 nd0NBpv8LNl7RrKK+O+dD8+uIWxMXmtVn/OTUfou3GQv7zemkD+JRJUcvyVcqrYAjqHVQ
	 LT9eZ2eOOiNRK2EWNnulAH5mgDFvY57FKu7pgpVi8dIFKQ6ugknwblFpvP5RQe06Ak/tJ
	 aOl0ukGqlnnrGVv/Yik0pm1wEawqGTSCFYThBGptkLGAoMtL2EQ5CYcKyERoAXns5BQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=NwCq2Q7i;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2285606A335;
	Wed,  4 Nov 2026 16:12:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E2285606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=NwCq2Q7i
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1464E1BB2;
	Wed,  4 Nov 2026 08:12:55 -0800 (PST)
Received: from [10.0.130.179] (e127648.arm.com [10.0.130.179])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1B2793F632;
	Wed,  4 Nov 2026 08:12:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793808778; bh=wt7REst1E+Oi2kyPtZi18Qsa3aZ9ccNwr8A3RcO4Phs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NwCq2Q7i4aceZL+OsFUcJqYoCThpXQ8G5EvzZTfY/L6htGD/3v4eP9meWfTgIt7Ff
	 LhVXUbB5LsboYi0/a5AJRGAUGFwqiiCiJuIjmvPeVIau1Q3XhhjIh/G3+rUQ0Vjvl/
	 H4tkYAvQOW037citF7xB6AToTSCPRHD2W7c2bwHA=
Message-ID: <f688c3fc-1375-4803-9775-9b4da78536c9@arm.com>
Date: Wed, 4 Nov 2026 16:12:53 +0000
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
To: Pengjie Zhang <zhangpengjie2@huawei.com>, rafael@kernel.org,
 viresh.kumar@linaro.org
Cc: linuxarm@huawei.com, zhanjie9@hisilicon.com, prime.zeng@hisilicon.com,
 wanghuiqiang@huawei.com, xuwei5@huawei.com, zhenglifeng1@huawei.com,
 yubowen8@huawei.com, pierre.gondois@arm.com, sumitg@nvidia.com,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, mojunjun4@huawei.com
References: <20261022075901.3436021-1-zhangpengjie2@huawei.com>
 <d9fa8052-f562-4867-9e9f-1fd2a66fa794@arm.com>
 <940a9a70-71fb-491d-a1a7-1a7b4d6dc089@huawei.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <940a9a70-71fb-491d-a1a7-1a7b4d6dc089@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/4/26 07:43, Pengjie Zhang wrote:
> 
> On 10/29/2026 4:51 AM, Christian Loehle wrote:
>> On 10/22/26 08:59, Pengjie Zhang wrote:
>>> The CPPC driver leaves boost disabled by default when Highest Performance
>>> exceeds Nominal Performance. Userspace must explicitly enable boost
>>> before governors can use the full advertised performance range.
>>>
>>> Enable boost by default when at least one possible CPU reports support,
>>> while users who prefer to stay within the sustained nominal limit can
>>> still disable it via the boost knob without determining scaling_max_freq
>>> for each policy.
>>>
>>> Check the performance capabilities before registering the driver so that
>>> the cpufreq core enables boost for each policy that supports it.
>>>
>>> Signed-off-by: Pengjie Zhang <zhangpengjie2@huawei.com>
>>
>> Just to be clear I'm not blocking this per se, but continuing my comments:
>>
>> I just wonder if this is a configuration worth keeping.
>> You mentioned your platforms have a BIOS to set nominal==highest or not.
>> If we removed interpreting highest - nominal as boost entirely that
>> would also make that BIOS setting obsolete. Userspace could still
>> query nominal and restrict cpufreq to that if it wishes to do that,
>> we could add that to cpupower for convenience (i.e. set all policies'
>> max to nominal).
>>
>> With the changes that are coming with CPCv4 we would save ourselves
>> some headache (like keeping track of boost status when ospm_nominal_perf
>> is being written).
>>
>> The question is also how often the combination of "enable nominal < highest"
>> and then explicitly toggling boost at runtime actually happens...
>>
>>> ---
>>> Changes in v2:
>>> - Drop "even" and clarify the commit message (Christian).
>>> - Link to v1: https://lore.kernel.org/all/20261015015812.867988-1-zhangpengjie2@huawei.com/
>>>
>>>   drivers/cpufreq/cppc_cpufreq.c | 20 ++++++++++++++++++++
>>>   1 file changed, 20 insertions(+)
>>>
>>> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
>>> index 80893844353c..0a4255a36f60 100644
>>> --- a/drivers/cpufreq/cppc_cpufreq.c
>>> +++ b/drivers/cpufreq/cppc_cpufreq.c
>>> @@ -1052,6 +1052,25 @@ static struct cpufreq_driver cppc_cpufreq_driver = {
>>>       .name = "cppc_cpufreq",
>>>   };
>>>   +static void __init cppc_cpufreq_default_boost_init(void)
>>> +{
>>> +    struct cppc_perf_caps caps;
>>> +    bool enable = false;
>>> +    int cpu;
>>> +
>>> +    for_each_possible_cpu(cpu) {
>>> +        if (cppc_get_perf_caps(cpu, &caps))
>>> +            continue;
>>> +
>>> +        if (caps.highest_perf > caps.nominal_perf) {
>>> +            enable = true;
>>> +            break;
>>> +        }
>>> +    }
>>> +
>>> +    cppc_cpufreq_driver.boost_enabled = enable;
>> Any reason for the scan instead of just setting
>> boost_enabled = true? Platforms without boost would
>> also expose the toggle, but that's mostly in line with
>> the other drivers? (also again the ospm_nominal_perf
>> angle)
> 
> The reason for scanning here is to keep the initial sysfs state
> consistent on platforms where highest_perf == nominal_perf on all CPUs
> (i.e. policy->boost_supported is false everywhere). If we just set
> boost_enabled = true unconditionally, the global cpufreq/boost file will
> read 1 on boot while every policyX/boost reads 0 (and rejects writes
> with -EINVAL).

FWIW, amd-pstate can already expose global boost=1 while all per-policy
boost knobs read 0 and writes to either knob then fail with -EINVAL AFAICS?

AFAIU the global sysfs knob represents permission to boost where
supported, rather than meaning boost is supported, too?

PS:
Also another fun one I discovered...
power-orion-o6-01# cat /sys/devices/system/cpu/cpufreq/boost 
0
power-orion-o6-01# echo 1 > /sys/devices/system/cpu/cpufreq/boost
echo: write error: invalid argument
power-orion-o6-01# cat /sys/devices/system/cpu/cpufreq/boost 
0
power-orion-o6-01# echo 0 > /sys/devices/system/cpu/cpufreq/boost
echo: write error: invalid argument
power-orion-o6-01# cat /sys/devices/system/cpu/cpufreq/boost     
1

I'll go and fix that...

> 
> Also, since ospm_nominal_perf has a valid range of [lowest_perf,
> nominal_perf], it actually pairs quite well with the boost knob: on
> platforms with highest_perf > nominal_perf, ospm_nominal_perf will
> always stay below highest_perf, and even on platforms with
> nominal_perf == highest_perf, lowering ospm_nominal_perf could
> dynamically define a nominal ceiling for when boost is disabled.

I don't think I agree with the latter. OSPM nominal has its own (platform)
semantics, but making boost=0 impose that value as a frequency ceiling
is just another way of setting scaling_max_freq.
I don't see why these two need to be coupled?

Also I think the fact that caps.highest_perf == caps.nominal_perf
but ospm_nominal_perf can change boost supported later is a reason
against the boot-time scan? (which would need to exclude
ospm_nominal_perf platforms?)
