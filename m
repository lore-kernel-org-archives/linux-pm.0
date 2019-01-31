From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: Record stats when fast switching is enabled
Date: Thu, 31 Jan 2019 15:37:53 +0530
Message-ID: <20190131100753.fjh6o3smmcjedxmz@vireshk-i7>
References: <20190131015139.126890-1-mka@chromium.org>
 <20190131083004.rkxehycu4pbbx52s@vireshk-i7>
 <CAJZ5v0hgBNY8cZgkn-u1qCCBrLxkS6T=srjMqsX50_H5V=ofHA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hgBNY8cZgkn-u1qCCBrLxkS6T=srjMqsX50_H5V=ofHA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Matthias Kaehlcke <mka@chromium.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Douglas Anderson <dianders@chromium.org>
List-Id: linux-pm@vger.kernel.org

On 31-01-19, 11:03, Rafael J. Wysocki wrote:
> On Thu, Jan 31, 2019 at 9:30 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > On 30-01-19, 17:51, Matthias Kaehlcke wrote:
> > > When fast switching is enabled currently no cpufreq stats are
> > > recorded and the corresponding sysfs attributes appear empty (see
> > > also commit 1aefc75b2449 ("cpufreq: stats: Make the stats code
> > > non-modular")).
> > >
> > > Record the stats after a successful fast switch and re-enable access
> > > through sysfs when fast switching is enabled. Since
> > > cpufreq_stats_update() can now be called in interrupt context (during
> > > a fast switch) disable local IRQs while holding the stats spinlock.
> > >
> > > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > > ---
> > > The change is so simple that I wonder if I'm missing some important
> > > reason why the stats can't/shouldn't be updated during/after a fast
> > > switch ...
> > >
> > > I would expect that holding the stats spinlock briefly in
> > > cpufreq_stats_update() shouldn't be a problem. In theory it would
> > > also be an option to have a per stats lock, though it seems overkill
> > > from my (possibly ignorant) point of view.
> > > ---
> > >  drivers/cpufreq/cpufreq.c       |  8 +++++++-
> > >  drivers/cpufreq/cpufreq_stats.c | 11 +++--------
> > >  2 files changed, 10 insertions(+), 9 deletions(-)
> > >
> > > diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> > > index e35a886e00bcf..63aadb0bbddfe 100644
> > > --- a/drivers/cpufreq/cpufreq.c
> > > +++ b/drivers/cpufreq/cpufreq.c
> > > @@ -1857,9 +1857,15 @@ EXPORT_SYMBOL(cpufreq_unregister_notifier);
> > >  unsigned int cpufreq_driver_fast_switch(struct cpufreq_policy *policy,
> > >                                       unsigned int target_freq)
> > >  {
> > > +     unsigned int freq;
> > > +
> > >       target_freq = clamp_val(target_freq, policy->min, policy->max);
> > >
> > > -     return cpufreq_driver->fast_switch(policy, target_freq);
> > > +     freq = cpufreq_driver->fast_switch(policy, target_freq);
> > > +     if (freq)
> > > +             cpufreq_stats_record_transition(policy, freq);
> > > +
> > > +     return freq;
> > >  }
> > >  EXPORT_SYMBOL_GPL(cpufreq_driver_fast_switch);
> > >
> > > diff --git a/drivers/cpufreq/cpufreq_stats.c b/drivers/cpufreq/cpufreq_stats.c
> > > index 1572129844a5b..21b919bfaeccf 100644
> > > --- a/drivers/cpufreq/cpufreq_stats.c
> > > +++ b/drivers/cpufreq/cpufreq_stats.c
> > > @@ -30,11 +30,12 @@ struct cpufreq_stats {
> > >  static void cpufreq_stats_update(struct cpufreq_stats *stats)
> > >  {
> > >       unsigned long long cur_time = get_jiffies_64();
> > > +     unsigned long flags;
> > >
> > > -     spin_lock(&cpufreq_stats_lock);
> > > +     spin_lock_irqsave(&cpufreq_stats_lock, flags);
> > >       stats->time_in_state[stats->last_index] += cur_time - stats->last_time;
> > >       stats->last_time = cur_time;
> > > -     spin_unlock(&cpufreq_stats_lock);
> > > +     spin_unlock_irqrestore(&cpufreq_stats_lock, flags);
> > >  }
> >
> > The only problem that I can think of (or recall) is that this routine
> > also gets called when time_in_state sysfs file is read and that can
> > end up taking lock which the scheduler's hotpath will wait for.
> 
> What about the extra locking overhead in the scheduler context?

What about using READ_ONCE/WRITE_ONCE here ? Not sure if we really
need locking in this particular case.

-- 
viresh
