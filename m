Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09777C433F5
	for <linux-pm@archiver.kernel.org>; Fri, 30 Sep 2022 09:48:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229462AbiI3Jss (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 30 Sep 2022 05:48:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231180AbiI3Jsk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 30 Sep 2022 05:48:40 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CEE6E814DE;
        Fri, 30 Sep 2022 02:48:39 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 003A615A1;
        Fri, 30 Sep 2022 02:48:46 -0700 (PDT)
Received: from e123648.arm.com (unknown [10.57.0.185])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 172133F73B;
        Fri, 30 Sep 2022 02:48:37 -0700 (PDT)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, rafael@kernel.org
Cc:     linux-pm@vger.kernel.org, lukasz.luba@arm.com,
        viresh.kumar@linaro.org, Dietmar.Eggemann@arm.com
Subject: [PATCH 1/2] cpufreq: Change macro for store scaling min/max frequency
Date:   Fri, 30 Sep 2022 10:48:20 +0100
Message-Id: <20220930094821.31665-1-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

In order to prepare extension to the store_scaling_max_freq() remove
the macro and use two normal functions. The set value for max frequency
is important for the task scheduler.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 drivers/cpufreq/cpufreq.c | 47 ++++++++++++++++++++++-----------------
 1 file changed, 27 insertions(+), 20 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 69b3d61852ac..1f8b93f42c76 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -715,26 +715,33 @@ static ssize_t show_scaling_cur_freq(struct cpufreq_policy *policy, char *buf)
 	return ret;
 }
 
-/*
- * cpufreq_per_cpu_attr_write() / store_##file_name() - sysfs write access
- */
-#define store_one(file_name, object)			\
-static ssize_t store_##file_name					\
-(struct cpufreq_policy *policy, const char *buf, size_t count)		\
-{									\
-	unsigned long val;						\
-	int ret;							\
-									\
-	ret = sscanf(buf, "%lu", &val);					\
-	if (ret != 1)							\
-		return -EINVAL;						\
-									\
-	ret = freq_qos_update_request(policy->object##_freq_req, val);\
-	return ret >= 0 ? count : ret;					\
-}
-
-store_one(scaling_min_freq, min);
-store_one(scaling_max_freq, max);
+static ssize_t store_scaling_max_freq
+(struct cpufreq_policy *policy, const char *buf, size_t count)
+{
+	unsigned long val;
+	int ret;
+
+	ret = sscanf(buf, "%lu", &val);
+	if (ret != 1)
+		return -EINVAL;
+
+	ret = freq_qos_update_request(policy->max_freq_req, val);
+	return ret >= 0 ? count : ret;
+}
+
+static ssize_t store_scaling_min_freq
+(struct cpufreq_policy *policy, const char *buf, size_t count)
+{
+	unsigned long val;
+	int ret;
+
+	ret = sscanf(buf, "%lu", &val);
+	if (ret != 1)
+		return -EINVAL;
+
+	ret = freq_qos_update_request(policy->min_freq_req, val);
+	return ret >= 0 ? count : ret;
+}
 
 /*
  * show_cpuinfo_cur_freq - current CPU frequency as detected by hardware
-- 
2.17.1

