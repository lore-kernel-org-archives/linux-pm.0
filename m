From: Patrick Bellasi <patrick.bellasi@arm.com>
Subject: Re: [RFC v3 0/5] Add capacity capping support to the CPU controller
Date: Wed, 12 Apr 2017 14:24:50 +0100
Message-ID: <20170412132450.GJ29455@e110439-lin>
References: <1488292722-19410-1-git-send-email-patrick.bellasi@arm.com>
 <20170320145131.GA3623@htj.duckdns.org>
 <20170320172233.GA28391@e110439-lin>
 <20170410073622.2y6tnpcd2ssuoztz@hirez.programming.kicks-ass.net>
 <20170411175833.GI29455@e110439-lin>
 <20170412122215.GF3093@worktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170412122215.GF3093@worktop>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Paul Turner <pjt@google.com>, Vincent Guittot <vincent.guittot@linaro.org>, John Stultz <john.stultz@linaro.org>, Todd Kjos <tkjos@android.com>, Tim Murray <timmurray@google.com>, Andres Oportus <andresoportus@google.com>, Joel Fernandes <joelaf@google.com>, Juri Lelli <juri.lelli@arm.com>, Chris Redpath <chris.redpath@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>
List-Id: linux-pm@vger.kernel.org

On 12-Apr 14:22, Peter Zijlstra wrote:
> On Tue, Apr 11, 2017 at 06:58:33PM +0100, Patrick Bellasi wrote:
> > Sorry, I don't get instead what are the "confusing nesting properties"
> > you are referring to?
> 
> If a parent group sets min=.2 and max=.8, what are the constraints on
> its child groups for setting their resp min and max?

Currently the logic I'm proposing enforces this:

a) capacity_max can only be reduced
   because we accept that a child can be further constrained
   for example:
   - a resource manager allocates a max capacity to an application
   - the application itself knows that some of its child are background
     tasks and they can be further constrained

b) capacity_min can only be increased
   because we want to inhibit child affecting overall performance
   for example:
   - a resource manager allocates a minimum capacity to an application
   - the application itself cannot slow-down some of its child
     without risking to affect other (unknown) external entities

> I can't immediately gives rules that would make sense.

The second rule is more tricky, but I see it matching better an
overall decomposition schema where a single resource manager is
allocating a capacity_min to two different entities (A and B) which
are independent but (it only knows) are also cooperating.

Let's think about the Android run-time which allocate resources to a
system service (entity A) which it knows it has to interact with
a certain app (entity B).

The cooperation dependency can be resolved only by the resource
manager, by assigning capacity_min at entity level CGroups.
Thus, entities subgroups should not be allowed to further reduce
this constraint without risking to impact an (unknown for them)
external entity.

> For instance, allowing a child to lower min would violate the parent
> constraint,

Quite likely don't want this.

> while allowing a child to increase min would grant the child
> more resources than the parent.

But still within the capacity_max enforced by the parent.

We should always consider the pair (min,max), once a parent defined
this range to me it's seem ok that child can freely play within that
range.

Why should not be allowed a child group to set:

   capacity_min_child = capacity_max_parent

?


> Neither seem like a good thing.

-- 
#include <best/regards.h>

Patrick Bellasi
