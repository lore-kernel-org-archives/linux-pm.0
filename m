From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V10 6/7] mmc: sdhci-msm: Adapt the driver to use OPPs to set clocks/performance state
Date: Tue, 19 Sep 2017 15:32:22 -0700
Message-ID: <a68f6fab6c90a13ffb2e565599ceeeae6c51aa35.1505859768.git.viresh.kumar@linaro.org>
References: <cover.1505859768.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f54.google.com ([74.125.83.54]:53637 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751710AbdISWcr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 19 Sep 2017 18:32:47 -0400
Received: by mail-pg0-f54.google.com with SMTP id j70so600673pgc.10
        for <linux-pm@vger.kernel.org>; Tue, 19 Sep 2017 15:32:46 -0700 (PDT)
In-Reply-To: <cover.1505859768.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1505859768.git.viresh.kumar@linaro.org>
References: <cover.1505859768.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, ulf.hansson@linaro.org, Kevin Hilman <khilman@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, Nishanth Menon <nm@ti.com>, robh+dt@kernel.org, lina.iyer@linaro.org, rnayak@codeaurora.org, sudeep.holla@arm.com, linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Andy Gross <andy.gross@linaro.org>, David Brown <david.brown@linaro.org>

From: Rajendra Nayak <rnayak@codeaurora.org>

THIS IS TEST CODE, SHOULDN'T BE MERGED.

SDHCI driver needs to set a performance state along with scaling its
clocks. Modify the driver to use the newly introducded powerdomain
performance state based OPPs to scale clocks as well as set an
appropriate powerdomain performance state.

The patch also adds OPPs for sdhci device on msm8996.

The changes have to be validated by populating similar OPP tables
on all other devices which use the sdhci driver. This is for now
validated only on msm8996 and with missing OPP tables for other
devices is known to break those platforms.

Not-signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
Not-signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8996.dtsi | 34 ++++++++++++++++++++++++++++++
 drivers/clk/qcom/gcc-msm8996.c        |  8 +++----
 drivers/mmc/host/sdhci-msm.c          | 39 ++++++++++++++++++++++++++---------
 3 files changed, 67 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index 0be1db559d61..71183c009c58 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -515,8 +515,42 @@
 			 <&gcc GCC_SDCC2_APPS_CLK>,
 			 <&xo_board>;
 			 bus-width = <4>;
+			power-domains = <&rpmpd 0>;
+			operating-points-v2 = <&sdhc_opp_table>;
 		 };
 
+		sdhc_opp_table: opp_table {
+			compatible = "operating-points-v2";
+
+			opp@400000 {
+				opp-hz = /bits/ 64 <400000>;
+			};
+
+			opp@20000000 {
+				opp-hz = /bits/ 64 <20000000>;
+			};
+
+			opp@25000000 {
+				opp-hz = /bits/ 64 <25000000>;
+			};
+
+			opp@50000000 {
+				opp-hz = /bits/ 64 <50000000>;
+			};
+
+			opp@96000000 {
+				opp-hz = /bits/ 64 <96000000>;
+			};
+
+			opp@192000000 {
+				opp-hz = /bits/ 64 <192000000>;
+			};
+
+			opp@384000000 {
+				opp-hz = /bits/ 64 <384000000>;
+			};
+		};
+
 		msmgpio: pinctrl@1010000 {
 			compatible = "qcom,msm8996-pinctrl";
 			reg = <0x01010000 0x300000>;
diff --git a/drivers/clk/qcom/gcc-msm8996.c b/drivers/clk/qcom/gcc-msm8996.c
index 7ddec886fcd3..38034692f5aa 100644
--- a/drivers/clk/qcom/gcc-msm8996.c
+++ b/drivers/clk/qcom/gcc-msm8996.c
@@ -460,7 +460,7 @@ static struct clk_rcg2 sdcc1_apps_clk_src = {
 		.name = "sdcc1_apps_clk_src",
 		.parent_names = gcc_xo_gpll0_gpll4_gpll0_early_div,
 		.num_parents = 4,
-		.ops = &clk_rcg2_floor_ops,
+		.ops = &clk_rcg2_ops,
 	},
 };
 
@@ -505,7 +505,7 @@ static struct clk_rcg2 sdcc2_apps_clk_src = {
 		.name = "sdcc2_apps_clk_src",
 		.parent_names = gcc_xo_gpll0_gpll4,
 		.num_parents = 3,
-		.ops = &clk_rcg2_floor_ops,
+		.ops = &clk_rcg2_ops,
 	},
 };
 
@@ -519,7 +519,7 @@ static struct clk_rcg2 sdcc3_apps_clk_src = {
 		.name = "sdcc3_apps_clk_src",
 		.parent_names = gcc_xo_gpll0_gpll4,
 		.num_parents = 3,
-		.ops = &clk_rcg2_floor_ops,
+		.ops = &clk_rcg2_ops,
 	},
 };
 
