From: Patrick Bellasi <patrick.bellasi@arm.com>
Subject: Re: [PATCH v4 14/16] sched/core: uclamp: request CAP_SYS_ADMIN by
 default
Date: Mon, 24 Sep 2018 18:23:51 +0100
Message-ID: <20180924172351.GV1413@e110439-lin>
References: <20180828135324.21976-15-patrick.bellasi@arm.com>
 <20180904134748.GA4974@localhost.localdomain>
 <20180906144053.GD25636@e110439-lin>
 <20180914111003.GC24082@hirez.programming.kicks-ass.net>
 <20180914140732.GR1413@e110439-lin>
 <20180914142813.GM24124@hirez.programming.kicks-ass.net>
 <20180917122723.GS1413@e110439-lin>
 <20180921091308.GD24082@hirez.programming.kicks-ass.net>
 <20180924151400.GT1413@e110439-lin>
 <20180924155616.GA7060@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180924155616.GA7060@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Tejun Heo <tj@kernel.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Paul Turner <pjt@google.com>, Quentin Perret <quentin.perret@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Todd Kjos <tkjos@google.com>, Joel Fernandes <joelaf@google.com>, Steve Muckle <smuckle@google.com>, Suren Baghdasaryan <surenb@google.com>
List-Id: linux-pm@vger.kernel.org

On 24-Sep 17:56, Peter Zijlstra wrote:
> On Mon, Sep 24, 2018 at 04:14:00PM +0100, Patrick Bellasi wrote:
> > On 21-Sep 11:13, Peter Zijlstra wrote:
> > > Laptops with active cooling however...
> > 
> > How do you see active cooling playing a role ?
> > 
> > Are you thinking, for example, at reduced fan noise if we remain below
> > a certain OPP ?
> > 
> > Are you factoring fans power consumptions into the overall P consumption ?
> 
> Nothing as fancy as that; I just figured that with a larger cooling
> capacity, you can push chips higher onto that curve past the optimal
> IPC/Watt point. Make it go fast etc..

That very concept of "optimal IPC/Watt" point is not something easy to
define considering a monotonic function and without considering the
specific optimization goals.

It really sounds like saying that an LP problem has a unique solution
independently from the optimization function.

Do you think we should "mandate" an optimization function from kernel
space? I'm not saying it does not make sense, but I find it at least a
strong implementation enforcement.

-- 
#include <best/regards.h>

Patrick Bellasi
