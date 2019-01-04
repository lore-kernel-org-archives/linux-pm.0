From: Joseph Lo <josephl@nvidia.com>
Subject: [PATCH V4 11/20] cpufreq: tegra124: do not handle the CPU rail
Date: Fri, 4 Jan 2019 11:06:53 +0800
Message-ID: <20190104030702.8684-12-josephl@nvidia.com>
References: <20190104030702.8684-1-josephl@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190104030702.8684-1-josephl@nvidia.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Thierry Reding <thierry.reding@gmail.com>, Peter De Schrijver <pdeschrijver@nvidia.com>, Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, Joseph Lo <josephl@nvidia.com>, linux-tegra@vger.kernel.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

The Tegra124 cpufreq driver has no information to handle the Vdd-CPU
rail. So this driver shouldn't handle for the CPU clock switching from
DFLL to other PLL clocks. It was designed to work on DFLL clock only,
which handle the frequency/voltage scaling in the background.

This patch removes the driver dependency of the CPU rail, as well as not
allow it to be built as a module and remove the removal function. So it
can keep working on DFLL clock.

Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org
Signed-off-by: Joseph Lo <josephl@nvidia.com>
Acked-by: Jon Hunter <jonathanh@nvidia.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
---
*V4:
 - no change
*V3:
 - add ack tags
*V2:
 - update the commit message since we change the driver not able to be
 built as a module and remove the removal function in V2
---
 drivers/cpufreq/Kconfig.arm        |  4 +--
 drivers/cpufreq/tegra124-cpufreq.c | 41 ++----------------------------
 2 files changed, 4 insertions(+), 41 deletions(-)

diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index 688f10227793..1a6778e81f90 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -272,8 +272,8 @@ config ARM_TEGRA20_CPUFREQ
 	  This adds the CPUFreq driver support for Tegra20 SOCs.
 
 config ARM_TEGRA124_CPUFREQ
-	tristate "Tegra124 CPUFreq support"
-	depends on ARCH_TEGRA && CPUFREQ_DT && REGULATOR
+	bool "Tegra124 CPUFreq support"
+	depends on ARCH_TEGRA && CPUFREQ_DT
 	default y
 	help
 	  This adds the CPUFreq driver support for Tegra124 SOCs.
diff --git a/drivers/cpufreq/tegra124-cpufreq.c b/drivers/cpufreq/tegra124-cpufreq.c
index 43530254201a..a1bfde0a7950 100644
--- a/drivers/cpufreq/tegra124-cpufreq.c
+++ b/drivers/cpufreq/tegra124-cpufreq.c
@@ -22,11 +22,9 @@
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/pm_opp.h>
-#include <linux/regulator/consumer.h>
 #include <linux/types.h>
 
 struct tegra124_cpufreq_priv {
-	struct regulator *vdd_cpu_reg;
 	struct clk *cpu_clk;
 	struct clk *pllp_clk;
 	struct clk *pllx_clk;
@@ -60,14 +58,6 @@ static int tegra124_cpu_switch_to_dfll(struct tegra124_cpufreq_priv *priv)
 	return ret;
 }
 
-static void tegra124_cpu_switch_to_pllx(struct tegra124_cpufreq_priv *priv)
-{
-	clk_set_parent(priv->cpu_clk, priv->pllp_clk);
-	clk_disable_unprepare(priv->dfll_clk);
-	regulator_sync_voltage(priv->vdd_cpu_reg);
-	clk_set_parent(priv->cpu_clk, priv->pllx_clk);
-}
-
 static int tegra124_cpufreq_probe(struct platform_device *pdev)
 {
 	struct tegra124_cpufreq_priv *priv;
@@ -88,16 +78,10 @@ static int tegra124_cpufreq_probe(struct platform_device *pdev)
 	if (!np)
 		return -ENODEV;
 
-	priv->vdd_cpu_reg = regulator_get(cpu_dev, "vdd-cpu");
-	if (IS_ERR(priv->vdd_cpu_reg)) {
-		ret = PTR_ERR(priv->vdd_cpu_reg);
-		goto out_put_np;
-	}
-
 	priv->cpu_clk = of_clk_get_by_name(np, "cpu_g");
 	if (IS_ERR(priv->cpu_clk)) {
 		ret = PTR_ERR(priv->cpu_clk);
-		goto out_put_vdd_cpu_reg;
+		goto out_put_np;
 	}
 
 	priv->dfll_clk = of_clk_get_by_name(np, "dfll");
@@ -129,15 +113,13 @@ static int tegra124_cpufreq_probe(struct platform_device *pdev)
 		platform_device_register_full(&cpufreq_dt_devinfo);
 	if (IS_ERR(priv->cpufreq_dt_pdev)) {
 		ret = PTR_ERR(priv->cpufreq_dt_pdev);
-		goto out_switch_to_pllx;
+		goto out_put_pllp_clk;
 	}
 
 	platform_set_drvdata(pdev, priv);
 
 	return 0;
 
-out_switch_to_pllx:
-	tegra124_cpu_switch_to_pllx(priv);
 out_put_pllp_clk:
 	clk_put(priv->pllp_clk);
 out_put_pllx_clk:
@@ -146,34 +128,15 @@ static int tegra124_cpufreq_probe(struct platform_device *pdev)
 	clk_put(priv->dfll_clk);
 out_put_cpu_clk:
 	clk_put(priv->cpu_clk);
-out_put_vdd_cpu_reg:
-	regulator_put(priv->vdd_cpu_reg);
 out_put_np:
 	of_node_put(np);
 
 	return ret;
 }
 
-static int tegra124_cpufreq_remove(struct platform_device *pdev)
-{
-	struct tegra124_cpufreq_priv *priv = platform_get_drvdata(pdev);
-
-	platform_device_unregister(priv->cpufreq_dt_pdev);
-	tegra124_cpu_switch_to_pllx(priv);
-
-	clk_put(priv->pllp_clk);
-	clk_put(priv->pllx_clk);
-	clk_put(priv->dfll_clk);
-	clk_put(priv->cpu_clk);
-	regulator_put(priv->vdd_cpu_reg);
-
-	return 0;
-}
-
 static struct platform_driver tegra124_cpufreq_platdrv = {
 	.driver.name	= "cpufreq-tegra124",
 	.probe		= tegra124_cpufreq_probe,
-	.remove		= tegra124_cpufreq_remove,
 };
 
 static int __init tegra_cpufreq_init(void)
-- 
2.20.1
