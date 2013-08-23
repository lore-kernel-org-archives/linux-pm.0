From: Joseph Lo <josephl@nvidia.com>
Subject: [PATCH] cpufreq: tegra: fix the wrong clock name
Date: Fri, 23 Aug 2013 09:43:58 +0800
Message-ID: <1377222238-9439-1-git-send-email-josephl@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <cpufreq-owner@vger.kernel.org>
Sender: cpufreq-owner@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, Joseph Lo <josephl@nvidia.com>
List-Id: linux-pm@vger.kernel.org

The "cpu" and "pclk_p_cclk" was a virtual clock name that was used in
the legacy Tegra clock framework. It was not used after converting to
CCF. Fix it as the correct clock name that we are using.

Signed-off-by: Joseph Lo <josephl@nvidia.com>
---
 drivers/cpufreq/tegra-cpufreq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/tegra-cpufreq.c b/drivers/cpufreq/tegra-cpufreq.c
index cd66b85..a7b876f 100644
--- a/drivers/cpufreq/tegra-cpufreq.c
+++ b/drivers/cpufreq/tegra-cpufreq.c
@@ -255,7 +255,7 @@ static struct cpufreq_driver tegra_cpufreq_driver = {
 
 static int __init tegra_cpufreq_init(void)
 {
-	cpu_clk = clk_get_sys(NULL, "cpu");
+	cpu_clk = clk_get_sys(NULL, "cclk");
 	if (IS_ERR(cpu_clk))
 		return PTR_ERR(cpu_clk);
 
@@ -263,7 +263,7 @@ static int __init tegra_cpufreq_init(void)
 	if (IS_ERR(pll_x_clk))
 		return PTR_ERR(pll_x_clk);
 
-	pll_p_clk = clk_get_sys(NULL, "pll_p_cclk");
+	pll_p_clk = clk_get_sys(NULL, "pll_p");
 	if (IS_ERR(pll_p_clk))
 		return PTR_ERR(pll_p_clk);
 
-- 
1.8.3.4

