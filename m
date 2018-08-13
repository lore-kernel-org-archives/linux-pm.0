From: Juri Lelli <juri.lelli@redhat.com>
Subject: Re: [PATCH v3 01/14] sched/core: uclamp: extend sched_setattr to
 support utilization clamping
Date: Mon, 13 Aug 2018 14:27:14 +0200
Message-ID: <20180813122714.GC9851@localhost.localdomain>
References: <20180806163946.28380-1-patrick.bellasi@arm.com>
 <20180806163946.28380-2-patrick.bellasi@arm.com>
 <20180807095905.GB2288@localhost.localdomain>
 <20180813121441.GC2605@e110439-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180813121441.GC2605@e110439-lin>
Sender: linux-kernel-owner@vger.kernel.org
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Tejun Heo <tj@kernel.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Paul Turner <pjt@google.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Todd Kjos <tkjos@google.com>, Joel Fernandes <joelaf@google.com>, Steve Muckle <smuckle@google.com>, Suren Baghdasaryan <surenb@google.com>
List-Id: linux-pm@vger.kernel.org

On 13/08/18 13:14, Patrick Bellasi wrote:
> On 07-Aug 11:59, Juri Lelli wrote:
> > Hi,
> > 
> > Minor comments below.
> > 
> > On 06/08/18 17:39, Patrick Bellasi wrote:
> > 
> > [...]
> > 
> > > + *
> > > + * Task Utilization Attributes
> > > + * ===========================
> > > + *
> > > + * A subset of sched_attr attributes allows to specify the utilization which
> > > + * should be expected by a task. These attributes allows to inform the
> >                                                        ^
> > 						     allow
> > 
> > > + * scheduler about the utilization boundaries within which is safe to schedule
> > 
> > Isn't all this more about providing hints than safety?
> 
> Yes, it's "just" hints... will rephrase to make it more clear.
> 
> > > + * the task. These utilization boundaries are valuable information to support
> > > + * scheduler decisions on both task placement and frequencies selection.
> > > + *
> > > + *  @sched_util_min	represents the minimum utilization
> > > + *  @sched_util_max	represents the maximum utilization
> > > + *
> > > + * Utilization is a value in the range [0..SCHED_CAPACITY_SCALE] which
> > > + * represents the percentage of CPU time used by a task when running at the
> > > + * maximum frequency on the highest capacity CPU of the system. Thus, for
> > > + * example, a 20% utilization task is a task running for 2ms every 10ms.
> > > + *
> > > + * A task with a min utilization value bigger then 0 is more likely to be
> > > + * scheduled on a CPU which can provide that bandwidth.
> > > + * A task with a max utilization value smaller then 1024 is more likely to be
> > > + * scheduled on a CPU which do not provide more then the required bandwidth.
> > 
> > Isn't s/bandwidth/capacity/ here, above, and in general where you use
> > the term "bandwidth" more appropriate? I wonder if overloading this term
> > (w.r.t. how is used with DEADLINE) might create confusion. In this case
> > we are not providing any sort of guarantees, it's a hint.
> 
> Yes, you right... here we are not really granting any bandwidth but
> just "improving" the bandwidth provisioning by hinting the scheduler
> about a certain min/max capacity required.
> 
> The problem related to using capacity is that, from kernel space,
> capacity is defined as a static quantity/property of CPUs. Still, I

Looks like it's also more inline with EAS terminology (i.e., capacity
states).
