Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 884B14C6EF6;
	Wed, 22 Jul 2026 10:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784715542; cv=none; b=Z2VTL+FdHpTjHNa2EG9ZIe2gYGy0QdX1XHspJUWcI/Ykranwxg9Olg+BDjdrw0xm9ol7B3EmAyarId9kqJ2/uCAEmW4GmtI2cNRTOfrXvYTlbMWm19YE80peYAuVU53uCWH1b6XRPFU4XCCbk4Q1yKGJYF1CwZV/QXqwR9uR4uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784715542; c=relaxed/simple;
	bh=6pQbfUf6qFxNFEfwCwxXQNTOh/NnINY/VwM1E/ShKZI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XZefYJyx5Z8dy9gIMn+W1lnhvBiR/7mDtTDSG7kSw5xYVHypd9+dmGoZB3C3EvD3OwCajHOOrCA8HMnwbvHdYJzvc8wKZtp246bbfEiJ44HgMBO7DYBrRPSRqgxpVvMK7Xgt4jKky5xXxUaUn9L/sDaSsegszfFNnSziYvYYcpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=DMls2/5G; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="DMls2/5G"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7495D1595;
	Wed, 22 Jul 2026 03:18:56 -0700 (PDT)
Received: from [10.1.39.91] (e127648.arm.com [10.1.39.91])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 10F653F58B;
	Wed, 22 Jul 2026 03:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1784715540; bh=6pQbfUf6qFxNFEfwCwxXQNTOh/NnINY/VwM1E/ShKZI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=DMls2/5GZfyNtx3+Cbrf0Ma+C24h/OJpaX1LQDFpVmUjvljjIzhpH2xCeUeqkQTWJ
	 OUtFDUyppPxMhBTljVuo+I7A8uk5Np17mmd/EtjviZXoBZnOvF1paLfcj8kBv5ST5G
	 zCvfjYJeh60FqYqo/0RjwpJLDepSJuQy8TStWhbw=
Message-ID: <bc0ba136-7f40-4198-8b71-557de0babc0f@arm.com>
Date: Wed, 22 Jul 2026 11:18:56 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] cpufreq: CPPC: Keep the policy across CPU hotplug
To: Sumit Gupta <sumitg@nvidia.com>, rafael@kernel.org,
 viresh.kumar@linaro.org, pierre.gondois@arm.com, ionela.voinescu@arm.com,
 zhenglifeng1@huawei.com, zhanjie9@hisilicon.com, saket.dumbre@intel.com,
 lenb@kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev,
 linux-tegra@vger.kernel.org
Cc: treding@nvidia.com, jonathanh@nvidia.com, vsethi@nvidia.com,
 ksitaraman@nvidia.com, sanjayc@nvidia.com, mochs@nvidia.com, bbasu@nvidia.com
References: <20260716153820.2007095-1-sumitg@nvidia.com>
 <20260716153820.2007095-2-sumitg@nvidia.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <20260716153820.2007095-2-sumitg@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/16/26 16:38, Sumit Gupta wrote:
> Without online()/offline() callbacks, the cpufreq core fully tears
> down a policy during exit() when its last online CPU is offlined,
> and rebuilds it during init() when it comes back.
> 
> Add lightweight online()/offline() callbacks so the core instead
> keeps the policy live and reuses the driver's cpu_data across
> CPU hotplug. This avoids re-reading the CPPC capabilities on every
> offline/online, making CPU hotplug faster.
> 
> Re-enable CPPC from online(), as it may have been disabled while
> the CPU was offline.
> 
> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> ---
>  drivers/cpufreq/cppc_cpufreq.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index f6cea0c54dd9..432c6a6288a7 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -722,6 +722,31 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
>  	return ret;
>  }
>  
> +/*
> + * With offline() defined, the cpufreq core keeps the policy alive when
> + * a CPU is hotplugged out.
> + */
> +static int cppc_cpufreq_cpu_offline(struct cpufreq_policy *policy)
> +{
> +	return 0;
> +}
> +
> +/*
> + * Re-enable CPPC when the policy's CPU comes back online, since the platform
> + * may have disabled it while the CPU was offline.
> + */
> +static int cppc_cpufreq_cpu_online(struct cpufreq_policy *policy)
> +{
> +	unsigned int cpu = policy->cpu;
> +	int ret;
> +
> +	ret = cppc_set_enable(cpu, true);
> +	if (ret && ret != -EOPNOTSUPP)
> +		pr_warn("Failed to re-enable CPPC for CPU%d (%d)\n", cpu, ret);

Keeping the policy alive means cpu_data->perf_ctrls survives hotplug, but the callback does not
reapply it. A governor restart does not guarantee an immediate target callback, so the controls
may remain reset indefinitely.

I think the online path needs to restore a complete, current performance-control request before
returning. MIN/MAX should be recomputed from the policy and the last requested DESIRED value
clamped into that range.

Also, what about suspend/resume?

> +
> +	return 0;
> +}
> +
>  static void cppc_cpufreq_cpu_exit(struct cpufreq_policy *policy)
>  {
>  	struct cppc_cpudata *cpu_data = policy->driver_data;
> @@ -1034,6 +1059,8 @@ static struct cpufreq_driver cppc_cpufreq_driver = {
>  	.fast_switch = cppc_cpufreq_fast_switch,
>  	.init = cppc_cpufreq_cpu_init,
>  	.exit = cppc_cpufreq_cpu_exit,
> +	.online = cppc_cpufreq_cpu_online,
> +	.offline = cppc_cpufreq_cpu_offline,
>  	.set_boost = cppc_cpufreq_set_boost,
>  	.attr = cppc_cpufreq_attr,
>  	.name = "cppc_cpufreq",

