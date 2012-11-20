From: Tushar Behera <tushar.behera@linaro.org>
Subject: [PATCH] [CPUFREQ] EXYNOS: Use static for functions used in only this file
Date: Tue, 20 Nov 2012 11:29:14 +0530
Message-ID: <1353391154-32524-1-git-send-email-tushar.behera@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:34378 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751528Ab2KTGFY (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 20 Nov 2012 01:05:24 -0500
Received: by mail-pb0-f46.google.com with SMTP id wy7so4025860pbc.19
        for <linux-pm@vger.kernel.org>; Mon, 19 Nov 2012 22:05:24 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, cpufreq@vger.kernel.org
Cc: rjw@sisk.pl, patches@linaro.org

Fixes following sparse error.
drivers/cpufreq/exynos-cpufreq.c:34:5: warning: symbol
'exynos_verify_speed' was not declared. Should it be static?
drivers/cpufreq/exynos-cpufreq.c:40:14: warning: symbol
'exynos_getspeed' was not declared. Should it be static?

Signed-off-by: Tushar Behera <tushar.behera@linaro.org>
---
 drivers/cpufreq/exynos-cpufreq.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/exynos-cpufreq.c b/drivers/cpufreq/exynos-cpufreq.c
index af2d81e..eb057bf 100644
--- a/drivers/cpufreq/exynos-cpufreq.c
+++ b/drivers/cpufreq/exynos-cpufreq.c
@@ -31,13 +31,13 @@ static unsigned int locking_frequency;
 static bool frequency_locked;
 static DEFINE_MUTEX(cpufreq_lock);
 
-int exynos_verify_speed(struct cpufreq_policy *policy)
+static int exynos_verify_speed(struct cpufreq_policy *policy)
 {
 	return cpufreq_frequency_table_verify(policy,
 					      exynos_info->freq_table);
 }
 
-unsigned int exynos_getspeed(unsigned int cpu)
+static unsigned int exynos_getspeed(unsigned int cpu)
 {
 	return clk_get_rate(exynos_info->cpu_clk) / 1000;
 }
-- 
1.7.4.1

