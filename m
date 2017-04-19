From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [patch V2 08/10] timer: Implement the hierarchical pull model
Date: Wed, 19 Apr 2017 10:11:16 +0200
Message-ID: <20170419081116.GA3029@worktop.programming.kicks-ass.net>
References: <20170418111102.490432548@linutronix.de>
 <20170418111401.016420305@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:52692 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1760498AbdDSILZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 19 Apr 2017 04:11:25 -0400
Content-Disposition: inline
In-Reply-To: <20170418111401.016420305@linutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, John Stultz <john.stultz@linaro.org>, Eric Dumazet <edumazet@google.com>, Anna-Maria Gleixner <anna-maria@linutronix.de>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-pm@vger.kernel.org, Arjan van de Ven <arjan@infradead.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Frederic Weisbecker <fweisbec@gmail.com>, Rik van Riel <riel@redhat.com>

On Tue, Apr 18, 2017 at 01:11:10PM +0200, Thomas Gleixner wrote:
> +static struct tmigr_group *tmigr_get_group(unsigned int node, unsigned int lvl)
> +{
> +	struct tmigr_group *group;
> +
> +	/* Try to attach to an exisiting group first */
> +	list_for_each_entry(group, &tmigr_level_list[lvl], list) {
> +		/*
> +		 * If @lvl is below the cross numa node level, check
> +		 * whether this group belongs to the same numa node.
> +		 */
> +		if (lvl < tmigr_crossnode_level && group->numa_node != node)
> +			continue;
> +		/* If the group has capacity, use it */
> +		if (group->num_childs < tmigr_childs_per_group) {
> +			group->num_childs++;
> +			return group;
> +		}

This would result in SMT siblings not sharing groups on regular Intel
systems, right? Since they get enumerated last.

> +	}
> +	/* Allocate and set up a new group */
> +	group = kzalloc_node(sizeof(*group), GFP_KERNEL, node);
> +	if (!group)
> +		return ERR_PTR(-ENOMEM);
> +
> +	if (!zalloc_cpumask_var_node(&group->cpus, GFP_KERNEL, node)) {
> +		kfree(group);
> +		return ERR_PTR(-ENOMEM);
> +	}

So if you place that cpumask last, you can do:

	group = kzalloc_node(sizeof(*group) + cpumask_size(),
	                     GFP_KERNEL, node);

> +	tmigr_init_group(group, lvl, node);
> +	/* Setup successful. Add it to the hierarchy */
> +	list_add(&group->list, &tmigr_level_list[lvl]);
> +	return group;
> +}
