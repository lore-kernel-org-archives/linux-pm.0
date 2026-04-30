Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C528A43634B;
	Thu, 30 Apr 2026 14:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777561069; cv=none; b=Y0kZj57uVp5rNtrv6uphtUyLwAY+SwwvI25fkTysfjT3KHQxfQond/PywXKAdmz3PBf+IV+0qyR75jVnskGThkRm2gAhFZRhx5mr4xhNVV2RmX+77QnmsaW4iKt7Sp7k2VJLCa6dq9oK7CrmMDmE1dPdOuPKHX3+Zc0ETQiKmsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777561069; c=relaxed/simple;
	bh=iGaKif43+SfAXhK26YEklwWGOVDrCInBN6cz7m/+dCs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H453j8pXZtmSd8oqHClqvE6oaxGSf1EbtX8/OUP8lgN+gDDKy22wqAKvJ9j3l3mKW/m2egfBmqxcMjXfsCJ6Yen7+1StcBIQeSxSiQThw1IAoRdH7g5J8DTl9JxX7hHRgGknwqV6PF4SX6P6PHp/P0hwXNzoBmuApHKMFakM0MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BhkUMnmW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BhkUMnmW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14AACC2BCB3;
	Thu, 30 Apr 2026 14:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777561069;
	bh=iGaKif43+SfAXhK26YEklwWGOVDrCInBN6cz7m/+dCs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=BhkUMnmWWep5wEPpbTwmnCuAU4b1GGaT6se0/f9E0IXon3efvLNbIXpjU+HgZNuZL
	 NWQnAsd1Ik3KAsF6FYyGo6v2GjIMFIbXjbk/xLieqp2u3WNMDl4FpzVPzV0qK+PSgd
	 kzcQK8c8LtOSsb0kfCxb5r8OBc7xYe4sGgnyI6xDvzVEnJ0303EjxqECXUCh174bR7
	 tF3TzzVDJT78sB9tBUPoVW4ZVJ9a2l+FkhNKMu9NJdkatxeStRotq0sl4p4oFoRKH+
	 ak7YbWzgGIDUBabyyZGtW7U3gbMWCAn+jftwvFWokAN/gbwh1XcQdCwwl+fKunBAA7
	 rjV7xBPJfCC8w==
Message-ID: <c3625be0-cafd-4b32-8225-30c75ca7eb72@kernel.org>
Date: Thu, 30 Apr 2026 09:57:44 -0500
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] ACPI: CPPC: Add ospm_nominal_perf support
To: Sumit Gupta <sumitg@nvidia.com>, rafael@kernel.org,
 viresh.kumar@linaro.org, lenb@kernel.org, pierre.gondois@arm.com,
 zhenglifeng1@huawei.com, zhanjie9@hisilicon.com, saket.dumbre@intel.com,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, acpica-devel@lists.linux.dev
Cc: treding@nvidia.com, jonathanh@nvidia.com, vsethi@nvidia.com,
 ksitaraman@nvidia.com, sanjayc@nvidia.com, bbasu@nvidia.com
References: <20260430142430.755437-1-sumitg@nvidia.com>
 <20260430142430.755437-3-sumitg@nvidia.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20260430142430.755437-3-sumitg@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/30/26 09:24, Sumit Gupta wrote:
