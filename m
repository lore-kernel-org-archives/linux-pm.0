Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8509A456E11;
	Fri, 25 Sep 2026 14:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790348080; cv=none; b=bJAry4UlzVEY4iB105l6vcc9hgj6O9p2WTKIzlWNJ1qOu60FFo3BHvIppqB7MwfQ6mYGwczL5uxBeGkmF9oi6bVOgMntmHWc1IU4v6DkgNr7FHUdOGV2WFubUbdaIBeREPXhqDAj+DnGqIrVV2hxNc47ytIQ7FmUSJctCaScW/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790348080; c=relaxed/simple;
	bh=4odbNr7XKjDR4UerAocdPmyXi9i3fGo5F/8mDupxdk8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KXpfxeFEmaPLSua88u1fDibJUryVLuuaaKGtvSCS96oPKFatYsvtgJV3PDvBkkRtNMMeT1tDZhO+AHLcS0aQMLKVcp93qLYdoFr0iIArAAHFV6SvBCwDAmpKDmmFyqpqTHk0kCjdyH9MqV44h+LVl28OCyrmpLvAQNDHPABDDZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lLcLDFB9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lLcLDFB9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 038E21F000FF;
	Fri, 25 Sep 2026 14:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790348066;
	bh=nFtidKjF7ID6JhYxagT5KO0CT27pZ9hd8nUSViGiOP0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=lLcLDFB9hdEQRY+YTjxY7OfjdZ2e+ssu648iyuXq6TeqaZzrolFGmd43f1+lw7zpi
	 p/h6FoWutyVy5PNmVR52loVC5tBe7jYUHX3x3OmMqv3RQO/45DHVIy3bUSiorPvjNv
	 wmBF6zTfafPKPxaiVeSk0Apfw9D9mu5MIbmTtClJjSUFEkKGyUoBnY1Y0Z6v8kFyNx
	 nEgOPIm/bGbBs1gVc+1siZkCcXqeOo4msei8mBLvcevO5sE3MIBoJSi2ml4VVbVOsE
	 rGvfH6K2DyPmWF4T+99T3wj2vvzMtfhC0bPJiMuxHW8RfthXlFQUBa/rPhe4GsjMQc
	 jyFGb1n4VzA8w==
Message-ID: <c20aa0b6-30a7-4c88-80e0-21bd5e97c0c8@kernel.org>
Date: Fri, 25 Sep 2026 09:54:24 -0500
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] ACPI: CPPC: Refactor boost ratio handling
Content-Language: en-US
To: Christian Loehle <christian.loehle@arm.com>,
 =?UTF-8?Q?Rafael_J_=2E_Wysocki_=E2=8F=8E?= <rafael@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, K Prateek Nayak <kprateek.nayak@amd.com>,
 x86@kernel.org, Mario Limonciello <mario.limonciello@amd.com>
References: <20260924160052.2858456-1-superm1@kernel.org>
 <20260924160052.2858456-2-superm1@kernel.org>
 <213bc2ba-2ee4-4a89-9054-3bd953546789@arm.com>
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <213bc2ba-2ee4-4a89-9054-3bd953546789@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/25/26 04:40, Christian Loehle wrote:
> On 9/24/26 17:00, Mario Limonciello (AMD) wrote:
>> From: Mario Limonciello <mario.limonciello@amd.com>
>>
>> Rename amd_get_boost_ratio_numerator() to amd_get_effective_highest_perf()
>> to better reflect that it returns the effective highest performance value
>> for a CPU, accounting for preferred cores and heterogeneous topologies.
>>
>> Add a new helper amd_get_boost_ratio() for doing both for boost
>> ratio calculations and update callers to use it.
>>
>> This refactoring is needed because on some AMD systems (Zen6+),
>> the boost ratio should be calculated from frequency values rather than
>> performance values.
> 
> I think I see why you chose to implement it this way (the x86 APERF / MPERF)
> issue, but I'd still prefer it to be spelled out here why this is necessary.
> 

Do you mean in the commit message, like spin the patch?  Or just in this 
thread?

