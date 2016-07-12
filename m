From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [Query] Preemption (hogging) of the work handler
Date: Tue, 12 Jul 2016 16:19:03 -0700
Message-ID: <20160712231903.GR4695@ubuntu>
References: <20160701165959.GR12473@ubuntu>
 <20160701172232.GD28719@htj.duckdns.org>
 <20160706182842.GS2671@ubuntu>
 <20160711102603.GI12410@quack2.suse.cz>
 <20160711154438.GA528@swordfish>
 <20160711223501.GI4695@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f176.google.com ([209.85.192.176]:36279 "EHLO
	mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751616AbcGLXTH (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 12 Jul 2016 19:19:07 -0400
Received: by mail-pf0-f176.google.com with SMTP id t190so11608085pfb.3
        for <linux-pm@vger.kernel.org>; Tue, 12 Jul 2016 16:19:06 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20160711223501.GI4695@ubuntu>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jan Kara <jack@suse.cz>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, rjw@rjwysocki.net
Cc: Tejun Heo <tj@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, vlevenetz@mm-sol.com, vaibhav.hiremath@linaro.org, alex.elder@linaro.org, johan@kernel.org, akpm@linux-foundation.org, rostedt@goodmis.org, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, linux-pm@vger.kernel.org

On 11-07-16, 15:35, Viresh Kumar wrote:
> Sometimes, the platform doesn't come back after suspend. I have tried
> enabling no-console-suspend and the last line it prints is:
> 
>         Disabling non-boot CPUs
> 
> And nothing after that at all. We have to forcefully reboot the phone
> after that. Moving the prints to they synchronous way (using
> echo 1 > /sys/module/printk/parameters/synchronous), fixes that issue.
> 
> So, the asynchronous printing have a issue that only we are hitting.
> It looks like that all the CPUs are gone except CPU0 and that CPU is
> hogged by the printk thread to print stuff as well as to suspend the
> system, and something eventually gets wrong.
> 
> I am only using the 3 patches from V12 version of the series.

Okay, we have tracked this BUG and its really interesting.

I hacked the platform's serial driver to implement a putchar() routine
that simply writes to the FIFO in polling mode, that helped us in
tracing on where we are going wrong.

The problem is that we are running asynchronous printks and we call
wake_up_process() from the last running CPU which has disabled
interrupts. That takes us to: try_to_wake_up().

In our case the CPU gets deadlocked on this line in try_to_wake_up().

        raw_spin_lock_irqsave(&p->pi_lock, flags);

I will explain how:

The try_to_wake_up() function takes us through the scheduler code (RT
sched), to the hrtimer code, where we eventually call ktime_get() (for
the MONOTONIC clock used for hrtimer). And this function has this:

        WARN_ON(timekeeping_suspended);

This starts another printk while we are in the middle of
wake_up_process() and the CPU tries to take the above lock again and
gets stuck there :)

This doesn't happen everytime because we don't always call ktime_get()
and it is called only if hrtimer_active() returns false.

This happened because of a WARN_ON() but it can happen anyway. Think
about this case:

- offline all CPUs, except 0
- call any routine that prints messages after disabling interrupts,
  etc.
- If any of the function within wake_up_process() does a print, we are
  screwed.

So the thing is that we can't really call wake_up_process() in cases
where the last CPU disables interrupts. And that's why my fixup patch
(which moved to synchronous prints after suspend) really works.

@Jan and Sergey: I would expect a patch from you guys to fix this
properly :)

Maybe something more in can_print_async() routine, like:

only-one-cpu-online + irqs_disabled()

or whatever.

-- 
viresh
