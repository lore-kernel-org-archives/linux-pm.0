Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF20E2EEE73;
	Fri, 17 Jul 2026 03:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784260040; cv=none; b=i0LjhXh+7mAWVuiMZW1JEKv0GxHSIwqR8OMP2WwSQdRtRqGjLa3jlKlQ+7dulvRANoOILoTn61J/s8JRa19waQ9+c7fF+4dQlRHStCnpoVhcT/cPSHstNRhteFMoCbce8gjOZIiDqt6nNd2q4WW19B2qNrc+jM7UXHRhGxVMo9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784260040; c=relaxed/simple;
	bh=kKZKJ9AC4A53wLLm5Sw+iKx+fKVtYYDEMRKAKJLGWV4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=N5eOSZjwEWzceXrzZ7MLkrYx8xtXYLIbfB2N2xEz+T6j/FAPcZPTlRmUWuIpAXyKPutnx7l7jFTxD+KEmNStpAZhu+11k8IFz9RJZjF8tvoKxaO5A29Pmb0FUi1nJrxnW1+qj3DhLRvdDbnZCg7FXIEMeqU5vGzxa9FaYkG7k+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=DtzfQhJ8; arc=none smtp.client-ip=113.46.200.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="DtzfQhJ8"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=KZQXTxL73jFelG7oWtSz1Y/jy0CbZRaJ40WFqtj1IzY=;
	b=DtzfQhJ8QztS58h4z7Uk8XnrcyopfBlleJAg8iFpya5xJ3uyfNrMTTbI5LrOhnefdhkTeTown
	u8ZBu4Ng8wrz6PxTIxw0zjwduV8HPMxI/DCNqep7L5ywQIEmBN82RThJKup129Jv1HeunrkZf3R
	mA4MmYpU+l72+w+oWjHLhCU=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4h1bG82tXDz1prKd;
	Fri, 17 Jul 2026 11:37:52 +0800 (CST)
Received: from kwepemf100001.china.huawei.com (unknown [7.202.181.215])
	by mail.maildlp.com (Postfix) with ESMTPS id D7AD640538;
	Fri, 17 Jul 2026 11:47:13 +0800 (CST)
Received: from [10.67.121.90] (10.67.121.90) by kwepemf100001.china.huawei.com
 (7.202.181.215) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Fri, 17 Jul
 2026 11:47:12 +0800
Message-ID: <31525db3-a7a6-48fa-bea9-5de28a4332c4@huawei.com>
Date: Fri, 17 Jul 2026 11:47:12 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] ACPI: CPPC: Add u64 wrappers for the autonomous
 selection register
To: Sumit Gupta <sumitg@nvidia.com>, <rafael@kernel.org>,
	<viresh.kumar@linaro.org>, <pierre.gondois@arm.com>,
	<ionela.voinescu@arm.com>, <zhanjie9@hisilicon.com>,
	<saket.dumbre@intel.com>, <lenb@kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<acpica-devel@lists.linux.dev>, <linux-tegra@vger.kernel.org>
CC: <treding@nvidia.com>, <jonathanh@nvidia.com>, <vsethi@nvidia.com>,
	<ksitaraman@nvidia.com>, <sanjayc@nvidia.com>, <mochs@nvidia.com>,
	<bbasu@nvidia.com>
References: <20260716153820.2007095-1-sumitg@nvidia.com>
 <20260716153820.2007095-3-sumitg@nvidia.com>
From: "zhenglifeng (A)" <zhenglifeng1@huawei.com>
In-Reply-To: <20260716153820.2007095-3-sumitg@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemf100001.china.huawei.com (7.202.181.215)

On 7/16/2026 11:38 PM, Sumit Gupta wrote:
> cppc_get_auto_sel()/cppc_set_auto_sel() use a bool, unlike the other
> CPPC register get/set helpers which use a u64.
> 
> The next patch in this series saves and restores the OSPM-set registers
> across CPU hotplug using a common table of get/set helpers typed as
> int (*)(int, u64 *) and int (*)(int, u64), which the bool autonomous
> selection helpers do not fit.
> 
> Add cppc_get_auto_sel_u64()/cppc_set_auto_sel_u64() wrappers with the u64
> signature so the autonomous selection register fits alongside the others.
> 
> Suggested-by: Pierre Gondois <pierre.gondois@arm.com>
> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>

