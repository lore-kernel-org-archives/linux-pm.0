From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 2/2] cpufreq: exynos: Fix unsigned variable being checked for negative value
Date: Mon, 21 Jan 2013 15:59:54 +0530
Message-ID: <1358764194-22753-2-git-send-email-sachin.kamat@linaro.org>
References: <1358764194-22753-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pb0-f53.google.com ([209.85.160.53]:43833 "EHLO
	mail-pb0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752230Ab3AUKiu (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 21 Jan 2013 05:38:50 -0500
Received: by mail-pb0-f53.google.com with SMTP id un1so2603112pbc.40
        for <linux-pm@vger.kernel.org>; Mon, 21 Jan 2013 02:38:50 -0800 (PST)
In-Reply-To: <1358764194-22753-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org
Cc: rjw@sisk.pl, jhbird.choi@samsung.com, sachin.kamat@linaro.org, patches@linaro.org

exynos_cpufreq_scale function returns signed value which was
assigned to an unsigned variable and checked for negative value which
is always false. Hence make it signed.

Fixes the following smatch warnings:
drivers/cpufreq/exynos-cpufreq.c:83 exynos_cpufreq_scale() warn:
unsigned 'old_index' is never less than zero.
drivers/cpufreq/exynos-cpufreq.c:89 exynos_cpufreq_scale() warn:
unsigned 'index' is never less than zero.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/cpufreq/exynos-cpufreq.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/cpufreq/exynos-cpufreq.c b/drivers/cpufreq/exynos-cpufreq.c
index 38c6158..4a71491 100644
--- a/drivers/cpufreq/exynos-cpufreq.c
+++ b/drivers/cpufreq/exynos-cpufreq.c
@@ -65,7 +65,7 @@ static int exynos_cpufreq_scale(unsigned int target_freq)
 	struct cpufreq_policy *policy = cpufreq_cpu_get(0);
 	unsigned int arm_volt, safe_arm_volt = 0;
 	unsigned int mpll_freq_khz = exynos_info->mpll_freq_khz;
-	unsigned int index, old_index;
+	int index, old_index;
 	int ret = 0;
 
 	freqs.old = policy->cur;
-- 
1.7.4.1

