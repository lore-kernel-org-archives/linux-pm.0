From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH] cpufreq: Unexport cpufreq_frequency_table_cpuinfo()
Date: Tue, 31 May 2016 16:50:23 +0530
Message-ID: <5985d7d6d89f24cce0f028f3475828b3081edfec.1464693600.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:35521 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753588AbcEaLU2 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 31 May 2016 07:20:28 -0400
Received: by mail-pa0-f46.google.com with SMTP id fy7so54068929pac.2
        for <linux-pm@vger.kernel.org>; Tue, 31 May 2016 04:20:27 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org

All cpufreq drivers with a freq-table are migrated to use
cpufreq_table_validate_and_show() long back and the routine
cpufreq_frequency_table_cpuinfo() isn't used outside of cpufreq core
now.

Unexport it and update Documentation as well.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 Documentation/cpu-freq/core.txt        | 4 ++--
 Documentation/cpu-freq/cpu-drivers.txt | 2 +-
 drivers/cpufreq/freq_table.c           | 2 --
 3 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/Documentation/cpu-freq/core.txt b/Documentation/cpu-freq/core.txt
index ba78e7c2a069..4bc7287806de 100644
--- a/Documentation/cpu-freq/core.txt
+++ b/Documentation/cpu-freq/core.txt
@@ -96,7 +96,7 @@ new	- new frequency
 For details about OPP, see Documentation/power/opp.txt
 
 dev_pm_opp_init_cpufreq_table - cpufreq framework typically is initialized with
-	cpufreq_frequency_table_cpuinfo which is provided with the list of
+	cpufreq_table_validate_and_show() which is provided with the list of
 	frequencies that are available for operation. This function provides
 	a ready to use conversion routine to translate the OPP layer's internal
 	information about the available frequencies into a format readily
@@ -110,7 +110,7 @@ dev_pm_opp_init_cpufreq_table - cpufreq framework typically is initialized with
 		/* Do things */
 		r = dev_pm_opp_init_cpufreq_table(dev, &freq_table);
 		if (!r)
-			cpufreq_frequency_table_cpuinfo(policy, freq_table);
+			cpufreq_table_validate_and_show(policy, freq_table);
 		/* Do other things */
 	 }
 
diff --git a/Documentation/cpu-freq/cpu-drivers.txt b/Documentation/cpu-freq/cpu-drivers.txt
index 14f4e6336d88..decbb8cb5573 100644
--- a/Documentation/cpu-freq/cpu-drivers.txt
+++ b/Documentation/cpu-freq/cpu-drivers.txt
@@ -231,7 +231,7 @@ if you want to skip one entry in the table, set the frequency to
 CPUFREQ_ENTRY_INVALID. The entries don't need to be in ascending
 order.
 
-By calling cpufreq_frequency_table_cpuinfo(struct cpufreq_policy *policy,
+By calling cpufreq_table_validate_and_show(struct cpufreq_policy *policy,
 					struct cpufreq_frequency_table *table);
 the cpuinfo.min_freq and cpuinfo.max_freq values are detected, and
 policy->min and policy->max are set to the same values. This is
diff --git a/drivers/cpufreq/freq_table.c b/drivers/cpufreq/freq_table.c
index a8f1daffc9bc..4e5c5dbfed7a 100644
--- a/drivers/cpufreq/freq_table.c
+++ b/drivers/cpufreq/freq_table.c
@@ -63,8 +63,6 @@ int cpufreq_frequency_table_cpuinfo(struct cpufreq_policy *policy,
 	else
 		return 0;
 }
-EXPORT_SYMBOL_GPL(cpufreq_frequency_table_cpuinfo);
-
 
 int cpufreq_frequency_table_verify(struct cpufreq_policy *policy,
 				   struct cpufreq_frequency_table *table)
-- 
2.7.1.410.g6faf27b

