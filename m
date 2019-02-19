From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 2/4] cpufreq: Reorder and simplify cpufreq_update_policy()
Date: Wed, 20 Feb 2019 00:24:25 +0100
Message-ID: <12123959.u3IqJzSc3J@aspire.rjw.lan>
References: <11668536.bBDtnvkYQE@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <11668536.bBDtnvkYQE@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

In cpufreq_update_policy(), instead of updating new_policy.cur
separately, which is kind of confusing, because cpufreq_set_policy()
doesn't take that value into account directly anyway, make the copy
of the existing policy after calling cpufreq_update_current_freq().

No intentional changes of behavior.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/cpufreq.c |   19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

Index: linux-pm/drivers/cpufreq/cpufreq.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq.c
+++ linux-pm/drivers/cpufreq/cpufreq.c
@@ -2354,23 +2354,18 @@ void cpufreq_update_policy(unsigned int
 	if (policy_is_inactive(policy))
 		goto unlock;
 
-	pr_debug("updating policy for CPU %u\n", cpu);
-	memcpy(&new_policy, policy, sizeof(*policy));
-	new_policy.min = policy->user_policy.min;
-	new_policy.max = policy->user_policy.max;
-
 	/*
 	 * BIOS might change freq behind our back
 	 * -> ask driver for current freq and notify governors about a change
 	 */
-	if (cpufreq_driver->get && !cpufreq_driver->setpolicy) {
-		if (cpufreq_suspended)
-			goto unlock;
+	if (cpufreq_driver->get && !cpufreq_driver->setpolicy &&
+	    (cpufreq_suspended || WARN_ON(!cpufreq_update_current_freq(policy))))
+		goto unlock;
 
-		new_policy.cur = cpufreq_update_current_freq(policy);
-		if (WARN_ON(!new_policy.cur))
-			goto unlock;
-	}
+	pr_debug("updating policy for CPU %u\n", cpu);
+	memcpy(&new_policy, policy, sizeof(*policy));
+	new_policy.min = policy->user_policy.min;
+	new_policy.max = policy->user_policy.max;
 
 	cpufreq_set_policy(policy, &new_policy);
 
