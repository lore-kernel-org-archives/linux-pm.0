From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 1/8] sched/cpufreq: remove cpufreq_trigger_update()
Date: Wed, 16 Mar 2016 09:00:50 +0100
Message-ID: <20160316080050.GR6344@twins.programming.kicks-ass.net>
References: <1457932932-28444-1-git-send-email-mturquette+renesas@baylibre.com>
 <1457932932-28444-2-git-send-email-mturquette+renesas@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1457932932-28444-2-git-send-email-mturquette+renesas@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Michael Turquette <mturquette@baylibre.com>
Cc: rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Juri.Lelli@arm.com, steve.muckle@linaro.org, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, vincent.guittot@linaro.org, Michael Turquette <mturquette+renesas@baylibre.com>
List-Id: linux-pm@vger.kernel.org

On Sun, Mar 13, 2016 at 10:22:05PM -0700, Michael Turquette wrote:
> cpufreq_trigger_update() was introduced in "cpufreq: Rework the
> scheduler hooks for triggering updates"[0]. Consensus is that this
> helper is not needed and removing it will aid in experimenting with
> deadline and rt capacity requests.
> 
> Instead of reverting the above patch, which includes useful renaming of
> data structures and related functions, simply remove the function,
> update affected kerneldoc and change rt.c and deadline.c to use
> cpufreq_update_util().

> -/**
> - * cpufreq_trigger_update - Trigger CPU performance state evaluation if needed.
> - * @time: Current time.
> - *
> - * The way cpufreq is currently arranged requires it to evaluate the CPU
> - * performance state (frequency/voltage) on a regular basis.  To facilitate
> - * that, cpufreq_update_util() is called by update_load_avg() in CFS when
> - * executed for the current CPU's runqueue.
> - *
> - * However, this isn't sufficient to prevent the CPU from being stuck in a
> - * completely inadequate performance level for too long, because the calls
> - * from CFS will not be made if RT or deadline tasks are active all the time
> - * (or there are RT and DL tasks only).
> - *
> - * As a workaround for that issue, this function is called by the RT and DL
> - * sched classes to trigger extra cpufreq updates to prevent it from stalling,
> - * but that really is a band-aid.  Going forward it should be replaced with
> - * solutions targeted more specifically at RT and DL tasks.
> - */
> -void cpufreq_trigger_update(u64 time)
> -{
> -	cpufreq_update_util(time, ULONG_MAX, 0);
> -}

> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index 1a035fa..3fd5bc4 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -728,7 +728,7 @@ static void update_curr_dl(struct rq *rq)
>  
>  	/* Kick cpufreq (see the comment in drivers/cpufreq/cpufreq.c). */
>  	if (cpu_of(rq) == smp_processor_id())
> -		cpufreq_trigger_update(rq_clock(rq));
> +		cpufreq_update_util(rq_clock(rq), ULONG_MAX, 0);
>  
>  	/*
>  	 * Consumed budget is computed considering the time as

OK, so take two on this, now hopefully more coherent (yay for sleep!).

So my problem is that this (update_curr_dl) is not the right location to
set DL utilization (although it might be for avg dl, see the other
email).

The only reason it lives here, is that some cpufreq governors require
'timely' calls into this hook. The comment you destroyed tries to convey
this.

We should still remove this requirement from the governors. And for
simple DL guarantees this hook is placed wrong.
