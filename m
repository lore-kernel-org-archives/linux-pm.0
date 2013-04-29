From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 2/5] cpufreq: ARM big LITTLE DT: Return correct transition latency
Date: Mon, 29 Apr 2013 18:54:45 +0530
Message-ID: <26f5713ba03a7d5ee590ce615d19578eb4395abe.1367241503.git.viresh.kumar@linaro.org>
References: <cover.1367241503.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1367241503.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1367241503.git.viresh.kumar@linaro.org>
References: <cover.1367241503.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@sisk.pl
Cc: linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, robin.randhawa@arm.com, Steve.Bannister@arm.com, Liviu.Dudau@arm.com, charles.garcia-tobin@arm.com, arvind.chauhan@arm.com, linux-arm-kernel@lists.infradead.org, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

By mistake we are returning zero for successful call to
dt_get_transition_latency(), whereas we should return transition_latency.

Fix it.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/arm_big_little_dt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/arm_big_little_dt.c b/drivers/cpufreq/arm_big_little_dt.c
index 44be311..d5ae4d2 100644
--- a/drivers/cpufreq/arm_big_little_dt.c
+++ b/drivers/cpufreq/arm_big_little_dt.c
@@ -78,7 +78,7 @@ static int dt_get_transition_latency(struct device *cpu_dev)
 		of_node_put(np);
 		of_node_put(parent);
 
-		return 0;
+		return transition_latency;
 	}
 
 	return -ENODEV;
-- 
1.7.12.rc2.18.g61b472e
