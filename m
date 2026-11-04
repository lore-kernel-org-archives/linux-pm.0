Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793813957;
	b=cHqss5bdygOV69kcpOTHvb2EM1P5FQzdQA0fhmC0QEaE4pVGUGXXMzMZlliH/wZHlyrh
	 Xv0QGPRgzRw6mhmiOcKY3gwCJ/OaQ4lNiX41T7jS49yEWxHBQEnZjmtYJGMOcmR5fP/uI
	 n2Jbwy5JTq23lJdHcWfG6cWucD8Iwcj4LjJ3Qu1JAVraf+AdndpRysCUlJc24wkVMznWX
	 NLC7azRz2xl1OzgCpwEL9aDop/x2kENYf2lzUKgaZlebfH5YGyj/AJsZqRweyWtstHEnU
	 ngWpA9mLS/S9yeh3j9mz1EOkL0tT6NtAZlfJESpvv6McRmiirv9VR0RVLjR5e7q44XQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793813957;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=9CcDkjihi+yiVBZ4yDcPql+O9dE6UXuwMcC+J0dZmUE=;
	b=cxOxJURE5/qGyCAv4MTD8oE3hv9Sd8qcmkM934IgZJhCemLJmWW6pjpgJkEtYxBjbr26
	 ATJWLi4f9rpFf4ynwMlFv+VJOGaXGeRZKFjK2UzIVSYDqIXnOakFLeI/4Xg4xq07iKXYl
	 mQBEW49Tk0I65CrLN3YneaWP6J3+CKZeYLIKBN+08GaQVpLHQOyVFYIVQ3uoDpD+KsGzX
	 99leoN4g1kXSrFLO/TAkrPlN9411whkYTjRlGB8n9SJ2Jsp+ddgsK7TnddCjecTDVOh2z
	 mrthd8J7FlG7i0zCANThlcRL04ds8fY8ppvRkzETJ8RCKNlBRa3JmXxAUkprW9enjew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=DVRMrYGo;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCB32606A32E;
	Wed,  4 Nov 2026 17:39:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DCB32606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=DVRMrYGo
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ED35B1BB0;
	Wed,  4 Nov 2026 09:39:12 -0800 (PST)
Received: from [10.0.130.179] (e127648.arm.com [10.0.130.179])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D7CD13F673;
	Wed,  4 Nov 2026 09:39:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793813956; bh=/kyJGjVyWY310MgT5Xs9DoLM2JJz9yZzou7eKEpHhQ0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=DVRMrYGopu7hfbBwieaIEXe7c7Z92PBAzHy7ulMbhJD+hoaYTBXEyH2ha7GUBsGBf
	 zrurxqeaIA2Qs7md8EwI8Mv4t8mFutsixlKN6TlziDNGZREfw1mmJ90aRttF+MaFiI
	 GGPPF+opoDATNdEYtaU7YNgBD8aOH5Dq3oXltZCs=
Message-ID: <4b7d65dd-6103-4363-ac9b-cbcd2ece905b@arm.com>
Date: Wed, 4 Nov 2026 17:39:10 +0000
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
Subject: Re: [PATCH v8 1/3] ACPI: CPPC: Add ospm_nominal_perf support
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
 <20261030172745.2045743-2-sumitg@nvidia.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <20261030172745.2045743-2-sumitg@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/30/26 17:27, Sumit Gupta wrote:
> Expose the OSPM Nominal Performance register (ACPI 6.6, Section
> 8.4.6.1.2.6), which conveys the nominal performance level at which the
> platform may run. Unlike the read-only Nominal Performance register, it
> is writable, so OSPM can ask for a nominal level below the
> platform-reported one, which then becomes the boundary between boosted
> and throttled operation.
> 
> Add cppc_set_ospm_nominal_perf() to write the register. Per the spec,
> the value must lie in [Lowest Performance, Nominal Performance], which
> the caller is responsible for validating.
> 
> Add cppc_ospm_nominal_perf_supported() to report whether the platform
> implements the register as writable, since a write-only register cannot
> be probed by reading it. It uses the same cpc_is_writable() test as the
> setter, so support is never reported for a register that a write would
> reject, and takes cpc_desc_lock while looking the descriptor up.
> 
> The register also joins the writable set that the SystemMemory overlap
> validation uses, as the driver now writes it and can compete with
> another control sharing an access unit.
> 
> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>

