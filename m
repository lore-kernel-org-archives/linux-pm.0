From: Quentin Perret <quentin.perret@arm.com>
Subject: Re: [PATCH v2 08/12] sched/core: uclamp: extend cpu's cgroup
 controller
Date: Fri, 27 Jul 2018 09:09:04 +0100
Message-ID: <20180727080827.u7tseookdhsckrec@queper01-lin>
References: <20180716082906.6061-1-patrick.bellasi@arm.com>
 <20180716082906.6061-9-patrick.bellasi@arm.com>
 <20180723153040.GG1934745@devbig577.frc2.facebook.com>
 <20180723172215.GG2683@e110439-lin>
 <20180724132902.GI1934745@devbig577.frc2.facebook.com>
 <20180727003919.GA22416@joelaf.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180727003919.GA22416@joelaf.mtv.corp.google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joel Fernandes <joel@joelfernandes.org>
Cc: Tejun Heo <tj@kernel.org>, Patrick Bellasi <patrick.bellasi@arm.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Paul Turner <pjt@google.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <juri.lelli@redhat.com>, Todd Kjos <tkjos@google.com>, Joel Fernandes <joelaf@google.com>, Steve Muckle <smuckle@google.com>, Suren Baghdasaryan <surenb@google.com>
List-Id: linux-pm@vger.kernel.org

On Thursday 26 Jul 2018 at 17:39:19 (-0700), Joel Fernandes wrote:
> On Tue, Jul 24, 2018 at 06:29:02AM -0700, Tejun Heo wrote:
> > Hello, Patrick.
> > 
> > On Mon, Jul 23, 2018 at 06:22:15PM +0100, Patrick Bellasi wrote:
> > > However, the "best effort" bandwidth control we have for CFS and RT
> > > can be further improved if, instead of just looking at time spent on
> > > CPUs, we provide some more hints to the scheduler to know at which
> > > min/max "MIPS" we want to consume the (best effort) time we have been
> > > allocated on a CPU.
> > > 
> > > Such a simple extension is still quite useful to satisfy many use-case
> > > we have, mainly on mobile systems, like the ones I've described in the
> > >    "Newcomer's Short Abstract (Updated)"
> > > section of the cover letter:
> > >    https://lore.kernel.org/lkml/20180716082906.6061-1-patrick.bellasi@arm.com/T/#u
> > 
> > So, that's all completely fine but then let's please not give it a
> > name which doesn't quite match what it does.  We can just call it
> > e.g. cpufreq range control.
> 
> But then what name can one give it if it does more than one thing, like
> task-placement and CPU frequency control?
> 
> It doesn't make sense to name it cpufreq IMHO. Its a clamp on the utilization
> of the task which can be used for many purposes.

Indeed, the scheduler could use clamped utilization values in several
places. The capacity-awareness bits (mostly useful for big.LITTLE
platforms) could already use that today I guess.

And on the longer term, depending on where the EAS patches [1] end up,
utilization clamping might actually become very useful to bias task
placement decisions. EAS basically decides where to place tasks based on
their utilization, so util_clamp would make a lot of sense there IMO.

Thanks,
Quentin

[1] https://lkml.org/lkml/2018/7/24/420
