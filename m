Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD66F28CF6F;
	Wed, 28 Jan 2026 10:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769597450; cv=none; b=L3hDUL7ChUvWC7D2bpenOuUD9VuBw1/rd+k7yMcFKP1i/TcRklSQP/0TfLSdLQ6Xh496DKIr6l/jT1yC1IPuLVjPFW9u/0YTOhSKpgvSfhtKmLEnJw5HTms1DlA6L/F3m9RPxvxvP8Fz+nXm+qPfq/l6w5s1o1kPvzHqA0yk1Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769597450; c=relaxed/simple;
	bh=BV0gNi+tc0yyHVuAWTUC07E1tMEAHg+We+j6aGJMvHg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=r/C5M68R8ppQM4S1cSK/P8b5jveXW2DiApKwPg7jGKuP5msZ5KMTKExjHj8LbmBS2iHrOZOFuMf2810VdCvpZxw4BYdPhwmPYs0Iec8ZP5pyWFBczSQIm6N5yq1mlLbWbHIOuATnJc7TFI4E1roJWAFcHur65xDsd9hZIZlGQ9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=113.46.200.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4f1JqY2ps8z12LDY;
	Wed, 28 Jan 2026 18:46:49 +0800 (CST)
Received: from kwepemf200017.china.huawei.com (unknown [7.202.181.10])
	by mail.maildlp.com (Postfix) with ESMTPS id 9731240538;
	Wed, 28 Jan 2026 18:50:43 +0800 (CST)
Received: from [10.67.121.58] (10.67.121.58) by kwepemf200017.china.huawei.com
 (7.202.181.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 28 Jan
 2026 18:50:42 +0800
Message-ID: <3c6d58b2-b4c9-4dc7-a705-b7626e127f33@hisilicon.com>
Date: Wed, 28 Jan 2026 18:50:42 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: topology: Fix false warning in
 counters_read_on_cpu() for same-CPU reads
To: Sumit Gupta <sumitg@nvidia.com>, <catalin.marinas@arm.com>,
	<will@kernel.org>, <zhenglifeng1@huawei.com>, <viresh.kumar@linaro.org>,
	<rafael@kernel.org>, <beata.michalska@arm.com>, <pierre.gondois@arm.com>,
	<ionela.voinescu@arm.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>
CC: <treding@nvidia.com>, <jonathanh@nvidia.com>, <bbasu@nvidia.com>
References: <20260127080700.3565546-1-sumitg@nvidia.com>
Content-Language: en-US
From: Jie Zhan <zhanjie9@hisilicon.com>
In-Reply-To: <20260127080700.3565546-1-sumitg@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemf200017.china.huawei.com (7.202.181.10)


Hi Sumit,

On 1/27/2026 4:07 PM, Sumit Gupta wrote:
> The counters_read_on_cpu() function warns when called with IRQs disabled
> to prevent deadlock in smp_call_function_single(). However, this warning
> is spurious when reading counters on the current CPU since no IPI is
> needed for same-CPU reads.
> 
> Commit 12eb8f4fff24 ("cpufreq: CPPC: Update FIE arch_freq_scale in ticks
> for non-PCC regs") changed the CPPC Frequency Invariance Engine to read
> AMU counters directly from the scheduler tick for non-PCC register
> spaces (like FFH), instead of deferring to a kthread. This means
> counters_read_on_cpu() is now called with IRQs disabled from the tick
> handler, triggering the warning:
> 
> | WARNING: arch/arm64/kernel/topology.c:410 at counters_read_on_cpu
> | ...
> | Call trace:
> |  counters_read_on_cpu+0x88/0xa8 (P)
> |  cpc_read_ffh+0xdc/0x148
> |  cpc_read+0x260/0x518
> |  cppc_get_perf_ctrs+0xf0/0x398
> |  __cppc_scale_freq_tick+0x4c/0x148 [cppc_cpufreq]
> |  cppc_scale_freq_tick+0x44/0x88 [cppc_cpufreq]
> |  topology_scale_freq_tick+0x34/0x58
> |  sched_tick+0x58/0x300
> |  update_process_times+0xcc/0x120
> |  tick_nohz_handler+0xa8/0x260
> |  __hrtimer_run_queues+0x154/0x360
> |  hrtimer_interrupt+0xf4/0x2b0
> |  arch_timer_handler_phys+0x4c/0x78
> |  ....
> |  CPPC Cpufreq:__cppc_scale_freq_tick: failed to read perf counters
> |  ....
> 
> Fix this by calling the counter read function directly for same-CPU
> case, bypassing smp_call_function_single() entirely. Use get_cpu() to
> disable preemption as the counter read functions call this_cpu_has_cap()
> which requires a non-preemptible context.
> 
> Fixes: 12eb8f4fff24 ("cpufreq: CPPC: Update FIE arch_freq_scale in ticks for non-PCC regs")
> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>

Reviewed-by: Jie Zhan <zhanjie9@hisilicon.com>

Looks fine for me except for the minor comment wrapping.

Thanks for spotting this.
I may have missed the warning log in the FFH test.

This happens during the short window in cpufreq_policy_online() between
driver->init() and the CREATE_POLICY notifier that gets AMU FIE ready.
After that, CPPC FIE will be stopped.

Ideally this can be merged together with Viresh's PR since the CPPC FIE
changes are there.
https://lore.kernel.org/all/j4qdid7iqmng4gzb5ozefemjkep3wx2b5z2yki5tnqc3vzvzf4@kvrnarvdod5p/

Jie

> ---
>  arch/arm64/kernel/topology.c | 21 +++++++++++++++++++--
>  1 file changed, 19 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
> index 539b38935182..57b71f403007 100644
> --- a/arch/arm64/kernel/topology.c
> +++ b/arch/arm64/kernel/topology.c
> @@ -401,12 +401,29 @@ static inline
>  int counters_read_on_cpu(int cpu, smp_call_func_t func, u64 *val)
>  {
>  	/*
> -	 * Abort call on counterless CPU or when interrupts are
> -	 * disabled - can lead to deadlock in smp sync call.
> +	 * Abort call on counterless CPU.
>  	 */
>  	if (!cpu_has_amu_feat(cpu))
>  		return -EOPNOTSUPP;
>  
> +	/*
> +	 * For same-CPU reads, call the function directly since no IPI
> +	 * is needed and this is safe even with IRQs disabled.
> +	 * Use get_cpu() to disable preemption as the counter read
> +	 * functions call this_cpu_has_cap() which requires a
> +	 * non-preemptible context.
> +	 */
Wrap at 80 chars?
> +	if (cpu == get_cpu()) {
> +		func(val);
> +		put_cpu();
> +		return 0;
> +	}
> +	put_cpu();
> +
> +	/*
> +	 * Reading from a remote CPU requires IRQs enabled to avoid
> +	 * deadlock in smp_call_function_single().
> +	 */
>  	if (WARN_ON_ONCE(irqs_disabled()))
>  		return -EPERM;
>  
