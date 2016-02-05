From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 3/3 v3] cpufreq: governor: Replace timers with utilization
 update callbacks
Date: Fri, 5 Feb 2016 14:36:54 +0100
Message-ID: <CAJZ5v0im=K5zVQMgOTKDUnXUTZ-ursAOQ+cu_YYAZisUbvx++g@mail.gmail.com>
References: <3071836.JbNxX8hU6x@vostro.rjw.lan>
	<4043287.vvCjrxyEmh@vostro.rjw.lan>
	<2546395.Be1INkvQBN@vostro.rjw.lan>
	<1486401.1RcnnVKZNP@vostro.rjw.lan>
	<20160205065037.GD21792@vireshk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f194.google.com ([209.85.217.194]:35981 "EHLO
	mail-lb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753128AbcBENg4 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 5 Feb 2016 08:36:56 -0500
In-Reply-To: <20160205065037.GD21792@vireshk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Juri Lelli <juri.lelli@arm.com>, Steve Muckle <steve.muckle@linaro.org>, Thomas Gleixner <tglx@linutronix.de>

On Fri, Feb 5, 2016 at 7:50 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> Will suck some more blood, sorry about that :)
>
> On 05-02-16, 02:28, Rafael J. Wysocki wrote:
>> The v3 addresses some review comments from Viresh and a couple of issues found
>> by me.  Changes from the previous version:
>> - Synchronize gov_cancel_work() with the (new) irq_work properly.
>> - Add a comment about the (new) memory barrier.
>> - Move samle_delay_ns to "shared" (struct cpu_common_dbs_info) so it is the
>
> sample_delay_ns was already there, you moved last_sample_time instead :)
>
>> @@ -139,7 +141,11 @@ struct cpu_common_dbs_info {
>>       struct mutex timer_mutex;
>>
>>       ktime_t time_stamp;
>> +     u64 last_sample_time;
>> +     s64 sample_delay_ns;
>>       atomic_t skip_work;
>> +     struct irq_work irq_work;
>
> Just for my understanding, why can't we schedule a normal work directly? Is it
> because of scheduler's hotpath and queue_work() is slow?

No, that's not the reason.

That path can't call wake_up_process() as it may be holding the locks
this would have attempted to grab.

That said it is hot too.  For example, ktime_get() may be too slow to
be called from it on some systems.

>> Index: linux-pm/drivers/cpufreq/cpufreq_governor.c
>> +void gov_set_update_util(struct cpu_common_dbs_info *shared,
>> +                      unsigned int delay_us)
>>  {
>> +     struct cpufreq_policy *policy = shared->policy;
>>       struct dbs_data *dbs_data = policy->governor_data;
>> -     struct cpu_dbs_info *cdbs;
>>       int cpu;
>>
>> +     shared->sample_delay_ns = delay_us * NSEC_PER_USEC;
>> +     shared->time_stamp = ktime_get();
>> +     shared->last_sample_time = 0;
>
> Calling this routine from update_sampling_rate() is still wrong. Because that
> will also make last_sample_time = 0, which means that we will schedule the
> irq-work on the next util update.

That isn't a problem, though.

This is the case when the new rate is smaller than the old one and we
want it to take effect immediately.  Taking the next sample
immediately in that case is not going to hurt anyone.

And this observation actually leads to some interesting realization
about update_sampling_rate() (see below).

> We surely didn't wanted that to happen, isn't it ?

No, it isn't. :-)

>
>>       for_each_cpu(cpu, policy->cpus) {
>> -             cdbs = dbs_data->cdata->get_cpu_cdbs(cpu);
>> -             cdbs->timer.expires = jiffies + delay;
>> -             add_timer_on(&cdbs->timer, cpu);
>> +             struct cpu_dbs_info *cdbs = dbs_data->cdata->get_cpu_cdbs(cpu);
>> +
>> +             cpufreq_set_update_util_data(cpu, &cdbs->update_util);
>>       }
>>  }
>> -EXPORT_SYMBOL_GPL(gov_add_timers);
>> +EXPORT_SYMBOL_GPL(gov_set_update_util);
>
>>  void gov_cancel_work(struct cpu_common_dbs_info *shared)
>>  {
>> -     /* Tell dbs_timer_handler() to skip queuing up work items. */
>> +     /* Tell dbs_update_util_handler() to skip queuing up work items. */
>>       atomic_inc(&shared->skip_work);
>>       /*
>> -      * If dbs_timer_handler() is already running, it may not notice the
>> -      * incremented skip_work, so wait for it to complete to prevent its work
>> -      * item from being queued up after the cancel_work_sync() below.
>> -      */
>> -     gov_cancel_timers(shared->policy);
>> -     /*
>> -      * In case dbs_timer_handler() managed to run and spawn a work item
>> -      * before the timers have been canceled, wait for that work item to
>> -      * complete and then cancel all of the timers set up by it.  If
>> -      * dbs_timer_handler() runs again at that point, it will see the
>> -      * positive value of skip_work and won't spawn any more work items.
>> +      * If dbs_update_util_handler() is already running, it may not notice
>> +      * the incremented skip_work, so wait for it to complete to prevent its
>> +      * work item from being queued up after the cancel_work_sync() below.
>>        */
>> +     gov_clear_update_util(shared->policy);
>> +     wait_for_completion(&shared->irq_work_done);
>
> I may be wrong, but isn't running irq_work_sync() enough here instead ?

Yes, it is.

I assumed that it would only check if the irq_work is running at the
moment for some reason, but that's not the case.

>>       cancel_work_sync(&shared->work);
>> -     gov_cancel_timers(shared->policy);
>>       atomic_set(&shared->skip_work, 0);
>>  }
>>  EXPORT_SYMBOL_GPL(gov_cancel_work);
>
>> Index: linux-pm/drivers/cpufreq/cpufreq_ondemand.c
>> @@ -264,7 +260,7 @@ static void update_sampling_rate(struct
>>               struct od_cpu_dbs_info_s *dbs_info;
>>               struct cpu_dbs_info *cdbs;
>>               struct cpu_common_dbs_info *shared;
>> -             unsigned long next_sampling, appointed_at;
>> +             ktime_t next_sampling, appointed_at;
>>
>>               dbs_info = &per_cpu(od_cpu_dbs_info, cpu);
>>               cdbs = &dbs_info->cdbs;
>> @@ -292,16 +288,19 @@ static void update_sampling_rate(struct
>>                       continue;
>>
>>               /*
>> -              * Checking this for any CPU should be fine, timers for all of
>> -              * them are scheduled together.
>> +              * Checking this for any CPU sharing the policy should be fine,
>> +              * they are all scheduled to sample at the same time.
>>                */
>> -             next_sampling = jiffies + usecs_to_jiffies(new_rate);
>> -             appointed_at = dbs_info->cdbs.timer.expires;
>> +             next_sampling = ktime_add_us(ktime_get(), new_rate);
>>
>> -             if (time_before(next_sampling, appointed_at)) {
>> -                     gov_cancel_work(shared);
>> -                     gov_add_timers(policy, usecs_to_jiffies(new_rate));
>> +             mutex_lock(&shared->timer_mutex);
>> +             appointed_at = ktime_add_ns(shared->time_stamp,
>> +                                         shared->sample_delay_ns);
>> +             mutex_unlock(&shared->timer_mutex);
>>
>> +             if (ktime_before(next_sampling, appointed_at)) {
>> +                     gov_cancel_work(shared);
>> +                     gov_set_update_util(shared, new_rate);
>
> So, I don't think we need to call these heavy routines at all here. Just use the
> above timer_mutex to update time_stamp and sample_delay_ns.

Well, the concern was that sample_delay_ns might not be updated
atomically on 32-bit architectures and that might be a problem for
dbs_update_util_handler().  However, this really isn't a problem,
because dbs_update_util_handler() only decides whether or not to take
a sample *this* time.  If it sees a semi-update value of
sample_delay_ns, that value will be either too small or too big, so it
will either skip the sample unnecessarily or take it immediately and
none of these is a real problem.  It doesn't hurt to take the sample
immediately at this point (as stated earlier) and if it is skipped, it
will be taken on the next attempt when the update has been completed
(which would have happened anyway had the update been atomic).

> Over that, that particular change might turn out to be a big big bonus for us.
> Why would we be taking the od_dbs_cdata.mutex in this routine anymore ? We
> aren't removing/adding timers anymore, just update the sample_delay_ns and there
> shouldn't be any races.

That's a very good point.

The only concern is that this function walks the entire collection of
cpu_dbs_infos and that's potentially racing with anything that updates
those.

> Of course you need to use the same timer_mutex in util's
> handler as well around sample_delay_ns, I believe.

That can't take any mutexes.  It might only take a raw spinlock if
really needed.

> And that will also kill the circular dependency lockdep we have been chasing
> badly :)
>
> Or am I being over excited here ? :(

Not really.  I think you're on the right track.

Before we drop the lock from here, though, we need to audit the code
for any possible races carefully.

Anyway, I'll send an update of the $subject patch later today when I
have a chance to run it through some test.

Thanks,
Rafael
