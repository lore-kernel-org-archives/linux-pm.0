From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCH 08/14] cpufreq: exynos5250: iounmap in error path
Date: Mon,  2 Feb 2015 16:58:11 -0400
Message-ID: <1422910697-5920-9-git-send-email-edubezval@gmail.com>
References: <1422910697-5920-1-git-send-email-edubezval@gmail.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1422910697-5920-1-git-send-email-edubezval@gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: Eduardo Valentin <edubezval@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kukjin Kim <kgene@kernel.org>, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

When error occurs, allow systems to release iomapped area.

Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Kukjin Kim <kgene@kernel.org>
Cc: linux-pm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-samsung-soc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
---
 drivers/cpufreq/exynos5250-cpufreq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/exynos5250-cpufreq.c b/drivers/cpufreq/exynos5250-cpufreq.c
index 50b0cdf..e61d149 100644
--- a/drivers/cpufreq/exynos5250-cpufreq.c
+++ b/drivers/cpufreq/exynos5250-cpufreq.c
@@ -206,6 +206,7 @@ err_mout_mpll:
 err_moutcore:
 	clk_put(cpu_clk);
 
+	iounmap(info->cmu_regs);
 	of_node_put(np);
 	pr_err("%s: failed initialization\n", __func__);
 
-- 
2.1.3
