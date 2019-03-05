From: Quentin Perret <quentin.perret@arm.com>
Subject: Re: [RFT][Update][PATCH 2/2] cpufreq: intel_pstate: Update max CPU
 frequency on global turbo changes
Date: Tue, 5 Mar 2019 10:42:59 +0000
Message-ID: <20190305104256.7kvedlttuovmptpc@queper01-lin>
References: <9956076.F4luUDm1Dq@aspire.rjw.lan>
 <2046937.YMVy5Qh3Pm@aspire.rjw.lan>
 <3017597.CVkTxgYgAs@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <3017597.CVkTxgYgAs@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Chen Yu <yu.c.chen@intel.com>, Gabriele Mazzotta <gabriele.mzt@gmail.com>, peterz@infradead.org
List-Id: linux-pm@vger.kernel.org

Hi Rafael,

+CC Peter since we were talking about cpuinfo.*_freq recently.

On Friday 01 Mar 2019 at 13:57:06 (+0100), Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> While the cpuinfo.max_freq value doesn't really matter for
> intel_pstate in the active mode, in the passive mode it is used by
> governors as the maximum physical frequency of the CPU and the
> results of governor computations generally depend on it. Also it
> is made available to user space via sysfs and it should match the
> current HW configuration.
> 
> For this reason, make intel_pstate update cpuinfo.max_freq for all
> CPUs if it detects a global change of turbo frequency settings from
> "disable" to "enable" or the other way associated with a _PPC change
> notification from the platform firmware.
> 
> Note that policy_is_inactive() and cpufreq_set_policy() need to be
> made available to it for this purpose.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=200759
> Reported-by: Gabriele Mazzotta <gabriele.mzt@gmail.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> Update, because the patch sent previously doesn't build, due to an extra
> arg declared for intel_pstate_update_max_freq().
> 
> ---
>  drivers/cpufreq/cpufreq.c      |   12 ++----------
>  drivers/cpufreq/intel_pstate.c |   33 ++++++++++++++++++++++++++++++++-
>  include/linux/cpufreq.h        |    7 +++++++
>  3 files changed, 41 insertions(+), 11 deletions(-)
> 
> Index: linux-pm/drivers/cpufreq/intel_pstate.c
> ===================================================================
> --- linux-pm.orig/drivers/cpufreq/intel_pstate.c
> +++ linux-pm/drivers/cpufreq/intel_pstate.c
> @@ -897,6 +897,36 @@ static void intel_pstate_update_policies
>  		cpufreq_update_policy(cpu);
>  }
>  
> +static void intel_pstate_update_max_freq(unsigned int cpu)
> +{
> +	struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
> +	struct cpufreq_policy new_policy;
> +	struct cpudata *cpudata;
> +
> +	if (!policy)
> +		return;
> +
> +	down_write(&policy->rwsem);
> +
> +	if (policy_is_inactive(policy))
> +		goto unlock;
> +
> +	cpudata = all_cpu_data[cpu];
> +	policy->cpuinfo.max_freq = global.turbo_disabled_upd ?
> +			cpudata->pstate.max_freq : cpudata->pstate.turbo_freq;
> +
> +	memcpy(&new_policy, policy, sizeof(*policy));
> +	new_policy.max = min(policy->user_policy.max, policy->cpuinfo.max_freq);
> +	new_policy.min = min(policy->user_policy.min, new_policy.max);
> +
> +	cpufreq_set_policy(policy, &new_policy);

Do you want to force-restart the governor here ? Schedutil caches
cpuinfo.max_freq for the iowait stuff in sugov_start() [1]. I'm not sure
about the other governors.

And just removing sg_cpu->iowait_boost_max to use the cpuinfo struct
instead will conflict with [2], I think.

Thanks,
Quentin

[1] https://elixir.bootlin.com/linux/latest/source/kernel/sched/cpufreq_schedutil.c#L840
[2] https://lore.kernel.org/lkml/1550831866-32749-1-git-send-email-chunyan.zhang@unisoc.com/

> +
> +unlock:
> +	up_write(&policy->rwsem);
> +
> +	cpufreq_cpu_put(policy);
> +}
