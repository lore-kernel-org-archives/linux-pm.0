From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 13/31] cpufreq: ia64: Covert to light weight ->target() routine
Date: Mon, 12 Aug 2013 23:18:49 +0530
Message-ID: <03b7ed274047ab208476f92b927ff2d1a9f7653b.1376329128.git.viresh.kumar@linaro.org>
References: <cover.1376329128.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f181.google.com ([209.85.192.181]:37870 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753738Ab3HLRvF (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 12 Aug 2013 13:51:05 -0400
Received: by mail-pd0-f181.google.com with SMTP id g10so3734651pdj.26
        for <linux-pm@vger.kernel.org>; Mon, 12 Aug 2013 10:51:05 -0700 (PDT)
In-Reply-To: <cover.1376329128.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1376329128.git.viresh.kumar@linaro.org>
References: <cover.1376329128.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl
Cc: linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, Tony Luck <tony.luck@intel.com>

This patch converts existing .target_old() to newly defined light weight
.target() routine for this driver.

CPUFreq core will call cpufreq_frequency_table_target() before calling this
routine and will pass index to it.

Cc: Tony Luck <tony.luck@intel.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/ia64-acpi-cpufreq.c | 21 +++------------------
 1 file changed, 3 insertions(+), 18 deletions(-)

diff --git a/drivers/cpufreq/ia64-acpi-cpufreq.c b/drivers/cpufreq/ia64-acpi-cpufreq.c
index 02bd69b..bb81f37 100644
--- a/drivers/cpufreq/ia64-acpi-cpufreq.c
+++ b/drivers/cpufreq/ia64-acpi-cpufreq.c
@@ -227,26 +227,11 @@ acpi_cpufreq_get (
 static int
 acpi_cpufreq_target (
 	struct cpufreq_policy   *policy,
-	unsigned int target_freq,
-	unsigned int relation)
+	unsigned int index)
 {
-	struct cpufreq_acpi_io *data = acpi_io_data[policy->cpu];
-	unsigned int next_state = 0;
-	unsigned int result = 0;
-
-	pr_debug("acpi_cpufreq_setpolicy\n");
-
-	result = cpufreq_frequency_table_target(policy,
-			data->freq_table, target_freq, relation, &next_state);
-	if (result)
-		return (result);
-
-	result = processor_set_freq(data, policy, next_state);
-
-	return (result);
+	return processor_set_freq(acpi_io_data[policy->cpu], policy, index);
 }
 
-
 static int
 acpi_cpufreq_cpu_init (
 	struct cpufreq_policy   *policy)
@@ -380,7 +365,7 @@ acpi_cpufreq_cpu_exit (
 
 static struct cpufreq_driver acpi_cpufreq_driver = {
 	.verify 	= cpufreq_generic_frequency_table_verify,
-	.target_old	= acpi_cpufreq_target,
+	.target 	= acpi_cpufreq_target,
 	.get 		= acpi_cpufreq_get,
 	.init		= acpi_cpufreq_cpu_init,
 	.exit		= acpi_cpufreq_cpu_exit,
-- 
1.7.12.rc2.18.g61b472e

