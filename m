From: Morten Rasmussen <morten.rasmussen@arm.com>
Subject: Re: [RFC PATCH 5/6] sched/fair: Select an energy-efficient CPU on
 task wake-up
Date: Fri, 23 Mar 2018 16:00:59 +0000
Message-ID: <20180323160059.GQ4589@e105550-lin.cambridge.arm.com>
References: <20180320094312.24081-1-dietmar.eggemann@arm.com>
 <20180320094312.24081-6-dietmar.eggemann@arm.com>
 <CAJWu+oqO75h0Ue0=zqD1KTcHFF7tUKYgCHQzXx39RyyGTjiang@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJWu+oqO75h0Ue0=zqD1KTcHFF7tUKYgCHQzXx39RyyGTjiang@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joel Fernandes <joelaf@google.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>, LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Quentin Perret <quentin.perret@arm.com>, Thara Gopinath <thara.gopinath@linaro.org>, Linux PM <linux-pm@vger.kernel.org>, Chris Redpath <chris.redpath@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Valentin Schneider <valentin.schneider@arm.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Vincent Guittot <vincent.guittot@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, Todd Kjos <tkjos@google.com>
List-Id: linux-pm@vger.kernel.org

On Thu, Mar 22, 2018 at 09:27:43AM -0700, Joel Fernandes wrote:
> Hi,
> 
> On Tue, Mar 20, 2018 at 2:43 AM, Dietmar Eggemann
> <dietmar.eggemann@arm.com> wrote:
> >
> > From: Quentin Perret <quentin.perret@arm.com>
> >
> > In case an energy model is available, waking tasks are re-routed into a
> > new energy-aware placement algorithm. The eligible CPUs to be used in the
> > energy-aware wakeup path are restricted to the highest non-overutilized
> > sched_domain containing prev_cpu and this_cpu. If no such domain is found,
> > the tasks go through the usual wake-up path, hence energy-aware placement
> > happens only in lightly utilized scenarios.
> >
> > The selection of the most energy-efficient CPU for a task is achieved by
> > estimating the impact on system-level active energy resulting from the
> > placement of the task on each candidate CPU. The best CPU energy-wise is
> > then selected if it saves a large enough amount of energy with respect to
> > prev_cpu.
> >
> > Although it has already shown significant benefits on some existing
> > targets, this brute force approach clearly cannot scale to platforms with
> > numerous CPUs. This patch is an attempt to do something useful as writing
> > a fast heuristic that performs reasonably well on a broad spectrum of
> > architectures isn't an easy task. As a consequence, the scope of usability
> > of the energy-aware wake-up path is restricted to systems with the
> > SD_ASYM_CPUCAPACITY flag set. These systems not only show the most
> > promising opportunities for saving energy but also typically feature a
> > limited number of logical CPUs.
> >
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Signed-off-by: Quentin Perret <quentin.perret@arm.com>
> > Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> > ---
> >  kernel/sched/fair.c | 74 ++++++++++++++++++++++++++++++++++++++++++++++++++---
> >  1 file changed, 71 insertions(+), 3 deletions(-)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 76bd46502486..65a1bead0773 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -6513,6 +6513,60 @@ static unsigned long compute_energy(struct task_struct *p, int dst_cpu)
> >         return energy;
> >  }
> >
> > +static bool task_fits(struct task_struct *p, int cpu)
> > +{
> > +       unsigned long next_util = cpu_util_next(cpu, p, cpu);
> > +
> > +       return util_fits_capacity(next_util, capacity_orig_of(cpu));
> > +}
> > +
> > +static int find_energy_efficient_cpu(struct sched_domain *sd,
> > +                                       struct task_struct *p, int prev_cpu)
> > +{
> > +       unsigned long cur_energy, prev_energy, best_energy;
> > +       int cpu, best_cpu = prev_cpu;
> > +
> > +       if (!task_util(p))
> > +               return prev_cpu;
> > +
> > +       /* Compute the energy impact of leaving the task on prev_cpu. */
> > +       prev_energy = best_energy = compute_energy(p, prev_cpu);
> 
> Is it possible that before the wakeup, the task's affinity is changed
> so that p->cpus_allowed no longer contains prev_cpu ? In that case
> prev_energy wouldn't matter since previous CPU is no longer an option?

It is possible to wake-up with a disallowed prev_cpu. In fact
select_idle_sibling() may happily return a disallowed cpu in that case.
The mistake gets fixed in select_task_rq() which uses
select_fallback_rq() to find an allowed cpu instead.

Could we fix the issue in find_energy_efficient_cpu() by a simple test
like below

if (cpumask_test_cpu(prev_cpu, &p->cpus_allowed))
	prev_energy = best_energy = compute_energy(p, prev_cpu);
else
	prev_energy = best_energy = ULONG_MAX;
