Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CE044334CA;
	Mon, 24 Aug 2026 14:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787580483; cv=none; b=IbIZtFrtJ2YQ17Om4gbrpHrFiNtXy2aAzjjysrS/XwCXkbr07r9BBAR7Bn9oDl8rjalS3iZDozYWFD5FiQM61A9hbkSW1lYnjSH8Q6seyCiw4YlLwNA5w4m9s2e/K0n46MYTdsr+gNsraaWvqRgG5oxV3EmhkTVqRI6zBpe0RHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787580483; c=relaxed/simple;
	bh=sCQFN55hS6uh/3yu8BodGmrJUPakI9h3K67oyeqsq6I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cJbY+q192UMF5VtxPtmCIL8R7IM8zQz8sQsJr4bD6HGHhpgV5O5HmixWbF/5nX65VLCjr7hoC17ykrQLxcNBugFGNV7grfJXcs/WkMTDc34fNTSHXLZulzGvRvKJtwh6m6mfROiZueTjbiS2hUb0Z+oe/Z71LhgrXwf3ktWS9xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=O949DjI0; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="O949DjI0"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 302F016F2;
	Mon, 24 Aug 2026 07:07:56 -0700 (PDT)
Received: from [10.1.39.91] (e127648.arm.com [10.1.39.91])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9B8383F85F;
	Mon, 24 Aug 2026 07:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1787580480; bh=sCQFN55hS6uh/3yu8BodGmrJUPakI9h3K67oyeqsq6I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=O949DjI0P/ZmgDkCcO/RhBBqs7cqisuPVDI64nCOyaV91Lk23zc5H8TEEnT8VrxzY
	 wH7Yr+gnuxRqmCLsFrAD+5cZOYmdZawvqnOMjBemOfn91lXEVvOyqDq7whJP/BOIoE
	 VuoETec0y6MxjhcXwH4OYxQy/H4D8WeSOlZ6gPZs=
Message-ID: <a4da085b-5a42-4559-a677-3796acd65170@arm.com>
Date: Mon, 24 Aug 2026 15:07:54 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched/cpufreq: Reevaluate frequency before tickless idle
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 rafael@kernel.org, viresh.kumar@linaro.org, mingo@redhat.com,
 peterz@infradead.org, vincent.guittot@linaro.org, daniel.lezcano@kernel.org
Cc: anna-maria@linutronix.de, frederic@kernel.org, tglx@linutronix.de,
 dietmar.eggemann@arm.com, jstultz@google.com, qyousef@layalina.io,
 hongyan.xia@transsion.com, sibi.sankar@oss.qualcomm.com,
 lukasz.luba@arm.com, morten.rasmussen@arm.com
References: <20260824131842.2443385-1-christian.loehle@arm.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <20260824131842.2443385-1-christian.loehle@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/24/26 14:18, Christian Loehle wrote:
> sugov_hold_freq() can preserve a UCLAMP_MIN-driven high frequency when
> the runqueue goes idle. If cpuidle then stops the tick, no later
> utilization update is guaranteed and a CPU using WFI can remain at an
> unnecessarily high voltage for the entire idle period.
> 
> Issue a final cpufreq update when the idle tick actually transitions to
> stopped and force single-policy schedutil past its rate limit. Keep the
> existing hold behavior when the tick is retained.
> 
> Signed-off-by: Christian Loehle <christian.loehle@arm.com>
> ---
>  include/linux/sched/cpufreq.h    |  1 +
>  kernel/sched/cpufreq_schedutil.c |  5 ++++-
>  kernel/sched/idle.c              | 29 +++++++++++++++++++++++++++--
>  3 files changed, 32 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/sched/cpufreq.h b/include/linux/sched/cpufreq.h
> index bdd31ab93bc5..0814f6c79315 100644
> --- a/include/linux/sched/cpufreq.h
> +++ b/include/linux/sched/cpufreq.h
> @@ -9,6 +9,7 @@
>   */
>  
>  #define SCHED_CPUFREQ_IOWAIT	(1U << 0)
> +#define SCHED_CPUFREQ_IDLE	(1U << 1)
>  
>  #ifdef CONFIG_CPU_FREQ
>  struct cpufreq_policy;
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index a1782755efcc..90bf8d8bffb7 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -100,7 +100,7 @@ static bool sugov_should_update_freq(struct sugov_policy *sg_policy, u64 time)
>  
>  		return true;
>  	} else if (sg_policy->need_freq_update) {
> -		/* ignore_dl_rate_limit() wants a new frequency to be found. */
> +		/* A forced update needs a new frequency to be found. */
>  		return true;
>  	}
>  
> @@ -407,6 +407,9 @@ static inline bool sugov_update_single_common(struct sugov_cpu *sg_cpu,
>  	sugov_iowait_boost(sg_cpu, time, flags);
>  	sg_cpu->last_update = time;
>  
> +	if (flags & SCHED_CPUFREQ_IDLE)
> +		sg_cpu->sg_policy->need_freq_update = true;
> +
>  	ignore_dl_rate_limit(sg_cpu);
>  
>  	if (!sugov_should_update_freq(sg_cpu->sg_policy, time))
> diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
> index eb73b65ce6c4..36f8840d0562 100644
> --- a/kernel/sched/idle.c
> +++ b/kernel/sched/idle.c
> @@ -161,10 +161,35 @@ static int call_cpuidle(struct cpuidle_driver *drv, struct cpuidle_device *dev,
>  	return cpuidle_enter(drv, dev, next_state);
>  }
>  
> +static void idle_stop_tick(void)
> +{
> +#ifdef CONFIG_CPU_FREQ
> +	bool was_stopped = tick_nohz_tick_stopped();
> +#endif
> +
> +	tick_nohz_idle_stop_tick();
> +
> +#ifdef CONFIG_CPU_FREQ
> +	/*
> +	 * Run one last cpufreq update before entering idle with the tick
> +	 * stopped, because no later update is guaranteed.
> +	 */
> +	if (!was_stopped && tick_nohz_tick_stopped()) {
> +		struct rq *rq = this_rq();
> +		struct rq_flags rf;
> +
> +		rq_lock(rq, &rf);
> +		update_rq_clock(rq);
> +		cpufreq_update_util(rq, SCHED_CPUFREQ_IDLE);

Sashiko correctly noted that this may lead to an infinite loop on
slow-switch platforms where the pre-idle update results in another
sugov kthread wakeup which in turn will result in a new pre-idle
cpufreq update.

I will just track if sugov actually held a frequency and gate
the update on that in v2.
