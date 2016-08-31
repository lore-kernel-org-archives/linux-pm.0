From: Juri Lelli <juri.lelli@arm.com>
Subject: Re: [PATCH v6 2/8] arm: parse cpu capacity-dmips-mhz from DT
Date: Wed, 31 Aug 2016 18:08:35 +0100
Message-ID: <20160831170835.GL9337@e106622-lin>
References: <1468932048-31635-1-git-send-email-juri.lelli@arm.com>
 <1468932048-31635-3-git-send-email-juri.lelli@arm.com>
 <CAKfTPtBy7LGCW2T4AGoqL5L_1AHtW6KxHigxFVFVc_EU4oUO0g@mail.gmail.com>
 <20160830162853.GF9337@e106622-lin>
 <CAKfTPtDAjedxh9J2rqOwafrmubN6+-wDyTRdNQh6fCAb2HS4RQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAKfTPtDAjedxh9J2rqOwafrmubN6+-wDyTRdNQh6fCAb2HS4RQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, LAK <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Mark Brown <broonie@kernel.org>
List-Id: linux-pm@vger.kernel.org

On 31/08/16 10:14, Vincent Guittot wrote:
> On 30 August 2016 at 18:28, Juri Lelli <juri.lelli@arm.com> wrote:
> > Hi Vincent,
> >
> > On 16/08/16 10:20, Vincent Guittot wrote:
> >> Hi Juri,
> >>
> >>
> >> On 19 July 2016 at 14:40, Juri Lelli <juri.lelli@arm.com> wrote:
> >
> > [...]
> >
> >> > +static int
> >> > +init_cpu_capacity_callback(struct notifier_block *nb,
> >> > +                          unsigned long val,
> >> > +                          void *data)
> >> > +{
> >> > +       struct cpufreq_policy *policy = data;
> >> > +       int cpu;
> >> > +
> >> > +       if (cap_parsing_failed || cap_parsing_done)
> >> > +               return 0;
> >> > +
> >> > +       switch (val) {
> >> > +       case CPUFREQ_NOTIFY:
> >> > +               pr_debug("cpu_capacity: init cpu capacity for CPUs [%*pbl] (to_visit=%*pbl)\n",
> >> > +                               cpumask_pr_args(policy->related_cpus),
> >> > +                               cpumask_pr_args(cpus_to_visit));
> >> > +               cpumask_andnot(cpus_to_visit,
> >> > +                              cpus_to_visit,
> >> > +                              policy->related_cpus);
> >> > +               for_each_cpu(cpu, policy->related_cpus) {
> >> > +                       raw_capacity[cpu] = arch_scale_cpu_capacity(NULL, cpu) *
> >> > +                                           policy->max / 1000UL;
> >>
> >> Should it be policy->cpuinfo.max_freq instead of policy->max ?
> >>
> >
> > Right. I'll fix the arm64 bits as well.
> >
> >> > +                       capacity_scale = max(raw_capacity[cpu], capacity_scale);
> >> > +               }
> >> > +               if (cpumask_empty(cpus_to_visit)) {
> >> > +                       normalize_cpu_capacity();
> >> > +                       kfree(raw_capacity);
> >> > +                       pr_debug("cpu_capacity: parsing done\n");
> >> > +                       cap_parsing_done = true;
> >>
> >> ok so you do that once with the 1st governor that will be registered
> >> for the CPU. Can't you unregister the notifier then ?
> >>
> >
> > I tried, but the only place I could find to unregister it is from the
> > callback itself; and it is not possible to do so AFAIK. Suggestions?
> 
> yes, you're right
> Can't you queue a work to unregister your callback ?

You mean something like this? I guess I thought it would be much more
ugly. :)

If it looks OK, I'll add the same for arm64 and test it a bit more.

--->8---
 arch/arm/kernel/topology.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/arch/arm/kernel/topology.c b/arch/arm/kernel/topology.c
index cbc57c287145..672ae22e2768 100644
--- a/arch/arm/kernel/topology.c
+++ b/arch/arm/kernel/topology.c
@@ -215,7 +215,8 @@ static void normalize_cpu_capacity(void)
 
 #ifdef CONFIG_CPU_FREQ
 static cpumask_var_t cpus_to_visit;
-static bool cap_parsing_done;
+static void parsing_done_workfn(struct work_struct *work);
+static DECLARE_WORK(parsing_done_work, parsing_done_workfn);
 
 static int
 init_cpu_capacity_callback(struct notifier_block *nb,
@@ -225,7 +226,7 @@ init_cpu_capacity_callback(struct notifier_block *nb,
 	struct cpufreq_policy *policy = data;
 	int cpu;
 
-	if (cap_parsing_failed || cap_parsing_done)
+	if (cap_parsing_failed)
 		return 0;
 
 	switch (val) {
@@ -245,7 +246,7 @@ init_cpu_capacity_callback(struct notifier_block *nb,
 			normalize_cpu_capacity();
 			kfree(raw_capacity);
 			pr_debug("cpu_capacity: parsing done\n");
-			cap_parsing_done = true;
+			schedule_work(&parsing_done_work);
 		}
 	}
 	return 0;
@@ -270,6 +271,13 @@ static int __init register_cpufreq_notifier(void)
 					 CPUFREQ_POLICY_NOTIFIER);
 }
 core_initcall(register_cpufreq_notifier);
+
+static void parsing_done_workfn(struct work_struct *work)
+{
+	cpufreq_unregister_notifier(&init_cpu_capacity_notifier,
+					 CPUFREQ_POLICY_NOTIFIER);
+}
+
 #else
 static int __init free_raw_capacity(void)
 {
