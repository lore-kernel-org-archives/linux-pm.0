Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1082E2E282B;
	Sat, 19 Sep 2026 08:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789806733; cv=none; b=Vf04WRb3lAmcWQE7thHvCjzeJwkuV5cAWBckn9OOayiqJuebDeYOQnY3JKPJEb3b9XPalGFpqggjvPZaU6/q/DvJBCU2tIjsIe9xdVNHdoMesLienPZqfW3PKBoDoZJW/dOapAp5tnW1rQXHufoWzFx2bLtRHAF2dSRACkH7qCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789806733; c=relaxed/simple;
	bh=wdYQFRXNDuWduapYTVTYkRUXalJz/aLHHvHfGHMzWAI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ojENB4ZBOG3AoAOGWQdaeW5W0HSn+2TH+303uMycCuOB+5UyRgT44g611GXOn1rAHkXJWfTvjL2qwsq0GaAgosjtOl/B6VwA4UVKnSYEznXBwV8yiaF/LPFb46J400jYg5Gwz5jdK85/L06Fcd019sczl72aNTohMlg/gBoV0IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=rrDogGEz; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="rrDogGEz"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A39D5165C;
	Sat, 19 Sep 2026 01:32:04 -0700 (PDT)
Received: from [10.57.48.138] (unknown [10.57.48.138])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E08B63F86F;
	Sat, 19 Sep 2026 01:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1789806728; bh=wdYQFRXNDuWduapYTVTYkRUXalJz/aLHHvHfGHMzWAI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=rrDogGEz4wyDV71r6v6cZY6f1Y02Mmfc8y8jO9GfxBVlFD5ZCXC32ZK2DHvKlidB2
	 EmfgBjlQhfKbdBacIGdNnK264zGFa2BNbSdQ3jUKZtPMeUC6ay3ipxnATDLq5SGSTK
	 ki9+E5SL4Ma13iwbiy7Nu/DumcrGt/dvWVCDLP34=
Message-ID: <1be30b2b-e1e5-41ed-a0dc-0dd5ad3c47cd@arm.com>
Date: Sat, 19 Sep 2026 09:32:00 +0100
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
 <7d250745-bed7-4e75-a3b5-17565d8ff662@arm.com>
 <19b236de-ec1d-4abd-a78e-17e4faa3b75a@nvidia.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <19b236de-ec1d-4abd-a78e-17e4faa3b75a@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/17/26 19:59, Sumit Gupta wrote:
> 
> 
> On 17/09/26 18:38, Christian Loehle wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> On 9/17/26 12:01, Sumit Gupta wrote:
>>>
>>>
>>>>>>
>>>>>> On 8/7/2026 4:08 AM, Sumit Gupta wrote:
>>>>>>> Without online()/offline() callbacks, the cpufreq core fully tears
>>>>>>> down a policy during exit() when its last online CPU is offlined, and
>>>>>>> rebuilds it during init() when it comes back.
>>>>>>>
>>>>>>> Add lightweight online()/offline() callbacks so the core instead keeps
>>>>>>> the policy live and reuses the driver's cpu_data across CPU hotplug.
>>>>>>> This avoids re-reading the CPPC capabilities on every offline/online,
>>>>>>> making CPU hotplug faster.
>>>>>>>
>>>>>>> Move what init() and exit() did on hotplug into the new callbacks:
>>>>>>>
>>>>>>>      - offline() requests the lowest desired performance, as exit() did.
>>>>>>>      - online() re-enables CPPC and restores the performance controls, as
>>>>>>>        the platform may have reset them. Failures are logged, not returned,
>>>>>>>        as the core would free the policy.
>>>>>>>      - online() also resyncs the frequency invariance counters, so that the
>>>>>>>        first tick does not measure across the offline window.
>>>>>>>
>>>>>>> The restore in online() uses cppc_set_perf(), which writes MIN before
>>>>>>> MAX. If the platform lowered MAX while the CPU was offline, writing the
>>>>>>> saved MIN could briefly leave MIN above MAX on registers not accessed
>>>>>>> through PCC, as PCC delivers the writes in one transaction. Raise MAX
>>>>>>> ahead of the restore when the saved MIN is above it.
>>>>>>>
>>>>>>> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
>>>>>>> ---
>>>>>>>     drivers/cpufreq/cppc_cpufreq.c | 128 +++++++++++++++++++++++++++++++++
>>>>>>>     1 file changed, 128 insertions(+)
>>>>>>>
>>>>>>> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
>>>>>>> index 80893844353c..4b3da9a3e122 100644
>>>>>>> --- a/drivers/cpufreq/cppc_cpufreq.c
>>>>>>> +++ b/drivers/cpufreq/cppc_cpufreq.c
>>>>>>> @@ -211,6 +211,29 @@ static void cppc_cpufreq_cpu_fie_exit(struct cpufreq_policy *policy)
>>>>>>>          }
>>>>>>>     }
>>>>>>>
>>>>>>> +/*
>>>>>>> + * Resync the counter snapshot, as the policy is kept across CPU hotplug and
>>>>>>> + * the first tick after online would otherwise span the offline window.
>>>>>>> + */
>>>>>>> +static void cppc_cpufreq_cpu_fie_resync(struct cpufreq_policy *policy)
>>>>>>> +{
>>>>>>> +     struct cppc_freq_invariance *cppc_fi;
>>>>>>> +     int cpu, ret;
>>>>>>> +
>>>>>>> +     if (fie_disabled)
>>>>>>> +             return;
>>>>>>> +
>>>>>>> +     /* policy->cpus still holds related_cpus here, so skip offline CPUs. */
>>>>>>> +     for_each_cpu_and(cpu, policy->cpus, cpu_online_mask) {
>>>>>>> +             cppc_fi = &per_cpu(cppc_freq_inv, cpu);
>>>>>>> +
>>>>>>> +             ret = cppc_get_perf_ctrs(cpu, &cppc_fi->prev_perf_fb_ctrs);
>>>>>>> +             if (ret)
>>>>>>> +                     pr_debug("%s: failed to read perf counters for cpu:%d: %d\n",
>>>>>>> +                              __func__, cpu, ret);
>>>>>>> +     }
>>>>>>> +}
>>>>>>> +
>>>>>>>     static void cppc_fie_kworker_init(void)
>>>>>>>     {
>>>>>>>          struct sched_attr attr = {
>>>>>>> @@ -281,6 +304,10 @@ static inline void cppc_cpufreq_cpu_fie_exit(struct cpufreq_policy *policy)
>>>>>>>     {
>>>>>>>     }
>>>>>>>
>>>>>>> +static inline void cppc_cpufreq_cpu_fie_resync(struct cpufreq_policy *policy)
>>>>>>> +{
>>>>>>> +}
>>>>>>> +
>>>>>>>     static inline void cppc_freq_invariance_init(void)
>>>>>>>     {
>>>>>>>     }
>>>>>>> @@ -735,6 +762,105 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
>>>>>>>          return ret;
>>>>>>>     }
>>>>>>>
>>>>>>> +/*
>>>>>>> + * With offline() defined, the cpufreq core keeps the policy alive when
>>>>>>> + * a CPU is hotplugged out.
>>>>>>> + */
>>>>>>> +static int cppc_cpufreq_cpu_offline(struct cpufreq_policy *policy)
>>>>>>> +{
>>>>>>> +     struct cppc_cpudata *cpu_data = policy->driver_data;
>>>>>>> +     struct cppc_perf_ctrls perf_ctrls = cpu_data->perf_ctrls;
>>>>>>> +     unsigned int cpu = policy->cpu;
>>>>>>> +     int ret;
>>>>>>> +
>>>>>>> +     /*
>>>>>>> +      * Request the lowest desired performance while the policy has no online
>>>>>>> +      * CPU. Zeroing MIN and MAX makes cppc_set_perf() leave them unchanged.
>>>>>>> +      */
>>>>>>> +     perf_ctrls.desired_perf = cpu_data->perf_caps.lowest_perf;
>>>>>>> +     perf_ctrls.min_perf = 0;
>>>>>>> +     perf_ctrls.max_perf = 0;
>>>>>>> +
>>>>>>> +     ret = cppc_set_perf(cpu, &perf_ctrls);
>>>>>>> +     if (ret)
>>>>>>> +             pr_debug("Err setting perf value:%u on CPU:%u. ret:%d\n",
>>>>>>> +                      cpu_data->perf_caps.lowest_perf, cpu, ret);
>>>>>>> +
>>>>>>> +     return 0;
>>>>>>> +}
>>>>>>> +
>>>>>>> +/*
>>>>>>> + * Raise MAX ahead of the full restore when the requested MIN is above the
>>>>>>> + * current MAX. cppc_set_perf() writes MIN before MAX, so the platform would
>>>>>>> + * otherwise briefly see MIN above MAX on registers not accessed through PCC.
>>>>>>> + * Lowering MAX is safe, as the MIN written first is never above it.
>>>>>>> + */
>>>>>>> +static int
>>>>>>> +cppc_cpufreq_prepare_perf_restore(unsigned int cpu,
>>>>>>> +                               const struct cppc_perf_ctrls *target)
>>>>>>> +{
>>>>>>> +     struct cppc_perf_ctrls cur = {}, prep = {};
>>>>>>> +     int ret;
>>>>>>> +
>>>>>>> +     ret = cppc_get_perf(cpu, &cur);
>>>>>>> +     if (ret)
>>>>>>> +             return ret;
>>>>>>> +
>>>>>>> +     if (!cur.max_perf || target->min_perf <= cur.max_perf)
>>>>>>> +             return 0;
>>>>>>> +
>>>>>>> +     prep.desired_perf = target->desired_perf;
>>>>>>> +     prep.min_perf = 0;      /* Zero leaves MIN unchanged. */
>>>>>>> +     prep.max_perf = target->max_perf;
>>>>>>> +
>>>>>>> +     return cppc_set_perf(cpu, &prep);
>>>>>>> +}
>>>>>>> +
>>>>>>> +/*
>>>>>>> + * Restore what the CPU may have lost while offline, as the platform may have
>>>>>>> + * disabled CPPC and reset the performance controls. Never fail the callback,
>>>>>>> + * or the core would free the policy and leave the CPU without cpufreq. The
>>>>>>> + * governor redoes the control writes, so they are best effort, unlike the
>>>>>>> + * enable, which only a later online() can retry.
>>>>>> Sorry, I don't quite understand the last sentence.
>>>>>
>>>>>
>>>>> Will rewrite in v5 as below:
>>>>>
>>>>>    Report failures without returning them, or the core would free the
>>>>>    policy and leave the CPU without cpufreq. A failed write to the
>>>>>    performance controls is not fatal, as the governor's next request
>>>>>    programs them again. A failed CPPC enable stops the restore, as the
>>>>>    writes that follow may not reach the platform.
>>>>>
>>>>>>> + */
>>>>>>> +static int cppc_cpufreq_cpu_online(struct cpufreq_policy *policy)
>>>>>>> +{
>>>>>>> +     struct cppc_cpudata *cpu_data = policy->driver_data;
>>>>>>> +     unsigned int cpu = policy->cpu;
>>>>>>> +     int ret;
>>>>>>> +
>>>>>>> +     cppc_cpufreq_cpu_fie_resync(policy);
>>>>>>> +
>>>>>>> +     ret = cppc_set_enable(cpu, true);
>>>>>>> +     if (ret && ret != -EOPNOTSUPP) {
>>>>>>> +             pr_warn("Failed to re-enable CPPC for CPU%u (%d)\n", cpu, ret);
>>>>>>> +             return 0;
>>>>>>> +     }
>>>>>>> +
>>>>>>> +     /*
>>>>>>> +      * The platform may reset the controls while the CPU is offline, so
>>>>>>> +      * recompute min/max, clamp desired_perf into range, and reprogram them.
>>>>>>> +      */
>>>>>>> +     cppc_cpufreq_update_perf_limits(cpu_data, policy);
>>>>>>> +
>>>>>>> +     cpu_data->perf_ctrls.desired_perf =
>>>>>>> +             clamp_t(u32, cpu_data->perf_ctrls.desired_perf,
>>>>>>> +                     cpu_data->perf_ctrls.min_perf,
>>>>>>> +                     cpu_data->perf_ctrls.max_perf);
>>>>>>> +
>>>>>>> +     ret = cppc_cpufreq_prepare_perf_restore(cpu, &cpu_data->perf_ctrls);
>>>>>> Actually, I don't quite think this is necessary?
>>>>>>
>>>>>> The motivation of doing this is fair (as mentioned in v3), but what's the
>>>>>> real consequence of transiently setting min_perf larger than max_perf?
>>>>>> Platforms should be able to handle this.
>>>>>>
>>>>>> Even if we have to fix it, it's supposed to be done in cppc_acpi.c.  The
>>>>>> current ABI wraps many things up.  cppc_get_perf() reads 4 values -
>>>>>> min_perf, max_perf, energy_perf, auto_sel.  cppc_set_perf writes 3
>>>>>> values - desired_perf, min_perf, max_perf.  The cppc_cpufreq driver would
>>>>>> be able to handle performance setting cleaner if those are separated.
>>>>>>
>>>>>> I don't suggest we complicate the driver for now?
>>>>>
>>>>> Agreed that it is not hotplug specific and can be done in the
>>>>> generic API.
>>>>>
>>>>> cppc_set_perf() would have to know the programmed MIN and MAX to pick
>>>>> the write order. Separate accessors would let it read only those two,
>>>>> but that would add a read before every write, including fast_switch().
>>>> fast_switch() doesn't have to touch min/max_perf, but it did at the moment.
>>>>> Caching what was last written would avoid that, but the platform can
>>>>> reset the registers while the CPU is offline or suspended.
>>>> Yeah, understood.  My question is still whether it's practically useful and
>>>> we're complicating this.
>>>>
>>>> Two reasons.
>>>>
>>>> 1. Platform should be able to handle min_perf being trasiently larger than
>>>> max_perf, otherwise it would be fragile.
>>>>
>>>> 2. It depends on the reset values of the two registers.
>>>>
>>>> I went over the ACPI Spec and didn't manage to find a descprition on what
>>>> the default/reset values of min/max perf registers should be.
>>>>
>>>> For a sensisble design, min_perf defaults to be 0 or lowest perf, and
>>>> max_perf defaults to be all 1s or highest perf.  In those cases, we are
>>>> safe to directly restore the saved values.
>>>
>>> Hi Jie,
>>
>> Hi Sumit, Jie
>>
>>>
>>> Agreed, those values would be safe, although they are not required
>>> reset defaults. A platform could reset MAX to a lower value, such as
>>> lowest_perf, while the saved policy MIN is higher.
>>> Restoring MIN first would then temporarily result in MIN greater than
>>> MAX on non-PCC systems.
>>>
>>> This preparation was added in response to Christian’s v3 comment [1].
>>> I had already posted v5 [2] before receiving this reply, and it retains
>>> the preparation.
>>
>> I basically agree(d) with Jie here when I commented on v3:
>> "I think cppc_set_perf() needs some prep first before using it on reset values.
>> We assume that reset value may be Autonomous Mode on, right? So we must never
>> write MIN>MAX and vice versa. I think we may just have to read and write
>> the 'otherwise-offending' value first on reset."
>> So I wanted to have this (as prep work) within cppc_set_perf() not in cppc-cpufreq,
>>
>>>
>>> Christian, are you okay with dropping it and restoring the controls
>>> directly with cppc_set_perf(), as in v3?
>>> Any general requirement for ordered MIN/MAX updates can then be handled
>>> in a separate CPPC core series.
>>>
>>> [1] https://lore.kernel.org/lkml/40d72385-0b3f-46e5-9f32-a27be3842d7c@arm.com/
>>> [2] https://lore.kernel.org/lkml/20260916103820.1760297-1-sumitg@nvidia.com/
>>
> 
> Hi Christian, Jie,
> 
> Thanks for the clarification. I will drop the preparation from
> cppc_cpufreq in v6 and restore the controls directly using
> cppc_set_perf(). I will address the MIN/MAX write ordering in
> cppc_set_perf() in a separate series soon.

I don't quite understand why though, if anything it should land before
this hotplug series? (It really should've landed with MIN/MAX_PERF
support or at least to prepare for AUTOSEL support?)
I don't disagree with Jie that a sane platforms should be able to handle
transient violations, but IMO just adhering to the spec here (which
is absolutely doable) ensures that we never have to support a bunch of
quirks sometime in the future, when we do want to be more strict about
the spec.

In any case, after my v7 ACPI CPPC fixes land (fingers crossed this time),
it seems pretty straightforward (and even a tiny optimization at that!).
Here's what I had in mind, what do you think?
(Lightly tested, without seeing any violations. Needs some wiring
into your series and would appreciate testing with AUTOSEL.)


--------->8-------------


From 49b45c6508bd306155db6e8d516ed61d0afa1b31 Mon Sep 17 00:00:00 2001
From: Christian Loehle <christian.loehle@arm.com>
Date: Thu, 17 Sep 2026 23:14:36 +0100
Subject: [PATCH] ACPI: CPPC: Order performance-control updates

The ACPI specification requires Minimum Performance to remain below
Maximum Performance. When autonomous selection is disabled, Desired
Performance must also remain within those limits.

cppc_set_perf() writes the three controls in a fixed order. This can expose
an invalid tuple after firmware resets the controls or while policy bounds
move across the current desired value.

Read the live limits. Apply non-atomic updates in three phases: widen the
interval, update Desired Performance, then narrow it. Submit PCC controls
in each phase together. Keep the existing single-command path when the
complete tuple is in PCC, reject invalid requests, and stop after the first
failed access.

Make cppc_cpufreq fast switches include the limits only when they differ
from the last successful request. Invalidate the cache across resume and
after a failed request, since firmware may have reset the controls or an
earlier phase of a failed update may have reached the platform. Publish
slow-path limits only after the complete request succeeds.

At policy teardown, lower Minimum Performance together with Desired
Performance so the final request remains valid. On initialization, clamp
Desired Performance to the live interval left by firmware or an earlier
driver instance.

Fixes: 76531df5e13b ("ACPI: CPPC: Add min and max perf register writing support")
Signed-off-by: Christian Loehle <christian.loehle@arm.com>
---
 drivers/acpi/cppc_acpi.c       | 279 +++++++++++++++++++++++++--------
 drivers/cpufreq/cppc_cpufreq.c |  84 ++++++++--
 include/acpi/cppc_acpi.h       |   1 +
 3 files changed, 288 insertions(+), 76 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 80e2e6b32ce3..4f68ff3d8555 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -3471,11 +3471,200 @@ int cppc_get_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls)
 }
 EXPORT_SYMBOL_GPL(cppc_get_perf);
 
