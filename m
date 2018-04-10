From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH v2 4/6] sched/fair: Introduce an energy estimation
 helper function
Date: Tue, 10 Apr 2018 14:51:05 +0200
Message-ID: <20180410125105.GC4043@hirez.programming.kicks-ass.net>
References: <20180406153607.17815-1-dietmar.eggemann@arm.com>
 <20180406153607.17815-5-dietmar.eggemann@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180406153607.17815-5-dietmar.eggemann@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: linux-kernel@vger.kernel.org, Quentin Perret <quentin.perret@arm.com>, Thara Gopinath <thara.gopinath@linaro.org>, linux-pm@vger.kernel.org, Morten Rasmussen <morten.rasmussen@arm.com>, Chris Redpath <chris.redpath@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Valentin Schneider <valentin.schneider@arm.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Vincent Guittot <vincent.guittot@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, Todd Kjos <tkjos@google.com>, Joel Fernandes <joelaf@google.com>, Juri Lelli <juri.lelli@redhat.com>, Steve Muckle <smuckle@google.com>, Eduardo Valentin <edubezval@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Fri, Apr 06, 2018 at 04:36:05PM +0100, Dietmar Eggemann wrote:
> +static inline
> +struct capacity_state *find_cap_state(int cpu, unsigned long util)
> +{
> +	struct sched_energy_model *em = *per_cpu_ptr(energy_model, cpu);
> +	struct capacity_state *cs = NULL;
> +	int i;
> +
> +	util += util >> 2;
> +
> +	for (i = 0; i < em->nr_cap_states; i++) {
> +		cs = &em->cap_states[i];
> +		if (cs->cap >= util)
> +			break;
> +	}
> +
> +	return cs;
> +}

So in the last thread there was some discussion about this; in
particular on how this related to schedutil and if we should tie it into
that.

I think for starters tying it to schedutil is not a bad idea; ideally
people _should_ migrate towards using that.

Also; I think it makes sense to better integrate cpufreq and the
energy-model values like what rjw already suggested, such that maybe we
can have cpufreq_driver_resolve_freq() return a structure containing the
relevant information for the selected frequency.

But implementing the frequency selection thing in multiple places like
now sounds like a very bad idea to me.
