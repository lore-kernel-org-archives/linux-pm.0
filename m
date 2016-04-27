From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 6/7] cpufreq: dt: Kill platform-data
Date: Wed, 27 Apr 2016 08:52:26 +0530
Message-ID: <97dcb2300111fddfcb1bb8044fbea384a2d2ff86.1461727086.git.viresh.kumar@linaro.org>
References: <cover.1461727086.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1461727086.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1461727086.git.viresh.kumar@linaro.org>
References: <cover.1461727086.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, nm@ti.com, sboyd@codeaurora.org, arnd.bergmann@linaro.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

There are no more users of platform-data for cpufreq-dt driver, get rid
of it.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/cpufreq/cpufreq-dt.c |  6 +-----
 include/linux/cpufreq-dt.h   | 24 ------------------------
 2 files changed, 1 insertion(+), 29 deletions(-)
 delete mode 100644 include/linux/cpufreq-dt.h

diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
index aca9bec00f91..3957de801ae8 100644
--- a/drivers/cpufreq/cpufreq-dt.c
+++ b/drivers/cpufreq/cpufreq-dt.c
@@ -15,7 +15,6 @@
 #include <linux/cpu.h>
 #include <linux/cpu_cooling.h>
 #include <linux/cpufreq.h>
-#include <linux/cpufreq-dt.h>
 #include <linux/cpumask.h>
 #include <linux/err.h>
 #include <linux/module.h>
@@ -217,10 +216,7 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 	}
 
 	if (fallback) {
-		struct cpufreq_dt_platform_data *pd = cpufreq_get_driver_data();
-
-		if (!pd || !pd->independent_clocks)
-			cpumask_setall(policy->cpus);
+		cpumask_setall(policy->cpus);
 
 		/*
 		 * OPP tables are initialized only for policy->cpu, do it for
diff --git a/include/linux/cpufreq-dt.h b/include/linux/cpufreq-dt.h
deleted file mode 100644
index a87335a1660c..000000000000
--- a/include/linux/cpufreq-dt.h
+++ /dev/null
@@ -1,24 +0,0 @@
-/*
- * Copyright (C) 2014 Marvell
- * Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#ifndef __CPUFREQ_DT_H__
-#define __CPUFREQ_DT_H__
-
-#include <linux/types.h>
-
-struct cpufreq_dt_platform_data {
-	/*
-	 * True when each CPU has its own clock to control its
-	 * frequency, false when all CPUs are controlled by a single
-	 * clock.
-	 */
-	bool independent_clocks;
-};
-
-#endif /* __CPUFREQ_DT_H__ */
-- 
2.7.1.410.g6faf27b
