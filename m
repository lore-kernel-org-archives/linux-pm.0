From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 07/17] cpufreq: pass policy to cpufreq_out_of_sync
Date: Fri,  2 Jan 2015 12:34:28 +0530
Message-ID: <8095637bb1e3b2b625eb016cea1a44469d4eb28c.1420181916.git.viresh.kumar@linaro.org>
References: <cover.1420181916.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:37693 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750744AbbABHFV (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 2 Jan 2015 02:05:21 -0500
Received: by mail-pa0-f53.google.com with SMTP id kq14so23337801pab.26
        for <linux-pm@vger.kernel.org>; Thu, 01 Jan 2015 23:05:21 -0800 (PST)
In-Reply-To: <cover.1420181916.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1420181916.git.viresh.kumar@linaro.org>
References: <cover.1420181916.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, prarit@redhat.com, skannan@codeaurora.org, Viresh Kumar <viresh.kumar@linaro.org>

There is no point finding out the 'policy' again within cpufreq_out_of_sync()
when all the callers already have it. Just make them pass policy instead.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 5e60b3259cf5..3e80b97d64b8 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1502,30 +1502,23 @@ static void handle_update(struct work_struct *work)
 /**
  *	cpufreq_out_of_sync - If actual and saved CPU frequency differs, we're
  *	in deep trouble.
- *	@cpu: cpu number
- *	@old_freq: CPU frequency the kernel thinks the CPU runs at
+ *	@policy: policy managing CPUs
  *	@new_freq: CPU frequency the CPU actually runs at
  *
  *	We adjust to current frequency first, and need to clean up later.
  *	So either call to cpufreq_update_policy() or schedule handle_update()).
  */
-static void cpufreq_out_of_sync(unsigned int cpu, unsigned int old_freq,
+static void cpufreq_out_of_sync(struct cpufreq_policy *policy,
 				unsigned int new_freq)
 {
-	struct cpufreq_policy *policy;
 	struct cpufreq_freqs freqs;
-	unsigned long flags;
 
 	pr_debug("Warning: CPU frequency out of sync: cpufreq and timing core thinks of %u, is %u kHz\n",
-		 old_freq, new_freq);
+		 policy->cur, new_freq);
 
-	freqs.old = old_freq;
+	freqs.old = policy->cur;
 	freqs.new = new_freq;
 
-	read_lock_irqsave(&cpufreq_driver_lock, flags);
-	policy = per_cpu(cpufreq_cpu_data, cpu);
-	read_unlock_irqrestore(&cpufreq_driver_lock, flags);
-
 	cpufreq_freq_transition_begin(policy, &freqs);
 	cpufreq_freq_transition_end(policy, &freqs, 0);
 }
@@ -1590,7 +1583,7 @@ static unsigned int __cpufreq_get(unsigned int cpu)
 		/* verify no discrepancy between actual and
 					saved value exists */
 		if (unlikely(ret_freq != policy->cur)) {
-			cpufreq_out_of_sync(cpu, policy->cur, ret_freq);
+			cpufreq_out_of_sync(policy, ret_freq);
 			schedule_work(&policy->update);
 		}
 	}
@@ -2289,8 +2282,7 @@ int cpufreq_update_policy(unsigned int cpu)
 			policy->cur = new_policy.cur;
 		} else {
 			if (policy->cur != new_policy.cur && has_target())
-				cpufreq_out_of_sync(cpu, policy->cur,
-								new_policy.cur);
+				cpufreq_out_of_sync(policy, new_policy.cur);
 		}
 	}
 
-- 
2.2.0

