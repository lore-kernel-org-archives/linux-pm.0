From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 1/6] cpufreq: governor: Remove prints from allocation failures
Date: Wed, 18 May 2016 17:55:26 +0530
Message-ID: <c67367f1c086fce0686e1ab154a9f1142e706a63.1463574213.git.viresh.kumar@linaro.org>
References: <cover.1463574213.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f177.google.com ([209.85.192.177]:35922 "EHLO
	mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752695AbcERMZm (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 18 May 2016 08:25:42 -0400
Received: by mail-pf0-f177.google.com with SMTP id c189so18699673pfb.3
        for <linux-pm@vger.kernel.org>; Wed, 18 May 2016 05:25:41 -0700 (PDT)
In-Reply-To: <cover.1463574213.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1463574213.git.viresh.kumar@linaro.org>
References: <cover.1463574213.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

These aren't required anymore as the allocation core already prints such
messages. Remove the redundant ones.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq_conservative.c | 4 +---
 drivers/cpufreq/cpufreq_ondemand.c     | 4 +---
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_conservative.c b/drivers/cpufreq/cpufreq_conservative.c
index 316df247e00d..5a15f649602c 100644
--- a/drivers/cpufreq/cpufreq_conservative.c
+++ b/drivers/cpufreq/cpufreq_conservative.c
@@ -273,10 +273,8 @@ static int cs_init(struct dbs_data *dbs_data, bool notify)
 	struct cs_dbs_tuners *tuners;
 
 	tuners = kzalloc(sizeof(*tuners), GFP_KERNEL);
-	if (!tuners) {
-		pr_err("%s: kzalloc failed\n", __func__);
+	if (!tuners)
 		return -ENOMEM;
-	}
 
 	tuners->down_threshold = DEF_FREQUENCY_DOWN_THRESHOLD;
 	tuners->freq_step = DEF_FREQUENCY_STEP;
diff --git a/drivers/cpufreq/cpufreq_ondemand.c b/drivers/cpufreq/cpufreq_ondemand.c
index 300163430516..309cfeb744b2 100644
--- a/drivers/cpufreq/cpufreq_ondemand.c
+++ b/drivers/cpufreq/cpufreq_ondemand.c
@@ -368,10 +368,8 @@ static int od_init(struct dbs_data *dbs_data, bool notify)
 	int cpu;
 
 	tuners = kzalloc(sizeof(*tuners), GFP_KERNEL);
-	if (!tuners) {
-		pr_err("%s: kzalloc failed\n", __func__);
+	if (!tuners)
 		return -ENOMEM;
-	}
 
 	cpu = get_cpu();
 	idle_time = get_cpu_idle_time_us(cpu, NULL);
-- 
2.7.1.410.g6faf27b

