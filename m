From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [RFC PATCH v2 2/6] sched: Introduce energy models of CPUs
Date: Fri, 13 Apr 2018 09:32:53 +0530
Message-ID: <20180413040253.GW7671@vireshk-i7>
References: <20180406153607.17815-1-dietmar.eggemann@arm.com>
 <20180406153607.17815-3-dietmar.eggemann@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180406153607.17815-3-dietmar.eggemann@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Quentin Perret <quentin.perret@arm.com>, Thara Gopinath <thara.gopinath@linaro.org>, linux-pm@vger.kernel.org, Morten Rasmussen <morten.rasmussen@arm.com>, Chris Redpath <chris.redpath@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Valentin Schneider <valentin.schneider@arm.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Vincent Guittot <vincent.guittot@linaro.org>, Todd Kjos <tkjos@google.com>, Joel Fernandes <joelaf@google.com>, Juri Lelli <juri.lelli@redhat.com>, Steve Muckle <smuckle@google.com>, Eduardo Valentin <edubezval@gmail.com>
List-Id: linux-pm@vger.kernel.org

On 06-04-18, 16:36, Dietmar Eggemann wrote:
> diff --git a/include/linux/sched/energy.h b/include/linux/sched/energy.h

> +#if defined(CONFIG_SMP) && defined(CONFIG_PM_OPP)
> +extern struct sched_energy_model ** __percpu energy_model;
> +extern struct static_key_false sched_energy_present;
> +extern struct list_head sched_freq_domains;
> +
> +static inline bool sched_energy_enabled(void)
> +{
> +	return static_branch_unlikely(&sched_energy_present);
> +}
> +
> +static inline struct cpumask *freq_domain_span(struct freq_domain *fd)
> +{
> +	return &fd->span;
> +}
> +
> +extern void init_sched_energy(void);
> +
> +#define for_each_freq_domain(fdom) \
> +	list_for_each_entry(fdom, &sched_freq_domains, next)
> +
> +#else
> +struct freq_domain;
> +static inline bool sched_energy_enabled(void) { return false; }
> +static inline struct cpumask
> +*freq_domain_span(struct freq_domain *fd) { return NULL; }
> +static inline void init_sched_energy(void) { }
> +#define for_each_freq_domain(fdom) for (; fdom; fdom = NULL)

I am not sure if this is correct. fdom would normally be a local
uninitialized variable and with above we may end up running the loop
once with an invalid pointer. Maybe rewrite it as:

for (fdom = NULL; fdom; )


And for the whole OPP discussion, perhaps we should have another
architecture specific callback which the scheduler can call to get a
ready-made energy model with all the structures filled in. That way
the OPP specific stuff will move to the architecture specific
callback.

-- 
viresh
