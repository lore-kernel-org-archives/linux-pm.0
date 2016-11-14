From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 3/3] thermal/powerclamp: use PF_IDLE in injection kthread
Date: Mon, 14 Nov 2016 16:11:05 +0100
Message-ID: <20161114151105.GH3142@twins.programming.kicks-ass.net>
References: <1478718312-12847-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1478718312-12847-4-git-send-email-jacob.jun.pan@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:34180 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751532AbcKNPML (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 14 Nov 2016 10:12:11 -0500
Content-Disposition: inline
In-Reply-To: <1478718312-12847-4-git-send-email-jacob.jun.pan@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Zhang Rui <rui.zhang@intel.com>, Rafael Wysocki <rafael.j.wysocki@intel.com>, "Chen, Yu C" <yu.c.chen@intel.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Petr Mladek <pmladek@suse.com>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Arjan van de Ven <arjan@linux.intel.com>

On Wed, Nov 09, 2016 at 11:05:12AM -0800, Jacob Pan wrote:
> +static enum hrtimer_restart idle_inject_timer_fn(struct hrtimer *hrtimer)
> +{
> +	set_tsk_need_resched(current);

So drivers really should not use this, which is why I had that in
play_idle().

> +	return HRTIMER_NORESTART;
> +}
> +
>  static void clamp_idle_injection_func(struct kthread_work *work)
>  {
>  	struct powerclamp_worker_data *w_data;
> -	unsigned long target_jiffies;
> +	unsigned long end_time;
> +	unsigned int duration_ms;
>  
>  	w_data = container_of(work, struct powerclamp_worker_data,
>  			      idle_injection_work.work);
>  
> +	hrtimer_init(&w_data->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_PINNED);
> +	w_data->timer.function = idle_inject_timer_fn;
> +
>  	/*
>  	 * only elected controlling cpu can collect stats and update
>  	 * control parameters.
> @@ -453,31 +459,17 @@ static void clamp_idle_injection_func(struct kthread_work *work)
>  	if (should_skip)
>  		goto balance;
>  
> +	end_time = jiffies + w_data->duration_jiffies;
> +	duration_ms = jiffies_to_msecs(w_data->duration_jiffies);
> +	hrtimer_start(&w_data->timer, ms_to_ktime(duration_ms),
> +		HRTIMER_MODE_REL_PINNED);
> +
> +	cpuidle_use_deepest_state(true);
> +	while (time_after(end_time, jiffies))
> +		play_idle();

Why that loop?

> +	cpuidle_use_deepest_state(false);

> +
> +	hrtimer_cancel(&w_data->timer);
