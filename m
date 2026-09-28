Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46708547052;
	Mon, 28 Sep 2026 15:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790608756; cv=none; b=Tp+qUA1SZUbbJcWeAvCaKfWhY3qIkfVnc3YsPcjq6U/5mIIVGDTT9f2mx6n1KGR9Oq4lAn4c26czPfXUUstBOfWvAiMrNFdt8iY0K3WP3+Z0Pjm59pQh3zKm0F25/T/eZRgfXzpmsoGn7wFksJdTe8cwATJEp5Gb60G7AXx8/uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790608756; c=relaxed/simple;
	bh=2GOz34l7ZuP2xTH5AFBhWdZi4hxnXdSdFJDa738reiw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t32UUqPRmqGfhtgsYxDXTDv2tlK1jBCkCIAzbG/Xd53A0sV+hC+wRuo1NOhFYU36bQdz1ltcpcUl8BJEP1DqrL0I+gzrxQUGDw2gNwFIbbIQuKPnnlyK6GAwGtieM2C23N9X6K6eM74x0XVQ1s2sNaSL6zYT2Ha94pBSYZQk/Ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Kny/YJ5o; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Kny/YJ5o"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 21EBD1C00;
	Mon, 28 Sep 2026 08:19:10 -0700 (PDT)
Received: from [10.57.52.74] (unknown [10.57.52.74])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7E2863F763;
	Mon, 28 Sep 2026 08:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1790608753; bh=2GOz34l7ZuP2xTH5AFBhWdZi4hxnXdSdFJDa738reiw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Kny/YJ5oWUrrfV/Q4MoRVHD86LDnzNEJIqygb9EPX3QquEUWdoOjXcnYV5GHomBpM
	 lir1QWlRR15n7TXBflYGtjczGLSt7dBkZOqHqBT4pO+UXTal6gCnOFDhVqK9yEqaOA
	 UQ2tUhgqBnEbvxbOXjb2l9PHnFTunyJeAyehhNoE=
Message-ID: <e539dce2-1b2a-45cc-9ea8-1ab0e0f11972@arm.com>
Date: Mon, 28 Sep 2026 16:19:07 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/3] cpufreq: CPPC: Add ospm_nominal_freq attribute
To: Sumit Gupta <sumitg@nvidia.com>, rafael@kernel.org,
 viresh.kumar@linaro.org, pierre.gondois@arm.com, ionela.voinescu@arm.com,
 zhenglifeng1@huawei.com, zhanjie9@hisilicon.com, lenb@kernel.org,
 saket.dumbre@intel.co, mario.limonciello@amd.com,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev,
 linux-tegra@vger.kernel.org
Cc: treding@nvidia.com, jonathanh@nvidia.com, vsethi@nvidia.com,
 ksitaraman@nvidia.com, sanjayc@nvidia.com, mochs@nvidia.com, bbasu@nvidia.com
References: <20260807214837.863209-1-sumitg@nvidia.com>
 <20260807214837.863209-3-sumitg@nvidia.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <20260807214837.863209-3-sumitg@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/7/26 22:48, Sumit Gupta wrote:
> OSPM Nominal Performance (ACPI 6.6, Section 8.4.6.1.2.6) lets the OS
> request a nominal performance level below the platform-reported one. The
> platform treats performance above that level as boosted and below it as
> throttled for its power and thermal decisions. A lower value moves that
> boundary down, so sustained work runs at a lower point while the range
> above it remains available as boost.
> 
> Expose it as a per-policy cpufreq attribute in kHz, matching the unit
> convention of the other frequency attributes:
> 
>   /sys/devices/system/cpu/cpuX/cpufreq/ospm_nominal_freq
> 
> The attribute is write-only as the register cannot be read back. Writes
> are converted with cppc_khz_to_perf() and rejected unless they fall in
> [Lowest Performance, Nominal Performance].
> 
> Also track the register in the OSPM-set save/restore table, so a
> requested value survives CPU hotplug and suspend/resume. The store
> handler records the request rather than init() capturing a firmware
> value, and driver unload reverts the register to the platform-reported
> Nominal Performance.
> 
> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> ---
>  .../ABI/testing/sysfs-devices-system-cpu      | 24 +++++++
>  drivers/cpufreq/cppc_cpufreq.c                | 70 +++++++++++++++++--
>  2 files changed, 90 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
> index 82d10d556cc8..59aafcb2af97 100644
> --- a/Documentation/ABI/testing/sysfs-devices-system-cpu
> +++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
> @@ -346,6 +346,30 @@ Description:	Performance Limited
>  
>  		This file is only present if the cppc-cpufreq driver is in use.
>  
> +What:		/sys/devices/system/cpu/cpuX/cpufreq/ospm_nominal_freq
> +Date:		August 2026
> +Contact:	linux-pm@vger.kernel.org
> +Description:	OSPM Nominal Performance (kHz), write-only

