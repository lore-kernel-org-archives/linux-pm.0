Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 053C828150F;
	Mon, 27 Jul 2026 14:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785160878; cv=none; b=BtRXNphQMU27PskpVe2+lcHyycRfWewR6TGIynIlV/U6IbNBJW0WpcoAgQPxP2lb5oBMuRi0AW6v0sXw1sMxgzZpk5xzdPaGswCpZL1dDi7kstZZy6b60ZvBr1pB091MOHQJKAq51ynxdANMwaCPPQlGOWX0fpwaSYFIM/PHKJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785160878; c=relaxed/simple;
	bh=NuMh4nOcJi5/5azBV7uilCMxVtBE7I++pV4eLnjbYv4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xp4vhnVPi39t0PbT+hk9GrbxW3q0d+RY4/+M2VON5KfvjLuKrgFFSPNF3lD260FMt99BmJX6gMhlHFi8VfeIE0wwHg4dH8YJp09cUQfKWv0pLwmPEmjF68s7Nv077zytniBTLk7P+zpn9G1f9eGq/tb9xnUsSmKmMGVUJw0RBgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=YS6Sd3bJ; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="YS6Sd3bJ"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 407751655;
	Mon, 27 Jul 2026 07:01:11 -0700 (PDT)
Received: from [10.57.1.72] (unknown [10.57.1.72])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1617A3F763;
	Mon, 27 Jul 2026 07:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1785160875; bh=NuMh4nOcJi5/5azBV7uilCMxVtBE7I++pV4eLnjbYv4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=YS6Sd3bJ3kA9kQNlXMrsF3RiI9CgQyIQEEZg9qj2srR5bNhS0EGbyzFd8McBZIQcW
	 psdWb4CZX3sbAkqcGFKM5DZ/OUGkVQ2H57lofyaz2NJPhoxHE4bg0TuE8B7tAphLYL
	 tMYbKyJYBG0KoL9fTWWsp1KnPeu4Lh+RPhF130IA=
Message-ID: <436ae296-cc68-4313-bf76-86908a1e5b29@arm.com>
Date: Mon, 27 Jul 2026 15:01:05 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/2] ACPI: CPPC: Add ospm_nominal_perf support
To: Sumit Gupta <sumitg@nvidia.com>, rafael@kernel.org,
 viresh.kumar@linaro.org, pierre.gondois@arm.com, ionela.voinescu@arm.com,
 zhenglifeng1@huawei.com, zhanjie9@hisilicon.com, lenb@kernel.org,
 saket.dumbre@intel.co, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
 acpica-devel@lists.linux.dev, linux-tegra@vger.kernel.org
Cc: treding@nvidia.com, jonathanh@nvidia.com, vsethi@nvidia.com,
 ksitaraman@nvidia.com, sanjayc@nvidia.com, mochs@nvidia.com, bbasu@nvidia.com
References: <20260717215330.2215058-1-sumitg@nvidia.com>
 <20260717215330.2215058-2-sumitg@nvidia.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <20260717215330.2215058-2-sumitg@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/17/26 22:53, Sumit Gupta wrote:
