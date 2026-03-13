Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFEDA379EFD;
	Fri, 13 Mar 2026 12:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773406407; cv=none; b=nVcDAyJWhC2daQg4S3xjvYx1ukCI55f1caxkq5xscH0xYDJDk/3ou/LlyLs8FxDigmsWr3BuGtCVwI9zrJ+qBx4Zc/6M0oLZf9Mwo5tB5ADbJvNSXp+9FgRjHVkX+j5MMEsnNStIiJqaxWO9qSZ8f8cZ7MUHRMO0a+44n1pb5Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773406407; c=relaxed/simple;
	bh=FYcj/Cbt+YjFWZxDaG3RA/F08eK1D9HtlGA+MNQUhFQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HK7ZHoeg3e01r/yQhiaDnS6iW/6eyQrnsjrWwAZr4RGzikijdkdmzccFmrdF202sMM5AenSkokQCLrmXFlbHV6jgOXt0XYgiMOAA8GaOle0eZuT5+gKuK/mpEWtVhnepqP7/KdNZKf7GgP7z5Wab9r4Vg7c5ADVpKLEYq7XIXr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 95542165C;
	Fri, 13 Mar 2026 05:53:17 -0700 (PDT)
Received: from [10.1.37.41] (e127648.arm.com [10.1.37.41])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9C3FF3F7BD;
	Fri, 13 Mar 2026 05:53:22 -0700 (PDT)
Message-ID: <c1f6d920-6bd9-4131-af08-da1be1206812@arm.com>
Date: Fri, 13 Mar 2026 12:53:20 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] sched: idle: Consolidate the handling of two special
 cases
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Thomas Gleixner
 <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>,
 Qais Yousef <qyousef@layalina.io>, Frederic Weisbecker
 <frederic@kernel.org>, Aboorva Devarajan <aboorvad@linux.ibm.com>
References: <4741364.LvFx2qVVIh@rafael.j.wysocki>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <4741364.LvFx2qVVIh@rafael.j.wysocki>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/13/26 12:25, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> There are two special cases in the idle loop that are handled
> inconsistently even though they are analogous.
> 
> The first one is when a cpuidle driver is absent and the default CPU
> idle time power management implemented by the architecture code is used.
> In that case, the scheduler tick is stopped every time before invoking
> default_idle_call().
> 
> The second one is when a cpuidle driver is present, but there is only
> one idle state in its table.  In that case, the scheduler tick is never
> stopped.
> 
> Since each of these approaches leads to suboptimal choices in some
> cases, reconcile them with the help of one simple heuristic.  Namely,
> stop the tick if the CPU has been woken up by it in the previous
> iteration of the idle loop, or let it tick otherwise.> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> Based on today's mainline.
> 
> ---
>  kernel/sched/idle.c |   30 +++++++++++++++++++++---------
>  1 file changed, 21 insertions(+), 9 deletions(-)
> 
> --- a/kernel/sched/idle.c
> +++ b/kernel/sched/idle.c
> @@ -161,6 +161,14 @@ static int call_cpuidle(struct cpuidle_d
>  	return cpuidle_enter(drv, dev, next_state);
>  }
>  
> +static void idle_call_stop_or_retain_tick(bool stop_tick)
> +{
> +	if (stop_tick || tick_nohz_tick_stopped())
> +		tick_nohz_idle_stop_tick();
> +	else
> +		tick_nohz_idle_retain_tick();
> +}
> +
>  /**
>   * cpuidle_idle_call - the main idle function
>   *
> @@ -170,7 +178,7 @@ static int call_cpuidle(struct cpuidle_d
>   * set, and it returns with polling set.  If it ever stops polling, it
>   * must clear the polling bit.
>   */
> -static void cpuidle_idle_call(void)
> +static void cpuidle_idle_call(bool stop_tick)
>  {
>  	struct cpuidle_device *dev = cpuidle_get_device();
>  	struct cpuidle_driver *drv = cpuidle_get_cpu_driver(dev);
> @@ -186,7 +194,7 @@ static void cpuidle_idle_call(void)
>  	}
>  
>  	if (cpuidle_not_available(drv, dev)) {
> -		tick_nohz_idle_stop_tick();
> +		idle_call_stop_or_retain_tick(stop_tick);
>  
>  		default_idle_call();
>  		goto exit_idle;
> @@ -222,17 +230,19 @@ static void cpuidle_idle_call(void)
>  		next_state = cpuidle_find_deepest_state(drv, dev, max_latency_ns);
>  		call_cpuidle(drv, dev, next_state);
>  	} else if (drv->state_count > 1) {
> -		bool stop_tick = true;
> +		/*
> +		 * stop_tick is expected to be true by default by cpuidle
> +		 * governors, which allows them to select idle states with
> +		 * target residency above the tick period length.
> +		 */
> +		stop_tick = true;
>  
>  		/*
>  		 * Ask the cpuidle framework to choose a convenient idle state.
>  		 */
>  		next_state = cpuidle_select(drv, dev, &stop_tick);
>  
> -		if (stop_tick || tick_nohz_tick_stopped())
> -			tick_nohz_idle_stop_tick();
> -		else
> -			tick_nohz_idle_retain_tick();
> +		idle_call_stop_or_retain_tick(stop_tick);
>  
>  		entered_state = call_cpuidle(drv, dev, next_state);
>  		/*
> @@ -240,7 +250,7 @@ static void cpuidle_idle_call(void)
>  		 */
>  		cpuidle_reflect(dev, entered_state);
>  	} else {
> -		tick_nohz_idle_retain_tick();
> +		idle_call_stop_or_retain_tick(stop_tick);

This would supersede e5c9ffc6ae1b ("cpuidle: Skip governor when only one idle state is available")
so we should remove that code too.
LGTM otherwise.

>  
>  		/*
>  		 * If there is only a single idle state (or none), there is
> @@ -268,6 +278,7 @@ exit_idle:
>  static void do_idle(void)
>  {
>  	int cpu = smp_processor_id();
> +	bool got_tick = false;
>  
>  	/*
>  	 * Check if we need to update blocked load
> @@ -338,8 +349,9 @@ static void do_idle(void)
>  			tick_nohz_idle_restart_tick();
>  			cpu_idle_poll();
>  		} else {
> -			cpuidle_idle_call();
> +			cpuidle_idle_call(got_tick);
>  		}
> +		got_tick = tick_nohz_idle_got_tick();
>  		arch_cpu_idle_exit();
>  	}
>  
> 
> 
> 

