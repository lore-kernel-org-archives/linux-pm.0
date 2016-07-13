From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [Query] Preemption (hogging) of the work handler
Date: Tue, 12 Jul 2016 17:18:08 -0700
Message-ID: <20160713001808.GT4695@ubuntu>
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
Received: from mail-pf0-f178.google.com ([209.85.192.178]:34018 "EHLO
	mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750829AbcGMASN (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 12 Jul 2016 20:18:13 -0400
Received: by mail-pf0-f178.google.com with SMTP id h14so12049850pfe.1
        for <linux-pm@vger.kernel.org>; Tue, 12 Jul 2016 17:18:13 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20160712231903.GR4695@ubuntu>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jan Kara <jack@suse.cz>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, rjw@rjwysocki.net
Cc: Tejun Heo <tj@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, vlevenetz@mm-sol.com, vaibhav.hiremath@linaro.org, alex.elder@linaro.org, johan@kernel.org, akpm@linux-foundation.org, rostedt@goodmis.org, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, linux-pm@vger.kernel.org

On 12-07-16, 16:19, Viresh Kumar wrote:
> Okay, we have tracked this BUG and its really interesting.
> 
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
> 
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

Actually, any printk done from wake_up_process() will hit this, even
if all the others CPUs are up as well :)

Its only BUG_ON() which has special handling in printk, and so we
print that safely.

-- 
viresh
