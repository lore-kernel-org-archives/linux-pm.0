From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH Resend] cpufreq: cpu0: OPPs can be populated at runtime
Date: Fri, 11 Jul 2014 20:24:19 +0530
Message-ID: <ba4ef31af64ef475c050d51bd04f3a93f0efc402.1405090205.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f176.google.com ([209.85.192.176]:37529 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752193AbaGKOye (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 11 Jul 2014 10:54:34 -0400
Received: by mail-pd0-f176.google.com with SMTP id ft15so1519878pdb.7
        for <linux-pm@vger.kernel.org>; Fri, 11 Jul 2014 07:54:34 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, arvind.chauhan@arm.com, ttynkkynen@nvidia.com, Viresh Kumar <viresh.kumar@linaro.org>

OPPs can be populated statically, via DT, or added at run time with
dev_pm_opp_add().

While this driver handles the first case correctly, it would fail to populate
OPPs added at runtime. Because call to of_init_opp_table() would fail as there
are no OPPs in DT and probe will return early.

To fix this, remove error checking and call dev_pm_opp_init_cpufreq_table()
unconditionally.

Update bindings as well.

Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Suggested-by: Stephen Boyd <sboyd@codeaurora.org>
Tested-by: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
Hi Rafael,

This was earlier sent as part of: https://lkml.org/lkml/2014/7/1/358 series. But
actually is an fix and can (should?) be pushed for 3.16.

Rest of the patches from that series are cleanups/updates and so can go in
3.17.

Please see if you can take it for 3.16.

 Documentation/devicetree/bindings/cpufreq/cpufreq-cpu0.txt | 6 ++++--
 drivers/cpufreq/cpufreq-cpu0.c                             | 7 ++-----
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-cpu0.txt b/Documentation/devicetree/bindings/cpufreq/cpufreq-cpu0.txt
index f055515..366690c 100644
--- a/Documentation/devicetree/bindings/cpufreq/cpufreq-cpu0.txt
+++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-cpu0.txt
@@ -8,10 +8,12 @@ Both required and optional properties listed below must be defined
 under node /cpus/cpu@0.
 
 Required properties:
-- operating-points: Refer to Documentation/devicetree/bindings/power/opp.txt
-  for details
+- None
 
 Optional properties:
+- operating-points: Refer to Documentation/devicetree/bindings/power/opp.txt for
+  details. OPPs *must* be supplied either via DT, i.e. this property, or
+  populated at runtime.
 - clock-latency: Specify the possible maximum transition latency for clock,
   in unit of nanoseconds.
 - voltage-tolerance: Specify the CPU voltage tolerance in percentage.
diff --git a/drivers/cpufreq/cpufreq-cpu0.c b/drivers/cpufreq/cpufreq-cpu0.c
index ee1ae30..86beda9 100644
--- a/drivers/cpufreq/cpufreq-cpu0.c
+++ b/drivers/cpufreq/cpufreq-cpu0.c
@@ -152,11 +152,8 @@ static int cpu0_cpufreq_probe(struct platform_device *pdev)
 		goto out_put_reg;
 	}
 
-	ret = of_init_opp_table(cpu_dev);
-	if (ret) {
-		pr_err("failed to init OPP table: %d\n", ret);
-		goto out_put_clk;
-	}
+	/* OPPs might be populated at runtime, don't check for error here */
+	of_init_opp_table(cpu_dev);
 
 	ret = dev_pm_opp_init_cpufreq_table(cpu_dev, &freq_table);
 	if (ret) {
-- 
2.0.0.rc2

