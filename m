From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [Query] Preemption (hogging) of the work handler
Date: Wed, 13 Jul 2016 08:39:10 -0700
Message-ID: <20160713153910.GY4695@ubuntu>
References: <20160701165959.GR12473@ubuntu>
 <20160701172232.GD28719@htj.duckdns.org>
 <20160706182842.GS2671@ubuntu>
 <20160711102603.GI12410@quack2.suse.cz>
 <20160711154438.GA528@swordfish>
 <20160711223501.GI4695@ubuntu>
 <20160712231903.GR4695@ubuntu>
 <20160713054507.GA563@swordfish>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160713054507.GA563@swordfish>
Sender: linux-kernel-owner@vger.kernel.org
To: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, rjw@rjwysocki.net, Tejun Heo <tj@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, vlevenetz@mm-sol.com, vaibhav.hiremath@linaro.org, alex.elder@linaro.org, johan@kernel.org, akpm@linux-foundation.org, rostedt@goodmis.org, linux-pm@vger.kernel.org, Petr Mladek <pmladek@suse.com>
List-Id: linux-pm@vger.kernel.org

On 13-07-16, 14:45, Sergey Senozhatsky wrote:
> On (07/12/16 16:19), Viresh Kumar wrote:
> [..]
> > Okay, we have tracked this BUG and its really interesting.
> 
> good find!
> 
> > I hacked the platform's serial driver to implement a putchar() routine
> > that simply writes to the FIFO in polling mode, that helped us in
> > tracing on where we are going wrong.
> > 
> > The problem is that we are running asynchronous printks and we call
> > wake_up_process() from the last running CPU which has disabled
> > interrupts. That takes us to: try_to_wake_up().
> > 
> > In our case the CPU gets deadlocked on this line in try_to_wake_up().
> > 
> >         raw_spin_lock_irqsave(&p->pi_lock, flags);
> 
> yeah, printk() can't handle these types of recursion. it can prevent
> printk() calls issued from within the logbuf_lock spinlock section,
> with some limitations:
> 
> 	if (unlikely(logbuf_cpu == smp_processor_id())) {
> 		recursion_bug = true;
> 		return;
> 	}
> 
> 	raw_spin_lock(&logbuf_lock);
> 	logbuf_cpu = this_cpu;
> 		...
> 	logbuf_cpu = UINT_MAX;
> 	raw_spin_unlock(&logbuf_lock);
> 
> so should, for instance, raw_spin_unlock() generate spin_dump(), printk()
> will blow up (both sync and async), because logbuf_cpu is already reset.

I see.

> it may look that async printk added another source of recursion - wake_up().
> but, apparently, this is not exactly correct. because there is already a
> wake_up() call in console_unlock() - up().
> 
> 	printk()
> 	 if (logbuf_cpu == smp_processor_id())
> 		return;
> 
>          raw_spin_lock(&logbuf_lock);
> 	 logbuf_cpu = this_cpu;
> 	 ...
> 	 logbuf_cpu = UINT_MAX;
>          raw_spin_unlock(&logbuf_lock);
> 
> 	 console_trylock()
> 	   raw_spin_lock_irqsave(&sem->lock)      << ***
> 	   raw_spin_unlock_irqsave(&sem->lock)    << ***
> 
> 	 console_unlock()
>           up()
> 	   raw_spin_lock_irqsave(&sem->lock)  << ***
> 	    __up()
> 	     wake_up_process()
> 	      try_to_wake_up()  << *** in may places
> 
> 
> *** a printk() call from here will kill the system. either it will
> recurse printk(), or spin forever in 'nested' printk() on one of
> the already taken spin locks.

So, in case you are asked for similar issues (system hang), we should
first doubt on recursive prints from somewhere :)

:)

> I had an idea of waking up a printk_kthread under logbuf_lock,
> so `logbuf_cpu == smp_processor_id()' test would help here. But
> it turned out to introduce a regression in printk() behaviour.
> apart from that, it didn't fix any of the existing recursion
> printks.
> 
> there is printk_deferred() printk that is supposed to be used for
> printing under scheduler locks, but it won't help in all of the cases.
> 
> printk() has many issues.

Yeah, that's why we are all here :)

> right. adding only (num_online_cpus() > 1) check to can_printk_async()
> *in theory* can break some cases. for example, SMP system, with only
> one online CPU, active rt_sched throttling (not necessarily because of
> printk kthread, any other task will do), and some of interrupts services
> by CPU0 keep calling printk(), so deferred printk IRQ will stay busy:

Right.

> 	echo 0 > /sys/..../cpu{1..NR_CPUS}/online  # only CPU0 is active
> 
> 	CPU0
> 	sched()
> 	 printk_deferred()
> 				IRQ
> 				wake_up_klogd_work_func()
> 					console_trylock()
> 						console_unlock()
> 
> 								IRQ
> 								printk()
> 
> 								IRQ
> 								printk()
> 								....
> 								IRQ
> 								printk()
> 								...
> 
> 						  console_sem_up()
> 						  return
> 
> with async printk here we can offload printing from IRQ.
> 
> the warning that you see is WARN_ON(timekeeping_suspended), so we have
> timekeeping_suspended

Right.

> checking for irqs_disabled() is a _bit_ non-intuitive,
> I think, but in the existing scheme of things can work (at least tick_suspend()
> comment suggests so). correct me if I'm wrong.
> 
> 
> so... I think we can switch to sync printk mode in suspend_console() and
> enable async printk from resume_console(). IOW, suspend/kexec are now
> executed under sync printk mode.
> 
> we already call console_unlock() during suspend, which is synchronous,
> many times (e.g. console_cpu_notify()).
> 
> 
> something like below, perhaps. will this work for you?

Maybe not, as this can still lead to the original bug we were all
chasing. This may hog some other CPU if we are doing excessive
printing in suspend :(

suspend_console() is called quite early, so for example in my case we
do lots of printing during suspend (not from the suspend thread, but
an IRQ handled by the USB subsystem, which removes a bus with help of
some other thread probably).

That is why my Hacky patch tried to do it after devices are removed
and irqs are disabled, but before syscore users are suspended (and
timekeeping is one of them). And so it fixes it for me completely.

IOW, we should switch back to synchronous printing after disabling
interrupts on the last running CPU.

And I of course agree with Rafael that we would need something similar
in Hibernation code path as well, if we choose to fix it my way.

-- 
viresh
