From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v5 07/15] sched/core: uclamp: add clamp group bucketing
 support
Date: Mon, 12 Nov 2018 01:09:10 +0100
Message-ID: <20181112000910.GC3038@worktop>
References: <20181029183311.29175-1-patrick.bellasi@arm.com>
 <20181029183311.29175-9-patrick.bellasi@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181029183311.29175-9-patrick.bellasi@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Tejun Heo <tj@kernel.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Vincent Guittot <vincent.guittot@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, Paul Turner <pjt@google.com>, Quentin Perret <quentin.perret@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <juri.lelli@redhat.com>, Todd Kjos <tkjos@google.com>, Joel Fernandes <joelaf@google.com>, Steve Muckle <smuckle@google.com>, Suren Baghdasaryan <surenb@google.com>
List-Id: linux-pm@vger.kernel.org

On Mon, Oct 29, 2018 at 06:33:02PM +0000, Patrick Bellasi wrote:
> The number of clamp groups configured at compile time defines the range
> of utilization clamp values tracked by each CPU clamp group.
> For example, with the default configuration:
>    CONFIG_UCLAMP_GROUPS_COUNT 5
> we will have 5 clamp groups tracking 20% utilization each. In this case,
> a task with util_min=25% will have group_id=1.

OK I suppose; but should we not do a wholesale s/group/bucket/ at this
point?

We should probably raise the minimum number of buckets from 1 though :-)

> +/*
> + * uclamp_group_value: get the "group value" for a given "clamp value"
> + * @value: the utiliation "clamp value" to translate
> + *
> + * The number of clamp group, which is defined at compile time, allows to
> + * track a finite number of different clamp values. Thus clamp values are
> + * grouped into bins each one representing a different "group value".
> + * This method returns the "group value" corresponding to the specified
> + * "clamp value".
> + */
> +static inline unsigned int uclamp_group_value(unsigned int clamp_value)
> +{
> +#define UCLAMP_GROUP_DELTA (SCHED_CAPACITY_SCALE / CONFIG_UCLAMP_GROUPS_COUNT)
> +#define UCLAMP_GROUP_UPPER (UCLAMP_GROUP_DELTA * CONFIG_UCLAMP_GROUPS_COUNT)
> +
> +	if (clamp_value >= UCLAMP_GROUP_UPPER)
> +		return SCHED_CAPACITY_SCALE;
> +
> +	return UCLAMP_GROUP_DELTA * (clamp_value / UCLAMP_GROUP_DELTA);
> +}

Can't we further simplify; I mean, at this point all we really need to
know is the rq's highest group_id that is in use. We don't need to
actually track the value anymore.
