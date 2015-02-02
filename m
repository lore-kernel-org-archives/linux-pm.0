From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCH 13/14] cpufreq: exynos5250: remove unused symbol cpufreq
Date: Mon,  2 Feb 2015 16:58:16 -0400
Message-ID: <1422910697-5920-14-git-send-email-edubezval@gmail.com>
References: <1422910697-5920-1-git-send-email-edubezval@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:35932 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965185AbbBBU7d (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 2 Feb 2015 15:59:33 -0500
In-Reply-To: <1422910697-5920-1-git-send-email-edubezval@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: Eduardo Valentin <edubezval@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kukjin Kim <kgene@kernel.org>, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org

Now that the set_freq call back receives the intended
data struct, the global cpufreq variable may be removed.

Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Kukjin Kim <kgene@kernel.org>
Cc: linux-pm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-samsung-soc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
---
 drivers/cpufreq/exynos5250-cpufreq.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/cpufreq/exynos5250-cpufreq.c b/drivers/cpufreq/exynos5250-cpufreq.c
index 191a511..ee274c9 100644
--- a/drivers/cpufreq/exynos5250-cpufreq.c
+++ b/drivers/cpufreq/exynos5250-cpufreq.c
@@ -25,7 +25,6 @@ static struct clk *cpu_clk;
 static struct clk *moutcore;
 static struct clk *mout_mpll;
 static struct clk *mout_apll;
-static struct exynos_dvfs_info *cpufreq;
 
 static unsigned int exynos5250_volt_table[] = {
 	1300000, 1250000, 1225000, 1200000, 1150000,
@@ -197,7 +196,6 @@ int exynos5250_cpufreq_init(struct exynos_dvfs_info *info)
 	info->freq_table = exynos5250_freq_table;
 	info->set_freq = exynos5250_set_frequency;
 
-	cpufreq = info;
 	of_node_put(np);
 
 	return 0;
-- 
2.1.3

