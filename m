Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B93F3FF8A5;
	Mon, 10 Aug 2026 14:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786372420; cv=none; b=ROSZyWlS6ucX5TKSzBQhomNML030BkxWfSMrfg+2ycNamY7ieV0UMgkRl31PtxtC1C4MR/WS1G9TqBe421wrWKD++musLY9yaW8IUPAaHK+ykcjPR6fpWIet3U77XhbiHQGsH11uNcrPxwdYeq3XQdcEqNRwEjc4eqCT69ESsWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786372420; c=relaxed/simple;
	bh=AfxvFoS/ftUkTwWYkLmLR+Bd4Y9eH94xPiNFj7HC8Jk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UGxMaO9CWernZrDPkzPLnaeKN0spKijPOESMmFchXzCcwe16boF+MBqLZyoyrzgZqyN8gqChUGbkQmBXS1Wxl9FLCU2zTEBETBcWXlpIBi0Dehi68hABU7uJrpU8KpheqRnrjYJfx8ykoU9WZ5KHt0mWO4Zd5dw9XGXKMRfgohE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=YsyWqvkn; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="YsyWqvkn"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 73F0314BF;
	Mon, 10 Aug 2026 07:33:33 -0700 (PDT)
Received: from [10.57.68.246] (unknown [10.57.68.246])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3CB743F86F;
	Mon, 10 Aug 2026 07:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1786372417; bh=AfxvFoS/ftUkTwWYkLmLR+Bd4Y9eH94xPiNFj7HC8Jk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=YsyWqvkn3zsbqmwUzojlwwxZiJWAhA5osq4Apo+zJQwSZ31nGBMbsz5YEFrfjPJws
	 Fu6KLmk2gaIj8EdMnB6Rs1wnM4gGU1k+E+EmkW9KHiVthutehonzSY8ZArGF/78MJ8
	 1ywnp7HGYi/dKwMA176okwj+xcFO4uvLEpgEE9d8=
Message-ID: <840da3ba-1d65-4a28-a072-a586ea4dfce5@arm.com>
Date: Mon, 10 Aug 2026 15:33:33 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/3] arch_topology: Add topology_update_cpu_capacity()
 for runtime updates
To: Xueqin Luo <luoxueqin@kylinos.cn>, Sudeep Holla
 <sudeep.holla@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Danilo Krummrich
 <dakr@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>,
 Beata Michalska <Beata.Michalska@arm.com>,
 Ionela Voinescu <Ionela.Voinescu@arm.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Jie Zhan <zhanjie9@hisilicon.com>, Lifeng Zheng
 <zhenglifeng1@huawei.com>, Pierre Gondois <pierre.gondois@arm.com>,
 Sumit Gupta <sumitg@nvidia.com>, linux-kernel@vger.kernel.org,
 driver-core@lists.linux.dev, linux-pm@vger.kernel.org
References: <20260807060848.832929-1-luoxueqin@kylinos.cn>
 <20260807060848.832929-4-luoxueqin@kylinos.cn>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <20260807060848.832929-4-luoxueqin@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/7/26 07:08, Xueqin Luo wrote:
