Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D7444BCAC9;
	Wed, 22 Jul 2026 10:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784715441; cv=none; b=BQThEeXEPm7e6FFjH/URzp4XHJlOvCcOU4TMw0qaax3HOqSNVAQuFZ2gUnd99xtZ2FcNnh2JFCoYr5BgUtZv+7BrhrvEcdFoIm30jC3xZP2rmrasQ8xE0yXJ0Xmcyb5jS7ImAakWCxx3mPP90glZ1Sr76pJWRYZouOSG3qPvTjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784715441; c=relaxed/simple;
	bh=2Dj1VaD4BY2dX/nTVm6jQGifDmA8qdzt/Z3Oct/vIe8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t3J9LuWLT2PoT0Fg7mkCMJ5pAaBj+aYZDvrsvMliUzQkWzaybAuLn4B+C1H8fiA89lmIg4a5ZqJ+Gzg93eANpGk7jj8QVWEZNuuum6MLOJYQKorK55o/v/V/vt7bcZr0EpWC3cKEe7HeF9YqTBKpLlVw1EGxO1ob5Urmsdmw3Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=ZRPqH4xh; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="ZRPqH4xh"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6B5E61595;
	Wed, 22 Jul 2026 03:17:13 -0700 (PDT)
Received: from [10.1.39.91] (e127648.arm.com [10.1.39.91])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 269323F58B;
	Wed, 22 Jul 2026 03:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1784715437; bh=2Dj1VaD4BY2dX/nTVm6jQGifDmA8qdzt/Z3Oct/vIe8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZRPqH4xhwfKTJ6KtnkAsbo9gTuLjPa74DAmNzgFG6mC13yJ39Zl9gLpC405MWGAl+
	 Nab73R2sOYNAV7gdONDmoiEwDF1o1v/zzSpZYYgfXFmCSaP9GQb6z6MtramjwtqzwC
	 u3Q4Ph6kYRBAHqWxWZ7LLmyJjo98cHlgd3ALVzuU=
Message-ID: <61942bf5-2ccc-4045-95e4-7fe78615e7a9@arm.com>
Date: Wed, 22 Jul 2026 11:17:13 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] cpufreq: CPPC: Preserve OSPM-set registers across
 hotplug and unload
To: Sumit Gupta <sumitg@nvidia.com>, rafael@kernel.org,
 viresh.kumar@linaro.org, pierre.gondois@arm.com, ionela.voinescu@arm.com,
 zhenglifeng1@huawei.com, zhanjie9@hisilicon.com, saket.dumbre@intel.com,
 lenb@kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev,
 linux-tegra@vger.kernel.org
Cc: treding@nvidia.com, jonathanh@nvidia.com, vsethi@nvidia.com,
 ksitaraman@nvidia.com, sanjayc@nvidia.com, mochs@nvidia.com, bbasu@nvidia.com
References: <20260716153820.2007095-1-sumitg@nvidia.com>
 <20260716153820.2007095-4-sumitg@nvidia.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <20260716153820.2007095-4-sumitg@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Sumit

