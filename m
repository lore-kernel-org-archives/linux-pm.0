From: Patrick Bellasi <patrick.bellasi@arm.com>
Subject: Re: [PATCH v3 01/14] sched/core: uclamp: extend sched_setattr to
 support utilization clamping
Date: Thu, 9 Aug 2018 10:14:27 +0100
Message-ID: <20180809091427.4p2c4fbxocpkjaby@darkstar>
References: <20180806163946.28380-1-patrick.bellasi@arm.com>
 <20180806163946.28380-2-patrick.bellasi@arm.com>
 <20180807123550.GA3062@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180807123550.GA3062@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Juri Lelli <juri.lelli@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Tejun Heo <tj@kernel.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Paul Turner <pjt@google.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Todd Kjos <tkjos@google.com>, Joel Fernandes <joelaf@google.com>, Steve Muckle <smuckle@google.com>, Suren Baghdasaryan <surenb@google.com>
List-Id: linux-pm@vger.kernel.org

On 07-Aug 14:35, Juri Lelli wrote:
> On 06/08/18 17:39, Patrick Bellasi wrote:
> 
> [...]
> 
> > @@ -4218,6 +4245,13 @@ static int __sched_setscheduler(struct task_struct *p,
> >  			return retval;
> >  	}
> >  
> > +	/* Configure utilization clamps for the task */
> > +	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP) {
> > +		retval = __setscheduler_uclamp(p, attr);
> > +		if (retval)
> > +			return retval;
> > +	}
> > +
> 
> IIUC, this is available to root and non-root users. In the latter case,
> how do we cope with the fact that some user might occupy all the
> available clamping groups configured for the system?

That's a very good point, glad you noticed it.

What concern me most is that we set constraints to the cgroups
delegation model. If all clamp groups have been used it could be
not possible for a parent group to shrink resources for its subgroups.

In both cases however, in principle, I think we can live with the idea
that the "System Management Software" (SMS) can pre-allocate all the
required boost groups at boot time;  malicious tasks and dependent
groups will eventually get an -ENOSPC error.

These are the main reason why I did not posted a more "safe" solution:
this series is already big enough, a properly (pre)configured system
is still reasonably functional safe and  this feature can be added in
a second step.

However, I already have a couple of possible extensions/fixes which I
can add on top on the next respin. They are along these lines:
1) make CAP_SYS_NICE protected the clamp groups, with an optional boot
   time parameter to relax this check
2) add discretization support to clamp groups allocation

This second feature specifically, will ensure that clamp values are
always mapped into one of the available clamp groups. While the exact
clamp value can always be used for tasks placement biasing, when it
comes to frequency selection biasing, depending on concurrently
running tasks, you can end up with an effective clamp value which is a
rounded up.

Will likely add a couple of additional patches on v4 posting.
Do you have any other possible idea?

Cheers Patrick

-- 
#include <best/regards.h>

Patrick Bellasi
