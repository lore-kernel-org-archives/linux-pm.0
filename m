From: Jan Kara <jack@suse.cz>
Subject: Re: [Query] Preemption (hogging) of the work handler
Date: Thu, 14 Jul 2016 16:55:54 +0200
Message-ID: <20160714145554.GG13151@quack2.suse.cz>
References: <20160701165959.GR12473@ubuntu>
 <163184622.ctfAvoN0Mo@vostro.rjw.lan>
 <20160714143939.GF13151@quack2.suse.cz>
 <56498260.j02nbY6ACm@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <56498260.j02nbY6ACm@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Jan Kara <jack@suse.cz>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Viresh Kumar <viresh.kumar@linaro.org>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Tejun Heo <tj@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, vlevenetz@mm-sol.com, vaibhav.hiremath@linaro.org, alex.elder@linaro.org, johan@kernel.org, akpm@linux-foundation.org, rostedt@goodmis.org, linux-pm@vger.kernel.org, Petr Mladek <pmladek@suse.com>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-pm@vger.kernel.org

On Thu 14-07-16 16:47:11, Rafael J. Wysocki wrote:
> On Thursday, July 14, 2016 04:39:39 PM Jan Kara wrote:
> > On Thu 14-07-16 16:33:38, Rafael J. Wysocki wrote:
> > > On Thursday, July 14, 2016 04:12:16 PM Jan Kara wrote:
> > > > On Wed 13-07-16 14:45:07, Sergey Senozhatsky wrote:
> > > > > Cc Petr Mladek.
> > > > > 
> > > > > On (07/12/16 16:19), Viresh Kumar wrote:
> > > > > [..]
> > > > > > Okay, we have tracked this BUG and its really interesting.
> > > > > 
> > > > > good find!
> > > > > 
> > > > > > I hacked the platform's serial driver to implement a putchar() routine
> > > > > > that simply writes to the FIFO in polling mode, that helped us in
> > > > > > tracing on where we are going wrong.
> > > > > > 
> > > > > > The problem is that we are running asynchronous printks and we call
> > > > > > wake_up_process() from the last running CPU which has disabled
> > > > > > interrupts. That takes us to: try_to_wake_up().
> > > > > > 
> > > > > > In our case the CPU gets deadlocked on this line in try_to_wake_up().
> > > > > > 
> > > > > >         raw_spin_lock_irqsave(&p->pi_lock, flags);
> > > > > 
> > > > > yeah, printk() can't handle these types of recursion. it can prevent
> > > > > printk() calls issued from within the logbuf_lock spinlock section,
> > > > > with some limitations:
> > > > > 
> > > > > 	if (unlikely(logbuf_cpu == smp_processor_id())) {
> > > > > 		recursion_bug = true;
> > > > > 		return;
> > > > > 	}
> > > > > 
> > > > > 	raw_spin_lock(&logbuf_lock);
> > > > > 	logbuf_cpu = this_cpu;
> > > > > 		...
> > > > > 	logbuf_cpu = UINT_MAX;
> > > > > 	raw_spin_unlock(&logbuf_lock);
> > > > > 
> > > > > so should, for instance, raw_spin_unlock() generate spin_dump(), printk()
> > > > > will blow up (both sync and async), because logbuf_cpu is already reset.
> > > > > it may look that async printk added another source of recursion - wake_up().
> > > > > but, apparently, this is not exactly correct. because there is already a
> > > > > wake_up() call in console_unlock() - up().
> > > > > 
> > > > > 	printk()
> > > > > 	 if (logbuf_cpu == smp_processor_id())
> > > > > 		return;
> > > > > 
> > > > >          raw_spin_lock(&logbuf_lock);
> > > > > 	 logbuf_cpu = this_cpu;
> > > > > 	 ...
> > > > > 	 logbuf_cpu = UINT_MAX;
> > > > >          raw_spin_unlock(&logbuf_lock);
> > > > > 
> > > > > 	 console_trylock()
> > > > > 	   raw_spin_lock_irqsave(&sem->lock)      << ***
> > > > > 	   raw_spin_unlock_irqsave(&sem->lock)    << ***
> > > > > 
> > > > > 	 console_unlock()
> > > > >           up()
> > > > > 	   raw_spin_lock_irqsave(&sem->lock)  << ***
> > > > > 	    __up()
> > > > > 	     wake_up_process()
> > > > > 	      try_to_wake_up()  << *** in may places
> > > > > 
> > > > > 
> > > > > *** a printk() call from here will kill the system. either it will
> > > > > recurse printk(), or spin forever in 'nested' printk() on one of
> > > > > the already taken spin locks.
> > > > 
> > > > Exactly. Calling printk() from certain parts of the kernel (like scheduler
> > > > code or timer code) has been always unsafe because printk itself uses these
> > > > parts and so it can lead to deadlocks. That's why printk_deffered() has
> > > > been introduced as you mention below.
> > > > 
> > > > And with sync printk the above deadlock doesn't trigger only by chance - if
> > > > there happened to be a waiter on console_sem while we suspend, the same
> > > > deadlock would trigger because up(&console_sem) will try to wake him up and
> > > > the warning in timekeeping code will cause recursive printk.
> > > > 
> > > > So I think your patch doesn't really address the real issue - it only
> > > > works around the particular WARN_ON(timekeeping_enabled) warning but if
> > > > there was a different warning in timekeeping code which would trigger, it
> > > > has a potential for causing recursive printk deadlock (and indeed we had
> > > > such issues previously - see e.g. 504d58745c9c "timer: Fix lock inversion
> > > > between hrtimer_bases.lock and scheduler locks").
> > > > 
> > > > So there are IMHO two issues here worth looking at:
> > > > 
> > > > 1) I didn't find how a wakeup would would lead to calling to ktime_get() in
> > > > the current upstream kernel or even current RT kernel. Maybe this is a
> > > > problem specific to the 3.10 kernel you are using? If yes, we don't have to
> > > > do anything for current upstream AFAIU.
> > > > 
> > > > If I just missed how wakeup can call into ktime_get() in current upstream,
> > > > there is another question:
> > > > 
> > > > 2) Is it OK that printk calls wakeup so late during suspend? I believe it
> > > > is but I'm neither scheduler nor suspend expert.
> > > 
> > > I don't think it really is OK.  Nothing will wake up for sure at this point,
> > > so why to do that in the first place?
> > 
> > So that the process is put into a runnable state (currently it is in
> > uninterruptible sleep) and may run after the system resumes?
> 
> Fair enough.
> 
> But calling ktime_get() with suspended timekeeping is dumb at best which
> is why the warning is there.

Agree on that - but that seems to be a problem of a particular wakeup
implementation of the 3.10 kernel Viresh is using, not a problem of the
upstream kernel.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
