From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [patch V2 08/10] timer: Implement the hierarchical pull model
Date: Wed, 19 Apr 2017 11:53:01 +0200
Message-ID: <20170419095301.itbvqq2ci2m2uxhe@hirez.programming.kicks-ass.net>
References: <20170418111102.490432548@linutronix.de>
 <20170418111401.016420305@linutronix.de>
 <20170419090914.qdiamqwzro34b53d@hirez.programming.kicks-ass.net>
 <20170419094445.oj5zc624zanv2hfp@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170419094445.oj5zc624zanv2hfp@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, John Stultz <john.stultz@linaro.org>, Eric Dumazet <edumazet@google.com>, Anna-Maria Gleixner <anna-maria@linutronix.de>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-pm@vger.kernel.org, Arjan van de Ven <arjan@infradead.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Frederic Weisbecker <fweisbec@gmail.com>, Rik van Riel <riel@redhat.com>
List-Id: linux-pm@vger.kernel.org

On Wed, Apr 19, 2017 at 11:44:45AM +0200, Peter Zijlstra wrote:
> On Wed, Apr 19, 2017 at 11:09:14AM +0200, Peter Zijlstra wrote:
> 
> > Would it be very onerous to rewrite that into regular loops? That avoids
> > us having to think (and worry) about blowing our stack.
> 
> void walk_groups(bool (*up)(void *), void (*down)(void *), void *data)
> {
> 	struct tmigr_cpu *tmc = this_cpu_ptr(&tmigr_cpu);
> 	struct group *stack[tmigr_hierarchy_levels];
> 	struct group *group = tmc->group;
> 	int i = 0;
> 
> 	raw_spin_lock(&tmc->lock);
> 
> 	do {
> 		stack[i++] = group;
> 
> 		if (up(data))
> 			break;
> 
> 	} while ((group = group->parent));
> 
> 	do {
> 		group = stack[--i];
> 
> 		down(data);
> 
> 	} while (group != tmc->group);
> 
> 	raw_spin_unlock(&tmc->lock);
> }
> 
> Something like so, iterates the hierarchy for the current CPU and calls
> @up and @down at each level in the proper order. And has obvious stack
> usage.

I should, of course, have added @group as an argument to @up,@down.
Otherwise its a bit hard for them to know what to do.
