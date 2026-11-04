Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793813976;
	b=05tIe2rZcqnqG0AL85Ps+DKIMCYGI+RJ740xsf9vsEbbRRs1GpD3t/QAif2dFFzxrpcj
	 7FhlYbyfIKfyeFEYKCHFaFVLjNhACRPuCbDFoJGqiO70xrO/oiF8zDlhPR8B5twJZYEUc
	 /la2nfGh8yDg1JD7vTw9PCCDrn8Tu5QfZbsuBbWqkVPrm4vk5ReXR+0MF8wCEfnJb065X
	 81Vo26FnvYT3wTuPOgewLKXOjJL5oNC6lDvsyK8OB1+aLiG2HSMuooNX3vyGsFPlmv1wm
	 O6lxCMA8NUNqFwv0AxaZNga4+zYh+k6cgG58hTLjQSpoA3WTcNUhDm0+rEiA34Ju5sQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793813976;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=ZRKlMChbObdDIR4yRgSAznCCf8n/+N94KMVWhJg4P/c=;
	b=EQzYpjRLYraIBdSQLa01QJ+jUVde7nnPgCkWeLAgB3g/m7XKBejOiCjau/T9TGz3Ndy8
	 yLXmmAVPn7kWjlSlQhOcTu7VsP6HdAfvlNkdkZAZKyoETNQmF6Zf9aI/u9yL5rwx3lcOD
	 UHKO7XBu88OQlJouB+agYJ97Xu36H+VXaFTwQ2x8Mp+wZumSwQ2BWx1JAFeRZrBzY/2DJ
	 By2kCrDy7gTTb4h1v0oii0kyO3b1qqVnDk+ZSLnLYw5dzokuE9tPhzx5PkRhhIVsKoHaN
	 LtfWZvAGqLci6MgSuHXgArhe/IGpknbETzu0siGzH5lSFgu03jfSSjLlX444vrEf0cw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=qT5ZPMUW;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D657D606A32C;
	Wed,  4 Nov 2026 17:39:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D657D606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=qT5ZPMUW
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 334831BB0;
	Wed,  4 Nov 2026 09:39:32 -0800 (PST)
Received: from [10.0.130.179] (e127648.arm.com [10.0.130.179])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4CCDB3F673;
	Wed,  4 Nov 2026 09:39:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793813975; bh=PyfAlFhsPQ8iAO3hNEf2+zQIfdM2JyqpLxshBsMkr8M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qT5ZPMUW+6XHss/1mzVLtw3ZoufepZXQsy7i6cOLqZ+ZAIJjG5CaRxYGxXLaTrvdV
	 H5iitWPD/U6DLy5A9Bj7hJIrQTsFl2YAE+P7mG5WQcLIpLsAW/DN6AfxywqTalNo7C
	 eU0uCkbVjzF4o52wsTfxlRUTlCaWGG3m4Agzj6v0=
Message-ID: <8be9a4f7-1b9a-4372-9751-6e5074305a5c@arm.com>
Date: Wed, 4 Nov 2026 17:39:29 +0000
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
Subject: Re: [PATCH v8 2/3] cpufreq: CPPC: Add ospm_nominal_freq attribute
To: Sumit Gupta <sumitg@nvidia.com>, rafael@kernel.org,
 viresh.kumar@linaro.org, pierre.gondois@arm.com, ionela.voinescu@arm.com,
 zhenglifeng1@huawei.com, zhanjie9@hisilicon.com, lenb@kernel.org,
 mario.limonciello@amd.com, maciej.wieczor-retman@intel.com,
 pawel.chmielewski@intel.com, linux-pm@vger.kernel.org,
 linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev,
 linux-kernel@vger.kernel.org
Cc: linux-tegra@vger.kernel.org, treding@nvidia.com, jonathanh@nvidia.com,
 vsethi@nvidia.com, ksitaraman@nvidia.com, sanjayc@nvidia.com,
 mochs@nvidia.com, bbasu@nvidia.com
References: <20261030172745.2045743-1-sumitg@nvidia.com>
 <20261030172745.2045743-3-sumitg@nvidia.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <20261030172745.2045743-3-sumitg@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/30/26 17:27, Sumit Gupta wrote:
> OSPM Nominal Performance (ACPI 6.6, Section 8.4.6.1.2.6) lets the OS
> request a nominal performance level below the platform-reported one. The
> platform treats performance above that level as boosted and below it as
> throttled. A lower value moves that boundary down, so more levels count
> as boost.
> 
> Expose it as a per-policy cpufreq attribute in kHz, matching the unit
> convention of the other frequency attributes:
> 
>   /sys/devices/system/cpu/cpuX/cpufreq/ospm_nominal_freq
> 
> Writes are converted with cppc_khz_to_perf() and rejected unless they
> fall in [Lowest Performance, Nominal Performance]. The register cannot
> be read back, so a read returns the last value written, or "<unset>"
> before the first write.
> 
> Also track the register in the OSPM-set save/restore table, so a
> requested value survives CPU hotplug and suspend/resume. The store
> handler records the request rather than init() capturing a firmware
> value, so the driver writes the register only once the OS has set it.
> CPU offline and driver unload write the platform-reported Nominal
> Performance to the register.
> 
> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>

Reviewed-by: Christian Loehle <christian.loehle@arm.com>

> ---
>  .../ABI/testing/sysfs-devices-system-cpu      |  27 +++++
>  drivers/cpufreq/cppc_cpufreq.c                | 101 ++++++++++++++++--
>  2 files changed, 121 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
> index 545687ebadcc..6af7fa86e44c 100644
> --- a/Documentation/ABI/testing/sysfs-devices-system-cpu
> +++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
> @@ -350,6 +350,33 @@ Description:	Performance Limited
>  
>  		This file is only present if the cppc-cpufreq driver is in use.
>  
> +What:		/sys/devices/system/cpu/cpuX/cpufreq/ospm_nominal_freq
> +Date:		October 2026
> +Contact:	linux-pm@vger.kernel.org
> +Description:	OSPM Nominal Performance (kHz)
> +
> +		OSPM uses this attribute to request a nominal performance level
> +		lower than the platform-reported nominal. The platform treats
> +		performance above this level as boost and below as throttle.
> +
> +		Write a value in kHz, between the frequencies corresponding to
> +		Lowest Performance and Nominal Performance.
> +
> +		The register cannot be read back, so a read returns the last
> +		value written, rounded to a performance level. It returns
> +		"<unset>" before the first write. Reads and writes fail with
> +		-EOPNOTSUPP if the platform does not implement the register.
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
> index 76cb803617f5..662397526433 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -34,11 +34,13 @@ static struct cpufreq_driver cppc_cpufreq_driver;
>   * reapplied from online() across CPU hotplug, and the firmware value is
>   * restored from offline().
>   *
> - * Autonomous Selection (auto_sel) is kept first, as the registers after it
> - * only have meaning while it is enabled.
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
> @@ -51,6 +53,11 @@ struct cppc_saved_reg {
>  };
>  
>  static const struct cppc_saved_reg cppc_saved_regs[CPPC_NR_SAVED_REGS] = {
> +	/* The register is write-only, so the driver tracks the requested value. */
> +	[CPPC_SAVED_OSPM_NOMINAL_PERF] = {
> +		.name = "ospm_nominal_perf",
> +		.set = cppc_set_ospm_nominal_perf,
> +	},
>  	[CPPC_SAVED_AUTO_SEL] = {
>  		.name = "auto_sel",
>  		.get = cppc_get_auto_sel,
> @@ -83,6 +90,9 @@ enum cppc_saved_type {
>   *   CPPC_SAVED_REQUESTED - value the OS asked for, reapplied at online().
>   *                          It starts as the firmware value and changes only
>   *                          when a write from the OS succeeds.
> + *
> + * A write-only register cannot be read back. init() leaves both values unset,
> + * and its store handler sets them.
>   */
>  struct cppc_policy_state {
>  	u64 regs[CPPC_NR_SAVED_REGS][CPPC_NR_SAVED_TYPES];
> @@ -135,11 +145,19 @@ static int cppc_cpufreq_save_firmware_regs(struct cpufreq_policy *policy)
>  	int i, ret;
>  
>  	for (i = 0; i < CPPC_NR_SAVED_REGS; i++) {
> -		ret = cppc_saved_regs[i].get(cpu, &val);
> -		if (ret == -EOPNOTSUPP)
> +		const struct cppc_saved_reg *reg = &cppc_saved_regs[i];
> +
> +		if (!reg->get) {
> +			/* A write-only register has no value to read. */
>  			val = U64_MAX;
> -		else if (ret)
> -			return ret;
> +		} else {
> +			ret = reg->get(cpu, &val);
> +			/* Leave a register the platform does not implement unset. */
> +			if (ret == -EOPNOTSUPP)
> +				val = U64_MAX;
> +			else if (ret)
> +				return ret;
> +		}
>  
>  		st->regs[i][CPPC_SAVED_FIRMWARE] = val;
>  		st->regs[i][CPPC_SAVED_REQUESTED] = val;
> @@ -198,6 +216,12 @@ static void cppc_cpufreq_apply_saved_regs(struct cpufreq_policy *policy,
>  	u64 auto_sel, val;
>  	int i;
>  
> +	/* Registers before auto_sel do not depend on it. */
> +	for (i = 0; i < CPPC_SAVED_AUTO_SEL; i++) {
> +		val = st->regs[i][saved_type];
> +		cppc_cpufreq_write_saved_reg(cpu, i, val, saved_type);
> +	}
> +
>  	auto_sel = st->regs[CPPC_SAVED_AUTO_SEL][saved_type];
>  
>  	if (auto_sel)
> @@ -1470,11 +1494,73 @@ static int cppc_get_perf_limited_filtered(int cpu, u64 *perf_limited)
>  CPPC_CPUFREQ_ATTR_RW_U64(perf_limited, cppc_get_perf_limited_filtered,
>  			 cppc_set_perf_limited)
>  
> +static ssize_t show_ospm_nominal_freq(struct cpufreq_policy *policy, char *buf)
> +{
> +	const struct cppc_policy_state *st = cppc_cpufreq_policy_state(policy);
> +	struct cppc_cpudata *cpu_data = policy->driver_data;
> +	u64 perf;
> +
> +	if (!cppc_ospm_nominal_perf_supported(policy->cpu))
> +		return -EOPNOTSUPP;
> +
> +	/* The register cannot be read back, so report the tracked request. */
> +	perf = st->regs[CPPC_SAVED_OSPM_NOMINAL_PERF][CPPC_SAVED_REQUESTED];
> +	if (perf == U64_MAX)
> +		return sysfs_emit(buf, "<unset>\n");
> +
> +	return sysfs_emit(buf, "%u\n",
> +			  cppc_perf_to_khz(&cpu_data->perf_caps, perf));
> +}
> +
> +static ssize_t store_ospm_nominal_freq(struct cpufreq_policy *policy,
> +				       const char *buf, size_t count)
> +{
> +	struct cppc_cpudata *cpu_data = policy->driver_data;
> +	struct cppc_policy_state *st;
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
> +	 * The OS can write this register but cannot read it back.
> +	 *
> +	 * The register lets the OS ask for a nominal level below the platform
> +	 * Nominal Performance. offline() and driver unload write the platform
> +	 * Nominal in place of the requested value. This removes the lower
> +	 * level the OS asked for. The value from before the first OS write
> +	 * cannot be read, so the driver cannot restore it. online() writes
> +	 * the requested value again.
> +	 *
> +	 * Set both values here and not at init(). The driver then writes the
> +	 * register only after the OS has set it.
> +	 */
> +	st = cppc_cpufreq_policy_state(policy);
> +	st->regs[CPPC_SAVED_OSPM_NOMINAL_PERF][CPPC_SAVED_REQUESTED] = perf;
> +	st->regs[CPPC_SAVED_OSPM_NOMINAL_PERF][CPPC_SAVED_FIRMWARE] =
> +		cpu_data->perf_caps.nominal_perf;
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
> @@ -1482,6 +1568,7 @@ static struct freq_attr *cppc_cpufreq_attr[] = {
>  	&auto_act_window,
>  	&energy_performance_preference_val,
>  	&perf_limited,
> +	&ospm_nominal_freq,
>  	NULL,
>  };
>  

