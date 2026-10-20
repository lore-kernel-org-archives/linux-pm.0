Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792512627;
	b=T6gTyGnPKLt/Rfhh79sIcYlzZsf4mq+aVCqOXUYBgTTDYQNwXo2CHgy8XPx5g/GTTysV
	 wMSCGRMtbEo4kEU/vI+kyaxI9Bqick4Tgzydpky6OpPMWRrZf0VKs6M83s9Eol53bjFPQ
	 1aCncrmjn4zQ5cguOCPkDIZJsjLMiFXi3Ez5bjglhLqpGy4WZc+4jxaj1hAMx46myd9jb
	 4ANFQaJcljIqhyeIyTatJPIt7zgegLqOhZkd3tGiusZqq9LQ+rucYCxdAQSGiXJ9fsjux
	 xe8N33+cHvbnI9kIGieYGvJYF0GZn4GhAJbjvO+ugN+lMjFrBbrHqeXM2B+eMUF2SVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792512627;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=2sNC3P1QUDjhawHsX037Mh7iiW1QRpYfhgHxBh43ZB8=;
	b=qqLcxwQ61zw7q0svkZpgItJybpRFpwzNWqj0xL+9ylWgZvsI2f9UUOtC0O+4bqt8LDHy
	 Zq8TUudqW6DDRwq4nhj2d1axeFFvchx9hQRF1xKKnssiP4W+Khj3maMlZsJvcTFTI7UYM
	 BaAgsH67A0S6eEd4bvsE0j1LXvmI3dCmw3ifTryDNWFligM+zMpjEVJ8aeMxN2rjWcR29
	 9OqEJHnwVyrbpqB+Rfh3KRenrvrFNVknBo/YLdcerBms/y9VVodCIPbG2fFz67UonXq9O
	 5AohGdYL3h9DV8ar8K9b4hUf5FWXffitGh6wNpn9tsoY1E8XLIFRaK5ZYoJ+IGacVlw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=Wpg1QRCw;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C72D606A322;
	Tue, 20 Oct 2026 16:10:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9C72D606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=Wpg1QRCw
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A54EA16F8;
	Tue, 20 Oct 2026 09:10:21 -0700 (PDT)
Received: from [10.0.128.106] (e127648.arm.com [10.0.128.106])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A37363F7D8;
	Tue, 20 Oct 2026 09:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1792512624; bh=fFFeUkThSorzl329T6P7JxtDbQyoTEDiDnc+J8On6Z8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Wpg1QRCwrOGPvXhZR9FUxX0VozNLTRjvQMuTNcNxjc2uomp6cGJHly9jixh89Y6gH
	 utJFT62aL2HxPBqVJUD/aBbDQVjsQ1+VD8ex7Vnj9dNfLl6IjPre9LaU6bpml3Zrfr
	 BkHCl+6I6TS+t4ZGjzsT4Xglp0OemzXxzeFbtnEg=
Message-ID: <1cfcfd24-f0ad-4b9d-ae29-8a7bc5832294@arm.com>
Date: Tue, 20 Oct 2026 17:10:17 +0100
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
Subject: Re: [PATCH v6 3/5] ACPI: CPPC: Make autonomous selection helpers take
 a u64
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
References: <20261020121846.691218-1-sumitg@nvidia.com>
 <20261020121846.691218-4-sumitg@nvidia.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <20261020121846.691218-4-sumitg@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/20/26 13:18, Sumit Gupta wrote:
> cppc_get_auto_sel()/cppc_set_auto_sel() use a bool, unlike the other
> CPPC register get/set helpers which use a u64.
> 
> The next patch in this series saves and restores the OSPM-set registers
> across CPU hotplug and driver unload through a common table of register
> get/set helpers that all take a u64. The bool autonomous selection
> helpers cannot be added to that table.
> 
> Change cppc_get_auto_sel()/cppc_set_auto_sel() to take a u64 so the
> autonomous selection register fits alongside the others, and update
> their callers.
> 
> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> Reviewed-by: K Prateek Nayak <kprateek.nayak@amd.com>
> Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>

Reviewed-by: Christian Loehle <christian.loehle@arm.com>

