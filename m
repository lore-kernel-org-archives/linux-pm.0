From: Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH v2 08/12] sched/core: uclamp: extend cpu's cgroup
 controller
Date: Thu, 26 Jul 2018 17:39:19 -0700
Message-ID: <20180727003919.GA22416@joelaf.mtv.corp.google.com>
References: <20180716082906.6061-1-patrick.bellasi@arm.com>
 <20180716082906.6061-9-patrick.bellasi@arm.com>
 <20180723153040.GG1934745@devbig577.frc2.facebook.com>
 <20180723172215.GG2683@e110439-lin>
 <20180724132902.GI1934745@devbig577.frc2.facebook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180724132902.GI1934745@devbig577.frc2.facebook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Patrick Bellasi <patrick.bellasi@arm.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Paul Turner <pjt@google.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <juri.lelli@redhat.com>, Todd Kjos <tkjos@google.com>, Joel Fernandes <joelaf@google.com>, Steve Muckle <smuckle@google.com>, Suren Baghdasaryan <surenb@google.com>
List-Id: linux-pm@vger.kernel.org

On Tue, Jul 24, 2018 at 06:29:02AM -0700, Tejun Heo wrote:
> Hello, Patrick.
> 
> On Mon, Jul 23, 2018 at 06:22:15PM +0100, Patrick Bellasi wrote:
> > However, the "best effort" bandwidth control we have for CFS and RT
> > can be further improved if, instead of just looking at time spent on
> > CPUs, we provide some more hints to the scheduler to know at which
> > min/max "MIPS" we want to consume the (best effort) time we have been
> > allocated on a CPU.
> > 
> > Such a simple extension is still quite useful to satisfy many use-case
> > we have, mainly on mobile systems, like the ones I've described in the
> >    "Newcomer's Short Abstract (Updated)"
> > section of the cover letter:
> >    https://lore.kernel.org/lkml/20180716082906.6061-1-patrick.bellasi@arm.com/T/#u
> 
> So, that's all completely fine but then let's please not give it a
> name which doesn't quite match what it does.  We can just call it
> e.g. cpufreq range control.

But then what name can one give it if it does more than one thing, like
task-placement and CPU frequency control?

It doesn't make sense to name it cpufreq IMHO. Its a clamp on the utilization
of the task which can be used for many purposes.

thanks,

- Joel
