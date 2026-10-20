Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792512711;
	b=wgc1A2g1Tl6CwstomOy4qFXWFWxXMMeuNZ2FVyrJhhX+LsGFY+YERLpywqK//Tbtgypt
	 SLgtXrjo5+BSnn67Zrin+Fenfs4RP3Kaoeu9IY2VcCSU31igPZoKMnZAuv+cn2xXBhJTK
	 g9RanlzYD+mLTfhjWKHfTa9YI68U3YPn2sPTi+7qmatyn49okIG/WUacF0XfLnk6pbmTq
	 L3+fDy8z+AAQC1E1U5xLueTrxmDmG/Ddfnt12PRDbtofahX7amT/2anw9Y6loz+QIFeZa
	 oSnR01jkigoX8zT+FEyVL46pdLpFL+TupdCr/Ys8yTfTM29A/Ix61L/rbRv+OTa4yZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792512711;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=Qd6+I1Wz5bOCO3hAh5nu1qluklfJQVsCoEPG0kv9fa4=;
	b=gU6uLxoTIyzgPpOgGaI//7yjnpvhCo1ylf6x6RpaTB5Ob+DmxTVtM/J1UXNYJPT0FVw/
	 rg98LLLCGoE6dEhTFmyI1c52mcbF/m/P/+mcE/FBgOGuLjyvDL+PHvF3g+B/gqtk9R+et
	 msdQfG67LDMAM1hG+aUpWMvwA4qkPE/k7OCxf4TryDNnBzgASED2gxbqxY0AAfIsH1AjY
	 Kf08WJl5jKJqafG9/NLAe0HVPtT8z1moOXt15T45a5wNNfvokS7N8B82vRL2F5efbXiiK
	 JfvOQ9mV2xgNuvzI3e/RpNKRrwgXYklS7EptPv5PeSJ0xNSyn2vIVZ7lDLi3S39wBOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b="Ylv/EMm1";
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EED3606A31E;
	Tue, 20 Oct 2026 16:11:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0EED3606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=Ylv/EMm1
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 273E82103;
	Tue, 20 Oct 2026 09:11:47 -0700 (PDT)
Received: from [10.0.128.106] (e127648.arm.com [10.0.128.106])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3A3FF3F7D8;
	Tue, 20 Oct 2026 09:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1792512710; bh=JvYp5A9GETNlfpQxlRjSH9/++M7IGKhy58KqiTyx1fs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Ylv/EMm1/P1GVqg6OHUXHzq3X8PhUt5hV70PB/zh0g5qc8LQcjqj+e4Jp54IoK7WN
	 KXZTHfJNPvs7ipTULxQRLULDfWGHNIzwGZsoDfByEXvmqSVjWS9maeRDgSxqjALrY4
	 7kDK3M96Vq3RJtwMQEWUUCkNkJUzjYfNWbVHNDP0=
Message-ID: <cf4e3153-ff80-4d0d-94f7-572a26f369c1@arm.com>
Date: Tue, 20 Oct 2026 17:11:43 +0100
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
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <20261020121846.691218-5-sumitg@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/20/26 13:18, Sumit Gupta wrote:
> Values written to OSPM-set CPPC registers via sysfs can be lost in two
> ways:
> 
>   - Across CPU hotplug: the platform may reset a CPU's registers while it
>     is offline.
>   - On driver unload: the value the driver wrote is left in the register
>     instead of returning to its pre-driver state.
> 
> Add a small table-driven mechanism that handles both:
> 
>   - On init(), capture each register's firmware value before the
>     driver programs anything.
>   - On offline(), read back each register's current value (whatever was
>     last set via sysfs) so it can be reapplied, then restore the firmware
>     value.

