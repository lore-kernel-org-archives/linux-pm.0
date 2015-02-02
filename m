From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCH 07/14] cpufreq: exynos5250: properly put of node
Date: Mon,  2 Feb 2015 16:58:10 -0400
Message-ID: <1422910697-5920-8-git-send-email-edubezval@gmail.com>
References: <1422910697-5920-1-git-send-email-edubezval@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:62035 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965130AbbBBU7N (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 2 Feb 2015 15:59:13 -0500
Received: by mail-pa0-f48.google.com with SMTP id ey11so87034367pad.7
        for <linux-pm@vger.kernel.org>; Mon, 02 Feb 2015 12:59:13 -0800 (PST)
In-Reply-To: <1422910697-5920-1-git-send-email-edubezval@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: Eduardo Valentin <edubezval@gmail.com>

Call of_node_put when necessary during init.

Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
---
 drivers/cpufreq/exynos5250-cpufreq.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/cpufreq/exynos5250-cpufreq.c b/drivers/cpufreq/exynos5250-cpufreq.c
index 3eafdc7..50b0cdf 100644
--- a/drivers/cpufreq/exynos5250-cpufreq.c
+++ b/drivers/cpufreq/exynos5250-cpufreq.c
@@ -195,6 +195,7 @@ int exynos5250_cpufreq_init(struct exynos_dvfs_info *info)
 	info->set_freq = exynos5250_set_frequency;
 
 	cpufreq = info;
+	of_node_put(np);
 
 	return 0;
 
@@ -205,6 +206,8 @@ err_mout_mpll:
 err_moutcore:
 	clk_put(cpu_clk);
 
+	of_node_put(np);
 	pr_err("%s: failed initialization\n", __func__);
+
 	return -EINVAL;
 }
-- 
2.1.3

