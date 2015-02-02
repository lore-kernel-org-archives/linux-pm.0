From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCH 12/14] cpufreq: exynos4x12: remove unused symbol cpufreq
Date: Mon,  2 Feb 2015 16:58:15 -0400
Message-ID: <1422910697-5920-13-git-send-email-edubezval@gmail.com>
References: <1422910697-5920-1-git-send-email-edubezval@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:47081 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965092AbbBBU7b (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 2 Feb 2015 15:59:31 -0500
Received: by mail-pa0-f46.google.com with SMTP id lj1so86903090pab.5
        for <linux-pm@vger.kernel.org>; Mon, 02 Feb 2015 12:59:30 -0800 (PST)
In-Reply-To: <1422910697-5920-1-git-send-email-edubezval@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: Eduardo Valentin <edubezval@gmail.com>

Now that the set_freq call back receives the intended
data struct, the global cpufreq variable may be removed.

Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
---
 drivers/cpufreq/exynos4x12-cpufreq.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/cpufreq/exynos4x12-cpufreq.c b/drivers/cpufreq/exynos4x12-cpufreq.c
index d12087b..5ea5dad 100644
--- a/drivers/cpufreq/exynos4x12-cpufreq.c
+++ b/drivers/cpufreq/exynos4x12-cpufreq.c
@@ -25,7 +25,6 @@ static struct clk *cpu_clk;
 static struct clk *moutcore;
 static struct clk *mout_mpll;
 static struct clk *mout_apll;
-static struct exynos_dvfs_info *cpufreq;
 
 static unsigned int exynos4x12_volt_table[] = {
 	1350000, 1287500, 1250000, 1187500, 1137500, 1087500, 1037500,
@@ -223,7 +222,6 @@ int exynos4x12_cpufreq_init(struct exynos_dvfs_info *info)
 	info->freq_table = exynos4x12_freq_table;
 	info->set_freq = exynos4x12_set_frequency;
 
-	cpufreq = info;
 	of_node_put(np);
 
 	return 0;
-- 
2.1.3

