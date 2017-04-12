From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC v3 0/5] Add capacity capping support to the CPU controller
Date: Wed, 12 Apr 2017 14:10:09 +0200
Message-ID: <20170412121009.GD3093@worktop>
References: <1488292722-19410-1-git-send-email-patrick.bellasi@arm.com>
 <20170320145131.GA3623@htj.duckdns.org>
 <20170320172233.GA28391@e110439-lin>
 <20170410073622.2y6tnpcd2ssuoztz@hirez.programming.kicks-ass.net>
 <20170411175833.GI29455@e110439-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:52156 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751780AbdDLMNQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 12 Apr 2017 08:13:16 -0400
Content-Disposition: inline
In-Reply-To: <20170411175833.GI29455@e110439-lin>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Paul Turner <pjt@google.com>, Vincent Guittot <vincent.guittot@linaro.org>, John Stultz <john.stultz@linaro.org>, Todd Kjos <tkjos@android.com>, Tim Murray <timmurray@google.com>, Andres Oportus <andresoportus@google.com>, Joel Fernandes <joelaf@google.com>, Juri Lelli <juri.lelli@arm.com>, Chris Redpath <chris.redpath@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>

Let me reply in parts as I read this.. easy things first :-)

On Tue, Apr 11, 2017 at 06:58:33PM +0100, Patrick Bellasi wrote:
> On 10-Apr 09:36, Peter Zijlstra wrote:

> >  4) they have muddled semantics, because while its presented as a task
> >     property, it very much is not.
> 
> Actually we always presented it as a task group property, while other
> people suggested it should be a per-task API.
> 
> Still, IMO it could make sense also as a per-task API, for example
> considering a specific RT task which we know in our system is
> perfectly fine to always run it below a certain OPP.
> 
> Do you think it should be a per-task API?
> Should we focus (at least initially) on providing a per task-group API?

Even for the cgroup interface, I think they should set a per-task
property, not a group property.

> >  3) they have absolutely unacceptable overhead in implementation. Two
> >     more RB tree operations per enqueue/dequeue is just not going to
> >     happen.
> 
> This last point is about "implementation details", I'm pretty
> confident that if we find an agreement on the previous point than
> this last will be simple to solve.
> 
> Just to be clear, the rb-trees are per CPU and used to track just the
> RUNNABLE tasks on each CPUs and, as I described in the previous
> example, for the OPP biasing to work I think we really need an
> aggregation mechanism.

I know its runnable, which is exactly what the regular RB tree in fair
already tracks. That gets us 3 RB tree operations per scheduling
operation, which is entirely ridiculous.

And while I disagree with the need to track this at all, see below, it
can be done _much_ cheaper using a double augmented RB-tree, where you
keep the min/max as heaps inside the regular RB-tree.

> Ideally, every time a task is enqueue/dequeued from a CPU we want to
> know what is the currently required capacity clamping. This requires
> to maintain an ordered list of values and rb-trees are the most effective
> solution.
> 
> Perhaps, if we accept a certain level of approximation, we can
> potentially reduce the set of tracked values to a finite set (maybe
> corresponding to the EM capacity values) and use just a per-cpu
> ref-counting array.
> Still the min/max aggregation will have a worst case O(N) search
> complexity, where N is the number of finite values we want to use.

So the bigger point is that if the min/max is a per-task property (even
if set through a cgroup interface), the min(max) / max(min) thing is
wrong.

If the min/max were to apply to each individual task's util, you'd end
up with something like: Dom(\Sum util) = [min(1, \Sum min), min(1, \Sum max)].

Where a possible approximation is scaling the aggregate util into that
domain.