Sorry for the late suggestion, but all the ospm-set registers I think we can
save ourselves some headache by just saving these at sysfs_store (and not deal
with potential read-errors during offline/suspend (which actually may happen!).

>   - On online(), reapply the value captured at offline() after
>     reprogramming the performance controls. A failed write to the controls
>     does not skip the reapply, as no other path restores these registers.
>   - On exit(), nothing is needed, as the core calls offline() first, which
>     already restored the firmware values.
> 
> Cover the Autonomous Selection (auto_sel), Energy Performance Preference
> (EPP) and Autonomous Activity Window (auto_act_window) registers. Writes
> to EPP and auto_act_window only have meaning while auto_sel is enabled,
> so write auto_sel before them when enabling it and after them when
> disabling it. While autonomous selection stays disabled, the platform may
> ignore those writes.
> 
> Suggested-by: Pierre Gondois <pierre.gondois@arm.com>
> Link: https://lore.kernel.org/all/86780f97-29ee-4a72-b311-38c89434b707@arm.com/
> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> ---
>  drivers/cpufreq/cppc_cpufreq.c | 176 ++++++++++++++++++++++++++++++++-
>  1 file changed, 173 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index 9e1214e1cb0d..1b733f15d641 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -29,6 +29,166 @@
>  
>  static struct cpufreq_driver cppc_cpufreq_driver;
>  
> +/*
> + * OSPM-set CPPC registers tracked for save/restore. A value the OS wrote is
> + * reapplied from online() across CPU hotplug, and the firmware value is
> + * restored from offline().
> + *
> + * Autonomous Selection (auto_sel) is kept first, as the registers after it
> + * only have meaning while it is enabled.
> + */
> +enum cppc_saved_reg_id {
> +	CPPC_SAVED_AUTO_SEL,
> +	CPPC_SAVED_EPP,
> +	CPPC_SAVED_AUTO_ACT_WINDOW,
> +	CPPC_NR_SAVED_REGS,
> +};
> +
> +struct cppc_saved_reg {
> +	const char *name;
> +	int (*get)(int cpu, u64 *val);
> +	int (*set)(int cpu, u64 val);
> +};
> +
> +static const struct cppc_saved_reg cppc_saved_regs[CPPC_NR_SAVED_REGS] = {
> +	[CPPC_SAVED_AUTO_SEL] = {
> +		.name = "auto_sel",
> +		.get = cppc_get_auto_sel,
> +		.set = cppc_set_auto_sel,
> +	},
> +	[CPPC_SAVED_EPP] = {
> +		.name = "epp",
> +		.get = cppc_get_epp_perf,
> +		.set = cppc_set_epp,
> +	},
> +	[CPPC_SAVED_AUTO_ACT_WINDOW] = {
> +		.name = "auto_act_window",
> +		.get = cppc_get_auto_act_window,
> +		.set = cppc_set_auto_act_window,
> +	},
> +};
> +
> +enum cppc_saved_type {
> +	CPPC_SAVED_FIRMWARE,
> +	CPPC_SAVED_REQUESTED,
> +	CPPC_NR_SAVED_TYPES,
> +};
> +
> +/*
> + * Per-policy values saved for each register in cppc_saved_regs[], U64_MAX
> + * if there is none:
> + *   CPPC_SAVED_FIRMWARE  - value before the driver touched it, captured at
> + *                          init() and written back when the policy goes
> + *                          offline
> + *   CPPC_SAVED_REQUESTED - value in effect when the policy last went offline,
> + *                          reapplied at online()
> + */
> +struct cppc_policy_state {
> +	u64 regs[CPPC_NR_SAVED_REGS][CPPC_NR_SAVED_TYPES];
> +};
> +
> +static DEFINE_PER_CPU(struct cppc_policy_state, cppc_policy_state);
> +
> +/*
> + * Per-policy state is kept in the per-CPU variable of the first CPU the policy
> + * manages. related_cpus (the policy's full set of CPUs) never changes while the
> + * policy exists, so this CPU (unlike policy->cpu) stays the same across CPU
> + * hotplug, and every callback reaches the same copy.
> + */
> +static struct cppc_policy_state *
> +cppc_cpufreq_policy_state(struct cpufreq_policy *policy)
> +{
> +	const struct cpumask *policy_cpus = policy->related_cpus;
> +
> +	/*
> +	 * related_cpus is empty until the core fills it in after init(), so
> +	 * fall back to policy->cpus, which has the same first CPU.
> +	 */
> +	if (cpumask_empty(policy_cpus))
> +		policy_cpus = policy->cpus;
> +
> +	return &per_cpu(cppc_policy_state, cpumask_first(policy_cpus));
> +}
> +
> +/*
> + * Save each register's current value, either as the firmware value, captured
> + * before the driver programs anything, or as the requested value, to reapply
> + * at online().
> + */
> +static void cppc_cpufreq_save_regs(struct cpufreq_policy *policy,
> +				   enum cppc_saved_type saved_type)
> +{
> +	struct cppc_policy_state *st = cppc_cpufreq_policy_state(policy);
> +	unsigned int cpu = policy->cpu;
> +	u64 val;
> +	int i;
> +
> +	for (i = 0; i < CPPC_NR_SAVED_REGS; i++) {
> +		if (cppc_saved_regs[i].get(cpu, &val))
> +			val = U64_MAX;
> +
> +		st->regs[i][saved_type] = val;
> +		if (saved_type == CPPC_SAVED_FIRMWARE)
> +			st->regs[i][CPPC_SAVED_REQUESTED] = U64_MAX;
> +	}
> +}
> +
> +/*
> + * Write one tracked register, skipping it when there is no saved value.
> + * A register the platform does not allow writing is not an error.
> + */
> +static void cppc_cpufreq_write_saved_reg(unsigned int cpu,
> +					 enum cppc_saved_reg_id reg, u64 val,
> +					 enum cppc_saved_type saved_type)
> +{
> +	const char *op = (saved_type == CPPC_SAVED_FIRMWARE) ?
> +			 "restore firmware" : "reapply saved";
> +	int ret;
> +
> +	if (val == U64_MAX)
> +		return;
> +
> +	ret = cppc_saved_regs[reg].set(cpu, val);
> +	if (ret == -EOPNOTSUPP)
> +		return;
> +	if (ret)
> +		pr_debug("Failed to %s %s=%llu on CPU%u (%d)\n", op,
> +			 cppc_saved_regs[reg].name, val, cpu, ret);
> +}
> +
> +/*
> + * Apply the saved firmware or requested value to each tracked register.
> + *
> + * Write auto_sel first when the value being applied enables autonomous
> + * selection and last when it disables it, so the writes to the dependent
> + * registers can still take effect. While autonomous selection stays disabled,
> + * the platform may ignore those writes. Do not enable it temporarily to force
> + * them through.
> + */
> +static void cppc_cpufreq_apply_saved_regs(struct cpufreq_policy *policy,
> +					  enum cppc_saved_type saved_type)
> +{
> +	const struct cppc_policy_state *st = cppc_cpufreq_policy_state(policy);
> +	unsigned int cpu = policy->cpu;
> +	u64 auto_sel, val;
> +	int i;
> +
> +	auto_sel = st->regs[CPPC_SAVED_AUTO_SEL][saved_type];
> +
> +	if (auto_sel)
> +		cppc_cpufreq_write_saved_reg(cpu, CPPC_SAVED_AUTO_SEL, auto_sel,
> +					     saved_type);
> +
> +	for (i = CPPC_SAVED_AUTO_SEL + 1; i < CPPC_NR_SAVED_REGS; i++) {
> +		val = st->regs[i][saved_type];
> +		cppc_cpufreq_write_saved_reg(cpu, i, val, saved_type);
> +	}
> +
> +	if (!auto_sel)
> +		cppc_cpufreq_write_saved_reg(cpu, CPPC_SAVED_AUTO_SEL, auto_sel,
> +					     saved_type);
> +}
> +
>  #ifdef CONFIG_ACPI_CPPC_CPUFREQ_FIE
>  static enum {
>  	FIE_UNSET = -1,
> @@ -800,6 +960,8 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
>  	policy->cur = cppc_perf_to_khz(caps, desired_perf);
>  	cpu_data->perf_ctrls.desired_perf = desired_perf;
>  
> +	cppc_cpufreq_save_regs(policy, CPPC_SAVED_FIRMWARE);
> +
>  	ret = cppc_set_perf(cpu, &cpu_data->perf_ctrls);
>  	if (ret) {
>  		pr_debug("Err setting perf value:%d on CPU:%d. ret:%d\n",
> @@ -843,12 +1005,14 @@ static void cppc_cpufreq_cpu_exit(struct cpufreq_policy *policy)
>   *
>   * The platform may have disabled CPPC and reset the performance controls
>   * (desired, min and max performance) while the CPU was offline, so re-enable
> - * CPPC and reprogram them.
> + * CPPC and reprogram them. Also reapply the OSPM-set registers that offline()
> + * reset to firmware values.
>   *
>   * Report failures without returning them, or the core would free the policy and
>   * leave the CPU without cpufreq. A failed write to the performance controls is
> - * not fatal, as the governor's next request programs them again. A failed CPPC
> - * enable stops the restore, as the writes that follow may not reach the
> + * not fatal, as the governor's next request programs them again. The OSPM-set
> + * registers are reapplied even then, as no other path restores them. A failed
> + * CPPC enable skips both restores, as the writes that follow may not reach the
>   * platform.
>   */
>  static int cppc_cpufreq_cpu_online(struct cpufreq_policy *policy)
> @@ -896,6 +1060,8 @@ static int cppc_cpufreq_cpu_online(struct cpufreq_policy *policy)
>  		WRITE_ONCE(cpu_data->perf_limits_valid, true);
>  	}
>  
> +	cppc_cpufreq_apply_saved_regs(policy, CPPC_SAVED_REQUESTED);
> +
>  out_fie:
>  	/* Restart what offline() stopped, with a new counter snapshot. */
>  	cppc_cpufreq_cpu_fie_init(policy);
> @@ -915,6 +1081,10 @@ static int cppc_cpufreq_cpu_offline(struct cpufreq_policy *policy)
>  	unsigned int cpu = policy->cpu;
>  	int ret;
>  
> +	/* Save what the OS set, and leave the platform in its pre-driver state. */
> +	cppc_cpufreq_save_regs(policy, CPPC_SAVED_REQUESTED);
> +	cppc_cpufreq_apply_saved_regs(policy, CPPC_SAVED_FIRMWARE);
> +
>  	/*
>  	 * Stop the frequency invariance updates and cancel the pending work, so
>  	 * that no sample spans the offline window. online() restarts them with

