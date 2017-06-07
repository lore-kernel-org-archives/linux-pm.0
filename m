From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH] cpufreq: exynos5440: Fix inconsistent indenting
Date: Wed,  7 Jun 2017 20:13:24 +0200
Message-ID: <20170607181324.32199-1-krzk@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Fix inconsistent indenting and unneeded white space in assignment.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/cpufreq/exynos5440-cpufreq.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/exynos5440-cpufreq.c b/drivers/cpufreq/exynos5440-cpufreq.c
index 9180d34cc9fc..b6b369c22272 100644
--- a/drivers/cpufreq/exynos5440-cpufreq.c
+++ b/drivers/cpufreq/exynos5440-cpufreq.c
@@ -173,12 +173,12 @@ static void exynos_enable_dvfs(unsigned int cur_frequency)
 	/* Enable PSTATE Change Event */
 	tmp = __raw_readl(dvfs_info->base + XMU_PMUEVTEN);
 	tmp |= (1 << PSTATE_CHANGED_EVTEN_SHIFT);
-	 __raw_writel(tmp, dvfs_info->base + XMU_PMUEVTEN);
+	__raw_writel(tmp, dvfs_info->base + XMU_PMUEVTEN);
 
 	/* Enable PSTATE Change IRQ */
 	tmp = __raw_readl(dvfs_info->base + XMU_PMUIRQEN);
 	tmp |= (1 << PSTATE_CHANGED_IRQEN_SHIFT);
-	 __raw_writel(tmp, dvfs_info->base + XMU_PMUIRQEN);
+	__raw_writel(tmp, dvfs_info->base + XMU_PMUIRQEN);
 
 	/* Set initial performance index */
 	cpufreq_for_each_entry(pos, freq_table)
@@ -330,7 +330,7 @@ static int exynos_cpufreq_probe(struct platform_device *pdev)
 	struct resource res;
 	unsigned int cur_frequency;
 
-	np =  pdev->dev.of_node;
+	np = pdev->dev.of_node;
 	if (!np)
 		return -ENODEV;
 
-- 
2.9.3