> ---
>  drivers/acpi/cppc_acpi.c       | 20 ++++----------------
>  drivers/cpufreq/amd-pstate.c   |  2 +-
>  drivers/cpufreq/cppc_cpufreq.c |  4 ++--
>  include/acpi/cppc_acpi.h       |  8 ++++----
>  4 files changed, 11 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index 8d38924e0750..11a895fa9199 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -3304,23 +3304,11 @@ EXPORT_SYMBOL_GPL(cppc_set_auto_act_window);
>  /**
>   * cppc_get_auto_sel() - Read autonomous selection register.
>   * @cpu: CPU from which to read register.
> - * @enable: Return address.
> + * @enable: Return address, set to 0 or 1.
>   */
> -int cppc_get_auto_sel(int cpu, bool *enable)
> +int cppc_get_auto_sel(int cpu, u64 *enable)
>  {
> -	u64 auto_sel;
> -	int ret;
> -
> -	if (enable == NULL)
> -		return -EINVAL;
> -
> -	ret = cppc_get_reg_val(cpu, AUTO_SEL_ENABLE, &auto_sel);
> -	if (ret)
> -		return ret;
> -
> -	*enable = (bool)auto_sel;
> -
> -	return 0;
> +	return cppc_get_reg_val(cpu, AUTO_SEL_ENABLE, enable);
>  }
>  EXPORT_SYMBOL_GPL(cppc_get_auto_sel);
>  
> @@ -3351,7 +3339,7 @@ EXPORT_SYMBOL_GPL(cppc_auto_sel_is_immutable);
>   * @cpu    : CPU to which to write register.
>   * @enable : the desired value of autonomous selection resiter to be updated.
>   */
> -int cppc_set_auto_sel(int cpu, bool enable)
> +int cppc_set_auto_sel(int cpu, u64 enable)
>  {
>  	return cppc_set_reg_val(cpu, AUTO_SEL_ENABLE, enable);
>  }
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 4bedfbfc18b6..bf7d25e89d2a 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -546,7 +546,7 @@ static int shmem_init_perf(struct amd_cpudata *cpudata)
>  	struct cppc_perf_caps cppc_perf;
>  	union perf_cached perf = READ_ONCE(cpudata->perf);
>  	u64 numerator;
> -	bool auto_sel;
> +	u64 auto_sel;
>  
>  	int ret = cppc_get_perf_caps(cpudata->cpu, &cppc_perf);
>  	if (ret)
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index 7448ca43b363..9e1214e1cb0d 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -1059,7 +1059,7 @@ static ssize_t show_freqdomain_cpus(struct cpufreq_policy *policy, char *buf)
>  
>  static ssize_t show_auto_select(struct cpufreq_policy *policy, char *buf)
>  {
> -	bool val;
> +	u64 val;
>  	int ret;
>  
>  	ret = cppc_get_auto_sel(policy->cpu, &val);
> @@ -1071,7 +1071,7 @@ static ssize_t show_auto_select(struct cpufreq_policy *policy, char *buf)
>  	if (ret)
>  		return ret;
>  
> -	return sysfs_emit(buf, "%d\n", val);
> +	return sysfs_emit(buf, "%llu\n", val);
>  }
>  
>  static ssize_t store_auto_select(struct cpufreq_policy *policy,
> diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
> index 4495ee4ab71e..a5545fd3f8bd 100644
> --- a/include/acpi/cppc_acpi.h
> +++ b/include/acpi/cppc_acpi.h
> @@ -197,9 +197,9 @@ extern int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls, bool e
>  extern int cppc_set_epp(int cpu, u64 epp_val);
>  extern int cppc_get_auto_act_window(int cpu, u64 *auto_act_window);
>  extern int cppc_set_auto_act_window(int cpu, u64 auto_act_window);
> -extern int cppc_get_auto_sel(int cpu, bool *enable);
> +extern int cppc_get_auto_sel(int cpu, u64 *enable);
>  bool cppc_auto_sel_is_immutable(int cpu);
> -extern int cppc_set_auto_sel(int cpu, bool enable);
> +extern int cppc_set_auto_sel(int cpu, u64 enable);
>  extern int cppc_get_perf_limited(int cpu, u64 *perf_limited);
>  extern int cppc_set_perf_limited(int cpu, u64 bits_to_clear);
>  extern int amd_get_highest_perf(unsigned int cpu, u32 *highest_perf);
> @@ -298,7 +298,7 @@ static inline int cppc_set_auto_act_window(int cpu, u64 auto_act_window)
>  {
>  	return -EOPNOTSUPP;
>  }
> -static inline int cppc_get_auto_sel(int cpu, bool *enable)
> +static inline int cppc_get_auto_sel(int cpu, u64 *enable)
>  {
>  	return -EOPNOTSUPP;
>  }
> @@ -308,7 +308,7 @@ static inline bool cppc_auto_sel_is_immutable(int cpu)
>  	return false;
>  }
>  
> -static inline int cppc_set_auto_sel(int cpu, bool enable)
> +static inline int cppc_set_auto_sel(int cpu, u64 enable)
>  {
>  	return -EOPNOTSUPP;
>  }

