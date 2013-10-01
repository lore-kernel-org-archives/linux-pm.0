From: Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>
Subject: [PATCH] cpufreq: arm-big-little: use clk_get instead of clk_get_sys
Date: Tue,  1 Oct 2013 10:30:03 +0100
Message-ID: <1380619803-2760-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
Return-path: <cpufreq-owner@vger.kernel.org>
Sender: cpufreq-owner@vger.kernel.org
To: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Sudeep.KarkadaNagesha@arm.com, Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@sisk.pl>
List-Id: linux-pm@vger.kernel.org

From: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>

Currently clk_get_sys is used with cpu-cluster.<n> as the device id
which is incorrect. It should be connection/consumer ID instead.

It is possible to specify input clock in the cpu device node along
with the optional clock-name. clk_get_sys can't handle that.

This patch replaces clk_get_sys with clk_get to extend support for
clocks specified in the device tree cpu node.

Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>
Signed-off-by: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
---
 drivers/cpufreq/arm_big_little.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/arm_big_little.c b/drivers/cpufreq/arm_big_little.c
index 3549f07..501a091 100644
--- a/drivers/cpufreq/arm_big_little.c
+++ b/drivers/cpufreq/arm_big_little.c
@@ -127,7 +127,7 @@ static int get_cluster_clk_and_freq_table(struct device *cpu_dev)
 	}
 
 	name[12] = cluster + '0';
-	clk[cluster] = clk_get_sys(name, NULL);
+	clk[cluster] = clk_get(cpu_dev, name);
 	if (!IS_ERR(clk[cluster])) {
 		dev_dbg(cpu_dev, "%s: clk: %p & freq table: %p, cluster: %d\n",
 				__func__, clk[cluster], freq_table[cluster],
-- 
1.8.1.2

