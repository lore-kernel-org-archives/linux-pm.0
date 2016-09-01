From: Juri Lelli <juri.lelli@arm.com>
Subject: Re: [PATCH v6 2/8] arm: parse cpu capacity-dmips-mhz from DT
Date: Thu, 1 Sep 2016 09:50:52 +0100
Message-ID: <20160901085052.GN9337@e106622-lin>
References: <1468932048-31635-1-git-send-email-juri.lelli@arm.com>
 <1468932048-31635-3-git-send-email-juri.lelli@arm.com>
 <CAKfTPtBy7LGCW2T4AGoqL5L_1AHtW6KxHigxFVFVc_EU4oUO0g@mail.gmail.com>
 <20160830162853.GF9337@e106622-lin>
 <CAKfTPtDAjedxh9J2rqOwafrmubN6+-wDyTRdNQh6fCAb2HS4RQ@mail.gmail.com>
 <20160831170835.GL9337@e106622-lin>
 <CAKfTPtAuo+d=NspXRjZuaHHmi70Ky+gNCoVcQBa1aGxkMP+F1g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <CAKfTPtAuo+d=NspXRjZuaHHmi70Ky+gNCoVcQBa1aGxkMP+F1g@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Mark Brown <broonie@kernel.org>, Will Deacon <will.deacon@arm.com>, linux-kernel <linux-kernel@vger.kernel.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Rob Herring <robh+dt@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, LAK <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

On 01/09/16 10:22, Vincent Guittot wrote:
> On 31 August 2016 at 19:08, Juri Lelli <juri.lelli@arm.com> wrote:
> > On 31/08/16 10:14, Vincent Guittot wrote:
> >> On 30 August 2016 at 18:28, Juri Lelli <juri.lelli@arm.com> wrote:
> >> > Hi Vincent,
> >> >
> >> > On 16/08/16 10:20, Vincent Guittot wrote:
> >> >> Hi Juri,
> >> >>
> >> >>
> >> >> On 19 July 2016 at 14:40, Juri Lelli <juri.lelli@arm.com> wrote:
> >> >
> >> > [...]
> >> >
> >> >> > +static int
> >> >> > +init_cpu_capacity_callback(struct notifier_block *nb,
> >> >> > +                          unsigned long val,
> >> >> > +                          void *data)
> >> >> > +{
> >> >> > +       struct cpufreq_policy *policy = data;
> >> >> > +       int cpu;
> >> >> > +
> >> >> > +       if (cap_parsing_failed || cap_parsing_done)
> >> >> > +               return 0;
> >> >> > +
> >> >> > +       switch (val) {
> >> >> > +       case CPUFREQ_NOTIFY:
> >> >> > +               pr_debug("cpu_capacity: init cpu capacity for CPUs [%*pbl] (to_visit=%*pbl)\n",
> >> >> > +                               cpumask_pr_args(policy->related_cpus),
> >> >> > +                               cpumask_pr_args(cpus_to_visit));
> >> >> > +               cpumask_andnot(cpus_to_visit,
> >> >> > +                              cpus_to_visit,
> >> >> > +                              policy->related_cpus);
> >> >> > +               for_each_cpu(cpu, policy->related_cpus) {
> >> >> > +                       raw_capacity[cpu] = arch_scale_cpu_capacity(NULL, cpu) *
> >> >> > +                                           policy->max / 1000UL;
> >> >>
> >> >> Should it be policy->cpuinfo.max_freq instead of policy->max ?
> >> >>
> >> >
> >> > Right. I'll fix the arm64 bits as well.
> >> >
> >> >> > +                       capacity_scale = max(raw_capacity[cpu], capacity_scale);
> >> >> > +               }
> >> >> > +               if (cpumask_empty(cpus_to_visit)) {
> >> >> > +                       normalize_cpu_capacity();
> >> >> > +                       kfree(raw_capacity);
> >> >> > +                       pr_debug("cpu_capacity: parsing done\n");
> >> >> > +                       cap_parsing_done = true;
> >> >>
> >> >> ok so you do that once with the 1st governor that will be registered
> >> >> for the CPU. Can't you unregister the notifier then ?
> >> >>
> >> >
> >> > I tried, but the only place I could find to unregister it is from the
> >> > callback itself; and it is not possible to do so AFAIK. Suggestions?
> >>
> >> yes, you're right
> >> Can't you queue a work to unregister your callback ?
> >
> > You mean something like this? I guess I thought it would be much more
> > ugly. :)
> 
> Yes something like below.
> 
> >
> > If it looks OK, I'll add the same for arm64 and test it a bit more.
> >
> > --->8---
> >  arch/arm/kernel/topology.c | 14 +++++++++++---
> >  1 file changed, 11 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/arm/kernel/topology.c b/arch/arm/kernel/topology.c
> > index cbc57c287145..672ae22e2768 100644
> > --- a/arch/arm/kernel/topology.c
> > +++ b/arch/arm/kernel/topology.c
> > @@ -215,7 +215,8 @@ static void normalize_cpu_capacity(void)
> >
> >  #ifdef CONFIG_CPU_FREQ
> >  static cpumask_var_t cpus_to_visit;
> > -static bool cap_parsing_done;
> > +static void parsing_done_workfn(struct work_struct *work);
> > +static DECLARE_WORK(parsing_done_work, parsing_done_workfn);
> >
> >  static int
> >  init_cpu_capacity_callback(struct notifier_block *nb,
> > @@ -225,7 +226,7 @@ init_cpu_capacity_callback(struct notifier_block *nb,
> >         struct cpufreq_policy *policy = data;
> >         int cpu;
> >
> > -       if (cap_parsing_failed || cap_parsing_done)
> > +       if (cap_parsing_failed)
> 
> you probably need to keep cap_parsing_done to prevent spurious
> notification until the work is scheduled
> 

OK. Thanks.

Best,

- Juri
