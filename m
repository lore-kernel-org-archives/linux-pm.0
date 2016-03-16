From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v4 6/7] cpufreq: Support for fast frequency switching
Date: Wed, 16 Mar 2016 16:35:50 +0100
Message-ID: <20160316153550.GA6344@twins.programming.kicks-ass.net>
References: <1711281.bPmSjlBT7c@vostro.rjw.lan>
 <1989596.XAKfhFj1lz@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1989596.XAKfhFj1lz@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Juri Lelli <juri.lelli@arm.com>, Steve Muckle <steve.muckle@linaro.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Ingo Molnar <mingo@kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Mar 16, 2016 at 03:52:28PM +0100, Rafael J. Wysocki wrote:
> +/**
> + * cpufreq_enable_fast_switch - Enable fast frequency switching for policy.
> + * @policy: cpufreq policy to enable fast frequency switching for.
> + *
> + * Try to enable fast frequency switching for @policy.
> + *
> + * The attempt will fail if there is at least one transition notifier registered
> + * at this point, as fast frequency switching is quite fundamentally at odds
> + * with transition notifiers.  Thus if successful, it will make registration of
> + * transition notifiers fail going forward.
> + *
> + * Call under policy->rwsem.

Nobody reads a comment..

> + */
> +void cpufreq_enable_fast_switch(struct cpufreq_policy *policy)
> +{

	lockdep_assert_held(&policy->rwsem);

While everybody complains when there's a big nasty splat in their dmesg
;-)

> +	mutex_lock(&cpufreq_fast_switch_lock);
> +	if (policy->fast_switch_possible && cpufreq_fast_switch_count >= 0) {
> +		cpufreq_fast_switch_count++;
> +		policy->fast_switch_enabled = true;
> +	} else {
> +		pr_warn("cpufreq: CPU%u: Fast freqnency switching not enabled\n",
> +			policy->cpu);
> +	}
> +	mutex_unlock(&cpufreq_fast_switch_lock);
> +}
