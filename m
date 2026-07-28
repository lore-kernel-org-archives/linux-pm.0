Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3753127AC31;
	Tue, 28 Jul 2026 08:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785228126; cv=none; b=P1NTOOdVihDBwPOh8Dpw/ezp99vqgedJF0t1DUlxHSeYl2P6Z/1jAWHplUOFBLa4KtHa4inUayXidrlLROHWTUnZA5PvhhnG1+LzM8V0KdU5YyL8elLPyjf0tex1fgYGx85LdbVgMqf96CcsHvNUrpK/X4mMskCfn/cT9zGfh/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785228126; c=relaxed/simple;
	bh=vTtpfS8DsqV0yX6Abtwlukd5XiEPzcmJl2/q1btkP5Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=f5ryqTEbbDbRhlvEdd+k1nX8o9Ta3yisaUxvALz4j8AJr00TqaHC0CkfjAcOT4IA+puN7gi6Xvplu+LXpWgjGB5iemXzu79Erca6Ef9jNekrtgjKjavfvQFqvigonuS2GSWrXCGoud6EOzyNSdd1hKvab52KSu4TJQXvxhXckQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=YPiMycY9; arc=none smtp.client-ip=113.46.200.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="YPiMycY9"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=b14c05HzraPU+WgxiYx6tlHbhfsQqX/AwR0LJeM5LeM=;
	b=YPiMycY90bZd5L+hFm9wCMxlXc98Qhc6LVe1CFm2FtQqt8rvT34YvM+dfXv03J+9MIlAPyTQG
	ZhTVAA5QtAE97tsdAHQ9gTK0oHUTLHQXqczWGaZwPYF9UyxiepW5DJETk3DddYOu8h1DeLib/fD
	+SzOzJ72qYmwPmQzyZ2A8Eg=
Received: from mail.maildlp.com (unknown [172.19.163.104])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4h8TGv6dKDz1prKd;
	Tue, 28 Jul 2026 16:32:23 +0800 (CST)
Received: from kwepemf100001.china.huawei.com (unknown [7.202.181.215])
	by mail.maildlp.com (Postfix) with ESMTPS id 5C1044057F;
	Tue, 28 Jul 2026 16:41:52 +0800 (CST)
Received: from [10.67.121.90] (10.67.121.90) by kwepemf100001.china.huawei.com
 (7.202.181.215) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Tue, 28 Jul
 2026 16:41:51 +0800
Message-ID: <a4891cdc-9635-4ad7-96b6-f62c39aa254a@huawei.com>
Date: Tue, 28 Jul 2026 16:41:51 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] cpufreq: CPPC: Keep the policy across CPU hotplug
To: Sumit Gupta <sumitg@nvidia.com>, <rafael@kernel.org>,
	<viresh.kumar@linaro.org>, <pierre.gondois@arm.com>,
	<christian.loehle@arm.com>, <ionela.voinescu@arm.com>,
	<zhanjie9@hisilicon.com>, <lenb@kernel.org>, <saket.dumbre@intel.co>,
	<ray.huang@amd.com>, <mario.limonciello@amd.com>, <perry.yuan@amd.com>,
	<kprateek.nayak@amd.com>, <linux-kernel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<acpica-devel@lists.linux.dev>, <linux-tegra@vger.kernel.org>
CC: <treding@nvidia.com>, <jonathanh@nvidia.com>, <vsethi@nvidia.com>,
	<ksitaraman@nvidia.com>, <sanjayc@nvidia.com>, <mochs@nvidia.com>,
	<bbasu@nvidia.com>
References: <20260724215937.3368276-1-sumitg@nvidia.com>
 <20260724215937.3368276-2-sumitg@nvidia.com>
From: "zhenglifeng (A)" <zhenglifeng1@huawei.com>
In-Reply-To: <20260724215937.3368276-2-sumitg@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemf100001.china.huawei.com (7.202.181.215)

On 7/25/2026 5:59 AM, Sumit Gupta wrote:
> Without online()/offline() callbacks, the cpufreq core fully tears
> down a policy during exit() when its last online CPU is offlined, and
> rebuilds it during init() when it comes back.
> 
> Add lightweight online()/offline() callbacks so the core instead keeps
> the policy live and reuses the driver's cpu_data across CPU hotplug.
> This avoids re-reading the CPPC capabilities on every offline/online,
> making CPU hotplug faster.
> 
> From online(), re-enable CPPC, as the platform may have disabled it
> while the CPU was offline. Since the policy is no longer rebuilt via
> init(), online() also reprograms the CPPC performance controls
> (desired/min/max).
> 
> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> ---
>  drivers/cpufreq/cppc_cpufreq.c | 44 ++++++++++++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
> 
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index f6cea0c54dd9..6dc59f99d880 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -722,6 +722,48 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
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

I am not sure if doing nothing here will cause issues. In my view, to be safe,
we should perform the actions found in cppc_cpufreq_cpu_exit() here, except
cppc_cpufreq_put_cpu_data().

> +
> +/*
> + * Re-enable CPPC when the policy's CPU comes back online, since the platform
> + * may have disabled it while the CPU was offline.
> + */
> +static int cppc_cpufreq_cpu_online(struct cpufreq_policy *policy)
> +{
> +	struct cppc_cpudata *cpu_data = policy->driver_data;
> +	unsigned int cpu = policy->cpu;
> +	int ret;
> +
> +	ret = cppc_set_enable(cpu, true);
> +	if (ret && ret != -EOPNOTSUPP)
> +		pr_warn("Failed to re-enable CPPC for CPU%d (%d)\n", cpu, ret);
> +
> +	/*
> +	 * The platform may reset the controls while the CPU is offline, so
> +	 * recompute min/max, clamp desired_perf into range, and reprogram them.
> +	 */
> +	cppc_cpufreq_update_perf_limits(cpu_data, policy);
> +
> +	cpu_data->perf_ctrls.desired_perf =
> +		clamp_t(u32, cpu_data->perf_ctrls.desired_perf,
> +			cpu_data->perf_ctrls.min_perf,
> +			cpu_data->perf_ctrls.max_perf);
> +
> +	ret = cppc_set_perf(cpu, &cpu_data->perf_ctrls);
> +	if (ret)
> +		pr_debug("Failed to reapply perf request on CPU%d (%d)\n",
> +			 cpu, ret);
> +
> +	return 0;
> +}
> +
>  static void cppc_cpufreq_cpu_exit(struct cpufreq_policy *policy)
>  {
>  	struct cppc_cpudata *cpu_data = policy->driver_data;
> @@ -1034,6 +1076,8 @@ static struct cpufreq_driver cppc_cpufreq_driver = {
>  	.fast_switch = cppc_cpufreq_fast_switch,
>  	.init = cppc_cpufreq_cpu_init,
>  	.exit = cppc_cpufreq_cpu_exit,
> +	.online = cppc_cpufreq_cpu_online,
> +	.offline = cppc_cpufreq_cpu_offline,
>  	.set_boost = cppc_cpufreq_set_boost,
>  	.attr = cppc_cpufreq_attr,
>  	.name = "cppc_cpufreq",

