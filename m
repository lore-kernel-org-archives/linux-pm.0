From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH][experimantal] cpufreq: governor: Use an atomic variable for synchronization
Date: Tue, 08 Dec 2015 15:19:31 +0100
Message-ID: <10138182.WjU9yqx6Gs@vostro.rjw.lan>
References: <cover.1449115453.git.viresh.kumar@linaro.org> <5461074.Yz9lhOaAu0@vostro.rjw.lan> <20151208133633.GC3692@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:62922 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1756340AbbLHNtc (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 8 Dec 2015 08:49:32 -0500
In-Reply-To: <20151208133633.GC3692@ubuntu>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org, linaro-kernel@lists.linaro.org, ashwin.chaugule@linaro.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, LKML <linux-kernel@vger.kernel.org>

On Tuesday, December 08, 2015 07:06:33 PM Viresh Kumar wrote:
> On 08-12-15, 14:30, Rafael J. Wysocki wrote:
> > OK, but instead of relying on the spinlock to wait for the already running
> 
> That's the purpose of the spinlock, not a side-effect.
> 
> > dbs_timer_handler() in gov_cancel_work() (which is really easy to overlook
> > and should at least be mentioned in a comment) we can wait for it explicitly.
> 
> I agree, and I will add explicit comment about it.
> 
> > That is, if the relevant code in gov_cancel_work() is like this:
> > 
> > 
> > 	atomic_inc(&shared->skip_work);
> > 	gov_cancel_timers(shared->policy);
> > 	cancel_work_sync(&shared->work);
> > 	gov_cancel_timers(shared->policy);
> 
> Apart from it being *really* ugly (we should know exactly what should
> be done, it rather looks like hit and try),

We know what should be done.  We need to wait for the timer function to
complete, then cancel the work item spawned by it (if any) and then
cancel the timers set by that work item.

> it is still racy.
> 
> > 	atomic_set(&shared->skip_work, 0);
> > 
> > then the work item should not be leaked behind the cancel_work_sync() any more
> > AFAICS.
> 
> Suppose queue_work() isn't done within the spin lock.
> 
> CPU0                                            CPU1
> 
> cpufreq_governor_stop()                         dbs_timer_handler()
> -> gov_cancel_work()                            -> lock
>                                                 -> shared->skip_work++, as skip_work was 0. //skip_work=1
>                                                 -> unlock
>    -> lock
>    -> shared->skip_work++; //skip_work=2

(*)

>    -> unlock
>                                                 -> queue_work();
>    -> gov_cancel_timers(shared->policy);
>                                                 dbs_work_handler();
>                                                 -> queue-timers again (as we aren't checking skip_work here)

skip_work = 1 (because dbs_work_handler() decrements it).

>    -> cancel_work_sync(&shared->work);
>                                                 dbs_timer_handler()
>                                                 -> lock
>                                                 -> shared->skip_work++, as skip_work was 0.

No, it wasn't 0, it was 1, because (*) incremented it
and it has only been decremented once by dbs_work_handler().

> //skip_work=1
>                                                 -> unlock

And the below won't happen.

>                                                 ->queue_work()
>
>    -> gov_cancel_timers(shared->policy);
>    -> shared->skip_work = 0;
> 
> 
> And we have the same situation again.

I don't really think so.

Thanks,
Rafael