> Expose the OSPM Nominal Performance register (ACPI 6.6, Section
> 8.4.6.1.2.6), which conveys the desired nominal performance level
> at which the platform may run. Unlike the existing read-only
> Nominal Performance register, it is writable and lets OSPM
> request a lower nominal level than the platform-reported nominal.
> The platform classifies performance above this level as boosted
> and below as throttled for its power/thermal decisions.
> 
> It is exposed as a per-policy cpufreq sysfs attribute in kHz, to
> match the cpufreq sysfs unit convention:
> 
>   /sys/devices/system/cpu/cpuX/cpufreq/ospm_nominal_freq
> 
> The attribute is documented in
> Documentation/ABI/testing/sysfs-devices-system-cpu.
> 
> Writes are converted to perf via cppc_khz_to_perf(), validated
> against [Lowest Performance, Nominal Performance], and applied to
> the policy->cpu. The register is assumed shared across the
> policy->cpus.
> 
> On read, the current register value is returned, or
> "<unsupported>" if the platform does not implement the register.
> 
> Also add the register to the OSPM-set register save/restore
> table, so its value survives CPU hotplug and reverts to the
> firmware value on driver unload, like the other registers in
> the table.
> 
> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> ---
>  .../ABI/testing/sysfs-devices-system-cpu      | 26 ++++++++++
>  drivers/acpi/cppc_acpi.c                      | 32 +++++++++++++
>  drivers/cpufreq/cppc_cpufreq.c                | 47 +++++++++++++++++++
>  include/acpi/cppc_acpi.h                      | 10 ++++
>  4 files changed, 115 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
> index 82d10d556cc8..a8d592c08823 100644
> --- a/Documentation/ABI/testing/sysfs-devices-system-cpu
> +++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
> @@ -346,6 +346,32 @@ Description:	Performance Limited
>  
>  		This file is only present if the cppc-cpufreq driver is in use.
>  
> +What:		/sys/devices/system/cpu/cpuX/cpufreq/ospm_nominal_freq
> +Date:		May 2026
> +Contact:	linux-pm@vger.kernel.org
> +Description:	OSPM Nominal Performance (kHz)
> +
> +		OSPM uses this attribute to request a nominal performance
> +		level lower than the platform-reported nominal. The
> +		platform treats performance above this level as boost
> +		and below as throttle for power and thermal decisions.
> +
> +		Read returns the current value in kHz, or "<unsupported>"
> +		if the platform does not implement the register. Write a
> +		kHz value in the range [lowest_freq, nominal_freq].
> +
> +		Note that tasks may be migrated from one CPU to another
> +		by the scheduler's load-balancing algorithm, and if
> +		different OSPM Nominal Performance values are set for
> +		those CPUs (through different cpufreq policies), that may
> +		lead to undesirable outcomes. To avoid such issues it is
> +		better to set the same value across all policies, or to
> +		pin every task potentially sensitive to it to a specific
> +		CPU.
> +
> +		This file is only present if the cppc-cpufreq driver is
> +		in use.
> +
>  What:		/sys/devices/system/cpu/cpu*/cache/index3/cache_disable_{0,1}
>  Date:		August 2008
>  KernelVersion:	2.6.27
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index a7fec6c93178..681d4fd40c11 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -1685,6 +1685,38 @@ int cppc_set_epp(int cpu, u64 epp_val)
>  }
>  EXPORT_SYMBOL_GPL(cppc_set_epp);
>  
> +/**
> + * cppc_set_ospm_nominal_perf() - Write OSPM Nominal Performance register.
> + * @cpu: CPU on which to write register.
> + * @ospm_nominal_perf: Value to write to the OSPM Nominal Performance register.
> + *
> + * OSPM Nominal Performance conveys the desired nominal performance level
> + * at which the platform may run. Per ACPI 6.6, s8.4.6.1.2.6, the value
> + * must lie within [Lowest Performance, Nominal Performance] and may be
> + * set independently of Minimum, Maximum and Desired performance. The
> + * caller is responsible for validating the range.
> + *
> + * Return: 0 on success or negative error code.
> + */
> +int cppc_set_ospm_nominal_perf(int cpu, u64 ospm_nominal_perf)
> +{
> +	return cppc_set_reg_val(cpu, OSPM_NOMINAL_PERF, ospm_nominal_perf);
> +}
> +EXPORT_SYMBOL_GPL(cppc_set_ospm_nominal_perf);
> +
> +/**
> + * cppc_get_ospm_nominal_perf() - Read OSPM Nominal Performance register.
> + * @cpu: CPU from which to read register.
> + * @ospm_nominal_perf: Pointer to store the OSPM Nominal Performance value.
> + *
> + * Return: 0 on success or negative error code.
> + */
> +int cppc_get_ospm_nominal_perf(int cpu, u64 *ospm_nominal_perf)
> +{
> +	return cppc_get_reg_val(cpu, OSPM_NOMINAL_PERF, ospm_nominal_perf);
> +}
> +EXPORT_SYMBOL_GPL(cppc_get_ospm_nominal_perf);

It's a write-only register, we need to track everything in the driver.