+enum cppc_perf_update {
+	CPPC_UPDATE_DESIRED	= BIT(0),
+	CPPC_UPDATE_MIN		= BIT(1),
+	CPPC_UPDATE_MAX		= BIT(2),
+};
+
+/* The caller holds pcc_lock for write if either limit is in PCC. */
+static int cppc_read_perf_limits(int cpu, u32 *min_perf, u32 *max_perf)
+{
+	struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpu);
+	struct cpc_register_resource *min_reg = &cpc_desc->cpc_regs[MIN_PERF];
+	struct cpc_register_resource *max_reg = &cpc_desc->cpc_regs[MAX_PERF];
+	u64 min, max;
+	int ret;
+
+	if (!cpc_is_readable(min_reg) || !cpc_is_readable(max_reg))
+		return -EOPNOTSUPP;
+
+	/* Firmware may have reset the controls, so read the live limits. */
+	if (CPC_IN_PCC(min_reg) || CPC_IN_PCC(max_reg)) {
+		ret = send_pcc_cmd(per_cpu(cpu_pcc_subspace_idx, cpu), CMD_READ);
+		if (ret)
+			return ret;
+	}
+
+	ret = cpc_read(cpu, min_reg, &min);
+	if (ret)
+		return ret;
+	ret = cpc_read(cpu, max_reg, &max);
+	if (ret)
+		return ret;
+	if (min > U32_MAX || max > U32_MAX)
+		return -EFAULT;
+	if (min > max)
+		return -EINVAL;
+
+	*min_perf = min;
+	*max_perf = max;
+	return 0;
+}
+
+static bool cppc_perf_updates_in_pcc(int cpu, unsigned int updates)
+{
+	struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpu);
+
+	return ((updates & CPPC_UPDATE_DESIRED) &&
+		CPC_IN_PCC(&cpc_desc->cpc_regs[DESIRED_PERF])) ||
+	       ((updates & CPPC_UPDATE_MIN) &&
+		CPC_IN_PCC(&cpc_desc->cpc_regs[MIN_PERF])) ||
+	       ((updates & CPPC_UPDATE_MAX) &&
+		CPC_IN_PCC(&cpc_desc->cpc_regs[MAX_PERF]));
+}
+
+/* The caller holds pcc_lock for write if an updated control is in PCC. */
+static int cppc_write_perf_controls(int cpu,
+				    struct cppc_perf_ctrls *perf_ctrls,
+				    unsigned int updates, bool sync_desired)
+{
+	struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpu);
+	struct cpc_register_resource *desired_reg =
+		&cpc_desc->cpc_regs[DESIRED_PERF];
+	struct cpc_register_resource *min_reg = &cpc_desc->cpc_regs[MIN_PERF];
+	struct cpc_register_resource *max_reg = &cpc_desc->cpc_regs[MAX_PERF];
+	struct cppc_pcc_data *pcc_ss_data;
+	int pcc_ss_id, ret;
+	bool pcc_update = false;
+
+	/* Direct writes precede the PCC command in each ordered phase. */
+	if ((updates & CPPC_UPDATE_DESIRED) && !CPC_IN_PCC(desired_reg)) {
+		ret = cpc_write(cpu, desired_reg, perf_ctrls->desired_perf);
+		if (ret)
+			return ret;
+	}
+	if ((updates & CPPC_UPDATE_MIN) && !CPC_IN_PCC(min_reg)) {
+		ret = cpc_write(cpu, min_reg, perf_ctrls->min_perf);
+		if (ret)
+			return ret;
+	}
+	if ((updates & CPPC_UPDATE_MAX) && !CPC_IN_PCC(max_reg)) {
+		ret = cpc_write(cpu, max_reg, perf_ctrls->max_perf);
+		if (ret)
+			return ret;
+	}
+
+	/* Keep Desired Performance valid in every intermediate PCC command. */
+	if (((updates & CPPC_UPDATE_DESIRED) || sync_desired) &&
+	    CPC_IN_PCC(desired_reg)) {
+		ret = cpc_write(cpu, desired_reg, perf_ctrls->desired_perf);
+		if (ret)
+			return ret;
+		pcc_update = true;
+	}
+	if ((updates & CPPC_UPDATE_MIN) && CPC_IN_PCC(min_reg)) {
+		ret = cpc_write(cpu, min_reg, perf_ctrls->min_perf);
+		if (ret)
+			return ret;
+		pcc_update = true;
+	}
+	if ((updates & CPPC_UPDATE_MAX) && CPC_IN_PCC(max_reg)) {
+		ret = cpc_write(cpu, max_reg, perf_ctrls->max_perf);
+		if (ret)
+			return ret;
+		pcc_update = true;
+	}
+	if (!pcc_update)
+		return 0;
+
+	pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpu);
+	pcc_ss_data = pcc_data[pcc_ss_id];
+	WRITE_ONCE(pcc_ss_data->pending_pcc_write_cmd, true);
+	cpc_desc->write_cmd_id = pcc_ss_data->pcc_write_cnt;
+	cpc_desc->write_cmd_status = 0;
+	return send_pcc_cmd(pcc_ss_id, CMD_WRITE);
+}
+
+/*
+ * Move from the live interval to the requested interval without exposing an
+ * invalid control tuple: widen, update Desired Performance, then narrow.
+ */
+static int cppc_write_ordered_perf(int cpu,
+				   struct cppc_perf_ctrls *perf_ctrls,
+				   bool desired_update, bool min_update,
+				   bool max_update)
+{
+	struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpu);
+	struct cpc_register_resource *desired_reg =
+		&cpc_desc->cpc_regs[DESIRED_PERF];
+	unsigned int widen = 0, narrow = 0;
+	u32 current_min, current_max;
+	u32 target_min, target_max;
+	bool desired_done = false;
+	bool sync_desired;
+	int ret;
+
+	ret = cppc_read_perf_limits(cpu, &current_min, &current_max);
+	if (ret)
+		return ret;
+
+	target_min = min_update ? perf_ctrls->min_perf : current_min;
+	target_max = max_update ? perf_ctrls->max_perf : current_max;
+	if (target_min > target_max)
+		return -EINVAL;
+	if (desired_update && perf_ctrls->desired_perf &&
+	    (perf_ctrls->desired_perf < target_min ||
+	     perf_ctrls->desired_perf > target_max))
+		return -EINVAL;
+
+	if (min_update) {
+		if (perf_ctrls->min_perf < current_min)
+			widen |= CPPC_UPDATE_MIN;
+		else
+			narrow |= CPPC_UPDATE_MIN;
+	}
+	if (max_update) {
+		if (perf_ctrls->max_perf > current_max)
+			widen |= CPPC_UPDATE_MAX;
+		else
+			narrow |= CPPC_UPDATE_MAX;
+	}
+
+	if (widen) {
+		sync_desired = desired_update && CPC_IN_PCC(desired_reg) &&
+			cppc_perf_updates_in_pcc(cpu, widen);
+		ret = cppc_write_perf_controls(cpu, perf_ctrls, widen,
+					       sync_desired);
+		if (ret)
+			return ret;
+		desired_done = sync_desired;
+	}
+
+	if (desired_update && !desired_done) {
+		ret = cppc_write_perf_controls(cpu, perf_ctrls,
+					       CPPC_UPDATE_DESIRED, false);
+		if (ret)
+			return ret;
+	}
+
+	if (!narrow)
+		return 0;
+
+	sync_desired = desired_update && CPC_IN_PCC(desired_reg) &&
+		cppc_perf_updates_in_pcc(cpu, narrow);
+	return cppc_write_perf_controls(cpu, perf_ctrls, narrow, sync_desired);
+}
+
 /**
  * cppc_set_perf - Set a CPU's performance controls.
  * @cpu: CPU for which to set performance controls.
  * @perf_ctrls: ptr to cppc_perf_ctrls. See cppc_acpi.h
  *
+ * Callers must serialize updates to the same CPU's performance controls.
+ * Limit updates preserve MIN <= MAX, including intermediate states on
+ * directly accessed registers. An error may leave an earlier write applied.
+ *
  * Return: 0 for success, -ERRNO otherwise.
  */
 int cppc_set_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls)