Reviewed-by: Christian Loehle <christian.loehle@arm.com>

> ---
>  drivers/acpi/cppc_acpi.c | 44 ++++++++++++++++++++++++++++++++++++++++
>  include/acpi/cppc_acpi.h | 10 +++++++++
>  2 files changed, 54 insertions(+)
> 
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index 5a1f84fddb7f..3a0ecdd1ab11 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -463,6 +463,7 @@ static bool cpc_reg_is_writable(unsigned int reg_idx)
>  	case AUTO_SEL_ENABLE:
>  	case AUTO_ACT_WINDOW:
>  	case ENERGY_PERF:
> +	case OSPM_NOMINAL_PERF:
>  		return true;
>  	default:
>  		return false;
> @@ -3232,6 +3233,49 @@ int cppc_set_epp(int cpu, u64 epp_val)
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
> + * Return: 0 on success, -EOPNOTSUPP if the platform does not implement the
> + * register as writable, or another negative error code.
> + */
> +int cppc_set_ospm_nominal_perf(int cpu, u64 ospm_nominal_perf)
> +{
> +	return cppc_set_reg_val(cpu, OSPM_NOMINAL_PERF, ospm_nominal_perf);
> +}
> +EXPORT_SYMBOL_GPL(cppc_set_ospm_nominal_perf);
> +
> +/**
> + * cppc_ospm_nominal_perf_supported() - Check OSPM Nominal Performance support.
> + * @cpu: CPU to query.
> + *
> + * The OSPM Nominal Performance register is write-only, so its value
> + * cannot be read back. This only reports whether the platform implements
> + * it as a writable register.
> + *
> + * Context: Process context.
> + * Return: true if the register is supported, false otherwise.
> + */
> +bool cppc_ospm_nominal_perf_supported(int cpu)
> +{
> +	struct cpc_desc *cpc_desc;
> +
> +	guard(mutex)(&cpc_desc_lock);
> +	cpc_desc = per_cpu(cpc_desc_ptr, cpu);
> +
> +	return cpc_desc &&
> +	       cpc_is_writable(&cpc_desc->cpc_regs[OSPM_NOMINAL_PERF]);
> +}
> +EXPORT_SYMBOL_GPL(cppc_ospm_nominal_perf_supported);
> +
>  /**
>   * cppc_get_auto_act_window() - Read autonomous activity window register.
>   * @cpu: CPU from which to read register.
> diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
> index a5545fd3f8bd..2cec54b4d2e2 100644
> --- a/include/acpi/cppc_acpi.h
> +++ b/include/acpi/cppc_acpi.h
> @@ -195,6 +195,8 @@ extern int cpc_write_ffh(int cpunum, struct cpc_reg *reg, u64 val);
>  extern int cppc_get_epp_perf(int cpunum, u64 *epp_perf);
>  extern int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls, bool enable);
>  extern int cppc_set_epp(int cpu, u64 epp_val);
> +extern int cppc_set_ospm_nominal_perf(int cpu, u64 ospm_nominal_perf);
> +extern bool cppc_ospm_nominal_perf_supported(int cpu);
>  extern int cppc_get_auto_act_window(int cpu, u64 *auto_act_window);
>  extern int cppc_set_auto_act_window(int cpu, u64 auto_act_window);
>  extern int cppc_get_auto_sel(int cpu, u64 *enable);
> @@ -290,6 +292,14 @@ static inline int cppc_set_epp(int cpu, u64 epp_val)
>  {
>  	return -EOPNOTSUPP;
>  }
> +static inline int cppc_set_ospm_nominal_perf(int cpu, u64 ospm_nominal_perf)
> +{
> +	return -EOPNOTSUPP;
> +}
> +static inline bool cppc_ospm_nominal_perf_supported(int cpu)
> +{
> +	return false;
> +}
>  static inline int cppc_get_auto_act_window(int cpu, u64 *auto_act_window)
>  {
>  	return -EOPNOTSUPP;