If this is necessary, I think it is better to just change the input parameter
of the original cppc_get/set_auto_sel() to u64.

> ---
>  drivers/acpi/cppc_acpi.c | 40 ++++++++++++++++++++++++++++++++++++++++
>  include/acpi/cppc_acpi.h | 10 ++++++++++
>  2 files changed, 50 insertions(+)
> 
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index 9f572f481241..a7fec6c93178 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -1788,6 +1788,46 @@ int cppc_set_auto_sel(int cpu, bool enable)
>  }
>  EXPORT_SYMBOL_GPL(cppc_set_auto_sel);
>  
> +/**
> + * cppc_get_auto_sel_u64 - Read the autonomous selection register as a u64.
> + * @cpu: CPU from which to read the register.
> + * @val: Return address, set to 0 or 1.
> + *
> + * u64-typed wrapper around cppc_get_auto_sel() for callers that keep CPPC
> + * register accessors in a common table.
> + *
> + * Return: 0 for success, -ERRNO otherwise.
> + */
> +int cppc_get_auto_sel_u64(int cpu, u64 *val)
> +{
> +	bool enable;
> +	int ret;
> +
> +	ret = cppc_get_auto_sel(cpu, &enable);
> +	if (ret)
> +		return ret;
> +
> +	*val = enable;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(cppc_get_auto_sel_u64);
> +
> +/**
> + * cppc_set_auto_sel_u64 - Write the autonomous selection register from a u64.
> + * @cpu: CPU to which to write the register.
> + * @val: Value to write, any non-zero value enables autonomous selection.
> + *
> + * u64-typed wrapper around cppc_set_auto_sel().
> + *
> + * Return: 0 for success, -ERRNO otherwise.
> + */
> +int cppc_set_auto_sel_u64(int cpu, u64 val)
> +{
> +	return cppc_set_auto_sel(cpu, !!val);
> +}
> +EXPORT_SYMBOL_GPL(cppc_set_auto_sel_u64);
> +
>  /**
>   * cppc_set_enable - Set to enable CPPC on the processor by writing the
>   * Continuous Performance Control package EnableRegister field.
> diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
> index 8693890a7275..cd07e1e92bf4 100644
> --- a/include/acpi/cppc_acpi.h
> +++ b/include/acpi/cppc_acpi.h
> @@ -184,6 +184,8 @@ extern int cppc_get_auto_act_window(int cpu, u64 *auto_act_window);
>  extern int cppc_set_auto_act_window(int cpu, u64 auto_act_window);
>  extern int cppc_get_auto_sel(int cpu, bool *enable);
>  extern int cppc_set_auto_sel(int cpu, bool enable);
> +extern int cppc_get_auto_sel_u64(int cpu, u64 *val);
> +extern int cppc_set_auto_sel_u64(int cpu, u64 val);
>  extern int cppc_get_perf_limited(int cpu, u64 *perf_limited);
>  extern int cppc_set_perf_limited(int cpu, u64 bits_to_clear);
>  extern int amd_get_highest_perf(unsigned int cpu, u32 *highest_perf);
> @@ -282,6 +284,14 @@ static inline int cppc_set_auto_sel(int cpu, bool enable)
>  {
>  	return -EOPNOTSUPP;
>  }
> +static inline int cppc_get_auto_sel_u64(int cpu, u64 *val)
> +{
> +	return -EOPNOTSUPP;
> +}
> +static inline int cppc_set_auto_sel_u64(int cpu, u64 val)
> +{
> +	return -EOPNOTSUPP;
> +}
>  static inline int cppc_get_perf_limited(int cpu, u64 *perf_limited)
>  {
>  	return -EOPNOTSUPP;