> When the CPPC Highest Performance register changes at runtime
> (e.g. via ACPI Notify(0x85)), the scheduler's view of CPU capacity
> and the frequency invariance engine's reference values become stale,
> as topology_init_cpu_capacity_cppc() is only called once during boot.
> 
> Keep raw_capacity allocated after CPPC init instead of freeing it,
> and introduce topology_update_cpu_capacity() to update per-CPU
> raw_capacity, capacity_freq_ref, and the normalized CPU capacity
> scale at runtime. Provide a no-op stub when GENERIC_ARCH_TOPOLOGY
> is disabled so cppc_cpufreq can link on those configs. Skip updates
> when the value is unchanged and reject a zero capacity_scale to
> avoid division by zero.
> 
> Call this from cppc_cpufreq_update_limits() for every CPU in the
> policy so shared-policy Notify(0x85) targeting a non-policy CPU
> still refreshes the correct topology capacity.
> 
> Signed-off-by: Xueqin Luo <luoxueqin@kylinos.cn>
> ---
>  drivers/base/arch_topology.c   | 76 ++++++++++++++++++++++++++++++++++
>  drivers/cpufreq/cppc_cpufreq.c |  2 +
>  include/linux/arch_topology.h  | 13 ++++++
>  3 files changed, 91 insertions(+)
> 
> diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
> index 8c5e47c28d9a..27f2bfa9f326 100644
> --- a/drivers/base/arch_topology.c
> +++ b/drivers/base/arch_topology.c
> @@ -229,6 +229,7 @@ static void update_topology_flags_workfn(struct work_struct *work)
>  }
>  
>  static u32 *raw_capacity;
> +static DEFINE_MUTEX(raw_capacity_lock);
>  
>  static int free_raw_capacity(void)
>  {
> @@ -372,13 +373,88 @@ static inline void topology_init_cpu_capacity_cppc(void)
>  	schedule_work(&update_topology_flags_work);
>  	pr_debug("cpu_capacity: cpu_capacity initialization done\n");
>  
> +	/*
> +	 * Keep raw_capacity for runtime updates via
> +	 * topology_update_cpu_capacity().
> +	 */
> +	return;
> +
>  exit:
>  	free_raw_capacity();
>  }
> +
>  void acpi_processor_init_invariance_cppc(void)
>  {
>  	topology_init_cpu_capacity_cppc();
>  }
> +
> +/**
> + * topology_update_cpu_capacity - Update CPU capacity after highest_perf change
> + * @cpu: CPU whose highest performance changed
> + * @perf_caps: Updated CPPC performance capabilities for @cpu
> + *
> + * When the CPPC Highest Performance register changes at runtime
> + * (e.g. via Notify(0x85)), the scheduler's view of CPU capacity
> + * and the frequency invariance engine's reference values become
> + * stale. This function updates the per-CPU raw_capacity,
> + * capacity_freq_ref and freq_inv max ratio, then re-normalizes the
> + * CPU capacity scale for all possible CPUs and triggers a sched
> + * domain rebuild. If the value is unchanged, everything is skipped.
> + */
> +void topology_update_cpu_capacity(unsigned int cpu,
> +				  struct cppc_perf_caps *perf_caps)
> +{
> +	u32 highest_perf = perf_caps->highest_perf;
> +	u64 capacity, capacity_scale = 0;
> +	int c;
> +
> +	guard(mutex)(&raw_capacity_lock);
> +
> +	if (!raw_capacity || cpu >= num_possible_cpus())
> +		return;
> +
> +	/*
> +	 * Validate: highest_perf must be >= nominal_perf and >= lowest_perf,
> +	 * consistent with the boot-time check in topology_init_cpu_capacity_cppc().
> +	 */
> +	if (highest_perf < perf_caps->lowest_perf) {
> +		pr_warn("cpu_capacity: CPU%d invalid highest_perf=%u (nominal=%u, lowest=%u), skipping\n",
> +			cpu, highest_perf, perf_caps->nominal_perf,
> +			perf_caps->lowest_perf);
> +		return;
> +	}
> +
> +	if (raw_capacity[cpu] == highest_perf)
> +		return;
> +
> +	pr_debug("cpu_capacity: CPU%d cpu_capacity=%u -> %u (raw)\n",
> +		 cpu, raw_capacity[cpu], highest_perf);
> +
> +	raw_capacity[cpu] = highest_perf;

Does this actually work if highest_perf would now be the equivalent for >1024?

> +	per_cpu(capacity_freq_ref, cpu) =
> +		cppc_perf_to_khz(perf_caps, highest_perf);
> +	freq_inv_set_max_ratio(cpu,
> +			       per_cpu(capacity_freq_ref, cpu) * HZ_PER_KHZ);
> +
> +	/* Re-normalize all CPUs: capacity is relative. */
> +	for_each_possible_cpu(c)
> +		capacity_scale = max_t(u64, capacity_scale, raw_capacity[c]);
> +
> +	if (!capacity_scale)
> +		return;
> +
> +	for_each_possible_cpu(c) {
> +		capacity = raw_capacity[c];
> +		capacity = div64_u64(capacity << SCHED_CAPACITY_SHIFT,
> +				     capacity_scale);
> +		topology_set_cpu_scale(c, capacity);
> +		pr_debug("cpu_capacity: CPU%d cpu_capacity=%lu\n",
> +			 c, topology_get_cpu_scale(c));
> +	}
> +
> +	schedule_work(&update_topology_flags_work);
> +}
> +EXPORT_SYMBOL_GPL(topology_update_cpu_capacity);
>  #endif
>  
>  #ifdef CONFIG_CPU_FREQ
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index 09d7745a609f..1480be537eaa 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -979,6 +979,8 @@ static void cppc_cpufreq_update_limits(struct cpufreq_policy *policy)
>  
>  	refresh_frequency_limits(policy);
>  
> +	topology_update_cpu_capacity(policy->cpu, caps);
> +
>  	/*
>  	 * Autonomous selection mode uses MIN/MAX performance as runtime
>  	 * hardware control bounds. Re-program them when highest_perf
> diff --git a/include/linux/arch_topology.h b/include/linux/arch_topology.h
> index ebd7f8935f96..9415cb6a6c2b 100644
> --- a/include/linux/arch_topology.h
> +++ b/include/linux/arch_topology.h
> @@ -11,6 +11,19 @@
>  void topology_normalize_cpu_scale(void);
>  int topology_update_cpu_topology(void);
>  
> +#ifdef CONFIG_ACPI_CPPC_LIB
> +struct cppc_perf_caps;
> +#ifdef CONFIG_GENERIC_ARCH_TOPOLOGY
> +void topology_update_cpu_capacity(unsigned int cpu,
> +				  struct cppc_perf_caps *perf_caps);
> +#else
> +static inline void
> +topology_update_cpu_capacity(unsigned int cpu, struct cppc_perf_caps *perf_caps)
> +{
> +}
> +#endif
> +#endif
> +
>  struct device_node;
>  bool topology_parse_cpu_capacity(struct device_node *cpu_node, int cpu);
>  

