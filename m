From: Tony Lindgren <tony@atomide.com>
Subject: Re: Regression in next with use printk_safe buffers in printk
Date: Tue, 14 Feb 2017 09:03:35 -0800
Message-ID: <20170214170335.GS3897@atomide.com>
References: <20170213185956.GM3897@atomide.com>
 <20170214160140.GA401@tigerII.localdomain>
 <20170214161809.GQ6500@twins.programming.kicks-ass.net>
 <20170214165645.GB10321@tigerII.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170214165645.GB10321@tigerII.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, John Stultz <john.stultz@linaro.org>
List-Id: linux-pm@vger.kernel.org

* Sergey Senozhatsky <sergey.senozhatsky@gmail.com> [170214 08:58]:
> On (02/14/17 17:18), Peter Zijlstra wrote:
> > On Wed, Feb 15, 2017 at 01:01:40AM +0900, Sergey Senozhatsky wrote:
> > > 
> > > but I'm a bit confused by rt_b->rt_runtime_lock in this unsafe lock
> > > scenario (so it's not ABBA, but ABAD)
> > > 
> > > >   lock(hrtimer_bases.lock);
> > > >                                lock(&rt_b->rt_runtime_lock);
> > > >                                lock(hrtimer_bases.lock);
> > > >   lock(tk_core);
> > > >
> > > >
> > > > Chain exists of:
> > > >
> > > >	tk_core --> &rt_b->rt_runtime_lock --> hrtimer_bases.lock
> > > 
> > > 
> > > I'm lacking some knowledge here, sorry. where does the tk_core --> &rt_b->rt_runtime_lock
> > > come from?
> > 
> > rt_b->rt_runtime_lock is one of the scheduler locks, since we do
> > printk() under tk_core, which does semaphore muck, which then includes
> > the entire scheduler chain of locks.
> 
> thanks, Peter.
> 
> that crossed my mind, but I kinda assumed that we do printk() from
> under tk_core using sched fair, and rt_runtime_lock is from sched rt.
> 
> 
> so something like below, perhaps. would be helpful if Tony can test it.
> 
> (I'll send out this patch 'in a proper way' tomorrow, after some sleep,
> it's 2am here).
> 
> 8< ====
> 
> From e1755b0bf7f8a0be5fdf4dd7303bf4cd150d9d20 Mon Sep 17 00:00:00 2001
> From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> Date: Wed, 15 Feb 2017 01:42:18 +0900
> Subject: [PATCH] time/timekeeping_debug: use printk_deferred()
> 
> Do not call printk() from tk_debug_account_sleep_time(), because
> tk_debug_account_sleep_time() is called under tk_core seq lock.
> It's not safe to call printk() under tk_core, because console_sem
> invokes scheduled (via wake_up_process()->activate_task()), which,
> in turn, can call timekeeping code again, for instance, via
> get_time()->ktime_get(). This may result in infinite loop on
> tk_core.
> 
> Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

Thanks yeah this fixes the issue for me:

Tested-by: Tony Lindgren <tony@atomide.com>

> ---
>  kernel/time/timekeeping_debug.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/time/timekeeping_debug.c b/kernel/time/timekeeping_debug.c
> index ca9fb800336b..b8f7146c3538 100644
> --- a/kernel/time/timekeeping_debug.c
> +++ b/kernel/time/timekeeping_debug.c
> @@ -75,7 +75,8 @@ void tk_debug_account_sleep_time(struct timespec64 *t)
>  	int bin = min(fls(t->tv_sec), NUM_BINS-1);
>  
>  	sleep_time_bin[bin]++;
> -	pr_info("Suspended for %lld.%03lu seconds\n", (s64)t->tv_sec,
> +	printk_deferred(KERN_INFO "Suspended for %lld.%03lu seconds\n",
> +			(s64)t->tv_sec,
>  			t->tv_nsec / NSEC_PER_MSEC);
>  }
>  
> -- 
> 2.11.1
> 
