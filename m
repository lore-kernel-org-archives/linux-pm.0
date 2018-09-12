From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v4 02/16] sched/core: uclamp: map TASK's clamp values
 into CPU's clamp groups
Date: Wed, 12 Sep 2018 15:49:45 +0200
Message-ID: <20180912134945.GZ24106@hirez.programming.kicks-ass.net>
References: <20180828135324.21976-1-patrick.bellasi@arm.com>
 <20180828135324.21976-3-patrick.bellasi@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180828135324.21976-3-patrick.bellasi@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Tejun Heo <tj@kernel.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Paul Turner <pjt@google.com>, Quentin Perret <quentin.perret@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <juri.lelli@redhat.com>, Todd Kjos <tkjos@google.com>, Joel Fernandes <joelaf@google.com>, Steve Muckle <smuckle@google.com>, Suren Baghdasaryan <surenb@google.com>
List-Id: linux-pm@vger.kernel.org

On Tue, Aug 28, 2018 at 02:53:10PM +0100, Patrick Bellasi wrote:
> +/**
> + * Utilization's clamp group
> + *
> + * A utilization clamp group maps a "clamp value" (value), i.e.
> + * util_{min,max}, to a "clamp group index" (group_id).
> + */
> +struct uclamp_se {
> +	unsigned int value;
> +	unsigned int group_id;
> +};

> +/**
> + * uclamp_map: reference counts a utilization "clamp value"
> + * @value:    the utilization "clamp value" required
> + * @se_count: the number of scheduling entities requiring the "clamp value"
> + * @se_lock:  serialize reference count updates by protecting se_count

Why do you have a spinlock to serialize a single value? Don't we have
atomics for that?

> + */
> +struct uclamp_map {
> +	int value;
> +	int se_count;
> +	raw_spinlock_t se_lock;
> +};
> +
> +/**
> + * uclamp_maps: maps each SEs "clamp value" into a CPUs "clamp group"
> + *
> + * Since only a limited number of different "clamp values" are supported, we
> + * need to map each different clamp value into a "clamp group" (group_id) to
> + * be used by the per-CPU accounting in the fast-path, when tasks are
> + * enqueued and dequeued.
> + * We also support different kind of utilization clamping, min and max
> + * utilization for example, each representing what we call a "clamp index"
> + * (clamp_id).
> + *
> + * A matrix is thus required to map "clamp values" to "clamp groups"
> + * (group_id), for each "clamp index" (clamp_id), where:
> + * - rows are indexed by clamp_id and they collect the clamp groups for a
> + *   given clamp index
> + * - columns are indexed by group_id and they collect the clamp values which
> + *   maps to that clamp group
> + *
> + * Thus, the column index of a given (clamp_id, value) pair represents the
> + * clamp group (group_id) used by the fast-path's per-CPU accounting.
> + *
> + * NOTE: first clamp group (group_id=0) is reserved for tracking of non
> + * clamped tasks.  Thus we allocate one more slot than the value of
> + * CONFIG_UCLAMP_GROUPS_COUNT.
> + *
> + * Here is the map layout and, right below, how entries are accessed by the
> + * following code.
> + *
> + *                          uclamp_maps is a matrix of
> + *          +------- UCLAMP_CNT by CONFIG_UCLAMP_GROUPS_COUNT+1 entries
> + *          |                                |
> + *          |                /---------------+---------------\
> + *          |               +------------+       +------------+
> + *          |  / UCLAMP_MIN | value      |       | value      |
> + *          |  |            | se_count   |...... | se_count   |
> + *          |  |            +------------+       +------------+
> + *          +--+            +------------+       +------------+
> + *             |            | value      |       | value      |
> + *             \ UCLAMP_MAX | se_count   |...... | se_count   |
> + *                          +-----^------+       +----^-------+
> + *                                |                   |
> + *                      uc_map =  +                   |
> + *                     &uclamp_maps[clamp_id][0]      +
> + *                                                clamp_value =
> + *                                       uc_map[group_id].value
> + */
> +static struct uclamp_map uclamp_maps[UCLAMP_CNT]
> +				    [CONFIG_UCLAMP_GROUPS_COUNT + 1]
> +				    ____cacheline_aligned_in_smp;
> +

I'm still completely confused by all this.

sizeof(uclamp_map) = 12

that array is 2*6=12 of those, so the whole thing is 144 bytes. which is
more than 2 (64 byte) cachelines. What's the purpose of that cacheline
align statement?

Note that without that apparently superfluous lock, it would be 8*12 =
96 bytes, which is 1.5 lines and would indeed suggest you default to
GROUP_COUNT=7 by default to fill 2 lines.

Why are the min and max things torn up like that?  I'm fairly sure I
asked some of that last time; but the above comments only try to explain
what, not why.