On 7/16/26 16:38, Sumit Gupta wrote:
> Values written to OSPM-set CPPC registers (via sysfs or the autonomous
> boot parameter) can be lost in two ways:
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
>     last set via sysfs or the boot parameter) so it can be reapplied, then
>     restore the firmware value.
>   - On online(), reapply the value captured at offline().
> 
> Cover the Autonomous Selection (auto_sel), Energy Performance Preference
> (EPP) and Autonomous Activity Window (auto_act_window) registers.
> 
> Suggested-by: Pierre Gondois <pierre.gondois@arm.com>
> Link: https://lore.kernel.org/all/86780f97-29ee-4a72-b311-38c89434b707@arm.com/
> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> ---
>  drivers/cpufreq/cppc_cpufreq.c | 130 +++++++++++++++++++++++++++++++++
>  1 file changed, 130 insertions(+)
> 
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index 432c6a6288a7..9c88512d635c 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -28,6 +28,123 @@
>  
>  static struct cpufreq_driver cppc_cpufreq_driver;
>  
> +/*
> + * OSPM-set CPPC registers tracked for save/restore. A value set via sysfs or
> + * the autonomous boot parameter is reapplied from online() across CPU
> + * hotplug, and the firmware value is restored from offline().
> + */
> +enum cppc_saved_reg_id {
> +	CPPC_SAVED_AUTO_SEL,
> +	CPPC_SAVED_EPP,
> +	CPPC_SAVED_AUTO_ACT_WINDOW,
> +	CPPC_NR_SAVED_REGS,
> +};
> +
> +struct cppc_saved_reg {
> +	int (*get)(int cpu, u64 *val);
> +	int (*set)(int cpu, u64 val);
> +};
> +
> +static const struct cppc_saved_reg cppc_saved_regs[CPPC_NR_SAVED_REGS] = {
> +	[CPPC_SAVED_AUTO_SEL] = {
> +		cppc_get_auto_sel_u64, cppc_set_auto_sel_u64,
> +	},
> +	[CPPC_SAVED_EPP] = {
> +		cppc_get_epp_perf, cppc_set_epp,
> +	},
> +	[CPPC_SAVED_AUTO_ACT_WINDOW] = {
> +		cppc_get_auto_act_window, cppc_set_auto_act_window,
> +	},
> +};
> +
> +/*
> + * Per-policy saved state for each register in cppc_saved_regs[]:
> + *   firmware_val  - value before the driver touched it, captured at init()
> + *                   and restored while the policy is offline. U64_MAX if it
> + *                   could not be read
> + *   requested_val - value in effect when the policy last went offline,
> + *                   reapplied at online(). U64_MAX if none
> + */
> +struct cppc_saved_state {
> +	u64 firmware_val;
> +	u64 requested_val;
> +};
> +
> +static DEFINE_PER_CPU(struct cppc_saved_state[CPPC_NR_SAVED_REGS], cppc_saved_state);
> +
> +/*
> + * Return this policy's saved state. Each policy keeps a single copy, stored in
> + * the per-CPU variable of the first CPU it manages. related_cpus (the policy's
> + * full set of CPUs) never changes while it exists, so this CPU (unlike
> + * policy->cpu) stays the same across CPU hotplug, and every callback reaches
> + * the same copy.
> + */
> +static struct cppc_saved_state *cppc_cpufreq_policy_saved_state(struct cpufreq_policy *policy)
> +{
> +	const struct cpumask *policy_cpus = policy->related_cpus;
> +
> +	/*
> +	 * related_cpus is empty until the core fills it in after init(). Until
> +	 * then, fall back to policy->cpus, which has the same first CPU.
> +	 */
> +	if (cpumask_empty(policy_cpus))
> +		policy_cpus = policy->cpus;
> +
> +	return per_cpu(cppc_saved_state, cpumask_first(policy_cpus));
> +}
> +
> +/*
> + * Capture each register's firmware value before the driver programs anything.
> + */
> +static void cppc_cpufreq_save_firmware_regs(struct cpufreq_policy *policy)
> +{
> +	struct cppc_saved_state *st = cppc_cpufreq_policy_saved_state(policy);
> +	unsigned int cpu = policy->cpu;
> +	u64 val;
> +	int i;
> +
> +	for (i = 0; i < CPPC_NR_SAVED_REGS; i++) {
> +		if (cppc_saved_regs[i].get(cpu, &val))
> +			val = U64_MAX;
> +		st[i].firmware_val = val;
> +		st[i].requested_val = U64_MAX;
> +	}
> +}
> +
> +/*
> + * Save each register's current value so online() can later reapply it, then
> + * restore the firmware value to leave the platform in its pre-driver state.
> + */
> +static void
> +cppc_cpufreq_save_req_and_restore_firmware_regs(struct cpufreq_policy *policy)
> +{
> +	struct cppc_saved_state *st = cppc_cpufreq_policy_saved_state(policy);
> +	unsigned int cpu = policy->cpu;
> +	u64 val;
> +	int i;
> +
> +	for (i = 0; i < CPPC_NR_SAVED_REGS; i++) {
> +		if (!cppc_saved_regs[i].get(cpu, &val))
> +			st[i].requested_val = val;
> +		if (st[i].firmware_val != U64_MAX)
> +			cppc_saved_regs[i].set(cpu, st[i].firmware_val);
> +	}
> +}
> +
> +/*
> + * Reapply each register's requested value that offline() saved.
> + */
> +static void cppc_cpufreq_reapply_requested_regs(struct cpufreq_policy *policy)
> +{
> +	struct cppc_saved_state *st = cppc_cpufreq_policy_saved_state(policy);
> +	unsigned int cpu = policy->cpu;
> +	int i;
> +
> +	for (i = 0; i < CPPC_NR_SAVED_REGS; i++)
> +		if (st[i].requested_val != U64_MAX)
> +			cppc_saved_regs[i].set(cpu, st[i].requested_val);
> +}
> +
>  #ifdef CONFIG_ACPI_CPPC_CPUFREQ_FIE
>  static enum {
>  	FIE_UNSET = -1,
> @@ -707,6 +824,8 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
>  	policy->cur = cppc_perf_to_khz(caps, caps->highest_perf);
>  	cpu_data->perf_ctrls.desired_perf =  caps->highest_perf;
>  
> +	cppc_cpufreq_save_firmware_regs(policy);
> +
>  	ret = cppc_set_perf(cpu, &cpu_data->perf_ctrls);
>  	if (ret) {
>  		pr_debug("Err setting perf value:%d on CPU:%d. ret:%d\n",
> @@ -725,15 +844,24 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
>  /*
>   * With offline() defined, the cpufreq core keeps the policy alive when
>   * a CPU is hotplugged out.
> + *
> + * Save each register's current value so online() can reapply it, then restore
> + * the firmware value, leaving the platform in its pre-driver state while the
> + * policy is down (CPU hotplug or driver unload).
>   */
>  static int cppc_cpufreq_cpu_offline(struct cpufreq_policy *policy)
>  {
> +	cppc_cpufreq_save_req_and_restore_firmware_regs(policy);
> +
>  	return 0;
>  }
>  
>  /*
>   * Re-enable CPPC when the policy's CPU comes back online, since the platform
>   * may have disabled it while the CPU was offline.
> + *
> + * offline() reset the registers to their firmware values, so reapply the
> + * OSPM-set values it saved.
>   */
>  static int cppc_cpufreq_cpu_online(struct cpufreq_policy *policy)
>  {
> @@ -744,6 +872,8 @@ static int cppc_cpufreq_cpu_online(struct cpufreq_policy *policy)
>  	if (ret && ret != -EOPNOTSUPP)
>  		pr_warn("Failed to re-enable CPPC for CPU%d (%d)\n", cpu, ret);
>  
> +	cppc_cpufreq_reapply_requested_regs(policy);
> +
>  	return 0;
>  }
>  

I had a look as well and I think the saved registers aren't enough for the stated hotplug problem.

CPPC also programs DESIRED_PERF, MIN_PERF and MAX_PERF. If the platform resets those controls
while a policy is offline, online() your series reapplies AUTO_SEL_ENABLE, EPP and the activity
window but leaves the main performance request unrestored.
So autonomous selection may be re-enabled while MIN_PERF and MAX_PERF still contain
reset values.

I do not think these controls should simply be added to cppc_saved_regs[]:
- MIN_PERF and MAX_PERF should be derived from the current policy, which may have changed.
- After state loss, direct controls require safe ordering: establish [0, all-ones], restore
a clamped DESIRED_PERF, then install the final bounds.
PCC controls make this more complex, they should remain grouped in a coordinated transaction.

Could the hotplug state instead retain the last requested DESIRED value, recompute the bounds
during online(), restore the complete tuple, and only then reapply AUTO_SEL_ENABLE?