@@ -3502,6 +3691,15 @@ int cppc_set_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls)
 		     (perf_ctrls->min_perf || perf_ctrls->min_perf_valid);
 	max_update = cpc_is_writable(max_perf_reg) &&
 		     perf_ctrls->max_perf;
+	if (min_update && max_update &&
+	    perf_ctrls->min_perf > perf_ctrls->max_perf)
+		return -EINVAL;
+	if (desired_update && perf_ctrls->desired_perf &&
+	    min_update && max_update &&
+	    (perf_ctrls->desired_perf < perf_ctrls->min_perf ||
+	     perf_ctrls->desired_perf > perf_ctrls->max_perf))
+		return -EINVAL;
+
 	desired_pcc = desired_update && CPC_IN_PCC(desired_reg);
 	min_pcc = min_update && CPC_IN_PCC(min_perf_reg);
 	max_pcc = max_update && CPC_IN_PCC(max_perf_reg);
@@ -3531,9 +3729,10 @@ int cppc_set_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls)
 	 * A mixed layout cannot batch fallible direct writes safely: another
 	 * CPU's staged PCC values may no longer match if a direct write fails.
 	 * Serialize the complete mixed transaction and drain an older batch
-	 * before changing a direct control.
+	 * before changing a direct control. A single PCC limit update also
+	 * needs the exclusive lock to read and check the unchanged limit.
 	 */
