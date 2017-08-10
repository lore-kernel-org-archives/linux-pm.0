From: Sudeep Holla <sudeep.holla@arm.com>
Subject: [PATCH] cpufreq: remove setting of policy->cpu in policy->cpus during init
Date: Thu, 10 Aug 2017 15:58:57 +0100
Message-ID: <1502377137-9058-1-git-send-email-sudeep.holla@arm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:34034 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751972AbdHJO6q (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 10 Aug 2017 10:58:46 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@arm.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>

policy->cpu is copied into policy->cpus in cpufreq_online() before
calling into cpufreq_driver->init(). So there's no need to set the
same in the individual driver init() functions again.

This patch removes the redundant setting of policy->cpu in policy->cpus
in intel_pstate and cppc drivers.

Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Reported-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/cpufreq/cppc_cpufreq.c | 1 -
 drivers/cpufreq/intel_pstate.c | 1 -
 2 files changed, 2 deletions(-)

Hi Viresh,

I had copied the cpumask_set_cpu from one of these drivers and when you
pointed out I thought it's better to remove the reference too. Let me
know if it makes sense.

Regards,
Sudeep

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index 10be285c9055..a1c3025f9df7 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -172,7 +172,6 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
 		return -EFAULT;
 	}

-	cpumask_set_cpu(policy->cpu, policy->cpus);
 	cpu->cur_policy = policy;

 	/* Set policy->cur to max now. The governors will adjust later. */
diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 0566455f233e..d82429859103 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -2133,7 +2133,6 @@ static int __intel_pstate_cpu_init(struct cpufreq_policy *policy)
 	policy->cpuinfo.max_freq *= cpu->pstate.scaling;

 	intel_pstate_init_acpi_perf_limits(policy);
-	cpumask_set_cpu(policy->cpu, policy->cpus);

 	policy->fast_switch_possible = true;

--
2.7.4
