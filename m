From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [patch V2 08/10] timer: Implement the hierarchical pull model
Date: Wed, 19 Apr 2017 11:09:14 +0200
Message-ID: <20170419090914.qdiamqwzro34b53d@hirez.programming.kicks-ass.net>
References: <20170418111102.490432548@linutronix.de>
 <20170418111401.016420305@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170418111401.016420305@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, John Stultz <john.stultz@linaro.org>, Eric Dumazet <edumazet@google.com>, Anna-Maria Gleixner <anna-maria@linutronix.de>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-pm@vger.kernel.org, Arjan van de Ven <arjan@infradead.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Frederic Weisbecker <fweisbec@gmail.com>, Rik van Riel <riel@redhat.com>
List-Id: linux-pm@vger.kernel.org

On Tue, Apr 18, 2017 at 01:11:10PM +0200, Thomas Gleixner wrote:
> +static void __tmigr_handle_remote(struct tmigr_group *group, unsigned int cpu,
> +				  u64 now, unsigned long jif, bool walkup)
> +{
> +	struct timerqueue_node *tmr;
> +	struct tmigr_group *parent;
> +	struct tmigr_event *evt;
> +
> +again:
> +	raw_spin_lock_irq(&group->lock);
> +	/*
> +	 * Handle the group only if @cpu is the migrator or if the group
> +	 * has no migrator. Otherwise the group is active and is handled by
> +	 * its own migrator.
> +	 */
> +	if (group->migrator != cpu && group->migrator != TMIGR_NONE) {
> +		raw_spin_unlock_irq(&group->lock);
> +		return;
> +	}
> +
> +	tmr = timerqueue_getnext(&group->events);
> +	if (tmr && now >= tmr->expires) {
> +		/*
> +		 * Remove the expired entry from the queue and handle
> +		 * it. If this is a leaf group, call the timer poll
> +		 * function for the given cpu. Otherwise handle the group
> +		 * itself.  Drop the group lock here in both cases to avoid
> +		 * lock ordering inversions.
> +		 */
> +		evt = container_of(tmr, struct tmigr_event, nextevt);
> +		tmigr_remove_evt(group, evt);
> +
> +		raw_spin_unlock_irq(&group->lock);
> +
> +		/*
> +		 * If the event is a group event walk down the hierarchy of
> +		 * that group to the CPU leafs. If not, handle the expired
> +		 * timer from the remote CPU.
> +		 */
> +		if (evt->group) {
> +			__tmigr_handle_remote(evt->group, cpu, now, jif, false);

Recursion..

> +		} else {
> +			timer_expire_remote(evt->cpu);
> +			tmigr_update_remote(evt->cpu, now, jif);
> +		}
> +		goto again;
> +	}
> +
> +	/*
> +	 * If @group is not active, queue the next event in the parent
> +	 * group. This is required, because the next event of @group
> +	 * could have been changed by tmigr_update_remote() above.
> +	 */
> +	parent = group->parent;
> +	if (parent && !group->active) {
> +		raw_spin_lock_nested(&parent->lock, parent->level);
> +		tmigr_add_evt(parent, &group->groupevt);
> +		raw_spin_unlock(&parent->lock);
> +	}
> +	raw_spin_unlock_irq(&group->lock);
> +
> +	/* Walk the hierarchy up? */
> +	if (!walkup || !parent)
> +		return;
> +
> +	/* Racy lockless check: See comment in tmigr_handle_remote() */
> +	if (parent->migrator == cpu)
> +		__tmigr_handle_remote(parent, cpu, now, jif, true);

(hopefully) Tail recursion..

> +}

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
> +	}
> +
> +	/* Add @evt to @group */
> +	tmigr_add_evt(group, evt);
> +
> +	/* If @cpu is not the active migrator, everything is up to date */
> +	if (group->migrator != cpu)
> +		goto done;
> +
> +	/* Update the migrator. */
> +	if (!group->active)
> +		group->migrator = TMIGR_NONE;
> +	else
> +		group->migrator = cpumask_first(group->cpus);
> +
> +	parent = group->parent;
> +	if (parent) {
> +		/*
> +		 * @cpu was the migrator in @group, so it is marked as
> +		 * active in its parent group(s) as well. Propagate the
> +		 * migrator change.
> +		 */
> +		evt = group->active ? NULL : &group->groupevt;
> +		nextevt = tmigr_set_cpu_inactive(parent, group, evt, cpu);

Recursion..

> +	} else {
> +		/*
> +		 * This is the top level of the hierarchy. If @cpu is about
> +		 * to go offline wake up some random other cpu so it will
> +		 * take over the migrator duty and program its timer
> +		 * proper. Ideally wake the cpu with the closest expiry
> +		 * time, but that's overkill to figure out.
> +		 */
> +		if (!per_cpu(tmigr_cpu, cpu).online) {
> +			cpu = cpumask_any_but(cpu_online_mask, cpu);
> +			smp_send_reschedule(cpu);
> +		}
> +		/*
> +		 * Return the earliest event of the top level group to make
> +		 * sure that its handled.
> +		 *
> +		 * This could be optimized by keeping track of the last
> +		 * global scheduled event and only arming it on @cpu if the
> +		 * new event is earlier. Not sure if its worth the
> +		 * complexity.
> +		 */
> +		nextevt = group->groupevt.nextevt.expires;
> +	}
> +done:
> +	raw_spin_unlock(&group->lock);
> +	return nextevt;
> +}

Would it be very onerous to rewrite that into regular loops? That avoids
us having to think (and worry) about blowing our stack.
