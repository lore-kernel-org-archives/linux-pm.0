Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FC4A50EBFC;
	Thu, 17 Sep 2026 13:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789650517; cv=none; b=Tienzz4/R9MJHIacmbE2kgvFUpZNl8ZWX4Bn0DJ3ivEDWRCRKv0lW6mR7+NT4ODL4pUGIW3ymlYUPKSjL0fubAxBHpY/LlywAS1pkKIdPfrYh83FvzNhxK5to4t9fx2wzjj2HA9rBgoQ9nGiAvnNY3JjNJ1YxSrnxS5PcVlPr+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789650517; c=relaxed/simple;
	bh=9REa1BqtKSFgluXgKPoygS+XYoOTO30AwYYhsGDwDAg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r71xNK0cAWZEaSPlxqifuKeIgJJxe+yWk6LlFgd+SoQDbr4wUUvHkLH6HUoPLxMaVvNr13Pjj4E1ds7cOCrTPBL+UUu7SJijyVvmuFUz+OpKnyF5O9B4rfmpdrNvWGxo5hiUOohEuiZ5VM27WLCh4x7H3jpN3yHssNfK5aZufRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=vI1jHPXG; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="vI1jHPXG"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B2218143D;
	Thu, 17 Sep 2026 06:08:24 -0700 (PDT)
Received: from [10.57.50.144] (unknown [10.57.50.144])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C04463F7B4;
	Thu, 17 Sep 2026 06:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1789650508; bh=9REa1BqtKSFgluXgKPoygS+XYoOTO30AwYYhsGDwDAg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=vI1jHPXGGMXM3N56LDwLWlHxAN9Fp05hnhLX1buiwVc85YChKSUhVjr+BxQkMCi0z
	 VJUN24ppqk8Gkzu/ZzJsNR8Yc1rp2iDwWrrF61VTkZTVgqZv+r95qyS3a5XVZbjWFI
	 7OXDHevAgxyHo3Sfx2hGbfenz4jTVxRX8aLqmJjI=
Message-ID: <7d250745-bed7-4e75-a3b5-17565d8ff662@arm.com>
Date: Thu, 17 Sep 2026 14:08:21 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/4] cpufreq: CPPC: Keep the policy across CPU hotplug
To: Sumit Gupta <sumitg@nvidia.com>, Jie Zhan <zhanjie9@hisilicon.com>,
 rafael@kernel.org, viresh.kumar@linaro.org, pierre.gondois@arm.com,
 ionela.voinescu@arm.com, zhenglifeng1@huawei.com, lenb@kernel.org,
 saket.dumbre@intel.com, ray.huang@amd.com, mario.limonciello@amd.com,
 perry.yuan@amd.com, kprateek.nayak@amd.com, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
 acpica-devel@lists.linux.dev, linux-tegra@vger.kernel.org
Cc: treding@nvidia.com, jonathanh@nvidia.com, vsethi@nvidia.com,
 ksitaraman@nvidia.com, sanjayc@nvidia.com, mochs@nvidia.com, bbasu@nvidia.com
References: <20260806200857.601152-1-sumitg@nvidia.com>
 <20260806200857.601152-2-sumitg@nvidia.com>
 <c30ddb21-2c97-4b9f-bae6-b29e30aa5e5e@hisilicon.com>
 <753b98a6-b3f7-431b-a867-eccbfd15d357@nvidia.com>
 <26439302-6759-446b-a498-310c218e4102@hisilicon.com>
 <404f0fea-4980-4e7f-ae05-eadcc2b13d7d@nvidia.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <404f0fea-4980-4e7f-ae05-eadcc2b13d7d@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/17/26 12:01, Sumit Gupta wrote:
> 
> 
>>>>
>>>> On 8/7/2026 4:08 AM, Sumit Gupta wrote:
>>>>> Without online()/offline() callbacks, the cpufreq core fully tears
>>>>> down a policy during exit() when its last online CPU is offlined, and
>>>>> rebuilds it during init() when it comes back.
>>>>>
>>>>> Add lightweight online()/offline() callbacks so the core instead keeps
>>>>> the policy live and reuses the driver's cpu_data across CPU hotplug.
>>>>> This avoids re-reading the CPPC capabilities on every offline/online,
>>>>> making CPU hotplug faster.
>>>>>
>>>>> Move what init() and exit() did on hotplug into the new callbacks:
>>>>>
>>>>>     - offline() requests the lowest desired performance, as exit() did.
>>>>>     - online() re-enables CPPC and restores the performance controls, as
>>>>>       the platform may have reset them. Failures are logged, not returned,
>>>>>       as the core would free the policy.
>>>>>     - online() also resyncs the frequency invariance counters, so that the
>>>>>       first tick does not measure across the offline window.
>>>>>
>>>>> The restore in online() uses cppc_set_perf(), which writes MIN before
>>>>> MAX. If the platform lowered MAX while the CPU was offline, writing the
>>>>> saved MIN could briefly leave MIN above MAX on registers not accessed
>>>>> through PCC, as PCC delivers the writes in one transaction. Raise MAX
>>>>> ahead of the restore when the saved MIN is above it.
>>>>>
>>>>> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
>>>>> ---
>>>>>    drivers/cpufreq/cppc_cpufreq.c | 128 +++++++++++++++++++++++++++++++++
>>>>>    1 file changed, 128 insertions(+)
>>>>>
>>>>> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
>>>>> index 80893844353c..4b3da9a3e122 100644
>>>>> --- a/drivers/cpufreq/cppc_cpufreq.c
>>>>> +++ b/drivers/cpufreq/cppc_cpufreq.c
>>>>> @@ -211,6 +211,29 @@ static void cppc_cpufreq_cpu_fie_exit(struct cpufreq_policy *policy)
>>>>>         }
>>>>>    }
>>>>>
>>>>> +/*
>>>>> + * Resync the counter snapshot, as the policy is kept across CPU hotplug and
>>>>> + * the first tick after online would otherwise span the offline window.
>>>>> + */
>>>>> +static void cppc_cpufreq_cpu_fie_resync(struct cpufreq_policy *policy)
>>>>> +{
>>>>> +     struct cppc_freq_invariance *cppc_fi;
>>>>> +     int cpu, ret;
>>>>> +
>>>>> +     if (fie_disabled)
>>>>> +             return;
>>>>> +
>>>>> +     /* policy->cpus still holds related_cpus here, so skip offline CPUs. */
>>>>> +     for_each_cpu_and(cpu, policy->cpus, cpu_online_mask) {
>>>>> +             cppc_fi = &per_cpu(cppc_freq_inv, cpu);
>>>>> +
>>>>> +             ret = cppc_get_perf_ctrs(cpu, &cppc_fi->prev_perf_fb_ctrs);
>>>>> +             if (ret)
>>>>> +                     pr_debug("%s: failed to read perf counters for cpu:%d: %d\n",
>>>>> +                              __func__, cpu, ret);
>>>>> +     }
>>>>> +}
>>>>> +
>>>>>    static void cppc_fie_kworker_init(void)
>>>>>    {
>>>>>         struct sched_attr attr = {
>>>>> @@ -281,6 +304,10 @@ static inline void cppc_cpufreq_cpu_fie_exit(struct cpufreq_policy *policy)
>>>>>    {
>>>>>    }
>>>>>
>>>>> +static inline void cppc_cpufreq_cpu_fie_resync(struct cpufreq_policy *policy)
>>>>> +{
>>>>> +}
>>>>> +
>>>>>    static inline void cppc_freq_invariance_init(void)
>>>>>    {
>>>>>    }
>>>>> @@ -735,6 +762,105 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
>>>>>         return ret;
>>>>>    }
>>>>>
>>>>> +/*
>>>>> + * With offline() defined, the cpufreq core keeps the policy alive when
>>>>> + * a CPU is hotplugged out.
>>>>> + */
>>>>> +static int cppc_cpufreq_cpu_offline(struct cpufreq_policy *policy)
>>>>> +{
>>>>> +     struct cppc_cpudata *cpu_data = policy->driver_data;
>>>>> +     struct cppc_perf_ctrls perf_ctrls = cpu_data->perf_ctrls;
>>>>> +     unsigned int cpu = policy->cpu;
>>>>> +     int ret;
>>>>> +
>>>>> +     /*
>>>>> +      * Request the lowest desired performance while the policy has no online
>>>>> +      * CPU. Zeroing MIN and MAX makes cppc_set_perf() leave them unchanged.
>>>>> +      */
>>>>> +     perf_ctrls.desired_perf = cpu_data->perf_caps.lowest_perf;
>>>>> +     perf_ctrls.min_perf = 0;
>>>>> +     perf_ctrls.max_perf = 0;
>>>>> +
>>>>> +     ret = cppc_set_perf(cpu, &perf_ctrls);
>>>>> +     if (ret)
>>>>> +             pr_debug("Err setting perf value:%u on CPU:%u. ret:%d\n",
>>>>> +                      cpu_data->perf_caps.lowest_perf, cpu, ret);
>>>>> +
>>>>> +     return 0;
>>>>> +}
>>>>> +
>>>>> +/*
>>>>> + * Raise MAX ahead of the full restore when the requested MIN is above the
>>>>> + * current MAX. cppc_set_perf() writes MIN before MAX, so the platform would
>>>>> + * otherwise briefly see MIN above MAX on registers not accessed through PCC.
>>>>> + * Lowering MAX is safe, as the MIN written first is never above it.
>>>>> + */
>>>>> +static int
>>>>> +cppc_cpufreq_prepare_perf_restore(unsigned int cpu,
>>>>> +                               const struct cppc_perf_ctrls *target)
>>>>> +{
>>>>> +     struct cppc_perf_ctrls cur = {}, prep = {};
>>>>> +     int ret;
>>>>> +
>>>>> +     ret = cppc_get_perf(cpu, &cur);
>>>>> +     if (ret)
>>>>> +             return ret;
>>>>> +
>>>>> +     if (!cur.max_perf || target->min_perf <= cur.max_perf)
>>>>> +             return 0;
>>>>> +
>>>>> +     prep.desired_perf = target->desired_perf;
>>>>> +     prep.min_perf = 0;      /* Zero leaves MIN unchanged. */
>>>>> +     prep.max_perf = target->max_perf;
>>>>> +
>>>>> +     return cppc_set_perf(cpu, &prep);
>>>>> +}
>>>>> +
>>>>> +/*
>>>>> + * Restore what the CPU may have lost while offline, as the platform may have
>>>>> + * disabled CPPC and reset the performance controls. Never fail the callback,
>>>>> + * or the core would free the policy and leave the CPU without cpufreq. The
>>>>> + * governor redoes the control writes, so they are best effort, unlike the
>>>>> + * enable, which only a later online() can retry.
>>>> Sorry, I don't quite understand the last sentence.
>>>
>>>
>>> Will rewrite in v5 as below:
>>>
>>>   Report failures without returning them, or the core would free the
>>>   policy and leave the CPU without cpufreq. A failed write to the
>>>   performance controls is not fatal, as the governor's next request
>>>   programs them again. A failed CPPC enable stops the restore, as the
>>>   writes that follow may not reach the platform.
>>>
>>>>> + */
>>>>> +static int cppc_cpufreq_cpu_online(struct cpufreq_policy *policy)
>>>>> +{
>>>>> +     struct cppc_cpudata *cpu_data = policy->driver_data;
>>>>> +     unsigned int cpu = policy->cpu;
>>>>> +     int ret;
>>>>> +
>>>>> +     cppc_cpufreq_cpu_fie_resync(policy);
>>>>> +
>>>>> +     ret = cppc_set_enable(cpu, true);
>>>>> +     if (ret && ret != -EOPNOTSUPP) {
>>>>> +             pr_warn("Failed to re-enable CPPC for CPU%u (%d)\n", cpu, ret);
>>>>> +             return 0;
>>>>> +     }
>>>>> +
>>>>> +     /*
>>>>> +      * The platform may reset the controls while the CPU is offline, so
>>>>> +      * recompute min/max, clamp desired_perf into range, and reprogram them.
>>>>> +      */
>>>>> +     cppc_cpufreq_update_perf_limits(cpu_data, policy);
>>>>> +
>>>>> +     cpu_data->perf_ctrls.desired_perf =
>>>>> +             clamp_t(u32, cpu_data->perf_ctrls.desired_perf,
>>>>> +                     cpu_data->perf_ctrls.min_perf,
>>>>> +                     cpu_data->perf_ctrls.max_perf);
>>>>> +
>>>>> +     ret = cppc_cpufreq_prepare_perf_restore(cpu, &cpu_data->perf_ctrls);
>>>> Actually, I don't quite think this is necessary?
>>>>
>>>> The motivation of doing this is fair (as mentioned in v3), but what's the
>>>> real consequence of transiently setting min_perf larger than max_perf?
>>>> Platforms should be able to handle this.
>>>>
>>>> Even if we have to fix it, it's supposed to be done in cppc_acpi.c.  The
>>>> current ABI wraps many things up.  cppc_get_perf() reads 4 values -
>>>> min_perf, max_perf, energy_perf, auto_sel.  cppc_set_perf writes 3
>>>> values - desired_perf, min_perf, max_perf.  The cppc_cpufreq driver would
>>>> be able to handle performance setting cleaner if those are separated.
>>>>
>>>> I don't suggest we complicate the driver for now?
>>>
>>> Agreed that it is not hotplug specific and can be done in the
>>> generic API.
>>>
>>> cppc_set_perf() would have to know the programmed MIN and MAX to pick
>>> the write order. Separate accessors would let it read only those two,
>>> but that would add a read before every write, including fast_switch().
>> fast_switch() doesn't have to touch min/max_perf, but it did at the moment.
>>> Caching what was last written would avoid that, but the platform can
>>> reset the registers while the CPU is offline or suspended.
>> Yeah, understood.  My question is still whether it's practically useful and
>> we're complicating this.
>>
>> Two reasons.
>>
>> 1. Platform should be able to handle min_perf being trasiently larger than
>> max_perf, otherwise it would be fragile.
>>
>> 2. It depends on the reset values of the two registers.
>>
>> I went over the ACPI Spec and didn't manage to find a descprition on what
>> the default/reset values of min/max perf registers should be.
>>
>> For a sensisble design, min_perf defaults to be 0 or lowest perf, and
>> max_perf defaults to be all 1s or highest perf.  In those cases, we are
>> safe to directly restore the saved values.
> 
> Hi Jie,

Hi Sumit, Jie

> 
> Agreed, those values would be safe, although they are not required
> reset defaults. A platform could reset MAX to a lower value, such as
> lowest_perf, while the saved policy MIN is higher.
> Restoring MIN first would then temporarily result in MIN greater than
> MAX on non-PCC systems.
> 
> This preparation was added in response to Christian’s v3 comment [1].
> I had already posted v5 [2] before receiving this reply, and it retains
> the preparation.

I basically agree(d) with Jie here when I commented on v3:
"I think cppc_set_perf() needs some prep first before using it on reset values.
We assume that reset value may be Autonomous Mode on, right? So we must never
write MIN>MAX and vice versa. I think we may just have to read and write
the 'otherwise-offending' value first on reset."
So I wanted to have this (as prep work) within cppc_set_perf() not in cppc-cpufreq,

> 
> Christian, are you okay with dropping it and restoring the controls
> directly with cppc_set_perf(), as in v3?
> Any general requirement for ordered MIN/MAX updates can then be handled
> in a separate CPPC core series.
> 
> [1] https://lore.kernel.org/lkml/40d72385-0b3f-46e5-9f32-a27be3842d7c@arm.com/
> [2] https://lore.kernel.org/lkml/20260916103820.1760297-1-sumitg@nvidia.com/

