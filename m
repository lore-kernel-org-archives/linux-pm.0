Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9489370AE5;
	Tue,  1 Sep 2026 08:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788251076; cv=none; b=pXASU/pa4wkGJ5IVVgQrhDuFOQbBy7YqqFq2GSbDu0+l3Pu5qooJpFPnV4pWA0WPQWEIoo2lB5RPqryOKza+upv+aSqfcssDejnSHVMIWL1BNO3uUm4oA26uCccnaKsFoNSk021PBYtfiLvMbALXMaz17n3LU8VIqGAuvtowv60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788251076; c=relaxed/simple;
	bh=ZglE1gUQO+WRY/zhJeoDzQUKvUbB21alqE0CNfeAZK0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=JRXSaqwOiwEd8PSa9tB0/nRRVBV4chuuBNSQZZAvQX9naN/VyuMo8LlNDDfbGvd2qd7UsZbOYZY3pWf54nMEd4kSN+YYx8LvPNGKr1GiUOZ/pfL2D3slPV9RA1Lvf0rYuZxf/T2x5RdobR5tYdfDW+NjZUPSjfeaeHv6/mmdZEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=113.46.200.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.163.104])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4hYzBb5cxzz12LDl;
	Tue,  1 Sep 2026 16:13:11 +0800 (CST)
Received: from kwepemf200017.china.huawei.com (unknown [7.202.181.10])
	by mail.maildlp.com (Postfix) with ESMTPS id AAC124056E;
	Tue,  1 Sep 2026 16:24:28 +0800 (CST)
Received: from [10.67.121.58] (10.67.121.58) by kwepemf200017.china.huawei.com
 (7.202.181.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 1 Sep
 2026 16:24:27 +0800
Message-ID: <c30ddb21-2c97-4b9f-bae6-b29e30aa5e5e@hisilicon.com>
Date: Tue, 1 Sep 2026 16:24:26 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/4] cpufreq: CPPC: Keep the policy across CPU hotplug
To: Sumit Gupta <sumitg@nvidia.com>, <rafael@kernel.org>,
	<viresh.kumar@linaro.org>, <pierre.gondois@arm.com>,
	<christian.loehle@arm.com>, <ionela.voinescu@arm.com>,
	<zhenglifeng1@huawei.com>, <lenb@kernel.org>, <saket.dumbre@intel.com>,
	<ray.huang@amd.com>, <mario.limonciello@amd.com>, <perry.yuan@amd.com>,
	<kprateek.nayak@amd.com>, <linux-kernel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<acpica-devel@lists.linux.dev>, <linux-tegra@vger.kernel.org>
CC: <treding@nvidia.com>, <jonathanh@nvidia.com>, <vsethi@nvidia.com>,
	<ksitaraman@nvidia.com>, <sanjayc@nvidia.com>, <mochs@nvidia.com>,
	<bbasu@nvidia.com>
References: <20260806200857.601152-1-sumitg@nvidia.com>
 <20260806200857.601152-2-sumitg@nvidia.com>
Content-Language: en-US
From: Jie Zhan <zhanjie9@hisilicon.com>
In-Reply-To: <20260806200857.601152-2-sumitg@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemf200017.china.huawei.com (7.202.181.10)


Hi Sumit,

Sorry for catching up late.

A few questions inline.

Regards,
Jie