Not all cores will operate at the same frequency and fixed scaling 
values from CPPC perf don't apply anymore.
> 
>>
>> The frequency values will eventually come from the BIOS, but for now
>> use some hardcoded values for Zen6 platforms.
>>
>> Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>>   arch/x86/kernel/acpi/cppc.c    | 166 ++++++++++++++++++++++-----------
>>   drivers/cpufreq/acpi-cpufreq.c |   5 +-
>>   drivers/cpufreq/amd-pstate.c   |  14 ++-
>>   include/acpi/cppc_acpi.h       |  14 ++-
>>   4 files changed, 134 insertions(+), 65 deletions(-)
>>
>> diff --git a/arch/x86/kernel/acpi/cppc.c b/arch/x86/kernel/acpi/cppc.c
>> index d2185b7a20306..1c6bf56c3215b 100644
>> --- a/arch/x86/kernel/acpi/cppc.c
>> +++ b/arch/x86/kernel/acpi/cppc.c
>> @@ -11,6 +11,7 @@
>>   #include <asm/msr.h>
>>   #include <asm/processor.h>
>>   #include <asm/topology.h>
>> +#include <asm/cpu_device_id.h>
>>   
>>   #define CPPC_HIGHEST_PERF_PERFORMANCE	196
>>   #define CPPC_HIGHEST_PERF_PREFCORE	166
>> @@ -95,31 +96,18 @@ int cpc_write_ffh(int cpunum, struct cpc_reg *reg, u64 val)
>>   
>>   static void amd_set_max_freq_ratio(void)
>>   {
>> -	struct cppc_perf_caps perf_caps;
>> -	u64 numerator, nominal_perf;
>> +	u64 numerator, denominator;
>>   	u64 perf_ratio;
>>   	int rc;
>>   
>> -	rc = cppc_get_perf_caps(0, &perf_caps);
>> -	if (rc) {
>> -		pr_debug("Could not retrieve perf counters (%d)\n", rc);
>> -		return;
>> -	}
>> -
>> -	rc = amd_get_boost_ratio_numerator(0, &numerator);
>> +	rc = amd_get_boost_ratio(0, &numerator, &denominator);
>>   	if (rc) {
>> -		pr_debug("Could not retrieve highest performance (%d)\n", rc);
>> -		return;
>> -	}
>> -	nominal_perf = perf_caps.nominal_perf;
>> -
>> -	if (!nominal_perf) {
>> -		pr_debug("Could not retrieve nominal performance\n");
>> +		pr_debug("Could not retrieve boost ratio (%d)\n", rc);
>>   		return;
>>   	}
>>   
>>   	/* midpoint between max_boost and max_P */
>> -	perf_ratio = (div_u64(numerator * SCHED_CAPACITY_SCALE, nominal_perf) + SCHED_CAPACITY_SCALE) >> 1;
>> +	perf_ratio = (div_u64(numerator * SCHED_CAPACITY_SCALE, denominator) + SCHED_CAPACITY_SCALE) >> 1;
>>   
>>   	freq_invariance_set_perf_ratio(perf_ratio, false);
>>   }
>> @@ -239,35 +227,30 @@ int amd_detect_prefcore(bool *detected)
>>   EXPORT_SYMBOL_GPL(amd_detect_prefcore);
>>   
>>   /**
>> - * amd_get_boost_ratio_numerator: Get the numerator to use for boost ratio calculation
>> - * @cpu: CPU to get numerator for.
>> - * @numerator: Output variable for numerator.
>> - *
>> - * Determine the numerator to use for calculating the boost ratio on
>> - * a CPU. On systems that support preferred cores, this will be a hardcoded
>> - * value. On other systems this will the highest performance register value.
>> + * amd_get_effective_highest_perf: Get the effective highest performance value
>> + * @cpu: CPU to get highest performance for.
>>    *
>> - * If booting the system with amd-pstate enabled but preferred cores disabled then
>> - * the correct boost numerator will be returned to match hardware capabilities
>> - * even if the preferred cores scheduling hints are not enabled.
>> + * Get the effective highest performance value for a CPU, accounting for
>> + * preferred cores and heterogeneous topologies. On systems with preferred
>> + * cores, this may be a hardcoded value. On heterogeneous systems, this
>> + * may be a per-CPU value. On other systems, this is the shared highest
>> + * performance value.
>>    *
>> - * Return: 0 for success, negative error code otherwise.
>> + * Return: Effective highest performance value, or negative error code.
>>    */
>> -int amd_get_boost_ratio_numerator(unsigned int cpu, u64 *numerator)
>> +int amd_get_effective_highest_perf(unsigned int cpu)
>>   {
>>   	bool prefcore;
>>   	int ret;
>>   	u32 tmp;
>>   
>>   	ret = amd_detect_prefcore(&prefcore);
>> -	if (ret)
>> +	if (ret < 0)
>>   		return ret;
>>   
>>   	/* without preferred cores, return the highest perf register value */
>> -	if (!prefcore) {
>> -		*numerator = boost_numerator;
>> -		return 0;
>> -	}
>> +	if (!prefcore)
>> +		return boost_numerator;
>>   
>>   	/*
>>   	 * For AMD CPUs with Family ID 19H and Model ID range 0x70 to 0x7f,
>> @@ -277,8 +260,7 @@ int amd_get_boost_ratio_numerator(unsigned int cpu, u64 *numerator)
>>   	if (cpu_feature_enabled(X86_FEATURE_ZEN4)) {
>>   		switch (boot_cpu_data.x86_model) {
>>   		case 0x70 ... 0x7f:
>> -			*numerator = CPPC_HIGHEST_PERF_PERFORMANCE;
>> -			return 0;
>> +			return CPPC_HIGHEST_PERF_PERFORMANCE;
>>   		default:
>>   			break;
>>   		}
>> @@ -286,28 +268,100 @@ int amd_get_boost_ratio_numerator(unsigned int cpu, u64 *numerator)
>>   
>>   	/* detect if running on heterogeneous design */
>>   	if (cpu_feature_enabled(X86_FEATURE_AMD_HTR_CORES)) {
>> -		switch (cpu_data(cpu).topo.cpu_type) {
>> -		case TOPO_CPU_TYPE_UNKNOWN:
>> -		case TOPO_CPU_TYPE_ANY:
>> -			pr_warn("Undefined core type found for cpu %d\n", cpu);
>> -			break;
>> -		case TOPO_CPU_TYPE_PERFORMANCE:
>> -			/* use the max scale for performance cores */
>> -			*numerator = CPPC_HIGHEST_PERF_PERFORMANCE;
>> -			return 0;
>> -		case TOPO_CPU_TYPE_LOW_POWER:
>> -		case TOPO_CPU_TYPE_EFFICIENCY:
>> -			/* use the highest perf value for efficiency and low-power cores */
>> -			ret = amd_get_highest_perf(cpu, &tmp);
>> -			if (ret)
>> -				return ret;
>> -			*numerator = tmp;
>> -			return 0;
>> -		}
>> +		if (cpu_feature_enabled(X86_FEATURE_ZEN5) &&
>> +		    cpu_data(cpu).topo.cpu_type == TOPO_CPU_TYPE_PERFORMANCE)
>> +			return CPPC_HIGHEST_PERF_PERFORMANCE;
>> +
>> +		/* Zen 5 efficiency, and Zen 6+ */
>> +		ret = amd_get_highest_perf(cpu, &tmp);
>> +		if (ret < 0)
>> +			return ret;
>> +
>> +		return tmp;
>> +	}
>> +
>> +	return CPPC_HIGHEST_PERF_PREFCORE;
>> +}
>> +EXPORT_SYMBOL_GPL(amd_get_effective_highest_perf);
>> +
>> +struct amd_max_freq {
>> +	u32 performance;
>> +	u32 efficiency;
>> +	u32 low_power;
>> +};
>> +
>> +static const struct amd_max_freq max_freq_zen6_client = {
>> +	.performance = 5025,
>> +	.efficiency = 3524,
>> +	.low_power = 2399,
>> +};
>> +
>> +int amd_get_max_frequency(unsigned int cpu)
>> +{
>> +	enum x86_topology_cpu_type type = cpu_data(cpu).topo.cpu_type;
>> +	const struct amd_max_freq *max_freq = NULL;
>> +
>> +	if (cpu_feature_enabled(X86_FEATURE_ZEN6) &&
>> +	    cpu_feature_enabled(X86_FEATURE_AMD_HTR_CORES))
>> +		max_freq = &max_freq_zen6_client;
>> +
>> +	if (!max_freq)
>> +		return 0;
>> +
>> +	switch (type) {
>> +	case TOPO_CPU_TYPE_PERFORMANCE:
>> +		return max_freq->performance;
>> +	case TOPO_CPU_TYPE_EFFICIENCY:
>> +		return max_freq->efficiency;
>> +	case TOPO_CPU_TYPE_LOW_POWER:
>> +		return max_freq->low_power;
>> +	default:
>> +		break;
>>   	}
>>   
>> -	*numerator = CPPC_HIGHEST_PERF_PREFCORE;
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(amd_get_max_frequency);
>> +
>> +/**
>> + * amd_get_boost_ratio: Get numerator and denominator for boost ratio
>> + * @cpu: CPU to get the boost ratio for.
>> + * @numerator: Output variable for numerator.
>> + * @denominator: Output variable for denominator.
>> + *
>> + * Get the numerator and denominator for calculating the boost ratio.
>> + *
>> + * Return: 0 for success, negative error code otherwise.
>> + */
>> +int amd_get_boost_ratio(unsigned int cpu, u64 *numerator, u64 *denominator)
>> +{
>> +	struct cppc_perf_caps perf_caps;
>> +	int max_frequency;
>> +	int ret;
>> +
>> +	ret = cppc_get_perf_caps(cpu, &perf_caps);
>> +	if (ret)
>> +		return ret;
>> +
>> +	max_frequency = amd_get_max_frequency(cpu);
>> +	/* Use frequency values if available */
>> +	if (max_frequency && perf_caps.nominal_freq) {
>> +		*numerator = max_frequency;
>> +		*denominator = perf_caps.nominal_freq;
>> +		return 0;
>> +	}
>> +
>> +	/* Fall back to performance values */
>> +	ret = amd_get_effective_highest_perf(cpu);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	*numerator = ret;
>> +
>> +	*denominator = perf_caps.nominal_perf;
>> +	if (!*denominator)
>> +		return -EINVAL;
>>   
>>   	return 0;
>>   }
>> -EXPORT_SYMBOL_GPL(amd_get_boost_ratio_numerator);
>> +EXPORT_SYMBOL_GPL(amd_get_boost_ratio);
>> diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
>> index 10ea6035f4ad6..523ee1a06ef8a 100644
>> --- a/drivers/cpufreq/acpi-cpufreq.c
>> +++ b/drivers/cpufreq/acpi-cpufreq.c
>> @@ -640,12 +640,13 @@ static u64 get_max_boost_ratio(unsigned int cpu, u64 *nominal_freq)
>>   	}
>>   
>>   	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD) {
>> -		ret = amd_get_boost_ratio_numerator(cpu, &highest_perf);
>> -		if (ret) {
>> +		ret = amd_get_effective_highest_perf(cpu);
>> +		if (ret < 0) {
>>   			pr_debug("CPU%d: Unable to get boost ratio numerator (%d)\n",
>>   				 cpu, ret);
>>   			return 0;
>>   		}
>> +		highest_perf = ret;
>>   	} else {
>>   		highest_perf = perf_caps.highest_perf;
>>   	}
>> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
>> index fbccbe86c94d0..496e0342c1c90 100644
>> --- a/drivers/cpufreq/amd-pstate.c
>> +++ b/drivers/cpufreq/amd-pstate.c
>> @@ -555,11 +555,13 @@ static int msr_init_perf(struct amd_cpudata *cpudata)
>>   	if (ret)
>>   		return ret;
>>   
>> -	ret = amd_get_boost_ratio_numerator(cpudata->cpu, &numerator);
>> -	if (ret)
>> +	ret = amd_get_effective_highest_perf(cpudata->cpu);
>> +	if (ret < 0)
>>   		return ret;
>>   
>> -	ret = rdmsrq_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ, &cppc_req);
>> +	numerator = ret;
>> +
>> +	ret = rdmsrq_safe_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ, &cppc_req);
>>   	if (ret)
>>   		return ret;
>>   
>> @@ -590,10 +592,12 @@ static int shmem_init_perf(struct amd_cpudata *cpudata)
>>   	if (ret)
>>   		return ret;
>>   
>> -	ret = amd_get_boost_ratio_numerator(cpudata->cpu, &numerator);
>> -	if (ret)
>> +	ret = amd_get_effective_highest_perf(cpudata->cpu);
>> +	if (ret < 0)
>>   		return ret;
>>   
>> +	numerator = ret;
>> +
>>   	perf.highest_perf = numerator;
>>   	perf.max_limit_perf = numerator;
>>   	perf.min_limit_perf = cppc_perf.lowest_perf;
>> diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
>> index 3f0005abac648..5bcdb0e553b96 100644
>> --- a/include/acpi/cppc_acpi.h
>> +++ b/include/acpi/cppc_acpi.h
>> @@ -202,7 +202,9 @@ extern int cppc_set_auto_sel(int cpu, bool enable);
>>   extern int cppc_get_perf_limited(int cpu, u64 *perf_limited);
>>   extern int cppc_set_perf_limited(int cpu, u64 bits_to_clear);
>>   extern int amd_get_highest_perf(unsigned int cpu, u32 *highest_perf);
>> -extern int amd_get_boost_ratio_numerator(unsigned int cpu, u64 *numerator);
>> +extern int amd_get_effective_highest_perf(unsigned int cpu);
>> +extern int amd_get_max_frequency(unsigned int cpu);
>> +extern int amd_get_boost_ratio(unsigned int cpu, u64 *numerator, u64 *denominator);
>>   extern int amd_detect_prefcore(bool *detected);
>>   #else /* !CONFIG_ACPI_CPPC_LIB */
>>   static inline int cppc_get_desired_perf(int cpunum, u64 *desired_perf)
>> @@ -321,7 +323,15 @@ static inline int amd_get_highest_perf(unsigned int cpu, u32 *highest_perf)
>>   {
>>   	return -ENODEV;
>>   }
>> -static inline int amd_get_boost_ratio_numerator(unsigned int cpu, u64 *numerator)
>> +static inline int amd_get_effective_highest_perf(unsigned int cpu)
>> +{
>> +	return -EOPNOTSUPP;
>> +}
>> +static inline int amd_get_max_frequency(unsigned int cpu)
>> +{
>> +	return 0;
>> +}
>> +static inline int amd_get_boost_ratio(unsigned int cpu, u64 *numerator, u64 *denominator)
>>   {
>>   	return -EOPNOTSUPP;
>>   }
> 

