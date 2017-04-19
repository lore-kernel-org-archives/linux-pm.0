From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [patch V2 08/10] timer: Implement the hierarchical pull model
Date: Wed, 19 Apr 2017 09:34:35 +0200
Message-ID: <20170419073435.3zlkg33rfskuxty2@hirez.programming.kicks-ass.net>
References: <20170418111102.490432548@linutronix.de>
 <20170418111401.016420305@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:52316 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752336AbdDSHeo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 19 Apr 2017 03:34:44 -0400
Content-Disposition: inline
In-Reply-To: <20170418111401.016420305@linutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, John Stultz <john.stultz@linaro.org>, Eric Dumazet <edumazet@google.com>, Anna-Maria Gleixner <anna-maria@linutronix.de>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-pm@vger.kernel.org, Arjan van de Ven <arjan@infradead.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Frederic Weisbecker <fweisbec@gmail.com>, Rik van Riel <riel@redhat.com>

On Tue, Apr 18, 2017 at 01:11:10PM +0200, Thomas Gleixner wrote:
> +struct tmigr_group {
> +	raw_spinlock_t		lock;
> +	unsigned int		active;
> +	unsigned int		migrator;
> +	struct timerqueue_head	events;
> +	struct tmigr_event	groupevt;
> +	struct tmigr_group	*parent;
> +	cpumask_var_t		cpus;
> +	struct list_head	list;
> +	unsigned int		level;
> +	unsigned int		numa_node;
> +	unsigned int		num_childs;
> +};

If you place the cpumask at the end, as a 0 sized array, you can avoid a
second allocation.
