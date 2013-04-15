From: Amit Daniel Kachhap <amit.daniel@samsung.com>
Subject: [PATCH] cpufreq: exynos5440: Protect opp search calls with rcu lock
Date: Mon, 15 Apr 2013 11:54:47 +0530
Message-ID: <1366007087-12090-1-git-send-email-amit.daniel@samsung.com>
Return-path: <cpufreq-owner@vger.kernel.org>
Sender: cpufreq-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kukjin Kim <kgene.kim@samsung.com>, cpufreq@vger.kernel.org, Nishanth Menon <nm@ti.com>
List-Id: linux-pm@vger.kernel.org

As per the OPP library documentation(Documentation/power/opp.txt) all
opp find/get calls should be protected by rcu locks.

Signed-off-by: Amit Daniel Kachhap <amit.daniel@samsung.com>
---

This patch is created against linux-next tree and is suggested by
Nishanth Menon. (https://lkml.org/lkml/2013/4/12/119)

 drivers/cpufreq/exynos5440-cpufreq.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/cpufreq/exynos5440-cpufreq.c b/drivers/cpufreq/exynos5440-cpufreq.c
index ead7ed4..0c74018 100644
--- a/drivers/cpufreq/exynos5440-cpufreq.c
+++ b/drivers/cpufreq/exynos5440-cpufreq.c
@@ -120,11 +120,13 @@ static int init_div_table(void)
 	int i = 0;
 	struct opp *opp;
 
+	rcu_read_lock();
 	for (i = 0; freq_tbl[i].frequency != CPUFREQ_TABLE_END; i++) {
 
 		opp = opp_find_freq_exact(dvfs_info->dev,
 					freq_tbl[i].frequency * 1000, true);
 		if (IS_ERR(opp)) {
+			rcu_read_unlock();
 			dev_err(dvfs_info->dev,
 				"failed to find valid OPP for %u KHZ\n",
 				freq_tbl[i].frequency);
@@ -159,6 +161,7 @@ static int init_div_table(void)
 		__raw_writel(tmp, dvfs_info->base + XMU_PMU_P0_7 + 4 * i);
 	}
 
+	rcu_read_unlock();
 	return 0;
 }
 
-- 
1.7.1

