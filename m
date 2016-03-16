From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v4 6/7] cpufreq: Support for fast frequency switching
Date: Wed, 16 Mar 2016 16:43:14 +0100
Message-ID: <20160316154314.GB6344@twins.programming.kicks-ass.net>
References: <1711281.bPmSjlBT7c@vostro.rjw.lan>
 <1989596.XAKfhFj1lz@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1989596.XAKfhFj1lz@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Juri Lelli <juri.lelli@arm.com>, Steve Muckle <steve.muckle@linaro.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Ingo Molnar <mingo@kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Mar 16, 2016 at 03:52:28PM +0100, Rafael J. Wysocki wrote:
> +void cpufreq_enable_fast_switch(struct cpufreq_policy *policy)
> +{
> +	mutex_lock(&cpufreq_fast_switch_lock);
> +	if (policy->fast_switch_possible && cpufreq_fast_switch_count >= 0) {
> +		cpufreq_fast_switch_count++;
> +		policy->fast_switch_enabled = true;
> +	} else {
> +		pr_warn("cpufreq: CPU%u: Fast freqnency switching not enabled\n",
> +			policy->cpu);

This happens because there's transition notifiers, right? Would it make
sense to iterate the notifier here and print the notifier function
symbol for each? That way we've got a clue as to where to start looking
when this happens.

> +	}
> +	mutex_unlock(&cpufreq_fast_switch_lock);
> +}

> @@ -1653,8 +1703,18 @@ int cpufreq_register_notifier(struct not
>  
>  	switch (list) {
>  	case CPUFREQ_TRANSITION_NOTIFIER:
> +		mutex_lock(&cpufreq_fast_switch_lock);
> +
> +		if (cpufreq_fast_switch_count > 0) {
> +			mutex_unlock(&cpufreq_fast_switch_lock);

So while theoretically (it has a return code)
cpufreq_register_notifier() could fail, it never actually did. Now we
do. Do we want to add a WARN here?

> +			return -EPERM;
> +		}
>  		ret = srcu_notifier_chain_register(
>  				&cpufreq_transition_notifier_list, nb);
> +		if (!ret)
> +			cpufreq_fast_switch_count--;
> +
> +		mutex_unlock(&cpufreq_fast_switch_lock);
>  		break;
>  	case CPUFREQ_POLICY_NOTIFIER:
>  		ret = blocking_notifier_chain_register(
