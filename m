From: Quentin Perret <quentin.perret@arm.com>
Subject: Re: [RFC PATCH 5/6] sched/fair: Select an energy-efficient CPU on
 task wake-up
Date: Sun, 25 Mar 2018 02:52:39 +0100
Message-ID: <20180325015238.GB1803@queper01-VirtualBox>
References: <20180320094312.24081-1-dietmar.eggemann@arm.com>
 <20180320094312.24081-6-dietmar.eggemann@arm.com>
 <20180321153518.GC13951@e110439-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180321153518.GC13951@e110439-lin>
Sender: linux-kernel-owner@vger.kernel.org
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>, linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Thara Gopinath <thara.gopinath@linaro.org>, linux-pm@vger.kernel.org, Morten Rasmussen <morten.rasmussen@arm.com>, Chris Redpath <chris.redpath@arm.com>, Valentin Schneider <valentin.schneider@arm.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Vincent Guittot <vincent.guittot@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, Todd Kjos <tkjos@google.com>, Joel Fernandes <joelaf@google.com>
List-Id: linux-pm@vger.kernel.org

On Wednesday 21 Mar 2018 at 15:35:18 (+0000), Patrick Bellasi wrote:
> On 20-Mar 09:43, Dietmar Eggemann wrote:
> > From: Quentin Perret <quentin.perret@arm.com>
> 
> [...]
> 
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 76bd46502486..65a1bead0773 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -6513,6 +6513,60 @@ static unsigned long compute_energy(struct task_struct *p, int dst_cpu)
> >  	return energy;
> >  }
> > 
> > +static bool task_fits(struct task_struct *p, int cpu)
> > +{
> > +	unsigned long next_util = cpu_util_next(cpu, p, cpu);
> > +
> > +	return util_fits_capacity(next_util, capacity_orig_of(cpu));
>                                              ^^^^^^^^^^^^^^^^^^^^^
> 
> Since here we are at scheduling CFS tasks, should we not better use
> capacity_of() to account for RT/IRQ pressure ?

Yes, definitely. I change this in v2.

> 
> > +}
> > +
> > +static int find_energy_efficient_cpu(struct sched_domain *sd,
> > +					struct task_struct *p, int prev_cpu)
> > +{
> > +	unsigned long cur_energy, prev_energy, best_energy;
> > +	int cpu, best_cpu = prev_cpu;
> > +
> > +	if (!task_util(p))
> 
> We are still waking up a task... what if the task was previously
> running on a big CPU which is now idle?
> 
> I understand that from a _relative_ energy_diff standpoint there is
> not much to do for a 0 utilization task. However, for those tasks we
> can still try to return the most energy efficient CPU among the ones
> in their cpus_allowed mask.
> 
> It should be a relatively low overhead (maybe contained in a fallback
> most_energy_efficient_cpu() kind of function) which allows, for
> example on ARM big.LITTLE systems, to consolidate those tasks on
> LITTLE CPUs instead for example keep running them on a big CPU.

Hmmmm so the difficult thing about a task with 0 util is that you don't
know if this is really a small task, or a big task with a very long
period. The only useful thing you know for sure about the task is where
it ran last time, so I guess that makes sense to use that information
rather than make assumptions. There is no perfect solution using the
util_avg of the task.

Now, UTIL_EST is changing the game here. If we use it for task placement
(which I think is the right thing to do), this issue should be a lot
easier to solve. What do you think ?

Thanks,
Quentin
