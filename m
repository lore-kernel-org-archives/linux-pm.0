From: Mark Brown <broonie@kernel.org>
Subject: [PATCH] cpufreq: s5pv210: Remove spurious __init annotation
Date: Wed, 27 Aug 2014 12:00:27 +0100
Message-ID: <1409137227-27080-1-git-send-email-broonie@kernel.org>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org, linaro-kernel@lists.linaro.org, linux-samsung-soc@vger.kernel.org, Mark Brown <broonie@linaro.org>
List-Id: linux-pm@vger.kernel.org

From: Mark Brown <broonie@linaro.org>

Since this is a platform driver and can be probed at any time we can't
annotate funtions in the probe path as __init, the code can't safely be
discarded at the end of kernel init.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 drivers/cpufreq/s5pv210-cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/s5pv210-cpufreq.c b/drivers/cpufreq/s5pv210-cpufreq.c
index 9a68225a757e..3f9791f07b8e 100644
--- a/drivers/cpufreq/s5pv210-cpufreq.c
+++ b/drivers/cpufreq/s5pv210-cpufreq.c
@@ -501,7 +501,7 @@ static int check_mem_type(void __iomem *dmc_reg)
 	return val >> 8;
 }
 
-static int __init s5pv210_cpu_init(struct cpufreq_policy *policy)
+static int s5pv210_cpu_init(struct cpufreq_policy *policy)
 {
 	unsigned long mem_type;
 	int ret;
-- 
2.1.0.rc1
