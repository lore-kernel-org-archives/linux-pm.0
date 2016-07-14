From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [Query] Preemption (hogging) of the work handler
Date: Thu, 14 Jul 2016 23:34:50 +0900
Message-ID: <20160714143450.GA619@swordfish>
References: <20160701165959.GR12473@ubuntu>
 <20160701172232.GD28719@htj.duckdns.org>
 <20160706182842.GS2671@ubuntu>
 <20160711102603.GI12410@quack2.suse.cz>
 <20160711154438.GA528@swordfish>
 <20160711223501.GI4695@ubuntu>
 <20160712231903.GR4695@ubuntu>
 <20160713054507.GA563@swordfish>
 <20160714141216.GC13151@quack2.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f68.google.com ([209.85.220.68]:36585 "EHLO
	mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750983AbcGNOfT (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 14 Jul 2016 10:35:19 -0400
Content-Disposition: inline
In-Reply-To: <20160714141216.GC13151@quack2.suse.cz>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jan Kara <jack@suse.cz>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Viresh Kumar <viresh.kumar@linaro.org>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, rjw@rjwysocki.net, Tejun Heo <tj@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, vlevenetz@mm-sol.com, vaibhav.hiremath@linaro.org, alex.elder@linaro.org, johan@kernel.org, akpm@linux-foundation.org, rostedt@goodmis.org, linux-pm@vger.kernel.org, Petr Mladek <pmladek@suse.com>, Thomas Gleixner <tglx@linutronix.de>

Hello Jan,

On (07/14/16 16:12), Jan Kara wrote:
[..]
> > *** a printk() call from here will kill the system. either it will
> > recurse printk(), or spin forever in 'nested' printk() on one of
> > the already taken spin locks.
[..]
> And with sync printk the above deadlock doesn't trigger only by chance - if
> there happened to be a waiter on console_sem while we suspend, the same
> deadlock would trigger because up(&console_sem) will try to wake him up and
> the warning in timekeeping code will cause recursive printk.
> 
> So I think your patch doesn't really address the real issue - it only
> works around the particular WARN_ON(timekeeping_enabled) warning but if
> there was a different warning in timekeeping code which would trigger, it
> has a potential for causing recursive printk deadlock (and indeed we had
> such issues previously - see e.g. 504d58745c9c "timer: Fix lock inversion
> between hrtimer_bases.lock and scheduler locks").

we switch to sync printk in suspend_console(), that is happening
long before we start bringing cpu downs

suspend_devices_and_enter()
	suspend_console()
	...
	suspend_enter()
		...
		dpm_suspend_late
		...
		disable_nonboot_cpus



and cpu_down() in printk does

static int console_cpu_notify(struct notifier_block *self,
	unsigned long action, void *hcpu)
{
	switch (action) {
	case CPU_ONLINE:
	case CPU_DEAD:
	case CPU_DOWN_FAILED:
	case CPU_UP_CANCELED:
		console_lock();
		console_unlock();
	}
	return NOTIFY_OK;
}

so I think this console_lock() sort of guarantees that there should be
no sleeping tasks in console semaphore wait list. or am I missing something?

> So there are IMHO two issues here worth looking at:
> 
> 1) I didn't find how a wakeup would would lead to calling to ktime_get() in
> the current upstream kernel or even current RT kernel. Maybe this is a
> problem specific to the 3.10 kernel you are using? If yes, we don't have to
> do anything for current upstream AFAIU.

I personally suspect it's an in-hose (custom) code.

	-ss

> If I just missed how wakeup can call into ktime_get() in current upstream,
> there is another question:
> 
> 2) Is it OK that printk calls wakeup so late during suspend? I believe it
> is but I'm neither scheduler nor suspend expert. If it is OK, and wakeup
> can lead to ktime_get() in current upstream, then this contradicts the
> check WARN_ON(timekeeping_suspended) in ktime_get() and something is wrong.
> 
> Adding Thomas to CC as timer / RT expert...
> 
> 								Honza
> 
> > so... I think we can switch to sync printk mode in suspend_console() and
> > enable async printk from resume_console(). IOW, suspend/kexec are now
> > executed under sync printk mode.
> > 
> > we already call console_unlock() during suspend, which is synchronous,
> > many times (e.g. console_cpu_notify()).
> > 
> > 
> > something like below, perhaps. will this work for you?
> > 
> > ---
> >  kernel/printk/printk.c | 12 +++++++++++-
> >  1 file changed, 11 insertions(+), 1 deletion(-)
> > 
> > diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> > index bbb4180..786690e 100644
> > --- a/kernel/printk/printk.c
> > +++ b/kernel/printk/printk.c
> > @@ -288,6 +288,11 @@ static u32 log_buf_len = __LOG_BUF_LEN;
> >  
> >  /* Control whether printing to console must be synchronous. */
> >  static bool __read_mostly printk_sync = true;
> > +/*
> > + * Force sync printk mode during suspend/kexec, regardless whether
> > + * console_suspend_enabled permits console suspend.
> > + */
> > +static bool __read_mostly force_printk_sync;
> >  /* Printing kthread for async printk */
> >  static struct task_struct *printk_kthread;
> >  /* When `true' printing thread has messages to print */
> > @@ -295,7 +300,7 @@ static bool printk_kthread_need_flush_console;
> >  
> >  static inline bool can_printk_async(void)
> >  {
> > -	return !printk_sync && printk_kthread;
> > +	return !printk_sync && printk_kthread && !force_printk_sync;
> >  }
> >  
> >  /* Return log buffer address */
> > @@ -2027,6 +2032,7 @@ static bool suppress_message_printing(int level) { return false; }
> >  
> >  /* Still needs to be defined for users */
> >  DEFINE_PER_CPU(printk_func_t, printk_func);
> > +static bool __read_mostly force_printk_sync;
> >  
> >  #endif /* CONFIG_PRINTK */
> >  
> > @@ -2163,6 +2169,8 @@ MODULE_PARM_DESC(console_suspend, "suspend console during suspend"
> >   */
> >  void suspend_console(void)
> >  {
> > +	force_printk_sync = true;
> > +
> >  	if (!console_suspend_enabled)
> >  		return;
> >  	printk("Suspending console(s) (use no_console_suspend to debug)\n");
> > @@ -2173,6 +2181,8 @@ void suspend_console(void)
> >  
> >  void resume_console(void)
> >  {
> > +	force_printk_sync = false;
> > +
> >  	if (!console_suspend_enabled)
> >  		return;
> >  	down_console_sem();
> > -- 
> > 2.9.0.rc1
> > 
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
> 
