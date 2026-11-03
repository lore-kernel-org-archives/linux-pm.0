Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793706610;
	b=1sOoxBKgazNF7PbmmdbPjXzh3Wgn8lffxrBhwzWISCOwtVWkNUD8ygUSg6miVOUUho09
	 Gd27zOAvy5GtI5Avibf2qnbKVtfwhVUg7PyCmwlwnCu5cdurA+ffCeTD5ZHVpCIa4vQpy
	 AIpB5/qWKCLyeAIbG1X/MvNckn8ktszbsTsPdUWIiRTV6oBwlRKMW+aSokZA1+FgfGQup
	 Fics2lajGncvw3SOxbBNcEcpw1ATv65HJPBokw3M4RNtOXzGYvBcdHjaAsZPcOzLcNzye
	 EqF9jT7dkXk4L6LuthuOspgfJ1cppDCGEIPqw6t6QaoNX1GR3dQZCMg4Zs/lL9KXSZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793706610;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=cM3f2k+WSJWTtnrVcHisib2bjevVmgFckszk6cXF/14=;
	b=uDGXvmmSnmW+nRR7o9xxtxNRKalmGjMFJJEvwBZDKoyw4wDl3kVhPUIX3h6tU0oa5DBc
	 7hkCpZmlw4LIbxqT4N24bH4tpfaa+zBJSwN/HyLqcxQHFDGBbRJkkLcPBQR0qrjtmdsTK
	 mvpZqP4pG2AtAE9qWad250pYUHQ+TJMua4TZWLQY7F05DrzNPI8lmNRSZQfurqlkNtuR4
	 U65DNqmpdEEhO1F1sBLYQ4x0WN3G64PWNwzPCVVqnGFDyPCLpfpMqSKLNOIFr2uFTEr90
	 yLGqU90EaJLoJvMP+HLDPn4se9gUYcwlDzOlmtRP1RGMyA5j+mtLX7HpH0MPrBXeQJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=m4n8FRl5;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28009606A32C;
	Tue,  3 Nov 2026 11:50:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 28009606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=m4n8FRl5
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DF3AE16A3;
	Tue,  3 Nov 2026 03:50:04 -0800 (PST)
Received: from [10.0.130.179] (unknown [10.0.130.179])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1F2BD3F632;
	Tue,  3 Nov 2026 03:50:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793706608; bh=mqnypz3yUy2oaNu2KMv651MQpITkWlXP906E1NPRi1Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=m4n8FRl5JZGVBwxBto5bGH8HZMPf+8GNaTvk/pKXtl014K6accIPlTne9nMgvqMwI
	 mirYuXyo6LyzvzYFrZ+ZW9KgWZw/69JRx+VsNfFE5Ep6Sy6etGA6YxN0ARlF2zFGOF
	 jUY1Z9UwF31APVER3ltzbP0VO23TSw669NuNAXq4=
Message-ID: <b56fe695-e626-4335-878d-07a6298954ac@arm.com>
Date: Tue, 3 Nov 2026 11:50:02 +0000
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
Subject: Re: [PATCH v7 2/5] cpufreq: CPPC: Keep the policy across CPU hotplug
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
References: <20261030092416.1993889-1-sumitg@nvidia.com>
 <20261030092416.1993889-2-sumitg@nvidia.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <20261030092416.1993889-2-sumitg@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/30/26 09:24, Sumit Gupta wrote:
> Without online()/offline() callbacks, the cpufreq core calls exit() when
> a policy's last online CPU goes down. That drops the driver's per-policy
> data, which init() rebuilds when a CPU comes back.
> 
> Add lightweight online()/offline() callbacks so the core instead keeps
> the policy active and reuses the driver's cpu_data across CPU hotplug.
> init() then runs once instead of on every hotplug, making CPU hotplug
> faster.
> 
> This also lets offline() and online() restore and reapply register
> values across CPU hotplug. A later patch in this series uses this to
> preserve the OSPM-set registers.
> 
> Move what init() and exit() did on hotplug into the new callbacks:
> 
>   - offline() requests the lowest performance and stops the frequency
>     invariance updates, as exit() did. It also sets MIN to the lowest
>     performance, so that Desired is not below MIN while the CPU is
>     offline.
>   - online() re-enables CPPC and restores the performance controls, as
>     the platform may have reset them. Failures are logged, not returned,
>     as the core would free the policy. It also restarts the frequency
>     invariance updates with a new counter snapshot, as init() did, so
>     that no sample spans the offline window.
>   - exit() now only frees the driver data, as the core calls offline()
>     before it.
> 
> The driver keeps a copy of the MIN and MAX it last wrote, so that
> fast_switch() can skip writing them again. online() marks that copy out
> of date before the restore, as the platform may have reset the limits,
> and updates it once the restore succeeds.
> 
> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>

Reviewed-by: Christian Loehle <christian.loehle@arm.com>

