From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2] PM / OPP: Allow inactive opp_device to be present in dev list
Date: Tue, 29 Nov 2016 11:04:52 +0530
Message-ID: <3bb7733d915c2e3e1cfcda8b8c798294a3c6ebbd.1480397575.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f176.google.com ([209.85.192.176]:36830 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752592AbcK2FfN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 29 Nov 2016 00:35:13 -0500
Received: by mail-pf0-f176.google.com with SMTP id 189so29645226pfz.3
        for <linux-pm@vger.kernel.org>; Mon, 28 Nov 2016 21:35:13 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, jy0922.shim@samsung.com, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, "# v4 . 4+" <stable@vger.kernel.org>

Joonyoung Shim reported an interesting problem on his ARM octa-core
Odoroid-XU3 platform. During system suspend, dev_pm_opp_put_regulator()
was failing for a struct device for which dev_pm_opp_set_regulator() is
called earlier.

This happened because an earlier call to
dev_pm_opp_of_cpumask_remove_table() function (from cpufreq-dt.c file)
removed all the entries from opp_table->dev_list apart from the last CPU
device in the cpumask of CPUs sharing the OPP.

But both dev_pm_opp_set_regulator() and dev_pm_opp_put_regulator()
routines get CPU device for the first CPU in the cpumask. And so the OPP
core failed to find the OPP table for the struct device.

In order to fix that up properly, we need to revisit APIs like
dev_pm_opp_set_regulator() and make them talk in terms of cookies
provided by the OPP core. But such a solution will be hard to backport
to stable kernels.

This patch attempts to fix this problem (in a Hacky way) by specially
handling the first cpu in the mask. A FIXME is also added to make sure
that this Hack doesn't get unnoticed later on.

Cc:  # v4.4+ <stable@vger.kernel.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
V1->V2:
- A completely different approach, more of hack so that backport to
  stable kernels can be done easily.
- A more comprehensive solution is required to fix the design flaws.

 drivers/base/power/opp/cpu.c | 50 +++++++++++++++++++++++++++++++-------------
 1 file changed, 35 insertions(+), 15 deletions(-)

diff --git a/drivers/base/power/opp/cpu.c b/drivers/base/power/opp/cpu.c
index 8c3434bdb26d..5d1b0f98bcb0 100644
--- a/drivers/base/power/opp/cpu.c
+++ b/drivers/base/power/opp/cpu.c
@@ -118,26 +118,46 @@ void dev_pm_opp_free_cpufreq_table(struct device *dev,
 EXPORT_SYMBOL_GPL(dev_pm_opp_free_cpufreq_table);
 #endif	/* CONFIG_CPU_FREQ */
 
+void _cpu_remove_table(unsigned int cpu, bool of)
+{
+	struct device *cpu_dev = get_cpu_device(cpu);
+
+	if (!cpu_dev) {
+		pr_err("%s: failed to get cpu%d device\n", __func__, cpu);
+		return;
+	}
+
+	if (of)
+		dev_pm_opp_of_remove_table(cpu_dev);
+	else
+		dev_pm_opp_remove_table(cpu_dev);
+}
+
 void _dev_pm_opp_cpumask_remove_table(const struct cpumask *cpumask, bool of)
 {
-	struct device *cpu_dev;
-	int cpu;
+	struct cpumask tmpmask;
+	int cpu, first_cpu;
 
 	WARN_ON(cpumask_empty(cpumask));
 
-	for_each_cpu(cpu, cpumask) {
-		cpu_dev = get_cpu_device(cpu);
-		if (!cpu_dev) {
-			pr_err("%s: failed to get cpu%d device\n", __func__,
-			       cpu);
-			continue;
-		}
-
-		if (of)
-			dev_pm_opp_of_remove_table(cpu_dev);
-		else
-			dev_pm_opp_remove_table(cpu_dev);
-	}
+	/*
+	 * The first cpu in the cpumask is important as that is used to create
+	 * the opp-table initially and routines like dev_pm_opp_put_regulator()
+	 * will expect the list-dev for the first CPU to be present while such
+	 * routines are called, otherwise we will fail to find the opp-table for
+	 * such devices.
+	 *
+	 * FIXME: Cleanup this mess and implement cookie based solutions instead
+	 * of working on the device pointer.
+	 */
+	first_cpu = cpumask_first(cpumask);
+	cpumask_copy(&tmpmask, cpumask);
+	cpumask_clear_cpu(first_cpu, &tmpmask);
+
+	for_each_cpu(cpu, &tmpmask)
+		_cpu_remove_table(cpu, of);
+
+	_cpu_remove_table(first_cpu, of);
 }
 
 /**
-- 
2.7.1.410.g6faf27b

