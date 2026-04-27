Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21A339A074;
	Mon, 27 Apr 2026 08:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777278277; cv=none; b=AUS7BTHctK3mk3MVVv7XaSPC5N8bk8WRArwxN2Yl94161biWOArvkAv2yVyKKcGiMTjUfFutrhQ4BGZDaSLhlXUJOYqkZYUG+GFYzskr9jLCR0RQslyP3NyoUcnLhLiXeuDuMCeL8HZYFV5ChaeYk1Y8CDZ4rIWjAkwq4GFWOaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777278277; c=relaxed/simple;
	bh=JoGYb5w+i7KAOj6ztX7K6yR7qMHfcXzHYJAIVcebOaI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=c4hxC8BPc+pZTjH/YlpUCfHDNvWjacV/mznDYK7oQSw4pxSWdLlNGnIhjpEmXpO1OG+KcsWFj+3vTPQDgwJZCQ5uLxxT3s7wVhKQ8y4g1x76l93VPCF7vHFLZkGS2GnQrjEMu+SfBWfp1rqe6WabSarmuY5OAHPFVsFd8qptQgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=113.46.200.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.163.214])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4g3xJp4TSGzmV6X;
	Mon, 27 Apr 2026 16:18:02 +0800 (CST)
Received: from kwepemf200017.china.huawei.com (unknown [7.202.181.10])
	by mail.maildlp.com (Postfix) with ESMTPS id B59DB4056C;
	Mon, 27 Apr 2026 16:24:29 +0800 (CST)
