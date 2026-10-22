Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792675428;
	b=mhO+tQfCrL/WqHduk61rCucsRS/m7zEKGoPqw+wiRwL0EKEn3D6lKe/kS4m/Lr4fCgt+
	 SrMjyQbNAV4klD13gV87WAPtNZFNNs+jDC30aUPjkBrzV+6IM1LZsYABiCkCwD0+ZxBNW
	 1cglkd8usmHyU0ZoY/2hI6y5SMLNq+PkjVug9VRn9TRdXIv+a+NasSFxom9i/7u5nDyu1
	 WQLTKMD15foU559eUJng5mByMzN2Zr3Q0hziXxIRNja8L+kNFqmdRiWuZwH6DYgPVdU8H
	 wlDvfIa4IFeNoicACrrgIyIormBkk+8AiaLjrZCxjNbTurOg44naETP0trwOvpAasug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792675428;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=12LC/esxneVdO/5GUZrpWKlHIp3GMEgPsrPM+1ZINTg=;
	b=l9HD63wF6iPbuFnk0V5Uoh4vzFTZoCM669GbJ8MjUZkyQ/isCuBXmSHNE7hdqVzUrJYk
	 JAegIQWXaALcGRLHv1iWrRR1gtw64zcx5PoRsGfl1+LmbK6c+8DJJ/rqXukmAjRj1RHuQ
	 +7oum0n7QBduAiqq92hUIBlLeJtlhLDtmfaJQQcCidiiRbJcGq1sJnQfgkSXKSsd3putq
	 zFP49PED7YRexZNQU6M5Rek3OFuYANcNphdXr1CgcFQYXrjhu9TOc+vgVws0HeHIyoXF8
	 pAX1AmpPoC129VmkCKiFCwG3RglMuNDsP5VohLUJxr9M8G4pHRud2qE1UgT4FrSSwmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=eYY0vFTH;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88775606A31A;
	Thu, 22 Oct 2026 13:23:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 88775606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=eYY0vFTH
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 957402ECB;
	Thu, 22 Oct 2026 06:23:43 -0700 (PDT)
Received: from [10.0.128.106] (e127648.arm.com [10.0.128.106])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 22A3D3F673;
	Thu, 22 Oct 2026 06:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1792675426; bh=WqU2eJpPph5KVG4MZbfqnJc6+ggj/evOyVaqSFPY9PE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=eYY0vFTHGJ9h8Qd+xz4GDUzORkTuHJlfeIf8niStFP4i23eOl+nGfMFt4zGPtBIoJ
	 DLs6lajNjO3ttXj0TogsvcKyqkkOKoC1riNSJwjRivO5b0MNP8nM1iT9FegTsWiHKc
	 zqp3aCqB6yFPbZGrRqt6BL58ruQ/Zpbf1XiVKGyQ=
Message-ID: <85da866f-4fbb-4cf2-9376-3f7405e049ef@arm.com>
Date: Thu, 22 Oct 2026 14:23:39 +0100
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
Subject: Re: [PATCH v6 4/5] cpufreq: CPPC: Preserve OSPM-set registers across
 hotplug and unload
To: Sumit Gupta <sumitg@nvidia.com>, rafael@kernel.org,
 viresh.kumar@linaro.org, pierre.gondois@arm.com, ionela.voinescu@arm.com,
 zhenglifeng1@huawei.com, zhanjie9@hisilicon.com, lenb@kernel.org,
 ray.huang@amd.com, mario.limonciello@amd.com, perry.yuan@amd.com,
 kprateek.nayak@amd.com, maciej.wieczor-retman@intel.com,
 pawel.chmielewski@intel.com, linux-pm@vger.kernel.org,
 linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev,
 linux-kernel@vger.kernel.org
Cc: linux-tegra@vger.kernel.org, treding@nvidia.com, jonathanh@nvidia.com,
 vsethi@nvidia.com, ksitaraman@nvidia.com, sanjayc@nvidia.com,
 mochs@nvidia.com, bbasu@nvidia.com
References: <20261020121846.691218-1-sumitg@nvidia.com>
 <20261020121846.691218-5-sumitg@nvidia.com>
 <cf4e3153-ff80-4d0d-94f7-572a26f369c1@arm.com>
 <51747329-abe1-406a-aeae-94ebb7a35bf4@nvidia.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <51747329-abe1-406a-aeae-94ebb7a35bf4@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/22/26 11:10, Sumit Gupta wrote:
