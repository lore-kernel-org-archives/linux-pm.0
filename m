From: Amit Daniel Kachhap <amit.daniel@samsung.com>
Subject: [PATCH] cpufreq: exynos5440: Fix to skip when new frequency same as current
Date: Wed,  7 Aug 2013 16:46:11 +0530
Message-ID: <1375874171-16951-1-git-send-email-amit.daniel@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Viresh Kumar <viresh.kumar@linaro.org>, Kukjin Kim <kgene.kim@samsung.com>
List-Id: linux-pm@vger.kernel.org

This patch fixes the issue of un-necessary setting the clock controller
when the new target frequency is same as the current one. This case usually
occurs with governors like ondemand which passes the target frequency as the
percentage of average frequency. This check is present in most of the cpufreq
driver.

Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael J. Wysocki <rjw@sisk.pl>
Cc: Kukjin Kim <kgene.kim@samsung.com>
Signed-off-by: Amit Daniel Kachhap <amit.daniel@samsung.com>
---
 drivers/cpufreq/exynos5440-cpufreq.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/cpufreq/exynos5440-cpufreq.c b/drivers/cpufreq/exynos5440-cpufreq.c
index 0c74018..d514c15 100644
--- a/drivers/cpufreq/exynos5440-cpufreq.c
+++ b/drivers/cpufreq/exynos5440-cpufreq.c
@@ -238,6 +238,9 @@ static int exynos_target(struct cpufreq_policy *policy,
 	freqs.old = dvfs_info->cur_frequency;
 	freqs.new = freq_table[index].frequency;
 
+	if (freqs.old == freqs.new)
+		goto out;
+
 	cpufreq_notify_transition(policy, &freqs, CPUFREQ_PRECHANGE);
 
 	/* Set the target frequency in all C0_3_PSTATE register */
-- 
1.7.1
