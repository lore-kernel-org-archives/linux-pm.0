From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH][experimantal] cpufreq: governor: Use an atomic variable
 for synchronization
Date: Tue, 8 Dec 2015 19:06:33 +0530
Message-ID: <20151208133633.GC3692@ubuntu>
References: <cover.1449115453.git.viresh.kumar@linaro.org>
 <4910771.IIQSzHPqps@vostro.rjw.lan>
 <20151208065905.GA3294@ubuntu>
 <5461074.Yz9lhOaAu0@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:34530 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756334AbbLHNgg (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 8 Dec 2015 08:36:36 -0500
Received: by pacwq6 with SMTP id wq6so12268393pac.1
        for <linux-pm@vger.kernel.org>; Tue, 08 Dec 2015 05:36:36 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <5461074.Yz9lhOaAu0@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-pm@vger.kernel.org, linaro-kernel@lists.linaro.org, ashwin.chaugule@linaro.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, LKML <linux-kernel@vger.kernel.org>

On 08-12-15, 14:30, Rafael J. Wysocki wrote:
> OK, but instead of relying on the spinlock to wait for the already running

That's the purpose of the spinlock, not a side-effect.

> dbs_timer_handler() in gov_cancel_work() (which is really easy to overlook
> and should at least be mentioned in a comment) we can wait for it explicitly.

I agree, and I will add explicit comment about it.

> That is, if the relevant code in gov_cancel_work() is like this:
> 
> 
> 	atomic_inc(&shared->skip_work);
> 	gov_cancel_timers(shared->policy);
> 	cancel_work_sync(&shared->work);
> 	gov_cancel_timers(shared->policy);

Apart from it being *really* ugly (we should know exactly what should
be done, it rather looks like hit and try), it is still racy.

> 	atomic_set(&shared->skip_work, 0);
> 
> then the work item should not be leaked behind the cancel_work_sync() any more
> AFAICS.

Suppose queue_work() isn't done within the spin lock.

CPU0                                            CPU1

cpufreq_governor_stop()                         dbs_timer_handler()
-> gov_cancel_work()                            -> lock
                                                -> shared->skip_work++, as skip_work was 0. //skip_work=1
                                                -> unlock
   -> lock
   -> shared->skip_work++; //skip_work=2
   -> unlock
                                                -> queue_work();
   -> gov_cancel_timers(shared->policy);
                                                dbs_work_handler();
                                                -> queue-timers again (as we aren't checking skip_work here)
   -> cancel_work_sync(&shared->work);
                                                dbs_timer_handler()
                                                -> lock
                                                -> shared->skip_work++, as skip_work was 0. //skip_work=1
                                                -> unlock
                                                ->queue_work()
   -> gov_cancel_timers(shared->policy);
   -> shared->skip_work = 0;


And we have the same situation again. I have thought of all this
before I wrote the initial patch, and really tried the ugly double
timer-cancel thing. But the current approach is really the right thing
to do.

I will send a patch adding the comment.

-- 
viresh