IMO exposing this as write-only feels an awkward interface, when we can just
return (-EOPNOTSUPP, requested_val, or <unset>)?

> +
> +		OSPM uses this attribute to request a nominal performance level
> +		lower than the platform-reported nominal. The platform treats
> +		performance above this level as boost and below as throttle for
> +		power and thermal decisions.
> +
> +		Write a value in kHz, between the frequencies corresponding to
> +		Lowest Performance and Nominal Performance. The register cannot
> +		be read back, so this attribute has no read side.
> +
> +		Note that tasks may be migrated from one CPU to another by the
> +		scheduler's load-balancing algorithm, and if different OSPM
> +		Nominal Performance values are set for those CPUs (through
> +		different cpufreq policies), that may lead to undesirable
> +		outcomes. To avoid such issues it is better to set the same
> +		value across all policies, or to pin every task potentially
> +		sensitive to it to a specific CPU.
> +
> +		This file is only present if the cppc-cpufreq driver is in use.
> +
>  What:		/sys/devices/system/cpu/cpu*/cache/index3/cache_disable_{0,1}
>  Date:		August 2008
>  KernelVersion:	2.6.27
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index 32f38b0c492b..fe714e71826a 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -33,11 +33,13 @@ static struct cpufreq_driver cppc_cpufreq_driver;
>   * reapplied from online() across CPU hotplug, and the firmware value is
>   * restored from offline().
>   *
> - * Autonomous Selection (auto_sel) is kept first, as writes to the registers
> - * listed after it only have meaning while autonomous selection is enabled.
> + * Autonomous Selection (auto_sel) splits the list: the registers before it are
> + * independent of it, and those after it have meaning only while autonomous
> + * selection is enabled. Place a new register on the matching side.
>   */
>  enum cppc_saved_reg_id {
> -	CPPC_SAVED_AUTO_SEL,
> +	CPPC_SAVED_OSPM_NOMINAL_PERF,
> +	CPPC_SAVED_AUTO_SEL,	/* Entries below need auto_sel enabled. */
>  	CPPC_SAVED_EPP,
>  	CPPC_SAVED_AUTO_ACT_WINDOW,
>  	CPPC_NR_SAVED_REGS,
> @@ -50,6 +52,11 @@ struct cppc_saved_reg {
>  };
>  
>  static const struct cppc_saved_reg cppc_saved_regs[CPPC_NR_SAVED_REGS] = {
> +	/* Write-only: the requested value is tracked in software. */
> +	[CPPC_SAVED_OSPM_NOMINAL_PERF] = {
> +		.name = "ospm_nominal_perf",
> +		.set = cppc_set_ospm_nominal_perf,
> +	},
>  	[CPPC_SAVED_AUTO_SEL] = {
>  		.name = "auto_sel",
>  		.get = cppc_get_auto_sel,
> @@ -79,6 +86,9 @@ enum cppc_saved_type {
>   *                   could not be read
>   *   requested_val - value in effect when the policy last went offline,
>   *                   reapplied at online(). U64_MAX if none
> + *
> + * A write-only register cannot be read back, so its store handler sets
> + * firmware_val and requested_val instead of init() and offline().
>   */
>  struct cppc_saved_vals {
>  	u64 firmware_val;
> @@ -135,7 +145,17 @@ static void cppc_cpufreq_save_regs(struct cpufreq_policy *policy,
>  		st->suspend_regs_handled = false;
>  
>  	for (i = 0; i < CPPC_NR_SAVED_REGS; i++) {
> -		if (cppc_saved_regs[i].get(cpu, &val))
> +		const struct cppc_saved_reg *reg = &cppc_saved_regs[i];
> +
> +		/*
> +		 * A write-only register cannot be read back. It has no
> +		 * firmware value to capture, and its requested value comes
> +		 * from the store handler, so do not overwrite it here.
> +		 */
> +		if (!reg->get && saved_type == CPPC_SAVED_REQUESTED)
> +			continue;
> +
> +		if (!reg->get || reg->get(cpu, &val))
>  			val = U64_MAX;
>  
>  		if (saved_type == CPPC_SAVED_FIRMWARE) {
> @@ -197,6 +217,12 @@ static void cppc_cpufreq_apply_saved_regs(struct cpufreq_policy *policy,
>  	u64 auto_sel, val;
>  	int i;
>  
> +	/* Registers before auto_sel do not depend on it. */
> +	for (i = 0; i < CPPC_SAVED_AUTO_SEL; i++) {
> +		val = cppc_cpufreq_saved_reg_value(st, i, saved_type);
> +		cppc_cpufreq_write_saved_reg(cpu, i, val, saved_type);
> +	}
> +
>  	auto_sel = cppc_cpufreq_saved_reg_value(st, CPPC_SAVED_AUTO_SEL,
>  						saved_type);
>  
> @@ -1385,11 +1411,46 @@ static int cppc_get_perf_limited_filtered(int cpu, u64 *perf_limited)
>  CPPC_CPUFREQ_ATTR_RW_U64(perf_limited, cppc_get_perf_limited_filtered,
>  			 cppc_set_perf_limited)
>  
> +static ssize_t store_ospm_nominal_freq(struct cpufreq_policy *policy,
> +				       const char *buf, size_t count)
> +{
> +	struct cppc_cpudata *cpu_data = policy->driver_data;
> +	struct cppc_saved_vals *st;
> +	unsigned int freq_khz;
> +	u32 perf;
> +	int ret;
> +
> +	ret = kstrtouint(buf, 0, &freq_khz);
> +	if (ret)
> +		return ret;
> +
> +	perf = cppc_khz_to_perf(&cpu_data->perf_caps, freq_khz);
> +	if (perf < cpu_data->perf_caps.lowest_perf ||
> +	    perf > cpu_data->perf_caps.nominal_perf)
> +		return -EINVAL;
> +
> +	ret = cppc_set_ospm_nominal_perf(policy->cpu, perf);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * Track the request in software: requested_val is reapplied across
> +	 * hotplug, and firmware_val makes the register revert to the platform
> +	 * Nominal on driver unload, since the value cannot be read back.
> +	 */
> +	st = &cppc_cpufreq_policy_state(policy)->regs[CPPC_SAVED_OSPM_NOMINAL_PERF];
> +	st->requested_val = perf;
> +	st->firmware_val = cpu_data->perf_caps.nominal_perf;
> +
> +	return count;
> +}
> +
>  cpufreq_freq_attr_ro(freqdomain_cpus);
>  cpufreq_freq_attr_rw(auto_select);
>  cpufreq_freq_attr_rw(auto_act_window);
>  cpufreq_freq_attr_rw(energy_performance_preference_val);
>  cpufreq_freq_attr_rw(perf_limited);
> +cpufreq_freq_attr_wo(ospm_nominal_freq);
>  
>  static struct freq_attr *cppc_cpufreq_attr[] = {
>  	&freqdomain_cpus,
> @@ -1397,6 +1458,7 @@ static struct freq_attr *cppc_cpufreq_attr[] = {
>  	&auto_act_window,
>  	&energy_performance_preference_val,
>  	&perf_limited,
> +	&ospm_nominal_freq,
>  	NULL,
>  };
>  

