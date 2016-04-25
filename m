From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: governor: Fix prev_load initialization in
 cpufreq_governor_start()
Date: Mon, 25 Apr 2016 16:57:22 +0530
Message-ID: <20160425112722.GB6104@vireshk-i7>
References: <5284094.6jVZZT3rEB@vostro.rjw.lan>
 <20160425041401.GH22726@vireshk-i7>
 <CAJZ5v0hcePcs3of2-c3tqnY2mJoGex-Lp=u-=s7Y95yX0OZitA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hcePcs3of2-c3tqnY2mJoGex-Lp=u-=s7Y95yX0OZitA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Chen Yu <yu.c.chen@intel.com>
List-Id: linux-pm@vger.kernel.org

On 25-04-16, 13:24, Rafael J. Wysocki wrote:
> On Mon, Apr 25, 2016 at 6:14 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > On 25-04-16, 03:07, Rafael J. Wysocki wrote:
> >> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >>
> >> The way cpufreq_governor_start() initializes j_cdbs->prev_load is
> >> questionable.
> >>
> >> First off, j_cdbs->prev_cpu_wall used as a denominator in the
> >> computation may be zero.  The case this happens is when
> >> get_cpu_idle_time_us() returns -1 and get_cpu_idle_time_jiffy()
> >> used to return that number is called exactly at the jiffies_64
> >> wrap time.  It is rather hard to trigger that error, but it is not
> >> impossible and it will just crash the kernel then.
> >>
> >> Second, j_cdbs->prev_load is computed as the average load during
> >> the entire time since the system started and it may not reflect the
> >> load in the previous sampling period (as it is expected to).
> >> That doesn't play well with the way dbs_update() uses that value.
> >> Namely, if the update time delta (wall_time) happens do be greater
> >> than twice the sampling rate on the first invocation of it, the
> >> initial value of j_cdbs->prev_load (which may be completely off) will
> >> be returned to the caller as the current load (unless it is equal to
> >> zero and unless another CPU sharing the same policy object has a
> >> greater load value).
> >>
> >> For this reason, notice that the prev_load field of struct cpu_dbs_info
> >> is only used by dbs_update() and only in that one place, so if
> >> cpufreq_governor_start() is modified to always initialize it to 0,
> >> it will make dbs_update() always compute the actual load first time
> >> it checks the update time delta against the doubled sampling rate
> >> (after initialization) and there won't be any side effects of it.
> >>
> >> Consequently, modify cpufreq_governor_start() as described.
> >>
> >> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >> ---
> >>  drivers/cpufreq/cpufreq_governor.c |    8 ++++----
> >>  1 file changed, 4 insertions(+), 4 deletions(-)
> >>
> >> Index: linux-pm/drivers/cpufreq/cpufreq_governor.c
> >> ===================================================================
> >> --- linux-pm.orig/drivers/cpufreq/cpufreq_governor.c
> >> +++ linux-pm/drivers/cpufreq/cpufreq_governor.c
> >> @@ -508,12 +508,12 @@ static int cpufreq_governor_start(struct
> >>
> >>       for_each_cpu(j, policy->cpus) {
> >>               struct cpu_dbs_info *j_cdbs = &per_cpu(cpu_dbs, j);
> >> -             unsigned int prev_load;
> >>
> >>               j_cdbs->prev_cpu_idle = get_cpu_idle_time(j, &j_cdbs->prev_cpu_wall, io_busy);
> >> -
> >> -             prev_load = j_cdbs->prev_cpu_wall - j_cdbs->prev_cpu_idle;
> >> -             j_cdbs->prev_load = 100 * prev_load / (unsigned int)j_cdbs->prev_cpu_wall;
> >> +             /*
> >> +              * Make the first invocation of dbs_update() compute the load.
> >> +              */
> >> +             j_cdbs->prev_load = 0;
> >>
> >>               if (ignore_nice)
> >>                       j_cdbs->prev_cpu_nice = kcpustat_cpu(j).cpustat[CPUTIME_NICE];
> >
> > I tried to understand why the
> >
> > commit 18b46abd0009 ("cpufreq: governor: Be friendly towards
> > latency-sensitive bursty workloads")
> >
> > modify the START section and added this stuff and I completely failed
> > to understand it now. Do you remember why was this added at all ?
> 
> The big comment in dbs_update() explains it, but not the initialization part.
> 
> I guess the initialization tried to be smart and avoid the "almost
> zero load" effect in cases when the CPU is idle to start with, but
> that's questionable as explained in my changelog.  I guess I should
> add a "Fixes:" tag for that commit to the patch. :-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

:)

-- 
viresh
