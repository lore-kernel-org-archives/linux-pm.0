From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2 5/6] cpufreq: governor: replace per-cpu delayed work
 with timers
Date: Tue, 8 Dec 2015 12:26:22 +0530
Message-ID: <20151208065622.GZ3294@ubuntu>
References: <cover.1449115453.git.viresh.kumar@linaro.org>
 <1517154.7rUJCu3tN2@vostro.rjw.lan>
 <20151207075027.GC3294@ubuntu>
 <3999637.u4UiK7zxOR@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <3999637.u4UiK7zxOR@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, ashwin.chaugule@linaro.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 07-12-15, 23:43, Rafael J. Wysocki wrote:
> On Monday, December 07, 2015 01:20:27 PM Viresh Kumar wrote:

> > At this point we might end up decrementing skip_work from
> > gov_cancel_work() and then cancel the work which we haven't queued
> > yet. And the end result will be that the work is still queued while
> > gov_cancel_work() has finished.
> 
> I'm not quite sure how that can happen.

I will describe that towards the end of this email.

> There is a bug in this code snippet, but it may cause us to fail to queue
> the work at all, so the incrementation and the check need to be done
> under the spinlock.

What bug ?

> > And we have to keep the atomic operation, as well as queue_work()
> > within the lock.
> 
> Putting queue_work() under the lock doesn't prevent any races from happening,

Then I am not able to think about it properly, but I will at least
present my case here :)

> because only one of the CPUs can execute that part of the function anyway.
> 
> > > 		queue_work(system_wq, &shared->work);
> > > 
> > > and the remaining incrementation and decrementation of skip_work are replaced
> > > with the corresponding atomic operations, it still should work, no?
> 
> Well, no, the above wouldn't work.
> 
> But what about something like this instead:
> 
> 	if (atomic_inc_return(&shared->skip_work) > 1)
> 		atomic_dec(&shared->skip_work);
> 	else
> 		queue_work(system_wq, &shared->work);
> 
> (plus the changes requisite replacements in the other places)?
> 
> Only one CPU can see the result of the atomic_inc_return() as 1 and this is the
> only one that will queue up the work item, unless I'm missing anything super
> subtle.

Looks like you are talking about the race between different timer
handlers, which race against queuing the work. Sorry if you are not.
But I am not talking about that thing..

Suppose queue_work() isn't done within the spin lock.

CPU0                                            CPU1

cpufreq_governor_stop()                         dbs_timer_handler()
-> gov_cancel_work()                            -> lock
                                                -> shared->skip_work++, as skip_work was 0. //skip_work=1
                                                -> unlock
   -> lock
   -> shared->skip_work++; //skip_work=2
   -> unlock
   -> cancel_work_sync(&shared->work);
                                                -> queue_work();
   -> gov_cancel_timers(shared->policy);
   -> shared->skip_work = 0;
                                                dbs_work_handler();



And according to how I understand it, we are screwed up at this point.
And its the same old bug which I fixed recently (which we hacked up by
using gov-lock earlier).

The work handler is still active after the policy-governor is stopped.

And your latest patch looks wrong for the same reason ...

-- 
viresh
