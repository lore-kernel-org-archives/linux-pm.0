Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAD2741A4F1;
	Mon, 27 Jul 2026 13:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785158859; cv=none; b=ixx+3MTcIpObDtb++GKNhwATyWdqHQASpt8Ja8OeoR1t51fvUGrLngKPvzBtPUM5NYJh2OQDHPobd5IvFQ3EIsES66CqH7Ez2Y18CU7wfj7aqWJyFieavNCPa7NgUsqvYPzIm8cueko/IVnXAhVLUhvsx8zWGrqLMas3KwGznGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785158859; c=relaxed/simple;
	bh=tuOO9BJ4e09hCOeSOpQbs/7qt+nSUQ8BheAUn/4agCQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JvGPE7/enq0/Ttd8EuXdx3sDT/zAKT1V31c6Hp8JpXgwxurtYFZoLg9x33rnZvdLq0ZpQ4AfzIQPs0kwRZcvVvHP/z+7+cA0tfYEgS7KV4E+sSG+gOUfHaVpd7viJ9ouYSUQBkXAwjiFRF1kqAi3Yzr7viE8RxslB1+DJ+6Y4nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=MnJHjHFO; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="MnJHjHFO"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B97E21476;
	Mon, 27 Jul 2026 06:27:22 -0700 (PDT)
Received: from [192.168.0.248] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B73D23F763;
	Mon, 27 Jul 2026 06:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1785158846; bh=tuOO9BJ4e09hCOeSOpQbs/7qt+nSUQ8BheAUn/4agCQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=MnJHjHFOU90Xjrw9Fs7gEnHBf6JEsQGEhZdRkM/mVfr8QcmAQ0IBQTm98WJ3kbqX4
	 rpwdSlfvy5KUrgbHl1wbRiUkr1q9JRExW1XiEsLjwwkZSuqDg01ojmfHPaMCqMknkg
	 aVNU90AEr4QoeJe09WTUugXjpzyg8j29bLzNiGWQ=
Message-ID: <40d72385-0b3f-46e5-9f32-a27be3842d7c@arm.com>
Date: Mon, 27 Jul 2026 14:27:19 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] cpufreq: CPPC: Keep the policy across CPU hotplug
To: Sumit Gupta <sumitg@nvidia.com>, rafael@kernel.org,
 viresh.kumar@linaro.org, pierre.gondois@arm.com, ionela.voinescu@arm.com,
 zhenglifeng1@huawei.com, zhanjie9@hisilicon.com, lenb@kernel.org,
 saket.dumbre@intel.co, ray.huang@amd.com, mario.limonciello@amd.com,
 perry.yuan@amd.com, kprateek.nayak@amd.com, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
 acpica-devel@lists.linux.dev, linux-tegra@vger.kernel.org
Cc: treding@nvidia.com, jonathanh@nvidia.com, vsethi@nvidia.com,
 ksitaraman@nvidia.com, sanjayc@nvidia.com, mochs@nvidia.com, bbasu@nvidia.com
References: <20260724215937.3368276-1-sumitg@nvidia.com>
 <20260724215937.3368276-2-sumitg@nvidia.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <20260724215937.3368276-2-sumitg@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/24/26 22:59, Sumit Gupta wrote:
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

What's the intention of continuing restoring CPPC register values here?

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

I think cppc_set_perf() needs some prep first before using it on reset values.
We assume that reset value may be Autonomous Mode on, right? So we must never
write MIN>MAX and vice versa. I think we may just have to read and write
the 'otherwise-offending' value first on reset.

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