> ---
>  drivers/cpufreq/cppc_cpufreq.c | 106 ++++++++++++++++++++++++++++++---
>  1 file changed, 97 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index ded4f935638e..2cf250b38633 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -209,7 +209,7 @@ static void cppc_cpufreq_cpu_fie_exit(struct cpufreq_policy *policy)
>  	if (fie_disabled)
>  		return;
>  
> -	/* policy->cpus will be empty here, use related_cpus instead */
> +	/* policy->cpus has only the online CPUs, so use related_cpus */
>  	topology_clear_scale_freq_source(SCALE_FREQ_SOURCE_CPPC, policy->related_cpus);
>  
>  	for_each_cpu(cpu, policy->related_cpus) {
> @@ -807,24 +807,110 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
>  }
>  
>  static void cppc_cpufreq_cpu_exit(struct cpufreq_policy *policy)
> +{
> +	/*
> +	 * The core always calls offline() first, so only the driver data is
> +	 * left to free.
> +	 */
> +	cppc_cpufreq_put_cpu_data(policy);
> +}
> +
> +/*
> + * Run when the policy's first CPU comes back online, the counterpart of
> + * offline().
> + *
> + * The platform may have disabled CPPC and reset the performance controls
> + * (desired, min and max performance) while the CPU was offline. Re-enable
> + * CPPC and reprogram the controls.
> + *
> + * Log failures but do not return them, as the core would free the policy.
> + * Continue after a failure to enable CPPC, as the writes that follow fail
> + * on their own if the platform does not take them. A failed controls write
> + * is not fatal, as the next frequency change writes the controls again.
> + */
> +static int cppc_cpufreq_cpu_online(struct cpufreq_policy *policy)
>  {
>  	struct cppc_cpudata *cpu_data = policy->driver_data;
> -	struct cppc_perf_caps *caps = &cpu_data->perf_caps;
> +	u32 desired_perf, min_perf, max_perf;
> +	struct cppc_perf_ctrls perf_ctrls = {};
> +	unsigned int cpu = policy->cpu;
> +	int ret;
> +
> +	/*
> +	 * The platform may have reset MIN and MAX, so mark the copy that
> +	 * fast_switch() uses as out of date until the restore below succeeds.
> +	 */
> +	WRITE_ONCE(cpu_data->perf_limits_valid, false);
> +
> +	ret = cppc_set_enable(cpu, true);
> +	if (ret && ret != -EOPNOTSUPP)
> +		pr_warn("Failed to re-enable CPPC for CPU%u (%d)\n", cpu, ret);
> +
> +	/*
> +	 * Recompute min/max from the policy, clamp the last request into range,
> +	 * and reprogram the performance controls. Update the driver's copy only
> +	 * if the write succeeds. Otherwise the next frequency change writes the
> +	 * limits again.
> +	 */
> +	cppc_cpufreq_get_perf_limits(cpu_data, policy, &min_perf, &max_perf);
> +	desired_perf = clamp_t(u32, cpu_data->perf_ctrls.desired_perf,
> +			       min_perf, max_perf);
> +
> +	perf_ctrls.desired_perf = desired_perf;
> +	perf_ctrls.min_perf = min_perf;
> +	perf_ctrls.max_perf = max_perf;
> +	perf_ctrls.min_perf_valid = true;
> +
> +	ret = cppc_set_perf(cpu, &perf_ctrls);
> +	if (ret) {
> +		pr_debug("Failed to restore perf controls on CPU%u (%d)\n",
> +			 cpu, ret);
> +	} else {
> +		WRITE_ONCE(cpu_data->perf_ctrls.desired_perf, desired_perf);
> +		WRITE_ONCE(cpu_data->perf_ctrls.min_perf, min_perf);
> +		WRITE_ONCE(cpu_data->perf_ctrls.max_perf, max_perf);
> +		WRITE_ONCE(cpu_data->perf_limits_valid, true);
> +	}
> +
> +	/* Restart what offline() stopped, with a new counter snapshot. */
> +	cppc_cpufreq_cpu_fie_init(policy);
> +
> +	return 0;
> +}
> +
> +/*
> + * Run when the policy's last online CPU goes down, the counterpart of online().
> + * Having offline() makes the core keep the policy rather than call exit().
> + */
> +static int cppc_cpufreq_cpu_offline(struct cpufreq_policy *policy)
> +{
> +	struct cppc_cpudata *cpu_data = policy->driver_data;
> +	struct cppc_perf_ctrls perf_ctrls = cpu_data->perf_ctrls;
>  	unsigned int cpu = policy->cpu;
>  	int ret;
>  
> +	/*
> +	 * Stop the frequency invariance updates and cancel the pending work, so
> +	 * that no sample spans the offline window. online() restarts them with
> +	 * a new counter snapshot.
> +	 */
>  	cppc_cpufreq_cpu_fie_exit(policy);
>  
> -	cpu_data->perf_ctrls.desired_perf = caps->lowest_perf;
> -	cpu_data->perf_ctrls.min_perf = caps->lowest_perf;
> -	cpu_data->perf_ctrls.min_perf_valid = true;
> +	/*
> +	 * Request the lowest performance while the policy has no online CPU,
> +	 * lowering MIN with it so that the request stays a valid tuple. MAX
> +	 * keeps the value the policy last programmed.
> +	 */
> +	perf_ctrls.desired_perf = cpu_data->perf_caps.lowest_perf;
> +	perf_ctrls.min_perf = cpu_data->perf_caps.lowest_perf;
> +	perf_ctrls.min_perf_valid = true;
>  
> -	ret = cppc_set_perf(cpu, &cpu_data->perf_ctrls);
> +	ret = cppc_set_perf(cpu, &perf_ctrls);
>  	if (ret)
> -		pr_debug("Err setting perf value:%d on CPU:%d. ret:%d\n",
> -			 caps->lowest_perf, cpu, ret);
> +		pr_debug("Err setting perf value:%u on CPU:%u. ret:%d\n",
> +			 cpu_data->perf_caps.lowest_perf, cpu, ret);
>  
> -	cppc_cpufreq_put_cpu_data(policy);
> +	return 0;
>  }
>  
>  static int cppc_cpufreq_cpu_resume(struct cpufreq_policy *policy)
> @@ -1141,6 +1227,8 @@ static struct cpufreq_driver cppc_cpufreq_driver = {
>  	.fast_switch = cppc_cpufreq_fast_switch,
>  	.init = cppc_cpufreq_cpu_init,
>  	.exit = cppc_cpufreq_cpu_exit,
> +	.online = cppc_cpufreq_cpu_online,
> +	.offline = cppc_cpufreq_cpu_offline,
>  	.resume = cppc_cpufreq_cpu_resume,
>  	.set_boost = cppc_cpufreq_set_boost,
>  	.attr = cppc_cpufreq_attr,

