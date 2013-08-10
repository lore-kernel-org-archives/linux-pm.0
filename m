From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 01/44] cpufreq: arm_big_little: call cpufreq_frequency_table_put_attr()
Date: Sat, 10 Aug 2013 12:13:57 +0530
Message-ID: <978bcbe9348cc446c9fe7f94a9c486f04f77a517.1376116345.git.viresh.kumar@linaro.org>
References: <cover.1376116344.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pb0-f50.google.com ([209.85.160.50]:61161 "EHLO
	mail-pb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757472Ab3HJGrw (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 10 Aug 2013 02:47:52 -0400
Received: by mail-pb0-f50.google.com with SMTP id uo5so5244723pbc.9
        for <linux-pm@vger.kernel.org>; Fri, 09 Aug 2013 23:47:51 -0700 (PDT)
In-Reply-To: <cover.1376116344.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1376116344.git.viresh.kumar@linaro.org>
References: <cover.1376116344.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl
Cc: linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>

Drivers which have an exit path must call cpufreq_frequency_table_put_attr() if
they have called cpufreq_frequency_table_get_attr() in their init path.

This driver was missing this part and is fixed with this patch.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/arm_big_little.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/arm_big_little.c b/drivers/cpufreq/arm_big_little.c
index 5070273..9acfb82 100644
--- a/drivers/cpufreq/arm_big_little.c
+++ b/drivers/cpufreq/arm_big_little.c
@@ -198,6 +198,7 @@ static int bL_cpufreq_exit(struct cpufreq_policy *policy)
 		return -ENODEV;
 	}
 
+	cpufreq_frequency_table_put_attr(policy->cpu);
 	put_cluster_clk_and_freq_table(cpu_dev);
 	dev_dbg(cpu_dev, "%s: Exited, cpu: %d\n", __func__, policy->cpu);
 
-- 
1.7.12.rc2.18.g61b472e

