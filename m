From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH] cpufreq: intel_pstate: Set P-state upfront in
 performance mode
Date: Thu, 20 Oct 2016 11:22:44 -0700
Message-ID: <1476987764.5666.29.camel@linux.intel.com>
References: <1724762.8Kf4o5e5cm@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1724762.8Kf4o5e5cm@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed, 2016-10-19 at 02:57 +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 

[...]

> +	if (policy->policy == CPUFREQ_POLICY_PERFORMANCE) {
> +		/*
> +		 * NOHZ_FULL CPUs need this as the governor callback
> may not
> +		 * be invoked on them.
> +		 */
> +		intel_pstate_clear_update_util_hook(policy->cpu);
> +		intel_pstate_max_within_limits(cpu);
> +	}
> +

Can we move this to intel_pstate_set_performance_limits

diff --git a/drivers/cpufreq/intel_pstate.c
b/drivers/cpufreq/intel_pstate.c
index a6ffd79..d0fd73e 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -1543,6 +1543,13 @@ static void
intel_pstate_set_performance_limits(struct perf_limits *limits)
        limits->max_sysfs_pct = 100;
        limits->min_policy_pct = 0;
        limits->min_sysfs_pct = 0;
+
+       /*
+        * NOHZ_FULL CPUs need this as the governor callback may not
+        * be invoked on them.
+        */
+       intel_pstate_clear_update_util_hook(policy->cpu);
+       intel_pstate_max_within_limits(cpu);
 }
 
 static int intel_pstate_set_policy(struct cpufreq_policy *policy)
@@ -1599,15 +1606,6 @@ static int intel_pstate_set_policy(struct
cpufreq_policy *policy)
        limits->max_perf = round_up(limits->max_perf, FRAC_BITS);
 
  out:
-       if (policy->policy == CPUFREQ_POLICY_PERFORMANCE) {
-               /*
-                * NOHZ_FULL CPUs need this as the governor callback
may not
-                * be invoked on them.
-                */
-               intel_pstate_clear_update_util_hook(policy->cpu);
-               intel_pstate_max_within_limits(cpu);
-       }
-
        intel_pstate_set_update_util_hook(policy->cpu);
 
        intel_pstate_hwp_set_policy(policy);


Thanks,
Srinivas