Received: from [10.67.121.58] (10.67.121.58) by kwepemf200017.china.huawei.com
 (7.202.181.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 27 Apr
 2026 16:24:28 +0800
Message-ID: <a4ed690a-50d6-4bfe-8810-86a75d7b51e3@hisilicon.com>
Date: Mon, 27 Apr 2026 16:24:27 +0800
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
Content-Language: en-US
From: Jie Zhan <zhanjie9@hisilicon.com>
In-Reply-To: <20260424201814.230071-1-sumitg@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemf200017.china.huawei.com (7.202.181.10)


Hi Sumit,

In general, I would expect this parameter only toggles on auto_sel by
default.  IIUC, other CPPC configurations (min/max/desired perf, EPP,
enable) are optional and not closely related to this.

Why including those stuff here?


Please see other questions inline.

Thanks!
Jie

On 4/25/2026 4:18 AM, Sumit Gupta wrote:
> Add a kernel boot parameter 'cppc_cpufreq.auto_sel_mode' to enable
> CPPC autonomous performance selection on all CPUs at system startup.
> When autonomous mode is enabled, the hardware automatically adjusts
> CPU performance based on workload demands using Energy Performance
> Preference (EPP) hints.
> 
> When auto_sel_mode=1:
> - Configure all CPUs for autonomous operation on first init
> - Set EPP to performance preference (0x0)
> - Use HW min/max_perf when available; otherwise initialize from caps
> - Clamp desired_perf to bounds before enabling autonomous mode
> - Hardware controls frequency instead of the OS governor
> 
> The boot parameter is applied only during first policy initialization.
> Skip applying it on CPU hotplug to preserve runtime sysfs configuration.
> 
> This patch depends on patch [2] ("cpufreq: Set policy->min and max
> as real QoS constraints") so that the policy->min/max set in
> cppc_cpufreq_cpu_init() are not overridden by cpufreq_set_policy()
> during init.
> 
> Reviewed-by: Randy Dunlap <rdunlap@infradead.org> (Documentation)
> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> ---
> v[1] -> v2:
> - Call cppc_set_enable() unconditionally so CPPC is enabled for both
>   OS-driven and autonomous modes.
Why adding this in v2?
This looks like a separate issue since setting CPPC Enable reg doesn't seem
to be related with autonomous control.
> - Init min/max from caps instead of cppc_cpufreq_update_perf_limits()
>   as policy->min/max aren't yet populated.
> 
> [1] https://lore.kernel.org/lkml/20260317151053.2361475-1-sumitg@nvidia.com/
> [2] https://lore.kernel.org/lkml/20260423084731.1090384-2-pierre.gondois@arm.com/
> ---
>  .../admin-guide/kernel-parameters.txt         | 13 +++
>  drivers/cpufreq/cppc_cpufreq.c                | 89 +++++++++++++++++--
>  2 files changed, 97 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 0a1abed1b93c..751817b0573a 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -1067,6 +1067,19 @@ Kernel parameters
>  			policy to use. This governor must be registered in the
>  			kernel before the cpufreq driver probes.
>  
> +	cppc_cpufreq.auto_sel_mode=
> +			[CPU_FREQ] Enable ACPI CPPC autonomous performance
> +			selection. When enabled, hardware automatically adjusts
> +			CPU frequency on all CPUs based on workload demands.
> +			In Autonomous mode, Energy Performance Preference (EPP)
> +			hints guide hardware toward performance (0x0) or energy
> +			efficiency (0xff).
> +			Requires ACPI CPPC autonomous selection register support.
> +			Format: <bool>
> +			Default: 0 (disabled)
> +			0: use cpufreq governors
> +			1: enable if supported by hardware
> +
>  	cpu_init_udelay=N
>  			[X86,EARLY] Delay for N microsec between assert and de-assert
>  			of APIC INIT to start processors.  This delay occurs
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index 02db03d03755..672fc3058190 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -28,6 +28,9 @@
>  
>  static struct cpufreq_driver cppc_cpufreq_driver;
>  
> +/* Autonomous Selection boot parameter */
> +static bool auto_sel_mode;
> +
>  #ifdef CONFIG_ACPI_CPPC_CPUFREQ_FIE
>  static enum {
>  	FIE_UNSET = -1,
> @@ -656,6 +659,14 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
>  	caps = &cpu_data->perf_caps;
>  	policy->driver_data = cpu_data;
>  
> +	/*
> +	 * Enable CPPC for both OS-driven and autonomous modes.
> +	 * The Enable register is optional - some platforms may not support it
> +	 */
> +	ret = cppc_set_enable(cpu, true);
> +	if (ret && ret != -EOPNOTSUPP)
> +		pr_warn("Failed to enable CPPC for CPU%d (%d)\n", cpu, ret);
> +
>  	min = cppc_perf_to_khz(caps, caps->lowest_nonlinear_perf);
>  	max = cppc_perf_to_khz(caps, policy->boost_enabled ?
>  			caps->highest_perf : caps->nominal_perf);
> @@ -711,11 +722,71 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
>  	policy->cur = cppc_perf_to_khz(caps, caps->highest_perf);
>  	cpu_data->perf_ctrls.desired_perf =  caps->highest_perf;
>  
> -	ret = cppc_set_perf(cpu, &cpu_data->perf_ctrls);
> -	if (ret) {
> -		pr_debug("Err setting perf value:%d on CPU:%d. ret:%d\n",
> -			 caps->highest_perf, cpu, ret);
> -		goto out;
> +	/*
> +	 * Enable autonomous mode on first init if boot param is set.
> +	 * Check last_governor to detect first init and skip if auto_sel
> +	 * is already enabled.
> +	 */
> +	if (auto_sel_mode && policy->last_governor[0] == '\0' &&
> +	    !cpu_data->perf_ctrls.auto_sel) {
> +		/* Init min/max_perf from caps if not already set by HW. */
> +		if (!cpu_data->perf_ctrls.min_perf)
> +			cpu_data->perf_ctrls.min_perf = caps->lowest_nonlinear_perf;
> +		if (!cpu_data->perf_ctrls.max_perf)
> +			cpu_data->perf_ctrls.max_perf = policy->boost_enabled ?
> +				caps->highest_perf : caps->nominal_perf;
Is it automatically adjusted when switching boost on and off?
> +
> +		cpu_data->perf_ctrls.desired_perf =
> +			clamp_t(u32, cpu_data->perf_ctrls.desired_perf,
> +				cpu_data->perf_ctrls.min_perf,
> +				cpu_data->perf_ctrls.max_perf);
Why do we need to clamp desire_perf here?
> +
> +		policy->cur = cppc_perf_to_khz(caps,
> +					       cpu_data->perf_ctrls.desired_perf);
> +
> +		/* EPP is optional - some platforms may not support it */
> +		ret = cppc_set_epp(cpu, CPPC_EPP_PERFORMANCE_PREF);
Why setting this to PERFORMANCE by default?
A platform can have its own default EPP value.  This would override that.
> +		if (ret && ret != -EOPNOTSUPP)
> +			pr_warn("Failed to set EPP for CPU%d (%d)\n", cpu, ret);
> +		else if (!ret)
> +			cpu_data->perf_ctrls.energy_perf = CPPC_EPP_PERFORMANCE_PREF;
> +
> +		/* Program min/max/desired into CPPC regs before enabling auto_sel. */
> +		ret = cppc_set_perf(cpu, &cpu_data->perf_ctrls);
> +		if (ret) {
> +			pr_debug("Err setting perf for autonomous mode CPU:%d ret:%d\n",
> +				 cpu, ret);
> +			goto out;
Shouldn't this be pr_warn(), or even pr_err(), if it needs to bail out?

However, IIUC setting min/max/desired perf is optional for auto_sel, so
better to pr_info() and continue setting auto_sel?
> +		}
> +
> +		ret = cppc_set_auto_sel(cpu, true);
> +		if (ret && ret != -EOPNOTSUPP) {
> +			pr_warn("Failed autonomous config for CPU%d (%d)\n",
> +				cpu, ret);
> +			goto out;
Bailing out here would end up without DVFS support.
Can we fall back to the normal OS directed mode?
> +		}
> +		if (!ret)
> +			cpu_data->perf_ctrls.auto_sel = true;
> +	}
> +
> +	if (cpu_data->perf_ctrls.auto_sel) {
> +		/* Sync policy limits from HW when autonomous mode is active */
> +		policy->min = cppc_perf_to_khz(caps,
> +					       cpu_data->perf_ctrls.min_perf ?:
> +					       caps->lowest_nonlinear_perf);
> +		policy->max = cppc_perf_to_khz(caps,
> +					       cpu_data->perf_ctrls.max_perf ?:
> +					       (policy->boost_enabled ?
> +						caps->highest_perf :
> +						caps->nominal_perf));
> +	} else {
> +		/* Normal mode: governors control frequency */
> +		ret = cppc_set_perf(cpu, &cpu_data->perf_ctrls);
> +		if (ret) {
> +			pr_debug("Err setting perf value:%d on CPU:%d. ret:%d\n",
> +				 caps->highest_perf, cpu, ret);
> +			goto out;
> +		}
>  	}
>  
>  	cppc_cpufreq_cpu_fie_init(policy);
> @@ -1035,10 +1106,18 @@ static int __init cppc_cpufreq_init(void)
>  
>  static void __exit cppc_cpufreq_exit(void)
>  {
> +	unsigned int cpu;
> +
> +	for_each_present_cpu(cpu)
> +		cppc_set_auto_sel(cpu, false);
> +
>  	cpufreq_unregister_driver(&cppc_cpufreq_driver);
>  	cppc_freq_invariance_exit();
>  }
>  
> +module_param(auto_sel_mode, bool, 0444);
> +MODULE_PARM_DESC(auto_sel_mode, "Enable CPPC autonomous performance selection at boot");
> +
>  module_exit(cppc_cpufreq_exit);
>  MODULE_AUTHOR("Ashwin Chaugule");
>  MODULE_DESCRIPTION("CPUFreq driver based on the ACPI CPPC v5.0+ spec");
