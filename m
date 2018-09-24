From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v4 14/16] sched/core: uclamp: request CAP_SYS_ADMIN by
 default
Date: Mon, 24 Sep 2018 18:26:40 +0200
Message-ID: <20180924162640.GB7060@hirez.programming.kicks-ass.net>
References: <20180828135324.21976-1-patrick.bellasi@arm.com>
 <20180828135324.21976-15-patrick.bellasi@arm.com>
 <20180904134748.GA4974@localhost.localdomain>
 <20180906144053.GD25636@e110439-lin>
 <20180914111003.GC24082@hirez.programming.kicks-ass.net>
 <20180914140732.GR1413@e110439-lin>
 <20180914142813.GM24124@hirez.programming.kicks-ass.net>
 <20180917122723.GS1413@e110439-lin>
 <20180921091308.GD24082@hirez.programming.kicks-ass.net>
 <20180924151400.GT1413@e110439-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180924151400.GT1413@e110439-lin>
Sender: linux-kernel-owner@vger.kernel.org
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: Juri Lelli <juri.lelli@redhat.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Tejun Heo <tj@kernel.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Paul Turner <pjt@google.com>, Quentin Perret <quentin.perret@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Todd Kjos <tkjos@google.com>, Joel Fernandes <joelaf@google.com>, Steve Muckle <smuckle@google.com>, Suren Baghdasaryan <surenb@google.com>
List-Id: linux-pm@vger.kernel.org

On Mon, Sep 24, 2018 at 04:14:00PM +0100, Patrick Bellasi wrote:

> ... still it's difficult to give a precise definition of knee point,
> unless you know about platforms which have a sharp change in energy
> efficiency.
> 
> The only cases we know about are those where:
> 
> A) multiple frequencies uses the same voltage, e.g.
> 
> 
>      ^                                     *
>      | Energy                              O
>      | efficiency                         O+
>      |                                   O |
>      |                                 O*  |
>      |                              O**    |
>      |   O**                    O***       |
>      |   +  O**            O****           |
>      |   |     O**   O*****                |
>      |   |        O**                      |
>      |   |          +                      |
>      |   |  Same V  |   Increasing V       |
>      +---+----------+----------------------+----------->
>          |          |                      | Frequency
>          L          M                      H
> 
> B) there is a big frequency gap between low frequency OPPs and high
>    frequency OPPs, e.g.
> 
>                                        O
>     ^                                **+
>     | Energy                       **  |
>     | efficiency                 **    |
>     |                          **      |
>     |                        **        |
>     |                      **          |
>     |                    **            |
>     |                  **              |
>     |               O**                |
>     |        O******+                  |
>     |O*******       |                  |
>     |               |                  |
>     ++--------------+------------------+------>
>      |              |                  |  Frequency
>      L              M                  H
> 
> 
> In case A, all the OPPs left of M are dominated by M in terms
> of energy efficiency and normally they should be never used.
> Unless you are under thermal constraints and you still want to keep
> your code running even if at a lower rate and energy efficiency.
> At this point, however, you already invalidated all the OPPs right of
> M and, on the remaining, you still struggle do define the knee point.
> 
> In case B... I'm wondering it such a conf even makes sense ;)
> Is there really some platform out there with such a "non homogeneously
> distributed" set of available frequencies ?

Well, the curve is a second or third order polynomial (when V~f -> fV^2
-> f^3), so it shoots up at some point. There's not really anything you
can do about that. But if you're willing to put in active cooling and
lots of energy, you can make it go fast :-)

Therefore I was thinking:

> Maybe we can define a threshold
> for a "EE derivative ratio", but it will still be quite arbitrary.

Because up until de/df=.5 we gain more performance than we loose ee. But
I might not have appreciated the fact that when we work with imaginary
cost units that skews the .5.
