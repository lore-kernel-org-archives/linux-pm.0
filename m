Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3339258CD7;
	Fri,  8 May 2026 02:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778207634; cv=none; b=pjoKoTtR1RF4jaE7K0n7msOz8heLtqUF7EDGpt98xCekuTYFRjw/pVfH/3JMtHhoVqaf3Mjx3lpom0YF3yp1uj1TGbHCtzH90/xbx3apHi7ahPaFJagdgDbHMcl4I8zneCOS3tweKjnM4JaCXatVlDHPN0gPUItVMukdDvBDwZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778207634; c=relaxed/simple;
	bh=33Kzi1QqQaOxup3HteWzWB4sskTQYnde6JYurTvGCjw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=NGFsSrISImWZEmFCLT2F7IFQSfspoJG6D3KPJOHmxc2Tzusn3HajrdKzbjvVe5MWA76cjQaq2eUvQcUvBl+tNDA+6EUAFtaSdGWQzE7pfPJekxipFjTigWNYR9CRE9ugeQcrnb2do92PGnGalGIHqjoxx5BXou79F2jAJgbCNaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=113.46.200.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.163.127])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4gBXzc50SkzKmT6;
	Fri,  8 May 2026 10:26:04 +0800 (CST)
Received: from kwepemf200017.china.huawei.com (unknown [7.202.181.10])
	by mail.maildlp.com (Postfix) with ESMTPS id E8FCF40572;
	Fri,  8 May 2026 10:33:40 +0800 (CST)
