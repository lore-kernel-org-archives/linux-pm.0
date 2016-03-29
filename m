From: Wei Ni <wni@nvidia.com>
Subject: [PATCH V9 RESEND 10/14] thermal: tegra: handle clocks in one function
Date: Tue, 29 Mar 2016 18:29:20 +0800
Message-ID: <1459247364-1139-11-git-send-email-wni@nvidia.com>
References: <1459247364-1139-1-git-send-email-wni@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from nat-hk.nvidia.com ([203.18.50.4]:11641 "EHLO
	hkmmgate102.nvidia.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756386AbcC2Kdh (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 29 Mar 2016 06:33:37 -0400
In-Reply-To: <1459247364-1139-1-git-send-email-wni@nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: edubezval@gmail.com, rui.zhang@intel.com, thierry.reding@gmail.com
Cc: MLongnecker@nvidia.com, swarren@wwwdotorg.org, mikko.perttunen@kapsi.fi, linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Wei Ni <wni@nvidia.com>

Handle clock enable/disable codes in one function
soctherm_clk_enable(), so that the codes are more clear.

Signed-off-by: Wei Ni <wni@nvidia.com>
---
 drivers/thermal/tegra/soctherm.c | 51 ++++++++++++++++++++++++++++------------
 1 file changed, 36 insertions(+), 15 deletions(-)

diff --git a/drivers/thermal/tegra/soctherm.c b/drivers/thermal/tegra/soctherm.c
index 365b45213327..deeb3b7e4dac 100644
--- a/drivers/thermal/tegra/soctherm.c
+++ b/drivers/thermal/tegra/soctherm.c
@@ -428,6 +428,39 @@ static void soctherm_debug_init(struct platform_device *pdev)
 static inline void soctherm_debug_init(struct platform_device *pdev) {}
 #endif
 
+static int soctherm_clk_enable(struct platform_device *pdev, bool enable)
+{
+	struct tegra_soctherm *tegra = platform_get_drvdata(pdev);
+	int err;
+
+	if (!tegra->clock_soctherm || !tegra->clock_tsensor)
+		return -EINVAL;
+
+	reset_control_assert(tegra->reset);
+
+	if (enable) {
+		err = clk_prepare_enable(tegra->clock_soctherm);
+		if (err) {
+			reset_control_deassert(tegra->reset);
+			return err;
+		}
+
+		err = clk_prepare_enable(tegra->clock_tsensor);
+		if (err) {
+			clk_disable_unprepare(tegra->clock_soctherm);
+			reset_control_deassert(tegra->reset);
+			return err;
+		}
+	} else {
+		clk_disable_unprepare(tegra->clock_tsensor);
+		clk_disable_unprepare(tegra->clock_soctherm);
+	}
+
+	reset_control_deassert(tegra->reset);
+
+	return 0;
+}
+
 static const struct of_device_id tegra_soctherm_of_match[] = {
 #ifdef CONFIG_ARCH_TEGRA_124_SOC
 	{
@@ -496,20 +529,10 @@ static int tegra_soctherm_probe(struct platform_device *pdev)
 		return PTR_ERR(tegra->clock_soctherm);
 	}
 
-	reset_control_assert(tegra->reset);
-
-	err = clk_prepare_enable(tegra->clock_soctherm);
+	err = soctherm_clk_enable(pdev, true);
 	if (err)
 		return err;
 
-	err = clk_prepare_enable(tegra->clock_tsensor);
-	if (err) {
-		clk_disable_unprepare(tegra->clock_soctherm);
-		return err;
-	}
-
-	reset_control_deassert(tegra->reset);
-
 	/* Initialize raw sensors */
 
 	tegra->calib = devm_kzalloc(&pdev->dev,
@@ -579,8 +602,7 @@ static int tegra_soctherm_probe(struct platform_device *pdev)
 	return 0;
 
 disable_clocks:
-	clk_disable_unprepare(tegra->clock_tsensor);
-	clk_disable_unprepare(tegra->clock_soctherm);
+	soctherm_clk_enable(pdev, false);
 
 	return err;
 }
@@ -591,8 +613,7 @@ static int tegra_soctherm_remove(struct platform_device *pdev)
 
 	debugfs_remove_recursive(tegra->debugfs_dir);
 
-	clk_disable_unprepare(tegra->clock_tsensor);
-	clk_disable_unprepare(tegra->clock_soctherm);
+	soctherm_clk_enable(pdev, false);
 
 	return 0;
 }
-- 
1.9.1