-	if (mixed_layout) {
+	if (mixed_layout || (pcc_update && min_update != max_update)) {
 		down_write(&pcc_ss_data->pcc_lock);
 		if (pcc_ss_data->pending_pcc_write_cmd) {
 			ret = send_pcc_cmd(pcc_ss_id, CMD_WRITE);
@@ -3547,50 +3746,14 @@ int cppc_set_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls)
 				goto out_mixed_unlock;
 		}
 
-		if (desired_update && !desired_pcc) {
-			ret = cpc_write(cpu, desired_reg,
-					perf_ctrls->desired_perf);
-			if (ret)
-				goto out_mixed_unlock;
-		}
-		if (min_update && !min_pcc) {
-			ret = cpc_write(cpu, min_perf_reg,
-					perf_ctrls->min_perf);
-			if (ret)
-				goto out_mixed_unlock;
-		}
-		if (max_update && !max_pcc) {
-			ret = cpc_write(cpu, max_perf_reg,
-					perf_ctrls->max_perf);
-			if (ret)
-				goto out_mixed_unlock;
-		}
-
-		if (desired_pcc) {
-			ret = cpc_write(cpu, desired_reg,
-					perf_ctrls->desired_perf);
-			if (ret)
-				goto out_mixed_unlock;
-		}
-		if (min_pcc) {
-			ret = cpc_write(cpu, min_perf_reg,
-					perf_ctrls->min_perf);
-			if (ret)
-				goto out_mixed_unlock;
-		}
-		if (max_pcc) {
-			ret = cpc_write(cpu, max_perf_reg,
-					perf_ctrls->max_perf);
-			if (ret)
-				goto out_mixed_unlock;
-		}
-
-		if (pcc_update) {
-			WRITE_ONCE(pcc_ss_data->pending_pcc_write_cmd, true);
-			cpc_desc->write_cmd_id = pcc_ss_data->pcc_write_cnt;
-			cpc_desc->write_cmd_status = 0;
-			ret = send_pcc_cmd(pcc_ss_id, CMD_WRITE);
-		}
+		if (min_update || max_update)
+			ret = cppc_write_ordered_perf(cpu, perf_ctrls,
+						      desired_update,
+						      min_update, max_update);
+		else if (desired_update)
+			ret = cppc_write_perf_controls(cpu, perf_ctrls,
+						       CPPC_UPDATE_DESIRED,
+						       false);
 
 out_mixed_unlock:
 		up_write(&pcc_ss_data->pcc_lock);
@@ -3599,22 +3762,14 @@ int cppc_set_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls)
 
 	/* A request without PCC updates has no payload to coordinate. */
 	if (!pcc_update) {
-		if (desired_update) {
-			ret = cpc_write(cpu, desired_reg,
-					perf_ctrls->desired_perf);
-			if (ret)
-				return ret;
-		}
-		if (min_update) {
-			ret = cpc_write(cpu, min_perf_reg,
-					perf_ctrls->min_perf);
-			if (ret)
-				return ret;
-		}
-		if (max_update)
-			ret = cpc_write(cpu, max_perf_reg,
-					perf_ctrls->max_perf);
-		return ret;
+		if (min_update || max_update)
+			return cppc_write_ordered_perf(cpu, perf_ctrls,
+						       desired_update,
+						       min_update, max_update);
+		if (desired_update)
+			return cpc_write(cpu, desired_reg,
+					 perf_ctrls->desired_perf);
+		return 0;
 	}
 
 	down_read(&pcc_ss_data->pcc_lock); /* BEGIN Phase-I */
diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index 09e55bfdca88..5d79e275f79a 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -335,47 +335,77 @@ static int cppc_cpufreq_set_target(struct cpufreq_policy *policy,
 				   unsigned int relation)
 {
 	struct cppc_cpudata *cpu_data = policy->driver_data;
+	struct cppc_perf_ctrls perf_ctrls = {};
 	unsigned int cpu = policy->cpu;
 	struct cpufreq_freqs freqs;
 	int ret = 0;
 
-	cpu_data->perf_ctrls.desired_perf =
-			cppc_khz_to_perf(&cpu_data->perf_caps, target_freq);
-	cppc_cpufreq_update_perf_limits(cpu_data, policy);
+	perf_ctrls.desired_perf =
+		cppc_khz_to_perf(&cpu_data->perf_caps, target_freq);
+	cppc_cpufreq_get_perf_limits(cpu_data, policy, &perf_ctrls.min_perf,
+				     &perf_ctrls.max_perf);
+	perf_ctrls.min_perf_valid = true;
 
 	freqs.old = policy->cur;
 	freqs.new = target_freq;
 
 	cpufreq_freq_transition_begin(policy, &freqs);
-	ret = cppc_set_perf(cpu, &cpu_data->perf_ctrls);
+	ret = cppc_set_perf(cpu, &perf_ctrls);
 	cpufreq_freq_transition_end(policy, &freqs, ret != 0);
 
-	if (ret)
+	if (ret) {
+		WRITE_ONCE(cpu_data->perf_limits_valid, false);
 		pr_debug("Failed to set target on CPU:%d. ret:%d\n",
 			 cpu, ret);
+		return ret;
+	}
 
-	return ret;
+	WRITE_ONCE(cpu_data->perf_ctrls.desired_perf,
+		   perf_ctrls.desired_perf);
+	WRITE_ONCE(cpu_data->perf_ctrls.min_perf, perf_ctrls.min_perf);
+	WRITE_ONCE(cpu_data->perf_ctrls.max_perf, perf_ctrls.max_perf);
+	WRITE_ONCE(cpu_data->perf_limits_valid, true);
+
+	return 0;
 }
 
 static unsigned int cppc_cpufreq_fast_switch(struct cpufreq_policy *policy,
 					      unsigned int target_freq)
 {
 	struct cppc_cpudata *cpu_data = policy->driver_data;
+	struct cppc_perf_ctrls perf_ctrls = {};
 	unsigned int cpu = policy->cpu;
-	u32 desired_perf;
+	u32 desired_perf, min_perf, max_perf;
+	bool update_limits;
 	int ret;
 
 	desired_perf = cppc_khz_to_perf(&cpu_data->perf_caps, target_freq);
-	cpu_data->perf_ctrls.desired_perf = desired_perf;
-	cppc_cpufreq_update_perf_limits(cpu_data, policy);
+	perf_ctrls.desired_perf = desired_perf;
+	cppc_cpufreq_get_perf_limits(cpu_data, policy, &min_perf, &max_perf);
+	update_limits = !READ_ONCE(cpu_data->perf_limits_valid) ||
+			min_perf != READ_ONCE(cpu_data->perf_ctrls.min_perf) ||
+			max_perf != READ_ONCE(cpu_data->perf_ctrls.max_perf);
+	if (update_limits) {
+		perf_ctrls.min_perf = min_perf;
+		perf_ctrls.max_perf = max_perf;
+		perf_ctrls.min_perf_valid = true;
+	}
 
-	ret = cppc_set_perf(cpu, &cpu_data->perf_ctrls);
+	ret = cppc_set_perf(cpu, &perf_ctrls);
 	if (ret) {
+		WRITE_ONCE(cpu_data->perf_limits_valid, false);
 		pr_debug("Failed to set target on CPU:%d. ret:%d\n",
 			 cpu, ret);
 		return 0;
 	}
 
+	WRITE_ONCE(cpu_data->perf_ctrls.desired_perf, desired_perf);
+	if (update_limits) {
+		WRITE_ONCE(cpu_data->perf_ctrls.min_perf, min_perf);
+		WRITE_ONCE(cpu_data->perf_ctrls.max_perf, max_perf);
+		WRITE_ONCE(cpu_data->perf_limits_valid, true);
+	}
+
 	return target_freq;
 }
 