> +
>  /**
>   * cppc_get_auto_act_window() - Read autonomous activity window register.
>   * @cpu: CPU from which to read register.
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index 9c88512d635c..eb6746810fa6 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -37,6 +37,7 @@ enum cppc_saved_reg_id {
>  	CPPC_SAVED_AUTO_SEL,
>  	CPPC_SAVED_EPP,
>  	CPPC_SAVED_AUTO_ACT_WINDOW,
> +	CPPC_SAVED_OSPM_NOMINAL_PERF,
>  	CPPC_NR_SAVED_REGS,
>  };
>  
> @@ -55,6 +56,9 @@ static const struct cppc_saved_reg cppc_saved_regs[CPPC_NR_SAVED_REGS] = {
>  	[CPPC_SAVED_AUTO_ACT_WINDOW] = {
>  		cppc_get_auto_act_window, cppc_set_auto_act_window,
>  	},
> +	[CPPC_SAVED_OSPM_NOMINAL_PERF] = {
> +		cppc_get_ospm_nominal_perf, cppc_set_ospm_nominal_perf,
> +	},
>  };
>  
>  /*
> @@ -1166,11 +1170,53 @@ static int cppc_get_perf_limited_filtered(int cpu, u64 *perf_limited)
>  CPPC_CPUFREQ_ATTR_RW_U64(perf_limited, cppc_get_perf_limited_filtered,
>  			 cppc_set_perf_limited)
>  
> +static ssize_t show_ospm_nominal_freq(struct cpufreq_policy *policy, char *buf)
> +{
> +	struct cppc_cpudata *cpu_data = policy->driver_data;
> +	u64 perf;
> +	int ret;
> +
> +	ret = cppc_get_ospm_nominal_perf(policy->cpu, &perf);
> +	if (ret == -EOPNOTSUPP)
> +		return sysfs_emit(buf, "<unsupported>\n");
> +	if (ret)
> +		return ret;
> +
> +	return sysfs_emit(buf, "%u\n",
> +			  cppc_perf_to_khz(&cpu_data->perf_caps, perf));
> +}
> +
> +static ssize_t store_ospm_nominal_freq(struct cpufreq_policy *policy,
> +				       const char *buf, size_t count)
> +{
> +	struct cppc_cpudata *cpu_data = policy->driver_data;
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
> +	/* The register is assumed shared across the policy's CPUs. */
> +	ret = cppc_set_ospm_nominal_perf(policy->cpu, perf);
> +	if (ret)
> +		return ret;
> +
> +	return count;
> +}
> +
>  cpufreq_freq_attr_ro(freqdomain_cpus);
>  cpufreq_freq_attr_rw(auto_select);
>  cpufreq_freq_attr_rw(auto_act_window);
>  cpufreq_freq_attr_rw(energy_performance_preference_val);
>  cpufreq_freq_attr_rw(perf_limited);
> +cpufreq_freq_attr_rw(ospm_nominal_freq);
>  
>  static struct freq_attr *cppc_cpufreq_attr[] = {
>  	&freqdomain_cpus,
> @@ -1178,6 +1224,7 @@ static struct freq_attr *cppc_cpufreq_attr[] = {
>  	&auto_act_window,
>  	&energy_performance_preference_val,
>  	&perf_limited,
> +	&ospm_nominal_freq,
>  	NULL,
>  };
>  
> diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
> index cd07e1e92bf4..4c9e59643cc0 100644
> --- a/include/acpi/cppc_acpi.h
> +++ b/include/acpi/cppc_acpi.h
> @@ -180,6 +180,8 @@ extern int cpc_write_ffh(int cpunum, struct cpc_reg *reg, u64 val);
>  extern int cppc_get_epp_perf(int cpunum, u64 *epp_perf);
>  extern int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls, bool enable);
>  extern int cppc_set_epp(int cpu, u64 epp_val);
> +extern int cppc_set_ospm_nominal_perf(int cpu, u64 ospm_nominal_perf);
> +extern int cppc_get_ospm_nominal_perf(int cpu, u64 *ospm_nominal_perf);
>  extern int cppc_get_auto_act_window(int cpu, u64 *auto_act_window);
>  extern int cppc_set_auto_act_window(int cpu, u64 auto_act_window);
>  extern int cppc_get_auto_sel(int cpu, bool *enable);
> @@ -268,6 +270,14 @@ static inline int cppc_set_epp(int cpu, u64 epp_val)
>  {
>  	return -EOPNOTSUPP;
>  }
> +static inline int cppc_set_ospm_nominal_perf(int cpu, u64 ospm_nominal_perf)
> +{
> +	return -EOPNOTSUPP;
> +}
> +static inline int cppc_get_ospm_nominal_perf(int cpu, u64 *ospm_nominal_perf)
> +{
> +	return -EOPNOTSUPP;
> +}
>  static inline int cppc_get_auto_act_window(int cpu, u64 *auto_act_window)
>  {
>  	return -EOPNOTSUPP;