> Hi Christian,
> 
> 
> On 20/10/26 21:41, Christian Loehle wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> On 10/20/26 13:18, Sumit Gupta wrote:
>>> Values written to OSPM-set CPPC registers via sysfs can be lost in two
>>> ways:
>>>
>>>    - Across CPU hotplug: the platform may reset a CPU's registers while it
>>>      is offline.
>>>    - On driver unload: the value the driver wrote is left in the register
>>>      instead of returning to its pre-driver state.
>>>
>>> Add a small table-driven mechanism that handles both:
>>>
>>>    - On init(), capture each register's firmware value before the
>>>      driver programs anything.
>>>    - On offline(), read back each register's current value (whatever was
>>>      last set via sysfs) so it can be reapplied, then restore the firmware
>>>      value.
>>
>> Sorry for the late suggestion, but all the ospm-set registers I think we can
>> save ourselves some headache by just saving these at sysfs_store (and not deal
>> with potential read-errors during offline/suspend (which actually may happen!).
>>
> 
> v1 [1] saved the values at store time. In v2 I switched to reading
> them in offline(), following the flow discussed in [2]. One read there
> covers every store handler and the pending boot parameter series.

Ah right!

> 
> But a read error in offline() or suspend() drops the request. A failed
> reapply in online() can also leave the register at its firmware or reset
> value, which the next offline() or suspend() then saves over the
> request. Saving at store time keeps the request in both cases.

Yup, that's more reasonable IMO

> 
> We could combine the two. Keep the policy across hotplug and the
> firmware restore in offline() from v2, and save the requested values
> at store time as in v1:
>  - init() saves the firmware values and uses them as the initial
>    requested values.

Yes, I guess if we cannot read the initial values at init() (or first
autosel enable?) there's no point in letting the driver initialize
(or allowing autosel=1 respectively)?

>  - Each sysfs store updates the requested value after it succeeds.>    The boot parameter series will do the same.
>  - offline() and suspend() restore the firmware values without
>    reading the registers.
>  - online() and resume() reapply the requested values. If that fails,
>    the request is kept for a later online().
> 
> Does this sound fine and keep the intent of the earlier discussion?
> I will respin accordingly.


To me it does, I have an updated version for my 1/5 I'll post as soon
as I verify it works on an AMD platform too!
Thanks!

> 
> Thanks,
> Sumit
> 
> [1] https://lore.kernel.org/lkml/20260623095403.3407436-1-sumitg@nvidia.com/
> [2] https://lore.kernel.org/lkml/15def9ce-abbd-4ef5-bb8f-0c55b42a0181@arm.com/
> 
> Thanks,
> Sumit
> 
> 
>>>    - On online(), reapply the value captured at offline() after
>>>      reprogramming the performance controls. A failed write to the controls
>>>      does not skip the reapply, as no other path restores these registers.
>>>    - On exit(), nothing is needed, as the core calls offline() first, which
>>>      already restored the firmware values.
>>>
>>> Cover the Autonomous Selection (auto_sel), Energy Performance Preference
>>> (EPP) and Autonomous Activity Window (auto_act_window) registers. Writes
>>> to EPP and auto_act_window only have meaning while auto_sel is enabled,
>>> so write auto_sel before them when enabling it and after them when
>>> disabling it. While autonomous selection stays disabled, the platform may
>>> ignore those writes.
>>>
>>> Suggested-by: Pierre Gondois <pierre.gondois@arm.com>
>>> Link: https://lore.kernel.org/all/86780f97-29ee-4a72-b311-38c89434b707@arm.com/
>>> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
>>> ---
>>>   drivers/cpufreq/cppc_cpufreq.c | 176 ++++++++++++++++++++++++++++++++-
>>>   1 file changed, 173 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
>>> index 9e1214e1cb0d..1b733f15d641 100644
>>> --- a/drivers/cpufreq/cppc_cpufreq.c
>>> +++ b/drivers/cpufreq/cppc_cpufreq.c
>>> @@ -29,6 +29,166 @@
>>>
>>>   static struct cpufreq_driver cppc_cpufreq_driver;
>>>
>>> +/*
>>> + * OSPM-set CPPC registers tracked for save/restore. A value the OS wrote is
>>> + * reapplied from online() across CPU hotplug, and the firmware value is
>>> + * restored from offline().
>>> + *
>>> + * Autonomous Selection (auto_sel) is kept first, as the registers after it
>>> + * only have meaning while it is enabled.
>>> + */
>>> +enum cppc_saved_reg_id {
>>> +     CPPC_SAVED_AUTO_SEL,
>>> +     CPPC_SAVED_EPP,
>>> +     CPPC_SAVED_AUTO_ACT_WINDOW,
>>> +     CPPC_NR_SAVED_REGS,
>>> +};
>>> +
>>> +struct cppc_saved_reg {
>>> +     const char *name;
>>> +     int (*get)(int cpu, u64 *val);
>>> +     int (*set)(int cpu, u64 val);
>>> +};
>>> +
>>> +static const struct cppc_saved_reg cppc_saved_regs[CPPC_NR_SAVED_REGS] = {
>>> +     [CPPC_SAVED_AUTO_SEL] = {
>>> +             .name = "auto_sel",
>>> +             .get = cppc_get_auto_sel,
>>> +             .set = cppc_set_auto_sel,
>>> +     },
>>> +     [CPPC_SAVED_EPP] = {
>>> +             .name = "epp",
>>> +             .get = cppc_get_epp_perf,
>>> +             .set = cppc_set_epp,
>>> +     },
>>> +     [CPPC_SAVED_AUTO_ACT_WINDOW] = {
>>> +             .name = "auto_act_window",
>>> +             .get = cppc_get_auto_act_window,
>>> +             .set = cppc_set_auto_act_window,
>>> +     },
>>> +};
>>> +
>>> +enum cppc_saved_type {
>>> +     CPPC_SAVED_FIRMWARE,
>>> +     CPPC_SAVED_REQUESTED,
>>> +     CPPC_NR_SAVED_TYPES,
>>> +};
>>> +
>>> +/*
>>> + * Per-policy values saved for each register in cppc_saved_regs[], U64_MAX
>>> + * if there is none:
>>> + *   CPPC_SAVED_FIRMWARE  - value before the driver touched it, captured at
>>> + *                          init() and written back when the policy goes
>>> + *                          offline
>>> + *   CPPC_SAVED_REQUESTED - value in effect when the policy last went offline,
>>> + *                          reapplied at online()
>>> + */
>>> +struct cppc_policy_state {
>>> +     u64 regs[CPPC_NR_SAVED_REGS][CPPC_NR_SAVED_TYPES];
>>> +};
>>> +
>>> +static DEFINE_PER_CPU(struct cppc_policy_state, cppc_policy_state);
>>> +
>>> +/*
>>> + * Per-policy state is kept in the per-CPU variable of the first CPU the policy
>>> + * manages. related_cpus (the policy's full set of CPUs) never changes while the
>>> + * policy exists, so this CPU (unlike policy->cpu) stays the same across CPU
>>> + * hotplug, and every callback reaches the same copy.
>>> + */
>>> +static struct cppc_policy_state *
>>> +cppc_cpufreq_policy_state(struct cpufreq_policy *policy)
>>> +{
>>> +     const struct cpumask *policy_cpus = policy->related_cpus;
>>> +
>>> +     /*
>>> +      * related_cpus is empty until the core fills it in after init(), so
>>> +      * fall back to policy->cpus, which has the same first CPU.
>>> +      */
>>> +     if (cpumask_empty(policy_cpus))
>>> +             policy_cpus = policy->cpus;
>>> +
>>> +     return &per_cpu(cppc_policy_state, cpumask_first(policy_cpus));
>>> +}
>>> +
>>> +/*
>>> + * Save each register's current value, either as the firmware value, captured
>>> + * before the driver programs anything, or as the requested value, to reapply
>>> + * at online().
>>> + */
>>> +static void cppc_cpufreq_save_regs(struct cpufreq_policy *policy,
>>> +                                enum cppc_saved_type saved_type)
>>> +{
>>> +     struct cppc_policy_state *st = cppc_cpufreq_policy_state(policy);
>>> +     unsigned int cpu = policy->cpu;
>>> +     u64 val;
>>> +     int i;
>>> +
>>> +     for (i = 0; i < CPPC_NR_SAVED_REGS; i++) {
>>> +             if (cppc_saved_regs[i].get(cpu, &val))
>>> +                     val = U64_MAX;
>>> +
>>> +             st->regs[i][saved_type] = val;
>>> +             if (saved_type == CPPC_SAVED_FIRMWARE)
>>> +                     st->regs[i][CPPC_SAVED_REQUESTED] = U64_MAX;
>>> +     }
>>> +}
>>> +
>>> +/*
>>> + * Write one tracked register, skipping it when there is no saved value.
>>> + * A register the platform does not allow writing is not an error.
>>> + */
>>> +static void cppc_cpufreq_write_saved_reg(unsigned int cpu,
>>> +                                      enum cppc_saved_reg_id reg, u64 val,
>>> +                                      enum cppc_saved_type saved_type)
>>> +{
>>> +     const char *op = (saved_type == CPPC_SAVED_FIRMWARE) ?
>>> +                      "restore firmware" : "reapply saved";
>>> +     int ret;
>>> +
>>> +     if (val == U64_MAX)
>>> +             return;
>>> +
>>> +     ret = cppc_saved_regs[reg].set(cpu, val);
>>> +     if (ret == -EOPNOTSUPP)
>>> +             return;
>>> +     if (ret)
>>> +             pr_debug("Failed to %s %s=%llu on CPU%u (%d)\n", op,
>>> +                      cppc_saved_regs[reg].name, val, cpu, ret);
>>> +}
>>> +
>>> +/*
>>> + * Apply the saved firmware or requested value to each tracked register.
>>> + *
>>> + * Write auto_sel first when the value being applied enables autonomous
>>> + * selection and last when it disables it, so the writes to the dependent
>>> + * registers can still take effect. While autonomous selection stays disabled,
>>> + * the platform may ignore those writes. Do not enable it temporarily to force
>>> + * them through.
>>> + */
>>> +static void cppc_cpufreq_apply_saved_regs(struct cpufreq_policy *policy,
>>> +                                       enum cppc_saved_type saved_type)
>>> +{
>>> +     const struct cppc_policy_state *st = cppc_cpufreq_policy_state(policy);
>>> +     unsigned int cpu = policy->cpu;
>>> +     u64 auto_sel, val;
>>> +     int i;
>>> +
>>> +     auto_sel = st->regs[CPPC_SAVED_AUTO_SEL][saved_type];
>>> +
>>> +     if (auto_sel)
>>> +             cppc_cpufreq_write_saved_reg(cpu, CPPC_SAVED_AUTO_SEL, auto_sel,
>>> +                                          saved_type);
>>> +
>>> +     for (i = CPPC_SAVED_AUTO_SEL + 1; i < CPPC_NR_SAVED_REGS; i++) {
>>> +             val = st->regs[i][saved_type];
>>> +             cppc_cpufreq_write_saved_reg(cpu, i, val, saved_type);
>>> +     }
>>> +
>>> +     if (!auto_sel)
>>> +             cppc_cpufreq_write_saved_reg(cpu, CPPC_SAVED_AUTO_SEL, auto_sel,
>>> +                                          saved_type);
>>> +}
>>> +
>>>   #ifdef CONFIG_ACPI_CPPC_CPUFREQ_FIE
>>>   static enum {
>>>        FIE_UNSET = -1,
>>> @@ -800,6 +960,8 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
>>>        policy->cur = cppc_perf_to_khz(caps, desired_perf);
>>>        cpu_data->perf_ctrls.desired_perf = desired_perf;
>>>
>>> +     cppc_cpufreq_save_regs(policy, CPPC_SAVED_FIRMWARE);
>>> +
>>>        ret = cppc_set_perf(cpu, &cpu_data->perf_ctrls);
>>>        if (ret) {
>>>                pr_debug("Err setting perf value:%d on CPU:%d. ret:%d\n",
>>> @@ -843,12 +1005,14 @@ static void cppc_cpufreq_cpu_exit(struct cpufreq_policy *policy)
>>>    *
>>>    * The platform may have disabled CPPC and reset the performance controls
>>>    * (desired, min and max performance) while the CPU was offline, so re-enable
>>> - * CPPC and reprogram them.
>>> + * CPPC and reprogram them. Also reapply the OSPM-set registers that offline()
>>> + * reset to firmware values.
>>>    *
>>>    * Report failures without returning them, or the core would free the policy and
>>>    * leave the CPU without cpufreq. A failed write to the performance controls is
>>> - * not fatal, as the governor's next request programs them again. A failed CPPC
>>> - * enable stops the restore, as the writes that follow may not reach the
>>> + * not fatal, as the governor's next request programs them again. The OSPM-set
>>> + * registers are reapplied even then, as no other path restores them. A failed
>>> + * CPPC enable skips both restores, as the writes that follow may not reach the
>>>    * platform.
>>>    */
>>>   static int cppc_cpufreq_cpu_online(struct cpufreq_policy *policy)
>>> @@ -896,6 +1060,8 @@ static int cppc_cpufreq_cpu_online(struct cpufreq_policy *policy)
>>>                WRITE_ONCE(cpu_data->perf_limits_valid, true);
>>>        }
>>>
>>> +     cppc_cpufreq_apply_saved_regs(policy, CPPC_SAVED_REQUESTED);
>>> +
>>>   out_fie:
>>>        /* Restart what offline() stopped, with a new counter snapshot. */
>>>        cppc_cpufreq_cpu_fie_init(policy);
>>> @@ -915,6 +1081,10 @@ static int cppc_cpufreq_cpu_offline(struct cpufreq_policy *policy)
>>>        unsigned int cpu = policy->cpu;
>>>        int ret;
>>>
>>> +     /* Save what the OS set, and leave the platform in its pre-driver state. */
>>> +     cppc_cpufreq_save_regs(policy, CPPC_SAVED_REQUESTED);
>>> +     cppc_cpufreq_apply_saved_regs(policy, CPPC_SAVED_FIRMWARE);
>>> +
>>>        /*
>>>         * Stop the frequency invariance updates and cancel the pending work, so
>>>         * that no sample spans the offline window. online() restarts them with
>>
> 

