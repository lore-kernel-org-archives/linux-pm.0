From: Tony Lindgren <tony@atomide.com>
Subject: Re: Regression in next with use printk_safe buffers in printk
Date: Tue, 14 Feb 2017 08:54:52 -0800
Message-ID: <20170214165451.GI21809@atomide.com>
References: <20170213185956.GM3897@atomide.com>
 <20170214160140.GA401@tigerII.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:35144 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753823AbdBNQy5 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 14 Feb 2017 11:54:57 -0500
Content-Disposition: inline
In-Reply-To: <20170214160140.GA401@tigerII.localdomain>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org

* Sergey Senozhatsky <sergey.senozhatsky@gmail.com> [170214 08:03]:
> Hello,
> 
> Cc Rafael, just in case
> 
> On (02/13/17 10:59), Tony Lindgren wrote:
> > Looks like commit f975237b7682 ("printk: use printk_safe buffers in
> > printk") causes "possible circular locking dependency detected " for
> > me on the first suspend.
> 
> thanks for the report.
> 
> > Reverting the following four patches in next makes it go away:
> > 
> > d9c23523ed98 ("printk: drop call_console_drivers() unused param")
> > de6fcbdb68b2 ("printk: convert the rest to printk-safe")
> > 8b1742c9c207 ("printk: remove zap_locks() function")
> > f975237b7682 ("printk: use printk_safe buffers in printk")
> 
> 
> these patches basically just enable locked where it previously was
> forcibly turned off. no timekeeping/pm/sched/etc code was modified.
> can you share the link where Peter pointed out that this might be
> caused by printk() changes?

Oh sorry I should have been more specific. Not much there to share,
I got redirected over to Peter's department in a private email thread
while chasing this issue. So that was just Peter's comment looking at
the log output.

> 	timekeeping_resume()
> 		lock timekeeper_lock
> 		lock tk_core
> 			tk_debug_account_sleep_time()
> 			printk()			<< lockdep was disabled here before
> 				try_to_wake_up()
> 					lock_hrtimer_base()  ##hrtimer_bases.lock

Yeah above seems describe what changed, so your patch makes sense.

> shouldn't tk_debug_account_sleep_time() do printk_deferred() instead of
> 'normal' printk()?
> printk() calls from under timekeeping seqlock are not safe, aren't they?
> and tk_debug_account_sleep_time() is under tk_core seq lock.
> 
> IOW, replace pr_info() in tk_debug_account_sleep_time() with something
> like this
> 
> 	printk_deferred(KERN_INFO "Suspended for %lld.%03lu seconds\n",
> 			(s64)t->tv_sec, t->tv_nsec / NSEC_PER_MSEC);

Your patch below fixes the issue for me thanks. I had to apply it manually
though as tabs got replaced by spaces probably by some mail daemons.

Regards,

Tony

> ---
> 
> diff --git a/kernel/time/timekeeping_debug.c b/kernel/time/timekeeping_debug.c
> index ca9fb800336b..b8f7146c3538 100644
> --- a/kernel/time/timekeeping_debug.c
> +++ b/kernel/time/timekeeping_debug.c
> @@ -75,7 +75,8 @@ void tk_debug_account_sleep_time(struct timespec64 *t)
>         int bin = min(fls(t->tv_sec), NUM_BINS-1);
>  
>         sleep_time_bin[bin]++;
> -       pr_info("Suspended for %lld.%03lu seconds\n", (s64)t->tv_sec,
> +       printk_deferred(KERN_INFO "Suspended for %lld.%03lu seconds\n",
> +                       (s64)t->tv_sec,
>                         t->tv_nsec / NSEC_PER_MSEC);
>  }
>  
> 