@@ -670,6 +700,7 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	unsigned int cpu = policy->cpu;
 	struct cppc_cpudata *cpu_data;
 	struct cppc_perf_caps *caps;
+	u32 desired_perf;
 	int ret;
 
 	cpu_data = cppc_cpufreq_get_cpu_data(cpu);
@@ -728,16 +759,26 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	if (caps->highest_perf > caps->nominal_perf)
 		policy->boost_supported = true;
 
-	/* Set policy->cur to max now. The governors will adjust later. */
-	policy->cur = cppc_perf_to_khz(caps, caps->highest_perf);
-	cpu_data->perf_ctrls.desired_perf =  caps->highest_perf;
+	/*
+	 * Keep the initial request within controls left by an earlier driver
+	 * instance or firmware. The governor will update the full tuple later.
+	 */
+	desired_perf = caps->highest_perf;
+	if (cpu_data->perf_ctrls.max_perf)
+		desired_perf = min(desired_perf, cpu_data->perf_ctrls.max_perf);
+	if (cpu_data->perf_ctrls.min_perf_valid)
+		desired_perf = max(desired_perf, cpu_data->perf_ctrls.min_perf);
+
+	policy->cur = cppc_perf_to_khz(caps, desired_perf);
+	cpu_data->perf_ctrls.desired_perf = desired_perf;
 
 	ret = cppc_set_perf(cpu, &cpu_data->perf_ctrls);
 	if (ret) {
 		pr_debug("Err setting perf value:%d on CPU:%d. ret:%d\n",
-			 caps->highest_perf, cpu, ret);
+			 desired_perf, cpu, ret);
 		goto out;
 	}
