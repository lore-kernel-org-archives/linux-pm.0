From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 1/1] cpufreq: ppc: Remove duplicate inclusion of fsl_soc.h
Date: Tue,  8 Apr 2014 10:27:58 +0530
Message-ID: <1396933078-11438-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <cpufreq-owner@vger.kernel.org>
Sender: cpufreq-owner@vger.kernel.org
To: cpufreq@vger.kernel.org
Cc: linux-pm@vger.kernel.org, rjw@rjwysocki.net, viresh.kumar@linaro.org, sachin.kamat@linaro.org
List-Id: linux-pm@vger.kernel.org

fsl_soc.h was included twice.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/cpufreq/ppc-corenet-cpufreq.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/cpufreq/ppc-corenet-cpufreq.c b/drivers/cpufreq/ppc-corenet-cpufreq.c
index 3bd9123e7026..b7e677be1df0 100644
--- a/drivers/cpufreq/ppc-corenet-cpufreq.c
+++ b/drivers/cpufreq/ppc-corenet-cpufreq.c
@@ -13,7 +13,6 @@
 #include <linux/clk.h>
 #include <linux/cpufreq.h>
 #include <linux/errno.h>
-#include <sysdev/fsl_soc.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
-- 
1.7.9.5

