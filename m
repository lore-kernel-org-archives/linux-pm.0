From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v5 03/15] sched/core: uclamp: map TASK's clamp values
 into CPU's clamp groups
Date: Wed, 7 Nov 2018 15:55:27 +0100
Message-ID: <20181107145527.GI9761@hirez.programming.kicks-ass.net>
References: <20181029183311.29175-1-patrick.bellasi@arm.com>
 <20181029183311.29175-4-patrick.bellasi@arm.com>
 <20181107133504.GQ9781@hirez.programming.kicks-ass.net>
 <20181107144809.GH14309@e110439-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181107144809.GH14309@e110439-lin>
Sender: linux-kernel-owner@vger.kernel.org
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Tejun Heo <tj@kernel.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Vincent Guittot <vincent.guittot@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, Paul Turner <pjt@google.com>, Quentin Perret <quentin.perret@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <juri.lelli@redhat.com>, Todd Kjos <tkjos@google.com>, Joel Fernandes <joelaf@google.com>, Steve Muckle <smuckle@google.com>, Suren Baghdasaryan <surenb@google.com>
List-Id: linux-pm@vger.kernel.org

On Wed, Nov 07, 2018 at 02:48:09PM +0000, Patrick Bellasi wrote:
> On 07-Nov 14:35, Peter Zijlstra wrote:
> You mean se_count overflow ?

Yah..

> > And I'm not really a fan of hiding that error in a define like you keep
> > doing.
> 
> The #define is not there to mask an overflow, it's there to catch the

+#define UCLAMP_MAPERR "clamp value [%u] mapping to clamp group failed\n"

Is what I was talking about.

> > What's wrong with something like:
> > 
> > 	if (SCHED_WARN(free_group_id == UCLAMP_GROUPS))
> > 		return;
> 
> Right, the flow should be:
> 
>   1. try to find a valid clamp group
>   2. if you don't find one, the data structures are corrupted
>      warn once for data corruption
>      do not map this scheduling entity and return
>   3. map the scheduling entity
> 
> Is that ok ?

That's what the proposed does.

> > and
> > 
> > > +	uc_map_new.se_count = uc_map_old.se_count + 1;
> > 
> > 	if (SCHED_WARN(!new.se_count))
> > 		new.se_count = -1;
> 
> Mmm... not sure we can recover from a corrupted refcount or an
> overflow.
> 
> What should we do on these cases, disable uclamp completely ?

You can teach put to never decrement -1 (aka. all 1s).

But its all SCHED_DEBUG stuff anyway, so who really cares.
