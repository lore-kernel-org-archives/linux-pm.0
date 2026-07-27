Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BED643E486;
	Mon, 27 Jul 2026 17:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785174578; cv=none; b=cDXiPCla6n/hHEd2184RerOHGLdj5rcBXg7GBmeGL/mjFpZSe6Ar3ex2mG6GaXyg5IjHO2zNPDmBagRCzvFYEYIOswgfYcIBEiEqRMhm7FTiCexBpVPlctpcOsX8xZ9ULQUi4fKfcqgWQvxwC5/RD9oQ2fNencoawc6BZTjhQVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785174578; c=relaxed/simple;
	bh=DA7+B9YKYeH7TOdVOM1/vMFaKR/jiRWVQWLtSBrapjk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Jr6W2dOfyqybGxwT+QUgGex7eiC7KcqM3j/IKRZHNGM1LkHptEZ8+g/HsgueDEuZj9vGkvHCd3xh/+Mqe0qIGrgED2maZbNA4VKuIIIZidngsSvB7Mfy2jaDIXqcrqzZhVtaNt6UJFTDgVhr1xg9Gr5k0a+UMgonNA38krH6kJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=toEObFLW; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="toEObFLW"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BED5B1682;
	Mon, 27 Jul 2026 10:49:14 -0700 (PDT)
Received: from [10.57.1.72] (unknown [10.57.1.72])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A86283F763;
	Mon, 27 Jul 2026 10:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1785174558; bh=DA7+B9YKYeH7TOdVOM1/vMFaKR/jiRWVQWLtSBrapjk=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=toEObFLW8bsAC+E+HVlNUupw/MXWKwflgg1zbe+JielVe1ZdhB0/hcdTfyq9KL/1H
	 n5eu4cJ8FZCfADXqusLRoqKYM6AlpY9rOEn82eB5u5wHWWPx6iVQvKamjMiqIPrkCg
	 BysrsokttmMYEpl4C9LcIdUuSkzKrhyg+4Kf0JlM=
Message-ID: <498f0051-e549-4be4-b5bf-56aba1670881@arm.com>
Date: Mon, 27 Jul 2026 18:49:13 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/2] ACPI: CPPC: Add ospm_nominal_perf support
From: Christian Loehle <christian.loehle@arm.com>
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
 <436ae296-cc68-4313-bf76-86908a1e5b29@arm.com>