+	cpu_data->perf_limits_valid = true;
 
 	cppc_cpufreq_cpu_fie_init(policy);
 	return 0;
@@ -757,6 +798,8 @@ static void cppc_cpufreq_cpu_exit(struct cpufreq_policy *policy)
 	cppc_cpufreq_cpu_fie_exit(policy);
 
 	cpu_data->perf_ctrls.desired_perf = caps->lowest_perf;
+	cpu_data->perf_ctrls.min_perf = caps->lowest_perf;
+	cpu_data->perf_ctrls.min_perf_valid = true;
 
 	ret = cppc_set_perf(cpu, &cpu_data->perf_ctrls);
 	if (ret)
@@ -766,6 +809,16 @@ static void cppc_cpufreq_cpu_exit(struct cpufreq_policy *policy)
 	cppc_cpufreq_put_cpu_data(policy);
 }
 
+static int cppc_cpufreq_cpu_resume(struct cpufreq_policy *policy)
+{
+	struct cppc_cpudata *cpu_data = policy->driver_data;
+
+	/* The platform may have reset the controls during suspend. */
+	WRITE_ONCE(cpu_data->perf_limits_valid, false);
+
+	return 0;
+}
+
 static inline u64 get_delta(u64 t1, u64 t0)
 {
 	if (t1 > t0 || t0 > ~(u32)0)
@@ -922,12 +975,14 @@ static ssize_t store_auto_select(struct cpufreq_policy *policy,
 
 		ret = cppc_set_perf(policy->cpu, &cpu_data->perf_ctrls);
 		if (ret) {
+			WRITE_ONCE(cpu_data->perf_limits_valid, false);
 			cpu_data->perf_ctrls.min_perf = old_min_perf;
 			cpu_data->perf_ctrls.max_perf = old_max_perf;
 			cppc_set_auto_sel(policy->cpu, old_auto_sel);
 			cpu_data->perf_ctrls.auto_sel = old_auto_sel;
 			return ret;
 		}
+		WRITE_ONCE(cpu_data->perf_limits_valid, true);
 	}
 
 	return count;
@@ -1060,6 +1115,7 @@ static struct cpufreq_driver cppc_cpufreq_driver = {
 	.fast_switch = cppc_cpufreq_fast_switch,
 	.init = cppc_cpufreq_cpu_init,
 	.exit = cppc_cpufreq_cpu_exit,
+	.resume = cppc_cpufreq_cpu_resume,
 	.set_boost = cppc_cpufreq_set_boost,
 	.attr = cppc_cpufreq_attr,
 	.name = "cppc_cpufreq",
diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
index 3f0005abac64..fd1e891a045e 100644
--- a/include/acpi/cppc_acpi.h
+++ b/include/acpi/cppc_acpi.h
@@ -165,6 +165,7 @@ struct cppc_cpudata {
 	struct cppc_perf_fb_ctrs perf_fb_ctrs;
 	unsigned int shared_type;
 	cpumask_var_t shared_cpu_map;
+	bool perf_limits_valid;
 };
 
 #ifdef CONFIG_ACPI_CPPC_LIB
-- 
2.34.1

