From: Steve Muckle <steve.muckle@linaro.org>
Subject: Re: [PATCH v6 6/7][Resend] cpufreq: Support for fast frequency
 switching
Date: Fri, 25 Mar 2016 18:12:11 -0700
Message-ID: <56F5E1EB.1050702@linaro.org>
References: <7262976.zPkLj56ATU@vostro.rjw.lan>
 <25154681.B5BGJ94JlQ@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <25154681.B5BGJ94JlQ@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>
Cc: Juri Lelli <juri.lelli@arm.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Ingo Molnar <mingo@kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Rafael,

On 03/21/2016 06:53 PM, Rafael J. Wysocki wrote:
> Add two new policy flags, fast_switch_possible, to be set by the
> cpufreq driver if fast frequency switching can be used for the
> given policy and fast_switch_enabled, to be set by the governor
> if it is going to use fast frequency switching for the given
> policy.  Also add a helper for setting the latter.
...
> @@ -740,6 +777,9 @@ static int acpi_cpufreq_cpu_init(struct
>  		goto err_unreg;
>  	}
>  
> +	policy->fast_switch_possible = !acpi_pstate_strict &&
> +		!(policy_is_shared(policy) && policy->shared_type != CPUFREQ_SHARED_TYPE_ANY);

Could the policy->fast_switch_possible flag be avoided by just checking
whether a driver has registered the .fast_switch callback?

...
> @@ -1726,6 +1810,34 @@ EXPORT_SYMBOL(cpufreq_unregister_notifie
>   *                              GOVERNORS                            *
>   *********************************************************************/
>  
> +/**
> + * cpufreq_driver_fast_switch - Carry out a fast CPU frequency switch.
> + * @policy: cpufreq policy to switch the frequency for.
> + * @target_freq: New frequency to set (may be approximate).
> + *
> + * Carry out a fast frequency switch from interrupt context.

I think that should say atomic rather than interrupt as this might not
be called from interrupt context.

thanks,
Steve
