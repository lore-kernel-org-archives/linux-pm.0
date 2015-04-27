From: Sudeep Holla <sudeep.holla@arm.com>
Subject: [PATCH 2/2] cpufreq: arm_big_little: remove unused cpu-cluster.<n> clock name
Date: Mon, 27 Apr 2015 10:51:06 +0100
Message-ID: <1430128266-15012-2-git-send-email-sudeep.holla@arm.com>
References: <1430128266-15012-1-git-send-email-sudeep.holla@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1430128266-15012-1-git-send-email-sudeep.holla@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@arm.com>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
List-Id: linux-pm@vger.kernel.org

The "cpu-cluster.<n>" used to get the cluster clock is not used by any
platform. Moreover __of_clk_get_by_name used in clk_get return error if
the "clock-names" in the DT doesn't match this string. When using DT,
it's not compulsory to specify the clock name unless there are multiple
clock input entries in the consumer.

This patch removes the unused clock string from the driver.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/cpufreq/arm_big_little.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/cpufreq/arm_big_little.c b/drivers/cpufreq/arm_big_little.c
index f65e19f340d0..e4d75ca9f3b0 100644
--- a/drivers/cpufreq/arm_big_little.c
+++ b/drivers/cpufreq/arm_big_little.c
@@ -331,7 +331,6 @@ static void put_cluster_clk_and_freq_table(struct device *cpu_dev)
 static int _get_cluster_clk_and_freq_table(struct device *cpu_dev)
 {
 	u32 cluster = raw_cpu_to_cluster(cpu_dev->id);
-	char name[14] = "cpu-cluster.";
 	int ret;
 
 	if (freq_table[cluster])
@@ -351,8 +350,7 @@ static int _get_cluster_clk_and_freq_table(struct device *cpu_dev)
 		goto free_opp_table;
 	}
 
-	name[12] = cluster + '0';
-	clk[cluster] = clk_get(cpu_dev, name);
+	clk[cluster] = clk_get(cpu_dev, NULL);
 	if (!IS_ERR(clk[cluster])) {
 		dev_dbg(cpu_dev, "%s: clk: %p & freq table: %p, cluster: %d\n",
 				__func__, clk[cluster], freq_table[cluster],
-- 
1.9.1