Content-Language: en-US
In-Reply-To: <436ae296-cc68-4313-bf76-86908a1e5b29@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/27/26 15:01, Christian Loehle wrote:
> On 7/17/26 22:53, Sumit Gupta wrote:
>> Expose the OSPM Nominal Performance register (ACPI 6.6, Section
>> 8.4.6.1.2.6), which conveys the desired nominal performance level
>> at which the platform may run. Unlike the existing read-only
>> Nominal Performance register, it is writable and lets OSPM
>> request a lower nominal level than the platform-reported nominal.
>> The platform classifies performance above this level as boosted
>> and below as throttled for its power/thermal decisions.
>>
>> It is exposed as a per-policy cpufreq sysfs attribute in kHz, to
>> match the cpufreq sysfs unit convention:
>>
>>   /sys/devices/system/cpu/cpuX/cpufreq/ospm_nominal_freq
>>
>> The attribute is documented in
>> Documentation/ABI/testing/sysfs-devices-system-cpu.
>>
>> Writes are converted to perf via cppc_khz_to_perf(), validated
>> against [Lowest Performance, Nominal Performance], and applied to
>> the policy->cpu. The register is assumed shared across the
>> policy->cpus.
>>
>> On read, the current register value is returned, or
>> "<unsupported>" if the platform does not implement the register.
>>
>> Also add the register to the OSPM-set register save/restore
>> table, so its value survives CPU hotplug and reverts to the
>> firmware value on driver unload, like the other registers in
>> the table.
>>
>> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
>> ---
>>  .../ABI/testing/sysfs-devices-system-cpu      | 26 ++++++++++
>>  drivers/acpi/cppc_acpi.c                      | 32 +++++++++++++
>>  drivers/cpufreq/cppc_cpufreq.c                | 47 +++++++++++++++++++
>>  include/acpi/cppc_acpi.h                      | 10 ++++
>>  4 files changed, 115 insertions(+)
>>
>> diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
>> index 82d10d556cc8..a8d592c08823 100644
>> --- a/Documentation/ABI/testing/sysfs-devices-system-cpu
>> +++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
>> @@ -346,6 +346,32 @@ Description:	Performance Limited
>>  
>>  		This file is only present if the cppc-cpufreq driver is in use.
>>  
>> +What:		/sys/devices/system/cpu/cpuX/cpufreq/ospm_nominal_freq
>> +Date:		May 2026
>> +Contact:	linux-pm@vger.kernel.org
>> +Description:	OSPM Nominal Performance (kHz)
>> +
>> +		OSPM uses this attribute to request a nominal performance
>> +		level lower than the platform-reported nominal. The
>> +		platform treats performance above this level as boost
>> +		and below as throttle for power and thermal decisions.
>> +
>> +		Read returns the current value in kHz, or "<unsupported>"
>> +		if the platform does not implement the register. Write a
>> +		kHz value in the range [lowest_freq, nominal_freq].
>> +
>> +		Note that tasks may be migrated from one CPU to another
>> +		by the scheduler's load-balancing algorithm, and if
>> +		different OSPM Nominal Performance values are set for
>> +		those CPUs (through different cpufreq policies), that may
>> +		lead to undesirable outcomes. To avoid such issues it is
>> +		better to set the same value across all policies, or to
>> +		pin every task potentially sensitive to it to a specific
>> +		CPU.
>> +
>> +		This file is only present if the cppc-cpufreq driver is
>> +		in use.
>> +
>>  What:		/sys/devices/system/cpu/cpu*/cache/index3/cache_disable_{0,1}
>>  Date:		August 2008
>>  KernelVersion:	2.6.27
>> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
>> index a7fec6c93178..681d4fd40c11 100644
>> --- a/drivers/acpi/cppc_acpi.c
>> +++ b/drivers/acpi/cppc_acpi.c
>> @@ -1685,6 +1685,38 @@ int cppc_set_epp(int cpu, u64 epp_val)
>>  }
>>  EXPORT_SYMBOL_GPL(cppc_set_epp);
>>  
>> +/**
>> + * cppc_set_ospm_nominal_perf() - Write OSPM Nominal Performance register.
>> + * @cpu: CPU on which to write register.
>> + * @ospm_nominal_perf: Value to write to the OSPM Nominal Performance register.
>> + *
>> + * OSPM Nominal Performance conveys the desired nominal performance level
>> + * at which the platform may run. Per ACPI 6.6, s8.4.6.1.2.6, the value
>> + * must lie within [Lowest Performance, Nominal Performance] and may be
>> + * set independently of Minimum, Maximum and Desired performance. The
>> + * caller is responsible for validating the range.
>> + *
>> + * Return: 0 on success or negative error code.
>> + */
>> +int cppc_set_ospm_nominal_perf(int cpu, u64 ospm_nominal_perf)
>> +{
>> +	return cppc_set_reg_val(cpu, OSPM_NOMINAL_PERF, ospm_nominal_perf);
>> +}
>> +EXPORT_SYMBOL_GPL(cppc_set_ospm_nominal_perf);
>> +
>> +/**
>> + * cppc_get_ospm_nominal_perf() - Read OSPM Nominal Performance register.
>> + * @cpu: CPU from which to read register.
>> + * @ospm_nominal_perf: Pointer to store the OSPM Nominal Performance value.
>> + *
>> + * Return: 0 on success or negative error code.
>> + */
>> +int cppc_get_ospm_nominal_perf(int cpu, u64 *ospm_nominal_perf)
>> +{
>> +	return cppc_get_reg_val(cpu, OSPM_NOMINAL_PERF, ospm_nominal_perf);
>> +}
>> +EXPORT_SYMBOL_GPL(cppc_get_ospm_nominal_perf);
> 
> It's a write-only register, we need to track everything in the driver.
> 

So just reread Pierre's comments, TBH I don't see the point of ever
reading it, even for sysfs reads, but I don't think
reading it for cppc_cpufreq_get_effective_nominal() would be valid
in any case?
