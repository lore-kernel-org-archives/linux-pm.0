From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 3/3 v3] cpufreq: governor: Replace timers with utilization update callbacks
Date: Sat, 06 Feb 2016 00:10:54 +0100
Message-ID: <21714199.nYFAWx0Z54@vostro.rjw.lan>
References: <3071836.JbNxX8hU6x@vostro.rjw.lan> <CAJZ5v0im=K5zVQMgOTKDUnXUTZ-ursAOQ+cu_YYAZisUbvx++g@mail.gmail.com> <CAOh2x==QtJaczU4kfEckw=tdzQanRMq3JzEYpPTT=6i9k8UCQA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:56670 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751255AbcBEXJs (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 5 Feb 2016 18:09:48 -0500
In-Reply-To: <CAOh2x==QtJaczU4kfEckw=tdzQanRMq3JzEYpPTT=6i9k8UCQA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Juri Lelli <juri.lelli@arm.com>, Steve Muckle <steve.muckle@linaro.org>, Thomas Gleixner <tglx@linutronix.de>

On Friday, February 05, 2016 08:17:56 PM Viresh Kumar wrote:
> On Fri, Feb 5, 2016 at 7:06 PM, Rafael J. Wysocki <rafael@kernel.org> wrote:
> 
> >>> Index: linux-pm/drivers/cpufreq/cpufreq_ondemand.c
> >>> @@ -264,7 +260,7 @@ static void update_sampling_rate(struct
> >>>               struct od_cpu_dbs_info_s *dbs_info;
> >>>               struct cpu_dbs_info *cdbs;
> >>>               struct cpu_common_dbs_info *shared;
> >>> -             unsigned long next_sampling, appointed_at;
> >>> +             ktime_t next_sampling, appointed_at;
> >>>
> >>>               dbs_info = &per_cpu(od_cpu_dbs_info, cpu);
> >>>               cdbs = &dbs_info->cdbs;
> >>> @@ -292,16 +288,19 @@ static void update_sampling_rate(struct
> >>>                       continue;
> >>>
> >>>               /*
> >>> -              * Checking this for any CPU should be fine, timers for all of
> >>> -              * them are scheduled together.
> >>> +              * Checking this for any CPU sharing the policy should be fine,
> >>> +              * they are all scheduled to sample at the same time.
> >>>                */
> >>> -             next_sampling = jiffies + usecs_to_jiffies(new_rate);
> >>> -             appointed_at = dbs_info->cdbs.timer.expires;
> >>> +             next_sampling = ktime_add_us(ktime_get(), new_rate);
> >>>
> >>> -             if (time_before(next_sampling, appointed_at)) {
> >>> -                     gov_cancel_work(shared);
> >>> -                     gov_add_timers(policy, usecs_to_jiffies(new_rate));
> >>> +             mutex_lock(&shared->timer_mutex);
> >>> +             appointed_at = ktime_add_ns(shared->time_stamp,
> >>> +                                         shared->sample_delay_ns);
> >>> +             mutex_unlock(&shared->timer_mutex);
> >>>
> >>> +             if (ktime_before(next_sampling, appointed_at)) {
> >>> +                     gov_cancel_work(shared);
> >>> +                     gov_set_update_util(shared, new_rate);
> >>
> >> So, I don't think we need to call these heavy routines at all here. Just use the
> >> above timer_mutex to update time_stamp and sample_delay_ns.
> >
> > Well, the concern was that sample_delay_ns might not be updated
> > atomically on 32-bit architectures and that might be a problem for
> > dbs_update_util_handler().  However, this really isn't a problem,
> > because dbs_update_util_handler() only decides whether or not to take
> > a sample *this* time.  If it sees a semi-update value of
> > sample_delay_ns, that value will be either too small or too big, so it
> > will either skip the sample unnecessarily or take it immediately and
> > none of these is a real problem.  It doesn't hurt to take the sample
> > immediately at this point (as stated earlier) and if it is skipped, it
> > will be taken on the next attempt when the update has been completed
> > (which would have happened anyway had the update been atomic).
> 
> Okay, how about this then.
> 
> We do some computations here and based on them, conditionally want to
> update sample_delay_ns. Because there is no penalty now, in terms of
> removing/adding timers/wq, etc, why shouldn't we simply update the
> sample_delay_ns everytime without any checks? That would mean that the
> change of sampling rate is effective immediately, what can be better than that?

Yes, we can do that.

There is a small concern about updating in parallel with dbs_work_handler()
in which case we may overwrite the (hopefully already correct) sample_delay_ns
value that it has just written, but then it will be corrected next time we
take a sample, so it shouldn't be a big deal.

OK, I'll update the patch to do that.

> Also, we should do the same from update-sampling-rate of conservative
> governor as well.

Let's just not change the whole world in one patch, OK?

> Just kill all this complex, unwanted code and make life simple.
> 
> > The only concern is that this function walks the entire collection of
> > cpu_dbs_infos and that's potentially racing with anything that updates
> > those.
> 
> Yeah, but fixing this race shall be easier than other crazy things we are
> looking to do with kobjects :)

Yes, I agree.

> > That can't take any mutexes.  It might only take a raw spinlock if
> > really needed.
> 
> That's doable as well :)
> 
> > Before we drop the lock from here, though, we need to audit the code
> > for any possible races carefully.
> 
> I did bit of that this morning, and there weren't any serious issues as
> as far as I could see :)

The case I'm mostly concerned about is when update_sampling_rate() looks
at a CPU with a policy completely unrelated to the dbs_data it was called
for.  In that case the "shared" object may just go away from under it at
any time while it is looking at that object in theory.

The existing code has this problem AFAICS and the reason why we don't see
any breakage from it right now is because the granularity of cdata->mutex
is really coarse.

Thanks,
Rafael