@@ -543,7 +543,7 @@ static struct clk_rcg2 sdcc4_apps_clk_src = {
 		.name = "sdcc4_apps_clk_src",
 		.parent_names = gcc_xo_gpll0,
 		.num_parents = 2,
-		.ops = &clk_rcg2_floor_ops,
+		.ops = &clk_rcg2_ops,
 	},
 };
 
diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index fc73e56eb1e2..cbc5a12af772 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -21,6 +21,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/slab.h>
 #include <linux/iopoll.h>
+#include <linux/pm_opp.h>
 
 #include "sdhci-pltfm.h"
 
@@ -131,6 +132,7 @@ struct sdhci_msm_host {
 	struct clk *pclk;	/* SDHC peripheral bus clock */
 	struct clk *bus_clk;	/* SDHC bus voter clock */
 	struct clk *xo_clk;	/* TCXO clk needed for FLL feature of cm_dll*/
+	struct opp_table *opp_table;
 	unsigned long clk_rate;
 	struct mmc_host *mmc;
 	bool use_14lpp_dll_reset;
@@ -140,7 +142,7 @@ struct sdhci_msm_host {
 	bool use_cdclp533;
 };
 
-static unsigned int msm_get_clock_rate_for_bus_mode(struct sdhci_host *host,
+static long unsigned int msm_get_clock_rate_for_bus_mode(struct sdhci_host *host,
 						    unsigned int clock)
 {
 	struct mmc_ios ios = host->mmc->ios;
@@ -165,16 +167,22 @@ static void msm_set_clock_rate_for_bus_mode(struct sdhci_host *host,
 	struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
 	struct mmc_ios curr_ios = host->mmc->ios;
 	int rc;
+	struct device *dev = &msm_host->pdev->dev;
+	struct dev_pm_opp *opp;
+	long unsigned int freq;
+
+	freq = msm_get_clock_rate_for_bus_mode(host, clock);
+	opp = dev_pm_opp_find_freq_floor(dev, &freq);
+	if (IS_ERR(opp))
+		pr_err("%s: failed to find OPP for %u at timing %d\n",
+				mmc_hostname(host->mmc), clock, curr_ios.timing);
+
+	rc = dev_pm_opp_set_rate(dev, freq);
+	if (rc)
+		pr_err("%s: error in setting opp\n", __func__);
+
+	msm_host->clk_rate = freq;
 
-	clock = msm_get_clock_rate_for_bus_mode(host, clock);
-	rc = clk_set_rate(msm_host->clk, clock);
-	if (rc) {
-		pr_err("%s: Failed to set clock at rate %u at timing %d\n",
-		       mmc_hostname(host->mmc), clock,
-		       curr_ios.timing);
-		return;
-	}
-	msm_host->clk_rate = clock;
 	pr_debug("%s: Setting clock at rate %lu at timing %d\n",
 		 mmc_hostname(host->mmc), clk_get_rate(msm_host->clk),
 		 curr_ios.timing);
@@ -1268,6 +1276,13 @@ static int sdhci_msm_probe(struct platform_device *pdev)
 		goto clk_disable;
 	}
 
+	/* Set up the OPP table */
+	msm_host->opp_table = dev_pm_opp_set_clkname(&pdev->dev, "core");
+
+	ret = dev_pm_opp_of_add_table(&pdev->dev);
+	if (ret)
+		dev_warn(&pdev->dev, "%s: No OPP table specified\n", __func__);
+
 	pm_runtime_get_noresume(&pdev->dev);
 	pm_runtime_set_active(&pdev->dev);
 	pm_runtime_enable(&pdev->dev);
@@ -1289,6 +1304,8 @@ static int sdhci_msm_probe(struct platform_device *pdev)
 	pm_runtime_disable(&pdev->dev);
 	pm_runtime_set_suspended(&pdev->dev);
 	pm_runtime_put_noidle(&pdev->dev);
+	dev_pm_opp_of_remove_table(&pdev->dev);
+	dev_pm_opp_put_clkname(msm_host->opp_table);
 clk_disable:
 	clk_disable_unprepare(msm_host->clk);
 pclk_disable:
@@ -1314,6 +1331,8 @@ static int sdhci_msm_remove(struct platform_device *pdev)
 	pm_runtime_get_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 	pm_runtime_put_noidle(&pdev->dev);
+	dev_pm_opp_of_remove_table(&pdev->dev);
+	dev_pm_opp_put_clkname(msm_host->opp_table);
 
 	clk_disable_unprepare(msm_host->clk);
 	clk_disable_unprepare(msm_host->pclk);
-- 
2.7.4
