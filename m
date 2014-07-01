From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 04/14] cpufreq: cpu0: Add Module Author
Date: Tue,  1 Jul 2014 22:02:33 +0530
Message-ID: <bc183ef08321e2699a0834d545bade9c7f7d7fcc.1404231535.git.viresh.kumar@linaro.org>
References: <cover.1404231535.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1404231535.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1404231535.git.viresh.kumar@linaro.org>
References: <cover.1404231535.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net, shawn.guo@linaro.org
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, arvind.chauhan@arm.com, sboyd@codeaurora.org, linux-arm-msm@vger.kernel.org, spk.linux@gmail.com, thomas.ab@samsung.com, nm@ti.com, t.figa@samsung.com, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

Two people are maintaining it now, Viresh and Shawn. Add Viresh's details in
MODULE_AUTHOR() and copyright section.

Suggested-by: Shawn Guo <shawn.guo@linaro.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq-cpu0.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/cpufreq/cpufreq-cpu0.c b/drivers/cpufreq/cpufreq-cpu0.c
index ee1ae30..7e191db 100644
--- a/drivers/cpufreq/cpufreq-cpu0.c
+++ b/drivers/cpufreq/cpufreq-cpu0.c
@@ -1,6 +1,9 @@
 /*
  * Copyright (C) 2012 Freescale Semiconductor, Inc.
  *
+ * Copyright (C) 2014 Linaro.
+ * Viresh Kumar <viresh.kumar@linaro.org>
+ *
  * The OPP code in function cpu0_set_target() is reused from
  * drivers/cpufreq/omap-cpufreq.c
  *
@@ -246,6 +249,7 @@ static struct platform_driver cpu0_cpufreq_platdrv = {
 };
 module_platform_driver(cpu0_cpufreq_platdrv);
 
+MODULE_AUTHOR("Viresh Kumar <viresh.kumar@linaro.org>");
 MODULE_AUTHOR("Shawn Guo <shawn.guo@linaro.org>");
 MODULE_DESCRIPTION("Generic CPU0 cpufreq driver");
 MODULE_LICENSE("GPL");
-- 
2.0.0.rc2
