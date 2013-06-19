From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 06/13] cpufreq: exynos: call CPUFREQ_POSTCHANGE notfier in error cases
Date: Wed, 19 Jun 2013 14:23:00 +0530
Message-ID: <ab291b0f037a019d65b1f7127702cfe8e4925a5e.1371630975.git.viresh.kumar@linaro.org>
References: <cover.1371630975.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pb0-f48.google.com ([209.85.160.48]:39949 "EHLO
	mail-pb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934412Ab3FSIyz (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 19 Jun 2013 04:54:55 -0400
Received: by mail-pb0-f48.google.com with SMTP id ma3so4814296pbc.7
        for <linux-pm@vger.kernel.org>; Wed, 19 Jun 2013 01:54:55 -0700 (PDT)
In-Reply-To: <cover.1371630975.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1371630975.git.viresh.kumar@linaro.org>
References: <cover.1371630975.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl
Cc: linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, robin.randhawa@arm.com, Steve.Bannister@arm.com, Liviu.Dudau@arm.com, charles.garcia-tobin@arm.com, arvind.chauhan@arm.com, dave.martin@arm.com, Viresh Kumar <viresh.kumar@linaro.org>, Kukjin Kim <kgene.kim@samsung.com>

PRECHANGE and POSTCHANGE notifiers must be called in groups, i.e either both
should be called or both shouldn't be.

In case we have started PRECHANGE notifier and found an error, we must call
POSTCHANGE notifier with freqs.new = freqs.old to guarantee that sequence of
calling notifiers is complete.

This patch fixes it.

Cc: Kukjin Kim <kgene.kim@samsung.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/exynos-cpufreq.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/exynos-cpufreq.c b/drivers/cpufreq/exynos-cpufreq.c
index 475b4f6..0d32f02 100644
--- a/drivers/cpufreq/exynos-cpufreq.c
+++ b/drivers/cpufreq/exynos-cpufreq.c
@@ -113,7 +113,8 @@ static int exynos_cpufreq_scale(unsigned int target_freq)
 		if (ret) {
 			pr_err("%s: failed to set cpu voltage to %d\n",
 				__func__, arm_volt);
-			goto out;
+			freqs.new = freqs.old;
+			goto post_notify;
 		}
 	}
 
@@ -123,14 +124,19 @@ static int exynos_cpufreq_scale(unsigned int target_freq)
 		if (ret) {
 			pr_err("%s: failed to set cpu voltage to %d\n",
 				__func__, safe_arm_volt);
-			goto out;
+			freqs.new = freqs.old;
+			goto post_notify;
 		}
 	}
 
 	exynos_info->set_freq(old_index, index);
 
+post_notify:
 	cpufreq_notify_transition(policy, &freqs, CPUFREQ_POSTCHANGE);
 
+	if (ret)
+		goto out;
+
 	/* When the new frequency is lower than current frequency */
 	if ((freqs.new < freqs.old) ||
 	   ((freqs.new > freqs.old) && safe_arm_volt)) {
-- 
1.7.12.rc2.18.g61b472e

