From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 5/7] mvebu: Use dev_pm_opp_set_sharing_cpus() to mark OPP tables as shared
Date: Wed, 27 Apr 2016 08:52:25 +0530
Message-ID: <e13515db21cb178a8834d50f8b6b68e9b650aaec.1461727086.git.viresh.kumar@linaro.org>
References: <cover.1461727086.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1461727086.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1461727086.git.viresh.kumar@linaro.org>
References: <cover.1461727086.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, nm@ti.com, sboyd@codeaurora.org, arnd.bergmann@linaro.org, Viresh Kumar <viresh.kumar@linaro.org>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

That will allow us to avoid using cpufreq-dt platform data.

Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Gregory Clement <gregory.clement@free-electrons.com>
Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 arch/arm/mach-mvebu/pmsu.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-mvebu/pmsu.c b/arch/arm/mach-mvebu/pmsu.c
index ed8fda4cd055..8928f7caaf70 100644
--- a/arch/arm/mach-mvebu/pmsu.c
+++ b/arch/arm/mach-mvebu/pmsu.c
@@ -20,7 +20,6 @@
 
 #include <linux/clk.h>
 #include <linux/cpu_pm.h>
-#include <linux/cpufreq-dt.h>
 #include <linux/delay.h>
 #include <linux/init.h>
 #include <linux/io.h>
@@ -609,10 +608,6 @@ int mvebu_pmsu_dfs_request(int cpu)
 	return 0;
 }
 
-struct cpufreq_dt_platform_data cpufreq_dt_pd = {
-	.independent_clocks = true,
-};
-
 static int __init armada_xp_pmsu_cpufreq_init(void)
 {
 	struct device_node *np;
@@ -683,10 +678,15 @@ static int __init armada_xp_pmsu_cpufreq_init(void)
 			clk_put(clk);
 			return ret;
 		}
+
+		ret = dev_pm_opp_set_sharing_cpus(cpu_dev,
+						  cpumask_of(cpu_dev->id));
+		if (ret)
+			dev_err(cpu_dev, "%s: failed to mark OPPs as shared: %d\n",
+				__func__, ret);
 	}
 
-	platform_device_register_data(NULL, "cpufreq-dt", -1,
-				      &cpufreq_dt_pd, sizeof(cpufreq_dt_pd));
+	platform_device_register_simple("cpufreq-dt", -1, NULL, 0);
 	return 0;
 }
 
-- 
2.7.1.410.g6faf27b
