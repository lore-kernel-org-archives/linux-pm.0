From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 07/14] cpufreq: cpu0: OPPs can be populated at runtime
Date: Tue,  1 Jul 2014 22:02:36 +0530
Message-ID: <1ba7771e910084cd0820c19ca5994fe1b3d6451d.1404231535.git.viresh.kumar@linaro.org>
References: <cover.1404231535.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f172.google.com ([209.85.192.172]:64731 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758460AbaGAQef (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 1 Jul 2014 12:34:35 -0400
Received: by mail-pd0-f172.google.com with SMTP id w10so10401052pde.31
        for <linux-pm@vger.kernel.org>; Tue, 01 Jul 2014 09:34:35 -0700 (PDT)
In-Reply-To: <cover.1404231535.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1404231535.git.viresh.kumar@linaro.org>
References: <cover.1404231535.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net, shawn.guo@linaro.org
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, arvind.chauhan@arm.com, sboyd@codeaurora.org, linux-arm-msm@vger.kernel.org, spk.linux@gmail.com, thomas.ab@samsung.com, nm@ti.com, t.figa@samsung.com, Viresh Kumar <viresh.kumar@linaro.org>

OPPs can be populated statically, via DT, or added at run time with
dev_pm_opp_add().

While this driver handles the first case correctly, it would fail to populate
OPPs added at runtime. Because call to of_init_opp_table() would fail as there
are no OPPs in DT and probe will return early.

To fix this, remove error checking and call dev_pm_opp_init_cpufreq_table()
unconditionally.

Suggested-by: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq-cpu0.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/cpufreq/cpufreq-cpu0.c b/drivers/cpufreq/cpufreq-cpu0.c
index b5b8e1c..f47f703 100644
--- a/drivers/cpufreq/cpufreq-cpu0.c
+++ b/drivers/cpufreq/cpufreq-cpu0.c
@@ -164,11 +164,8 @@ static int cpu0_cpufreq_probe(struct platform_device *pdev)
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

