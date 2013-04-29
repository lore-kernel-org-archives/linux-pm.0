From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 3/5] cpufreq: ARM big LITTLE DT: Return CPUFREQ_ETERNAL if clock-latency isn't found
Date: Mon, 29 Apr 2013 18:54:46 +0530
Message-ID: <7103baee30f84c26eb6080e407a9f91d219a54c0.1367241503.git.viresh.kumar@linaro.org>
References: <cover.1367241503.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f180.google.com ([209.85.192.180]:45005 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758084Ab3D2NZe (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 29 Apr 2013 09:25:34 -0400
Received: by mail-pd0-f180.google.com with SMTP id u10so3618103pdi.25
        for <linux-pm@vger.kernel.org>; Mon, 29 Apr 2013 06:25:33 -0700 (PDT)
In-Reply-To: <cover.1367241503.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1367241503.git.viresh.kumar@linaro.org>
References: <cover.1367241503.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl
Cc: linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, robin.randhawa@arm.com, Steve.Bannister@arm.com, Liviu.Dudau@arm.com, charles.garcia-tobin@arm.com, arvind.chauhan@arm.com, linux-arm-kernel@lists.infradead.org, Viresh Kumar <viresh.kumar@linaro.org>

If "/cpus" node isn't found or "clock-latency" isn't defined we are returning
error currently. Lets return CPUFREQ_ETERNAL instead, so that we don't fail.

Flag appropriate messages to user in such cases.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/arm_big_little_dt.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/arm_big_little_dt.c b/drivers/cpufreq/arm_big_little_dt.c
index d5ae4d2..173ed05 100644
--- a/drivers/cpufreq/arm_big_little_dt.c
+++ b/drivers/cpufreq/arm_big_little_dt.c
@@ -66,8 +66,8 @@ static int dt_get_transition_latency(struct device *cpu_dev)
 
 	parent = of_find_node_by_path("/cpus");
 	if (!parent) {
-		pr_err("failed to find OF /cpus\n");
-		return -ENOENT;
+		pr_info("Failed to find OF /cpus. Use CPUFREQ_ETERNAL transition latency\n");
+		return CPUFREQ_ETERNAL;
 	}
 
 	for_each_child_of_node(parent, np) {
@@ -81,7 +81,8 @@ static int dt_get_transition_latency(struct device *cpu_dev)
 		return transition_latency;
 	}
 
-	return -ENODEV;
+	pr_info("clock-latency isn't found, use CPUFREQ_ETERNAL transition latency\n");
+	return CPUFREQ_ETERNAL;
 }
 
 static struct cpufreq_arm_bL_ops dt_bL_ops = {
-- 
1.7.12.rc2.18.g61b472e