> Add acpi_cppc/ospm_nominal_perf sysfs attribute (read-write) and
> cppc_set_ospm_nominal_perf() API for the OSPM Nominal Performance
> register (ACPI 6.6, Section 8.4.6.1.2.6).
> 
> The register conveys the desired nominal performance level at which
> the platform may run. OSPM can request a lower level than platform
> nominal. Valid range is [Lowest Performance, Nominal Performance].
> The value tells the platform what OSPM considers nominal. The
> platform classifies performance above this as boosted and below as
> throttled. It uses that for its power/thermal decisions.
> 
> Although the register is write-only per spec, cache the OSPM-written
> value in cpc_desc so userspace can observe it via sysfs, and to
> skip redundant writes.
> 
> Initialize to platform nominal at policy init. Override via sysfs
> if needed.
> 
> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
> ---
>   drivers/acpi/cppc_acpi.c       | 69 ++++++++++++++++++++++++++++++++++
>   drivers/cpufreq/cppc_cpufreq.c | 10 +++++
>   include/acpi/cppc_acpi.h       |  6 +++
>   3 files changed, 85 insertions(+)
> 
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index a1c91ce20cc8..fbc620adafad 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -155,6 +155,10 @@ static DEFINE_PER_CPU(struct cpc_desc *, cpc_desc_ptr);
>   static struct kobj_attribute _name =		\
>   __ATTR(_name, 0444, show_##_name, NULL)
>   
> +#define define_one_cppc_rw(_name)		\
> +static struct kobj_attribute _name =		\
> +__ATTR(_name, 0644, show_##_name, store_##_name)
> +
>   #define to_cpc_desc(a) container_of(a, struct cpc_desc, kobj)
>   
>   #define show_cppc_data(access_fn, struct_name, member_name)		\
> @@ -211,6 +215,38 @@ static ssize_t show_feedback_ctrs(struct kobject *kobj,
>   }
>   define_one_cppc_ro(feedback_ctrs);
>   
> +static ssize_t show_ospm_nominal_perf(struct kobject *kobj,
> +				      struct kobj_attribute *attr, char *buf)
> +{
> +	struct cpc_desc *cpc_ptr = to_cpc_desc(kobj);
> +	u64 val = READ_ONCE(cpc_ptr->ospm_nominal_perf);
> +
> +	if (!val)
> +		return -ENODATA;
> +
> +	return sysfs_emit(buf, "%llu\n", val);
> +}
> +
> +static ssize_t store_ospm_nominal_perf(struct kobject *kobj,
> +				       struct kobj_attribute *attr,
> +				       const char *buf, size_t count)
> +{
> +	struct cpc_desc *cpc_ptr = to_cpc_desc(kobj);
> +	u64 val;
> +	int ret;
> +
> +	ret = kstrtou64(buf, 0, &val);
> +	if (ret)
> +		return ret;
> +
> +	ret = cppc_set_ospm_nominal_perf(cpc_ptr->cpu_id, val);
> +	if (ret)
> +		return ret;
> +
> +	return count;
> +}
> +define_one_cppc_rw(ospm_nominal_perf);
> +
>   static struct attribute *cppc_attrs[] = {
>   	&feedback_ctrs.attr,
>   	&reference_perf.attr,
> @@ -222,6 +258,7 @@ static struct attribute *cppc_attrs[] = {
>   	&nominal_perf.attr,
>   	&nominal_freq.attr,
>   	&lowest_freq.attr,
> +	&ospm_nominal_perf.attr,
>   	NULL
>   };
>   ATTRIBUTE_GROUPS(cppc);
> @@ -1683,6 +1720,38 @@ int cppc_set_epp(int cpu, u64 epp_val)
>   }
>   EXPORT_SYMBOL_GPL(cppc_set_epp);
>   
> +/**
> + * cppc_set_ospm_nominal_perf() - Write OSPM Nominal Performance register.
> + * @cpu: CPU on which to write register.
> + * @ospm_nominal_perf: Value to write to the OSPM Nominal Performance register.
> + *
> + * OSPM Nominal Performance allows OSPM to inform the platform of the nominal
> + * performance level it intends to maintain.
> + *
> + * Return: 0 for success, -EINVAL on invalid input, -EOPNOTSUPP if not
> + * supported, -EIO otherwise.
> + */
> +int cppc_set_ospm_nominal_perf(int cpu, u64 ospm_nominal_perf)
> +{
> +	struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpu);
> +	int ret;
> +
> +	if (!ospm_nominal_perf || ospm_nominal_perf > U32_MAX)
> +		return -EINVAL;
> +
> +	if (cpc_desc &&
> +	    READ_ONCE(cpc_desc->ospm_nominal_perf) == ospm_nominal_perf)
> +		return 0;
> +
> +	ret = cppc_set_reg_val(cpu, OSPM_NOMINAL_PERF, ospm_nominal_perf);
> +	if (ret)
> +		return ret;
> +
> +	WRITE_ONCE(cpc_desc->ospm_nominal_perf, ospm_nominal_perf);
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(cppc_set_ospm_nominal_perf);
> +
>   /**
>    * cppc_get_auto_act_window() - Read autonomous activity window register.
>    * @cpu: CPU from which to read register.
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index 7e7f9dfb7a24..d06cba963550 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -715,6 +715,16 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
>   		goto out;
>   	}
>   
> +	/*
> +	 * Initialize OSPM Nominal Performance to inform firmware of
> +	 * OSPM's nominal level. Performance above this value = boost;
> +	 * below = throttle. Uses platform nominal by default.
> +	 */
> +	ret = cppc_set_ospm_nominal_perf(cpu, caps->nominal_perf);
> +	if (ret && ret != -EOPNOTSUPP)
> +		pr_debug("Failed to set ospm_nominal_perf for CPU%d: %d\n",
> +			 cpu, ret);
> +
>   	cppc_cpufreq_cpu_fie_init(policy);
>   	return 0;
>   
> diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
> index 8693890a7275..3771e2ed507d 100644
> --- a/include/acpi/cppc_acpi.h
> +++ b/include/acpi/cppc_acpi.h
> @@ -86,6 +86,7 @@ struct cpc_desc {
>   	struct cpc_register_resource cpc_regs[MAX_CPC_REG_ENT];
>   	struct acpi_psd_package domain_info;
>   	struct kobject kobj;
> +	u32 ospm_nominal_perf;
>   };
>   
>   /* These are indexes into the per-cpu cpc_regs[]. Order is important. */
> @@ -180,6 +181,7 @@ extern int cpc_write_ffh(int cpunum, struct cpc_reg *reg, u64 val);
>   extern int cppc_get_epp_perf(int cpunum, u64 *epp_perf);
>   extern int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls, bool enable);
>   extern int cppc_set_epp(int cpu, u64 epp_val);
> +extern int cppc_set_ospm_nominal_perf(int cpu, u64 ospm_nominal_perf);
>   extern int cppc_get_auto_act_window(int cpu, u64 *auto_act_window);
>   extern int cppc_set_auto_act_window(int cpu, u64 auto_act_window);
>   extern int cppc_get_auto_sel(int cpu, bool *enable);
> @@ -266,6 +268,10 @@ static inline int cppc_set_epp(int cpu, u64 epp_val)
>   {
>   	return -EOPNOTSUPP;
>   }
> +static inline int cppc_set_ospm_nominal_perf(int cpu, u64 ospm_nominal_perf)
> +{
> +	return -EOPNOTSUPP;
> +}
>   static inline int cppc_get_auto_act_window(int cpu, u64 *auto_act_window)
>   {
>   	return -EOPNOTSUPP;

