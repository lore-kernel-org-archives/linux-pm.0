From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [patch V2 08/10] timer: Implement the hierarchical pull model
Date: Wed, 19 Apr 2017 12:22:59 +0200
Message-ID: <20170419102259.lkmvpcbd3mpkoi4r@hirez.programming.kicks-ass.net>
References: <20170418111102.490432548@linutronix.de>
 <20170418111401.016420305@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:47050 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1762148AbdDSKXI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 19 Apr 2017 06:23:08 -0400
Content-Disposition: inline
In-Reply-To: <20170418111401.016420305@linutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, John Stultz <john.stultz@linaro.org>, Eric Dumazet <edumazet@google.com>, Anna-Maria Gleixner <anna-maria@linutronix.de>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-pm@vger.kernel.org, Arjan van de Ven <arjan@infradead.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Frederic Weisbecker <fweisbec@gmail.com>, Rik van Riel <riel@redhat.com>

On Tue, Apr 18, 2017 at 01:11:10PM +0200, Thomas Gleixner wrote:
> +static u64 tmigr_set_cpu_inactive(struct tmigr_group *group,
> +				  struct tmigr_group *child,
> +				  struct tmigr_event *evt,
> +				  unsigned int cpu)
> +{
> +	struct tmigr_group *parent;
> +	u64 nextevt = KTIME_MAX;
> +
> +	raw_spin_lock_nested(&group->lock, group->level);
> +
> +	DBG_BUG_ON(!group->active);
> +
> +	cpumask_clear_cpu(cpu, group->cpus);
> +	group->active--;
> +
> +	/*
> +	 * If @child is not NULL, then this is a recursive invocation to
> +	 * propagate the deactivation of @cpu. If @child has a new migrator
> +	 * set it active in @group.
> +	 */
> +	if (child && child->migrator != TMIGR_NONE) {
> +		cpumask_set_cpu(child->migrator, group->cpus);
> +		group->active++;

And I'm confused...

If we retain child->migrator as 'active', should we then not also re-set
our own bit for that child group?

> +	}
> +
> +	/* Add @evt to @group */
> +	tmigr_add_evt(group, evt);
> +
> +	/* If @cpu is not the active migrator, everything is up to date */
> +	if (group->migrator != cpu)
> +		goto done;

At this point we have already cleared @cpu's bit in our group->cpus. Is
that right?

> +	/* Update the migrator. */
> +	if (!group->active)
> +		group->migrator = TMIGR_NONE;
> +	else
> +		group->migrator = cpumask_first(group->cpus);

So here we could have changed ->migrator away from @cpu, no?

> +
> +	parent = group->parent;
> +	if (parent) {
> +		/*
> +		 * @cpu was the migrator in @group, so it is marked as
> +		 * active in its parent group(s) as well. Propagate the
> +		 * migrator change.
> +		 */

So how is that then still valid? Because this seems to hinge on the
assumption that @cpu is the migrator.

> +		evt = group->active ? NULL : &group->groupevt;
> +		nextevt = tmigr_set_cpu_inactive(parent, group, evt, cpu);



In general I'm a wee bit confused on how this works. Do we at all times
retain a migrator per group, or only one per group that has activity,
which then reduces to 1 per system when the whole system idles.

I'll stare at this a bit more, but I feel a comment explaining things
wouldn't go amiss.
