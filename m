From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 1/2] cpufreq: Rearrange __cpufreq_driver_target()
Date: Fri, 26 Feb 2016 00:03:01 +0100
Message-ID: <3379824.2JIdz3GIvn@vostro.rjw.lan>
References: <3419119.Zd6aAZrh1K@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:57967 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752154AbcBYXCa (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 25 Feb 2016 18:02:30 -0500
In-Reply-To: <3419119.Zd6aAZrh1K@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Drop a pointless label at a return statement from
__cpufreq_driver_target() and rearrange that function
to reduce the indentation level.

No intentional functional changes.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/cpufreq.c |   47 ++++++++++++++++++++--------------------------
 1 file changed, 21 insertions(+), 26 deletions(-)

Index: linux-pm/drivers/cpufreq/cpufreq.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq.c
+++ linux-pm/drivers/cpufreq/cpufreq.c
@@ -1899,7 +1899,8 @@ int __cpufreq_driver_target(struct cpufr
 			    unsigned int relation)
 {
 	unsigned int old_target_freq = target_freq;
-	int retval = -EINVAL;
+	struct cpufreq_frequency_table *freq_table;
+	int index, retval;
 
 	if (cpufreq_disabled())
 		return -ENODEV;
@@ -1926,34 +1927,28 @@ int __cpufreq_driver_target(struct cpufr
 	policy->restore_freq = policy->cur;
 
 	if (cpufreq_driver->target)
-		retval = cpufreq_driver->target(policy, target_freq, relation);
-	else if (cpufreq_driver->target_index) {
-		struct cpufreq_frequency_table *freq_table;
-		int index;
-
-		freq_table = cpufreq_frequency_get_table(policy->cpu);
-		if (unlikely(!freq_table)) {
-			pr_err("%s: Unable to find freq_table\n", __func__);
-			goto out;
-		}
-
-		retval = cpufreq_frequency_table_target(policy, freq_table,
-				target_freq, relation, &index);
-		if (unlikely(retval)) {
-			pr_err("%s: Unable to find matching freq\n", __func__);
-			goto out;
-		}
-
-		if (freq_table[index].frequency == policy->cur) {
-			retval = 0;
-			goto out;
-		}
+		return cpufreq_driver->target(policy, target_freq, relation);
 
-		retval = __target_index(policy, freq_table, index);
+	if (!cpufreq_driver->target_index)
+		return -EINVAL;
+
+	freq_table = cpufreq_frequency_get_table(policy->cpu);
+	if (unlikely(!freq_table)) {
+		pr_err("%s: Unable to find freq_table\n", __func__);
+		return -EINVAL;
+	}
+
+	retval = cpufreq_frequency_table_target(policy, freq_table, target_freq,
+						relation, &index);
+	if (unlikely(retval)) {
+		pr_err("%s: Unable to find matching freq\n", __func__);
+		return retval;
 	}
 
-out:
-	return retval;
+	if (freq_table[index].frequency == policy->cur)
+		return 0;
+
+	return __target_index(policy, freq_table, index);
 }
 EXPORT_SYMBOL_GPL(__cpufreq_driver_target);
 

