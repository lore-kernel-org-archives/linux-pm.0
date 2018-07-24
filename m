From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2 08/12] sched/core: uclamp: extend cpu's cgroup
 controller
Date: Tue, 24 Jul 2018 06:29:02 -0700
Message-ID: <20180724132902.GI1934745@devbig577.frc2.facebook.com>
References: <20180716082906.6061-1-patrick.bellasi@arm.com>
 <20180716082906.6061-9-patrick.bellasi@arm.com>
 <20180723153040.GG1934745@devbig577.frc2.facebook.com>
 <20180723172215.GG2683@e110439-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180723172215.GG2683@e110439-lin>
Sender: linux-kernel-owner@vger.kernel.org
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Paul Turner <pjt@google.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <juri.lelli@redhat.com>, Todd Kjos <tkjos@google.com>, Joel Fernandes <joelaf@google.com>, Steve Muckle <smuckle@google.com>, Suren Baghdasaryan <surenb@google.com>
List-Id: linux-pm@vger.kernel.org

Hello, Patrick.

On Mon, Jul 23, 2018 at 06:22:15PM +0100, Patrick Bellasi wrote:
> However, the "best effort" bandwidth control we have for CFS and RT
> can be further improved if, instead of just looking at time spent on
> CPUs, we provide some more hints to the scheduler to know at which
> min/max "MIPS" we want to consume the (best effort) time we have been
> allocated on a CPU.
> 
> Such a simple extension is still quite useful to satisfy many use-case
> we have, mainly on mobile systems, like the ones I've described in the
>    "Newcomer's Short Abstract (Updated)"
> section of the cover letter:
>    https://lore.kernel.org/lkml/20180716082906.6061-1-patrick.bellasi@arm.com/T/#u

So, that's all completely fine but then let's please not give it a
name which doesn't quite match what it does.  We can just call it
e.g. cpufreq range control.

> > So, there are fundamental discrepancies between
> > description+interface vs. what it actually does.
> 
> Perhaps then I should just change the description to make it less
> generic...

I think so, along with the interface itself.

> > I really don't think that's something we can fix up later.
> 
> ... since, really, I don't think we can get to the point to extend
> later this interface to provide the strict bandwidth enforcement you
> are thinking about.

That's completley fine.  The interface just has to match what's
implemented.

...
> > and what you're describing inherently breaks the delegation model.
> 
> What I describe here is just an additional hint to the scheduler which
> enrich the above described model. Provided A and B are already
> satisfied, when a task gets a chance to run it will be executed at a
> min/max configured frequency. That's really all... there is not
> additional impact on "resources allocation".

So, if it's a cpufreq range controller.  It'd have sth like
cpu.freq.min and cpu.freq.max, where min defines the maximum minimum
cpufreq its descendants can get and max defines the maximum cpufreq
allowed in the subtree.  For an example, please refer to how
memory.min and memory.max are defined.

Thanks.

-- 
tejun
