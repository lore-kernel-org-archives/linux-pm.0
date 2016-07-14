From: Jan Kara <jack@suse.cz>
Subject: Re: [Query] Preemption (hogging) of the work handler
Date: Thu, 14 Jul 2016 17:03:49 +0200
Message-ID: <20160714150349.GH13151@quack2.suse.cz>
References: <20160701165959.GR12473@ubuntu>
 <20160701172232.GD28719@htj.duckdns.org>
 <20160706182842.GS2671@ubuntu>
 <20160711102603.GI12410@quack2.suse.cz>
 <20160711154438.GA528@swordfish>
 <20160711223501.GI4695@ubuntu>
 <20160712231903.GR4695@ubuntu>
 <20160713054507.GA563@swordfish>
 <20160714141216.GC13151@quack2.suse.cz>
 <20160714143450.GA619@swordfish>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:45515 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751051AbcGNPD5 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 14 Jul 2016 11:03:57 -0400
Content-Disposition: inline
In-Reply-To: <20160714143450.GA619@swordfish>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Viresh Kumar <viresh.kumar@linaro.org>, rjw@rjwysocki.net, Tejun Heo <tj@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, vlevenetz@mm-sol.com, vaibhav.hiremath@linaro.org, alex.elder@linaro.org, johan@kernel.org, akpm@linux-foundation.org, rostedt@goodmis.org, linux-pm@vger.kernel.org, Petr Mladek <pmladek@suse.com>, Thomas Gleixner <tglx@linutronix.de>

On Thu 14-07-16 23:34:50, Sergey Senozhatsky wrote:
> Hello Jan,
> 
> On (07/14/16 16:12), Jan Kara wrote:
> [..]
> > > *** a printk() call from here will kill the system. either it will
> > > recurse printk(), or spin forever in 'nested' printk() on one of
> > > the already taken spin locks.
> [..]
> > And with sync printk the above deadlock doesn't trigger only by chance - if
> > there happened to be a waiter on console_sem while we suspend, the same
> > deadlock would trigger because up(&console_sem) will try to wake him up and
> > the warning in timekeeping code will cause recursive printk.
> > 
> > So I think your patch doesn't really address the real issue - it only
> > works around the particular WARN_ON(timekeeping_enabled) warning but if
> > there was a different warning in timekeeping code which would trigger, it
> > has a potential for causing recursive printk deadlock (and indeed we had
> > such issues previously - see e.g. 504d58745c9c "timer: Fix lock inversion
> > between hrtimer_bases.lock and scheduler locks").
> 
> we switch to sync printk in suspend_console(), that is happening
> long before we start bringing cpu downs
> 
> suspend_devices_and_enter()
> 	suspend_console()
> 	...
> 	suspend_enter()
> 		...
> 		dpm_suspend_late
> 		...
> 		disable_nonboot_cpus
> 
> 
> 
> and cpu_down() in printk does
> 
> static int console_cpu_notify(struct notifier_block *self,
> 	unsigned long action, void *hcpu)
> {
> 	switch (action) {
> 	case CPU_ONLINE:
> 	case CPU_DEAD:
> 	case CPU_DOWN_FAILED:
> 	case CPU_UP_CANCELED:
> 		console_lock();
> 		console_unlock();
> 	}
> 	return NOTIFY_OK;
> }
> 
> so I think this console_lock() sort of guarantees that there should be
> no sleeping tasks in console semaphore wait list. or am I missing something?

No, probably you're right - unless there would be a CPU notifier executed
after console_cpu_notify() which would try to acquire console_sem for some
reason. But that is a wild speculation and I tend to agree that in
synchronous printk case and current code the wakeup cannot happen.

But my point really is that I don't see why changing process state (which
is what wakeup actually is) should be problematic even this late during
suspend...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
