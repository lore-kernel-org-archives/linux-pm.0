From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: [Query] Preemption (hogging) of the work handler
Date: Wed, 13 Jul 2016 14:45:07 +0900
Message-ID: <20160713054507.GA563@swordfish>
References: <20160701165959.GR12473@ubuntu>
 <20160701172232.GD28719@htj.duckdns.org>
 <20160706182842.GS2671@ubuntu>
 <20160711102603.GI12410@quack2.suse.cz>
 <20160711154438.GA528@swordfish>
 <20160711223501.GI4695@ubuntu>
 <20160712231903.GR4695@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34453 "EHLO
	mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750852AbcGMFpR (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 13 Jul 2016 01:45:17 -0400
Content-Disposition: inline
In-Reply-To: <20160712231903.GR4695@ubuntu>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Jan Kara <jack@suse.cz>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, rjw@rjwysocki.net, Tejun Heo <tj@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, vlevenetz@mm-sol.com, vaibhav.hiremath@linaro.org, alex.elder@linaro.org, johan@kernel.org, akpm@linux-foundation.org, rostedt@goodmis.org, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, linux-pm@vger.kernel.org, Petr Mladek <pmladek@suse.com>

Cc Petr Mladek.

On (07/12/16 16:19), Viresh Kumar wrote:
[..]
> Okay, we have tracked this BUG and its really interesting.

good find!

> I hacked the platform's serial driver to implement a putchar() routine
> that simply writes to the FIFO in polling mode, that helped us in
> tracing on where we are going wrong.
> 
> The problem is that we are running asynchronous printks and we call
> wake_up_process() from the last running CPU which has disabled
> interrupts. That takes us to: try_to_wake_up().
> 
> In our case the CPU gets deadlocked on this line in try_to_wake_up().
> 
>         raw_spin_lock_irqsave(&p->pi_lock, flags);

yeah, printk() can't handle these types of recursion. it can prevent
printk() calls issued from within the logbuf_lock spinlock section,
with some limitations:

	if (unlikely(logbuf_cpu == smp_processor_id())) {
		recursion_bug = true;
		return;
	}

	raw_spin_lock(&logbuf_lock);
	logbuf_cpu = this_cpu;
		...
	logbuf_cpu = UINT_MAX;
	raw_spin_unlock(&logbuf_lock);

so should, for instance, raw_spin_unlock() generate spin_dump(), printk()
will blow up (both sync and async), because logbuf_cpu is already reset.
it may look that async printk added another source of recursion - wake_up().
but, apparently, this is not exactly correct. because there is already a
wake_up() call in console_unlock() - up().

	printk()
	 if (logbuf_cpu == smp_processor_id())
		return;

         raw_spin_lock(&logbuf_lock);
	 logbuf_cpu = this_cpu;
	 ...
	 logbuf_cpu = UINT_MAX;
         raw_spin_unlock(&logbuf_lock);

	 console_trylock()
	   raw_spin_lock_irqsave(&sem->lock)      << ***
	   raw_spin_unlock_irqsave(&sem->lock)    << ***

	 console_unlock()
          up()
	   raw_spin_lock_irqsave(&sem->lock)  << ***
	    __up()
	     wake_up_process()
	      try_to_wake_up()  << *** in may places


*** a printk() call from here will kill the system. either it will
recurse printk(), or spin forever in 'nested' printk() on one of
the already taken spin locks.

I had an idea of waking up a printk_kthread under logbuf_lock,
so `logbuf_cpu == smp_processor_id()' test would help here. But
it turned out to introduce a regression in printk() behaviour.
apart from that, it didn't fix any of the existing recursion
printks.

there is printk_deferred() printk that is supposed to be used for
printing under scheduler locks, but it won't help in all of the cases.

printk() has many issues.

> I will explain how:
> 
> The try_to_wake_up() function takes us through the scheduler code (RT
> sched), to the hrtimer code, where we eventually call ktime_get() (for
> the MONOTONIC clock used for hrtimer). And this function has this:
> 
>         WARN_ON(timekeeping_suspended);
> 
> This starts another printk while we are in the middle of
> wake_up_process() and the CPU tries to take the above lock again and
> gets stuck there :)
> 
> This doesn't happen everytime because we don't always call ktime_get()
> and it is called only if hrtimer_active() returns false.
> 
> This happened because of a WARN_ON() but it can happen anyway. Think
> about this case:
> 
> - offline all CPUs, except 0
> - call any routine that prints messages after disabling interrupts,
>   etc.
> - If any of the function within wake_up_process() does a print, we are
>   screwed.
> 
> So the thing is that we can't really call wake_up_process() in cases
> where the last CPU disables interrupts. And that's why my fixup patch
> (which moved to synchronous prints after suspend) really works.
> 
> @Jan and Sergey: I would expect a patch from you guys to fix this
> properly :)
> 
> Maybe something more in can_print_async() routine, like:
> 
> only-one-cpu-online + irqs_disabled()
> 

right. adding only (num_online_cpus() > 1) check to can_printk_async()
*in theory* can break some cases. for example, SMP system, with only
one online CPU, active rt_sched throttling (not necessarily because of
printk kthread, any other task will do), and some of interrupts services
by CPU0 keep calling printk(), so deferred printk IRQ will stay busy:

	echo 0 > /sys/..../cpu{1..NR_CPUS}/online  # only CPU0 is active

	CPU0
	sched()
	 printk_deferred()
				IRQ
				wake_up_klogd_work_func()
					console_trylock()
						console_unlock()

								IRQ
								printk()

								IRQ
								printk()
								....
								IRQ
								printk()
								...

						  console_sem_up()
						  return

with async printk here we can offload printing from IRQ.

the warning that you see is WARN_ON(timekeeping_suspended), so we have
timekeeping_suspended, checking for irqs_disabled() is a _bit_ non-intuitive,
I think, but in the existing scheme of things can work (at least tick_suspend()
comment suggests so). correct me if I'm wrong.


so... I think we can switch to sync printk mode in suspend_console() and
enable async printk from resume_console(). IOW, suspend/kexec are now
executed under sync printk mode.

we already call console_unlock() during suspend, which is synchronous,
many times (e.g. console_cpu_notify()).


something like below, perhaps. will this work for you?

---
 kernel/printk/printk.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index bbb4180..786690e 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -288,6 +288,11 @@ static u32 log_buf_len = __LOG_BUF_LEN;
 
 /* Control whether printing to console must be synchronous. */
 static bool __read_mostly printk_sync = true;
+/*
+ * Force sync printk mode during suspend/kexec, regardless whether
+ * console_suspend_enabled permits console suspend.
+ */
+static bool __read_mostly force_printk_sync;
 /* Printing kthread for async printk */
 static struct task_struct *printk_kthread;
 /* When `true' printing thread has messages to print */
@@ -295,7 +300,7 @@ static bool printk_kthread_need_flush_console;
 
 static inline bool can_printk_async(void)
 {
-	return !printk_sync && printk_kthread;
+	return !printk_sync && printk_kthread && !force_printk_sync;
 }
 
 /* Return log buffer address */
@@ -2027,6 +2032,7 @@ static bool suppress_message_printing(int level) { return false; }
 
 /* Still needs to be defined for users */
 DEFINE_PER_CPU(printk_func_t, printk_func);
+static bool __read_mostly force_printk_sync;
 
 #endif /* CONFIG_PRINTK */
 
@@ -2163,6 +2169,8 @@ MODULE_PARM_DESC(console_suspend, "suspend console during suspend"
  */
 void suspend_console(void)
 {
+	force_printk_sync = true;
+
 	if (!console_suspend_enabled)
 		return;
 	printk("Suspending console(s) (use no_console_suspend to debug)\n");
@@ -2173,6 +2181,8 @@ void suspend_console(void)
 
 void resume_console(void)
 {
+	force_printk_sync = false;
+
 	if (!console_suspend_enabled)
 		return;
 	down_console_sem();
-- 
2.9.0.rc1