Received: from [10.67.121.58] (10.67.121.58) by kwepemf200017.china.huawei.com
 (7.202.181.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 8 May
 2026 10:33:39 +0800
Message-ID: <a9324a65-9da9-4e35-8c78-a054fb24bc8d@hisilicon.com>
Date: Fri, 8 May 2026 10:33:39 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cpufreq: CPPC: add autonomous mode boot parameter
 support
To: Sumit Gupta <sumitg@nvidia.com>, <rafael@kernel.org>,
	<viresh.kumar@linaro.org>, <pierre.gondois@arm.com>,
	<ionela.voinescu@arm.com>, <zhenglifeng1@huawei.com>, <corbet@lwn.net>,
	<skhan@linuxfoundation.org>, <rdunlap@infradead.org>,
	<mario.limonciello@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <linux-tegra@vger.kernel.org>, <treding@nvidia.com>,
	<jonathanh@nvidia.com>, <vsethi@nvidia.com>, <ksitaraman@nvidia.com>,
	<sanjayc@nvidia.com>, <mochs@nvidia.com>, <bbasu@nvidia.com>
References: <20260424201814.230071-1-sumitg@nvidia.com>
 <a4ed690a-50d6-4bfe-8810-86a75d7b51e3@hisilicon.com>
 <bc06c3ab-0286-4e1e-a615-e704b267c21a@nvidia.com>
Content-Language: en-US
From: Jie Zhan <zhanjie9@hisilicon.com>
In-Reply-To: <bc06c3ab-0286-4e1e-a615-e704b267c21a@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemf200017.china.huawei.com (7.202.181.10)



On 5/5/2026 8:29 PM, Sumit Gupta wrote:
> Hi Jie,
> 
> 
> On 27/04/26 13:54, Jie Zhan wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> Hi Sumit,
>>
>> In general, I would expect this parameter only toggles on auto_sel by
>> default.  IIUC, other CPPC configurations (min/max/desired perf, EPP,
>> enable) are optional and not closely related to this.
>>
>> Why including those stuff here?
>>
>>
>> Please see other questions inline.
>>
>> Thanks!
>> Jie
> 
> These together provide a known, predictable autonomous mode boot.
> min/max/desired seeding ensures HW has a known starting bound (BIOS
> may leave them unset).
> EPP=PERFORMANCE_PREF is needed as BIOS defaults often bias toward
> energy saving, and admins on many CPU systems shouldn't have to script
> per CPU sysfs writes at every boot to undo that.
Hi Sumit,

The min/max/desired perf might be a slightly different case, but the EPP
value should probably follow the default if there is?
Otherwise, users may complain that their BIOS defaults don't work and find
out it's driver's fault.

Alternatively, we may also make an assumption that we ignore BIOS EPP
config, but not sure if that's suitable?

(Perhaps let's just discuss in the bottom trunk because the main issue is
pretty much the same.)
>>
>> On 4/25/2026 4:18 AM, Sumit Gupta wrote:
>>> Add a kernel boot parameter 'cppc_cpufreq.auto_sel_mode' to enable
>>> CPPC autonomous performance selection on all CPUs at system startup.
>>> When autonomous mode is enabled, the hardware automatically adjusts
>>> CPU performance based on workload demands using Energy Performance
>>> Preference (EPP) hints.
>>>
>>> When auto_sel_mode=1:
>>> - Configure all CPUs for autonomous operation on first init
>>> - Set EPP to performance preference (0x0)
>>> - Use HW min/max_perf when available; otherwise initialize from caps
>>> - Clamp desired_perf to bounds before enabling autonomous mode
>>> - Hardware controls frequency instead of the OS governor
>>>
>>> The boot parameter is applied only during first policy initialization.
>>> Skip applying it on CPU hotplug to preserve runtime sysfs configuration.
>>>
>>> This patch depends on patch [2] ("cpufreq: Set policy->min and max
>>> as real QoS constraints") so that the policy->min/max set in
>>> cppc_cpufreq_cpu_init() are not overridden by cpufreq_set_policy()
>>> during init.
>>>
>>> Reviewed-by: Randy Dunlap <rdunlap@infradead.org> (Documentation)
>>> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
>>> ---
>>> v[1] -> v2:
>>> - Call cppc_set_enable() unconditionally so CPPC is enabled for both
>>>    OS-driven and autonomous modes.
>> Why adding this in v2?
>> This looks like a separate issue since setting CPPC Enable reg doesn't seem
>> to be related with autonomous control.
> 
> In v2, moved it out of the auto_sel specific check.
> Agree that cppc_set_enable() is general CPPC enablement and can be split
> into a separate patch in v3 if preferred.
> 
Yeah it should be a separate patch I think.
>>> - Init min/max from caps instead of cppc_cpufreq_update_perf_limits()
>>>    as policy->min/max aren't yet populated.
>>>
>>> [1] https://lore.kernel.org/lkml/20260317151053.2361475-1-sumitg@nvidia.com/
>>> [2] https://lore.kernel.org/lkml/20260423084731.1090384-2-pierre.gondois@arm.com/
>>> ---
>>>   .../admin-guide/kernel-parameters.txt         | 13 +++
>>>   drivers/cpufreq/cppc_cpufreq.c                | 89 +++++++++++++++++--
>>>   2 files changed, 97 insertions(+), 5 deletions(-)
>>>
...
>>> +
>>> +             policy->cur = cppc_perf_to_khz(caps,
>>> +                                            cpu_data->perf_ctrls.desired_perf);
>>> +
>>> +             /* EPP is optional - some platforms may not support it */
>>> +             ret = cppc_set_epp(cpu, CPPC_EPP_PERFORMANCE_PREF);
>> Why setting this to PERFORMANCE by default?
>> A platform can have its own default EPP value.  This would override that.
> 
> The boot option targets performance oriented use cases on many CPU
> systems, avoiding sysfs scripting across all CPUs on every boot.
> The BIOS default EPP (often biased toward energy saving) would otherwise
> steer HW away from that goal. Admins can still re-tune EPP at runtime via
> the existing energy_performance_preference_val sysfs.
> 
Yeah, avoiding scripting makes sense for sure.
The thing is how do we do this nicely.

For now we need to consider follow either the BIOS default or the driver
default.
They seem to be exclusive since there isn't a clear way to support both at
the same time.

So, are we going to support the BIOS default case?
For example, users can config a default EPP in the BIOS setup menu.
>>> +             if (ret && ret != -EOPNOTSUPP)
>>> +                     pr_warn("Failed to set EPP for CPU%d (%d)\n", cpu, ret);
>>> +             else if (!ret)
>>> +                     cpu_data->perf_ctrls.energy_perf = CPPC_EPP_PERFORMANCE_PREF;
>>> +
...
