From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v7 02/14] sched/cpufreq: Prepare schedutil for Energy Aware Scheduling
Date: Fri, 28 Sep 2018 10:23:42 +0200
Message-ID: <2417577.QmA9JEQx1z@aspire.rjw.lan>
References: <20180912091309.7551-1-quentin.perret@arm.com> <CAJZ5v0gL+NurA8UcN5oweqwxfgS10HgO1Zjh_cod4_Sr5nWQHQ@mail.gmail.com> <20180927121749.urdqtayq6ll4k7qn@queper01-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180927121749.urdqtayq6ll4k7qn@queper01-lin>
Sender: linux-kernel-owner@vger.kernel.org
To: Quentin Perret <quentin.perret@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ingo Molnar <mingo@redhat.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Chris Redpath <chris.redpath@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Valentin Schneider <valentin.schneider@arm.com>, Vincent Guittot <vincent.guittot@linaro.org>, Thara Gopinath <thara.gopinath@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, Todd Kjos <tkjos@google.com>, Joel Fernandes <joel@joelfernandes.org>, Steve Muckle <smuckle@google.com>, adharmap@codeaurora.org, Saravana Kannan <skann>
List-Id: linux-pm@vger.kernel.org

On Thursday, September 27, 2018 2:17:49 PM CEST Quentin Perret wrote:
> Hi Rafael,
> 
> Very sorry for the late reply ...
> 
> On Tuesday 18 Sep 2018 at 23:33:22 (+0200), Rafael J. Wysocki wrote:
> [...]
> > The new "type" argument should be documented.
> > 
> > Also IMO using the special enum for it is quite confusing, because you
> > ever only check one value from it directly.  What would be wrong with
> > using a plain "bool" instead?
> 
> So, this part of the code was originally proposed by Peter. I basically
> took it from the following message (hence the Suggested-by) which was
> fine by me:
> 
> https://lore.kernel.org/lkml/20180709120138.GQ2494@hirez.programming.kicks-ass.net/
> 
> Also, one of the things that has been mentioned during reviews was that
> other clients (such as cpuidle, IIRC) could potentially be interested
> in a 'global' cpu util value. And since those clients might have
> different needs than EAS or sugov, they might need a new entry in the
> enum.
> 
> So that's probably the main argument for the enum, it is easy to extend.

OK, so please document the enum type.

> [...]
> > > +static unsigned long sugov_get_util(struct sugov_cpu *sg_cpu)
> > > +{
> > > +       struct rq *rq = cpu_rq(sg_cpu->cpu);
> > > +       unsigned long util = cpu_util_cfs(rq);
> > > +
> > > +       sg_cpu->max = arch_scale_cpu_capacity(NULL, sg_cpu->cpu);
> > > +       sg_cpu->bw_dl = cpu_bw_dl(rq);
> > > +
> > > +       return schedutil_freq_util(sg_cpu->cpu, util, FREQUENCY_UTIL);
> > 
> > If you add a "max" argument to schedutil_freq_util(), you can avoid
> > the second (and arguably redundant) evaluation of
> > arch_scale_cpu_capacity() in there.
> 
> OK
> 
> [...]
> > > +enum schedutil_type {
> > > +       FREQUENCY_UTIL,
> > > +       ENERGY_UTIL,
> > > +};
> > 
> > As I said above, I would just use "bool" instead of this new enum (it
> > has two values too) or the new type needs to be documented.
> 
> As I said above, the enum has the good side of being easier to extend.
> So, if we care about that, I guess I'd rather add a doc for the new
> type.

Right, so please add a kerneldoc description here.

> > > +
> > >  #ifdef CONFIG_CPU_FREQ_GOV_SCHEDUTIL
> > > +unsigned long schedutil_freq_util(int cpu, unsigned long util_cfs,
> > > +                                 enum schedutil_type type);
> > > +
> > >  static inline unsigned long cpu_bw_dl(struct rq *rq)
> > >  {
> > >         return (rq->dl.running_bw * SCHED_CAPACITY_SCALE) >> BW_SHIFT;
> > > @@ -2199,6 +2207,12 @@ static inline unsigned long cpu_util_rt(struct rq *rq)
> > >  {
> > >         return READ_ONCE(rq->avg_rt.util_avg);
> > >  }
> > > +#else /* CONFIG_CPU_FREQ_GOV_SCHEDUTIL */
> > > +static inline unsigned long schedutil_freq_util(int cpu, unsigned long util,
> > > +                                 enum schedutil_type type)
> > > +{
> > > +       return util;
> > > +}
> > >  #endif
> > 
> > And I would add a wrapper around schedutil_freq_util(), called say
> > schedutil_energy_util(), that would pass a specific value as the
> > "type".
> 
> OK, that's fine by me.
> 
> Other than that, do you think these changes could be done later ? Or do
> you see that as mandatory before the patches can be picked up ?

Documenting things properly is absolutely required.

The other changes suggested by me are rather straightforward, so why would it
be a problem to make them right away if you agree to make them?

Thanks,
Rafael
