From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 1/6] thermal/cpu_cooling: No need to initialize max_freq to 0
Date: Thu, 30 Jul 2015 12:40:30 +0530
Message-ID: <af4a4b1ed4accda9100e00b82a1f46f8af6e507d.1438239727.git.viresh.kumar@linaro.org>
References: <cover.1438239727.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:35122 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751000AbbG3HKu (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 30 Jul 2015 03:10:50 -0400
Received: by pabkd10 with SMTP id kd10so18790296pab.2
        for <linux-pm@vger.kernel.org>; Thu, 30 Jul 2015 00:10:50 -0700 (PDT)
In-Reply-To: <cover.1438239727.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1438239727.git.viresh.kumar@linaro.org>
References: <cover.1438239727.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: edubezval@gmail.com
Cc: linaro-kernel@lists.linaro.org, rui.zhang@intel.com, linux-pm@vger.kernel.org, radivoje.jovanovic@linux.intel.com, punit.agrawal@arm.com, Viresh Kumar <viresh.kumar@linaro.org>, open list <linux-kernel@vger.kernel.org>

Its always set before getting used, don't initialize it.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/thermal/cpu_cooling.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index 6509c61b9648..d010c6d0d722 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -215,7 +215,7 @@ static int cpufreq_thermal_notifier(struct notifier_block *nb,
 				    unsigned long event, void *data)
 {
 	struct cpufreq_policy *policy = data;
-	unsigned long max_freq = 0;
+	unsigned long max_freq;
 	struct cpufreq_cooling_device *cpufreq_dev;
 
 	switch (event) {
-- 
2.4.0

