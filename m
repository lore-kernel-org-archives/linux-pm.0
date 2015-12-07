From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V2 5/6] cpufreq: governor: replace per-cpu delayed work with timers
Date: Mon, 07 Dec 2015 23:43:50 +0100
Message-ID: <3999637.u4UiK7zxOR@vostro.rjw.lan>
References: <cover.1449115453.git.viresh.kumar@linaro.org> <1517154.7rUJCu3tN2@vostro.rjw.lan> <20151207075027.GC3294@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:43395 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754803AbbLGWNy (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 7 Dec 2015 17:13:54 -0500
In-Reply-To: <20151207075027.GC3294@ubuntu>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, ashwin.chaugule@linaro.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, open list <linux-kernel@vger.kernel.org>

On Monday, December 07, 2015 01:20:27 PM Viresh Kumar wrote:
> On 07-12-15, 02:28, Rafael J. Wysocki wrote:
> > What about if that happens in parallel with the decrementation in
> > dbs_work_handler()?
> > 
> > Is there anything preventing that from happening?
> 
> Hmmm, you are right. Following is required for that.
> 
> diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
> index c9e420bd0eec..d8a89e653933 100644
> --- a/drivers/cpufreq/cpufreq_governor.c
> +++ b/drivers/cpufreq/cpufreq_governor.c
> @@ -230,6 +230,7 @@ static void dbs_work_handler(struct work_struct *work)
>         struct dbs_data *dbs_data;
>         unsigned int sampling_rate, delay;
>         bool eval_load;
> +       unsigned long flags;
>  
>         policy = shared->policy;
>         dbs_data = policy->governor_data;
> @@ -257,7 +258,10 @@ static void dbs_work_handler(struct work_struct *work)
>         delay = dbs_data->cdata->gov_dbs_timer(policy, eval_load);
>         mutex_unlock(&shared->timer_mutex);
>  
> +       spin_lock_irqsave(&shared->timer_lock, flags);
>         shared->skip_work--;
> +       spin_unlock_irqrestore(&shared->timer_lock, flags);
> +
>         gov_add_timers(policy, delay);
>  }

OK, so can you please send an updated patch with the above change folded in?

> > That aside, I think you could avoid using the spinlock altogether if the
> > counter was atomic (and which would make the above irrelevant too).
> > 
> > Say, skip_work is atomic the the relevant code in dbs_timer_handler() is
> > written as
> > 
> > 	atomic_inc(&shared->skip_work);
> > 	smp_mb__after_atomic();
> > 	if (atomic_read(&shared->skip_work) > 1)
> > 		atomic_dec(&shared->skip_work);
> > 	else
> 
> At this point we might end up decrementing skip_work from
> gov_cancel_work() and then cancel the work which we haven't queued
> yet. And the end result will be that the work is still queued while
> gov_cancel_work() has finished.

I'm not quite sure how that can happen.

There is a bug in this code snippet, but it may cause us to fail to queue
the work at all, so the incrementation and the check need to be done
under the spinlock.

> And we have to keep the atomic operation, as well as queue_work()
> within the lock.

Putting queue_work() under the lock doesn't prevent any races from happening,
because only one of the CPUs can execute that part of the function anyway.

> > 		queue_work(system_wq, &shared->work);
> > 
> > and the remaining incrementation and decrementation of skip_work are replaced
> > with the corresponding atomic operations, it still should work, no?

Well, no, the above wouldn't work.

But what about something like this instead:

	if (atomic_inc_return(&shared->skip_work) > 1)
		atomic_dec(&shared->skip_work);
	else
		queue_work(system_wq, &shared->work);

(plus the changes requisite replacements in the other places)?

Only one CPU can see the result of the atomic_inc_return() as 1 and this is the
only one that will queue up the work item, unless I'm missing anything super
subtle.

Thanks,
Rafael

