From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v4 14/16] sched/core: uclamp: request CAP_SYS_ADMIN by
 default
Date: Fri, 14 Sep 2018 16:28:13 +0200
Message-ID: <20180914142813.GM24124@hirez.programming.kicks-ass.net>
References: <20180828135324.21976-1-patrick.bellasi@arm.com>
 <20180828135324.21976-15-patrick.bellasi@arm.com>
 <20180904134748.GA4974@localhost.localdomain>
 <20180906144053.GD25636@e110439-lin>
 <20180914111003.GC24082@hirez.programming.kicks-ass.net>
 <20180914140732.GR1413@e110439-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180914140732.GR1413@e110439-lin>
Sender: linux-kernel-owner@vger.kernel.org
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: Juri Lelli <juri.lelli@redhat.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Tejun Heo <tj@kernel.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Paul Turner <pjt@google.com>, Quentin Perret <quentin.perret@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Todd Kjos <tkjos@google.com>, Joel Fernandes <joelaf@google.com>, Steve Muckle <smuckle@google.com>, Suren Baghdasaryan <surenb@google.com>
List-Id: linux-pm@vger.kernel.org


Just a quick reply because I have to run..

On Fri, Sep 14, 2018 at 03:07:32PM +0100, Patrick Bellasi wrote:
> On 14-Sep 13:10, Peter Zijlstra wrote:

> > I think the problem here is that the two are conflated in the very same
> > interface.
> > 
> > Would it make sense to move the available clamp values out to some sysfs
> > interface like thing and guard that with a capability, while keeping the
> > task interface unprivilidged?
> 
> You mean something like:
> 
>    $ cat /proc/sys/kernel/sched_uclamp_min_utils
>    0 10 20 ... 100
> 
> to notify users about the set of clamp values which are available ?
> 
> > Another thing that has me 'worried' about this interface is the direct
> > tie to CPU capacity (not that I have a better suggestion). But it does
> > raise the point of how userspace is going to discover the relevant
> > values of the platform.
> 
> This point worries me too, and that's what I think is addressed in a
> sane way in:
> 
>    [PATCH v4 13/16] sched/core: uclamp: use percentage clamp values
>    https://lore.kernel.org/lkml/20180828135324.21976-14-patrick.bellasi@arm.com/
> 
> IMHO percentages are a reasonably safe and generic API to expose to
> user-space. Don't you think this should address your concern above ?

Not at all what I meant, and no, percentages don't help.

The thing is, the values you'd want to use are for example the capacity
of the little CPUs. or the capacity of the most energy efficient OPP
(the knee).

Similarly for boosting, how are we 'easily' going to find the values
that correspond to the various available OPPs.

The EAS thing might have these around; but I forgot if/how they're
exposed to userspace (I'll have to soon look at the latest posting).

But changing the clamp metric to something different than these values
is going to be pain.