On 8/7/2026 4:08 AM, Sumit Gupta wrote:
> Without online()/offline() callbacks, the cpufreq core fully tears
> down a policy during exit() when its last online CPU is offlined, and
> rebuilds it during init() when it comes back.
> 
> Add lightweight online()/offline() callbacks so the core instead keeps
> the policy live and reuses the driver's cpu_data across CPU hotplug.
> This avoids re-reading the CPPC capabilities on every offline/online,
> making CPU hotplug faster.
> 
> Move what init() and exit() did on hotplug into the new callbacks:
> 
>   - offline() requests the lowest desired performance, as exit() did.
>   - online() re-enables CPPC and restores the performance controls, as
>     the platform may have reset them. Failures are logged, not returned,
>     as the core would free the policy.
>   - online() also resyncs the frequency invariance counters, so that the
>     first tick does not measure across the offline window.
> 
> The restore in online() uses cppc_set_perf(), which writes MIN before
> MAX. If the platform lowered MAX while the CPU was offline, writing the
> saved MIN could briefly leave MIN above MAX on registers not accessed
> through PCC, as PCC delivers the writes in one transaction. Raise MAX
> ahead of the restore when the saved MIN is above it.
> 
> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> ---
>  drivers/cpufreq/cppc_cpufreq.c | 128 +++++++++++++++++++++++++++++++++
>  1 file changed, 128 insertions(+)
> 
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index 80893844353c..4b3da9a3e122 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -211,6 +211,29 @@ static void cppc_cpufreq_cpu_fie_exit(struct cpufreq_policy *policy)
>  	}
>  }
>  
> +/*
> + * Resync the counter snapshot, as the policy is kept across CPU hotplug and
> + * the first tick after online would otherwise span the offline window.
> + */
> +static void cppc_cpufreq_cpu_fie_resync(struct cpufreq_policy *policy)
> +{
> +	struct cppc_freq_invariance *cppc_fi;
> +	int cpu, ret;
> +
> +	if (fie_disabled)
> +		return;
> +
> +	/* policy->cpus still holds related_cpus here, so skip offline CPUs. */
> +	for_each_cpu_and(cpu, policy->cpus, cpu_online_mask) {
> +		cppc_fi = &per_cpu(cppc_freq_inv, cpu);
> +
> +		ret = cppc_get_perf_ctrs(cpu, &cppc_fi->prev_perf_fb_ctrs);
> +		if (ret)
> +			pr_debug("%s: failed to read perf counters for cpu:%d: %d\n",
> +				 __func__, cpu, ret);
> +	}
> +}
> +
>  static void cppc_fie_kworker_init(void)
>  {
>  	struct sched_attr attr = {
> @@ -281,6 +304,10 @@ static inline void cppc_cpufreq_cpu_fie_exit(struct cpufreq_policy *policy)
>  {
>  }
>  
> +static inline void cppc_cpufreq_cpu_fie_resync(struct cpufreq_policy *policy)
> +{
> +}
> +
>  static inline void cppc_freq_invariance_init(void)
>  {
>  }
> @@ -735,6 +762,105 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
>  	return ret;
>  }
>  
> +/*
> + * With offline() defined, the cpufreq core keeps the policy alive when
> + * a CPU is hotplugged out.
> + */
> +static int cppc_cpufreq_cpu_offline(struct cpufreq_policy *policy)
> +{
> +	struct cppc_cpudata *cpu_data = policy->driver_data;
> +	struct cppc_perf_ctrls perf_ctrls = cpu_data->perf_ctrls;
> +	unsigned int cpu = policy->cpu;
> +	int ret;
> +
> +	/*
> +	 * Request the lowest desired performance while the policy has no online
> +	 * CPU. Zeroing MIN and MAX makes cppc_set_perf() leave them unchanged.
> +	 */
> +	perf_ctrls.desired_perf = cpu_data->perf_caps.lowest_perf;
> +	perf_ctrls.min_perf = 0;
> +	perf_ctrls.max_perf = 0;
> +
> +	ret = cppc_set_perf(cpu, &perf_ctrls);
> +	if (ret)
> +		pr_debug("Err setting perf value:%u on CPU:%u. ret:%d\n",
> +			 cpu_data->perf_caps.lowest_perf, cpu, ret);
> +
> +	return 0;
> +}
> +
> +/*
> + * Raise MAX ahead of the full restore when the requested MIN is above the
> + * current MAX. cppc_set_perf() writes MIN before MAX, so the platform would
> + * otherwise briefly see MIN above MAX on registers not accessed through PCC.
> + * Lowering MAX is safe, as the MIN written first is never above it.
> + */
> +static int
> +cppc_cpufreq_prepare_perf_restore(unsigned int cpu,
> +				  const struct cppc_perf_ctrls *target)
> +{
> +	struct cppc_perf_ctrls cur = {}, prep = {};
> +	int ret;
> +
> +	ret = cppc_get_perf(cpu, &cur);
> +	if (ret)
> +		return ret;
> +
> +	if (!cur.max_perf || target->min_perf <= cur.max_perf)
> +		return 0;
> +
> +	prep.desired_perf = target->desired_perf;
> +	prep.min_perf = 0;	/* Zero leaves MIN unchanged. */
> +	prep.max_perf = target->max_perf;
> +
> +	return cppc_set_perf(cpu, &prep);
> +}
> +
> +/*
> + * Restore what the CPU may have lost while offline, as the platform may have
> + * disabled CPPC and reset the performance controls. Never fail the callback,
> + * or the core would free the policy and leave the CPU without cpufreq. The
> + * governor redoes the control writes, so they are best effort, unlike the
> + * enable, which only a later online() can retry.
Sorry, I don't quite understand the last sentence.
> + */
> +static int cppc_cpufreq_cpu_online(struct cpufreq_policy *policy)
> +{
> +	struct cppc_cpudata *cpu_data = policy->driver_data;
> +	unsigned int cpu = policy->cpu;
> +	int ret;
> +
> +	cppc_cpufreq_cpu_fie_resync(policy);
> +
> +	ret = cppc_set_enable(cpu, true);
> +	if (ret && ret != -EOPNOTSUPP) {
> +		pr_warn("Failed to re-enable CPPC for CPU%u (%d)\n", cpu, ret);
> +		return 0;
> +	}
> +
> +	/*
> +	 * The platform may reset the controls while the CPU is offline, so
> +	 * recompute min/max, clamp desired_perf into range, and reprogram them.
> +	 */
> +	cppc_cpufreq_update_perf_limits(cpu_data, policy);
> +
> +	cpu_data->perf_ctrls.desired_perf =
> +		clamp_t(u32, cpu_data->perf_ctrls.desired_perf,
> +			cpu_data->perf_ctrls.min_perf,
> +			cpu_data->perf_ctrls.max_perf);
> +
> +	ret = cppc_cpufreq_prepare_perf_restore(cpu, &cpu_data->perf_ctrls);
Actually, I don't quite think this is necessary?

The motivation of doing this is fair (as mentioned in v3), but what's the
real consequence of transiently setting min_perf larger than max_perf?
Platforms should be able to handle this.

Even if we have to fix it, it's supposed to be done in cppc_acpi.c.  The
current ABI wraps many things up.  cppc_get_perf() reads 4 values -
min_perf, max_perf, energy_perf, auto_sel.  cppc_set_perf writes 3
values - desired_perf, min_perf, max_perf.  The cppc_cpufreq driver would
be able to handle performance setting cleaner if those are separated.

I don't suggest we complicate the driver for now?
> +	if (ret)
> +		pr_debug("Failed to reorder perf restore on CPU%u (%d)\n",
> +			 cpu, ret);
> +
> +	ret = cppc_set_perf(cpu, &cpu_data->perf_ctrls);
> +	if (ret)
> +		pr_debug("Failed to reapply perf request on CPU%u (%d)\n",
> +			 cpu, ret);
> +
> +	return 0;
> +}
> +
>  static void cppc_cpufreq_cpu_exit(struct cpufreq_policy *policy)
>  {
>  	struct cppc_cpudata *cpu_data = policy->driver_data;
For neatness, can we place the above functions after cppc_cpufreq_cpu_exit()?
such that the order of source functions would be the same as the following
structure, i.e. init, exit, online, offline, and perhaps, suspend, resume.
> @@ -1047,6 +1173,8 @@ static struct cpufreq_driver cppc_cpufreq_driver = {
>  	.fast_switch = cppc_cpufreq_fast_switch,
>  	.init = cppc_cpufreq_cpu_init,
>  	.exit = cppc_cpufreq_cpu_exit,
> +	.online = cppc_cpufreq_cpu_online,
> +	.offline = cppc_cpufreq_cpu_offline,
>  	.set_boost = cppc_cpufreq_set_boost,
>  	.attr = cppc_cpufreq_attr,
>  	.name = "cppc_cpufreq",
