From: Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH V3 10/19] drm/tegra: dc: Prepare for generic PM domains
Date: Mon, 13 Jul 2015 13:39:48 +0100
Message-ID: <1436791197-32358-11-git-send-email-jonathanh@nvidia.com>
References: <1436791197-32358-1-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hqemgate14.nvidia.com ([216.228.121.143]:11225 "EHLO
	hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751031AbbGMMkz (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 13 Jul 2015 08:40:55 -0400
In-Reply-To: <1436791197-32358-1-git-send-email-jonathanh@nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, Philipp Zabel <p.zabel@pengutronix.de>, Peter De Schrijver <pdeschrijver@nvidia.com>, Prashant Gaikwad <pgaikwad@nvidia.com>, =?UTF-8?q?Terje=20Bergstr=C3=B6m?= <tbergstrom@nvidia.com>, Hans de Goede <hdegoede@redhat.com>, Tejun Heo <tj@kernel.org>
Cc: Vince Hsu <vinceh@nvidia.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, linux-tegra@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, Jon Hunter <jonathanh@nvidia.com>

Add support to the tegra dc driver for generic PM domains. However,
to ensure backward compatibility with older device tree blobs ensure
that the driver can work with or without generic PM domains. In order
to migrate to generic PM domain infrastructure the necessary changes
are:

1. If the "power-domains" property is present in the DT device node then
   generic PM domains is supported and pm_runtime_enable() should be
   called for the device. Furthermore, the enabling and disabling of the
   power-domain is handled via calling pm_runtime_get/put, respectively.

2. To ensure that clocks are managed consistently when generic PM domains
   are used and are not used, drivers should be migrated to use the
   tegra_powergate_power_on_legacy() and tegra_powergate_power_off_legacy()
   functions instead of the current tegra_powergate_sequence_power_up()
   and tegra_powergate_power_off(). The purpose of the
   tegra_powergate_power_on_legacy() and tegra_powergate_power_off_legacy()
   APIs is to mimick the behaviour of the tegra generic power-domain code,
   such that if generic power domains are not supported the functionality
   is the same.

3. The main difference between the tegra_powergate_sequence_power_up() API
   and the tegra_powergate_power_on_legacy() is that the clock used to
   enable the powergate is not kept enabled when using the
   tegra_powergate_power_on_legacy() API. Therefore, drivers must enable
   the clocks they need after calling tegra_powergate_power_on_legacy()
   and disable these clocks before calling
   tegra_powergate_power_off_legacy().

Helper functions have been added to the dc driver for handling power on
and off the power-domains with and without generic PM domain support.

Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
 drivers/gpu/drm/tegra/dc.c | 94 +++++++++++++++++++++++++++++-----------------
 1 file changed, 59 insertions(+), 35 deletions(-)

diff --git a/drivers/gpu/drm/tegra/dc.c b/drivers/gpu/drm/tegra/dc.c
index a287e4fec865..a5b2475a7b9c 100644
--- a/drivers/gpu/drm/tegra/dc.c
+++ b/drivers/gpu/drm/tegra/dc.c
@@ -10,6 +10,7 @@
 #include <linux/clk.h>
 #include <linux/debugfs.h>
 #include <linux/iommu.h>
+#include <linux/pm_runtime.h>
 #include <linux/reset.h>
 
 #include <soc/tegra/pmc.h>
@@ -1880,6 +1881,49 @@ static int tegra_dc_parse_dt(struct tegra_dc *dc)
 	return 0;
 }
 
+static void tegra_dc_power_off(struct tegra_dc *dc)
+{
+	if (!dc->soc->has_powergate)
+		reset_control_assert(dc->rst);
+
+	clk_disable_unprepare(dc->clk);
+
+	if (dc->soc->has_powergate) {
+		if (pm_runtime_enabled(dc->dev))
+			pm_runtime_put_sync(dc->dev);
+		else
+			tegra_powergate_power_off_legacy(dc->powergate,
+							 dc->clk, dc->rst);
+	}
+}
+
+static int tegra_dc_power_on(struct tegra_dc *dc)
+{
+	int err;
+
+	if (dc->soc->has_powergate) {
+		if (pm_runtime_enabled(dc->dev))
+			err = pm_runtime_get_sync(dc->dev);
+		else
+			err = tegra_powergate_power_on_legacy(dc->powergate,
+							      dc->clk, dc->rst);
+		if (err < 0) {
+			dev_err(dc->dev, "failed to power partition: %d\n",
+				err);
+			return err;
+		}
+	}
+
+	err = clk_prepare_enable(dc->clk);
+	if (err < 0)
+		dev_err(dc->dev, "failed to enable clock: %d\n", err);
+
+	if (!dc->soc->has_powergate)
+		reset_control_deassert(dc->rst);
+
+	return err;
+}
+
 static int tegra_dc_probe(struct platform_device *pdev)
 {
 	unsigned long flags = HOST1X_SYNCPT_CLIENT_MANAGED;
@@ -1917,35 +1961,6 @@ static int tegra_dc_probe(struct platform_device *pdev)
 		return PTR_ERR(dc->rst);
 	}
 
-	if (dc->soc->has_powergate) {
-		if (dc->pipe == 0)
-			dc->powergate = TEGRA_POWERGATE_DIS;
-		else
-			dc->powergate = TEGRA_POWERGATE_DISB;
-
-		err = tegra_powergate_sequence_power_up(dc->powergate, dc->clk,
-							dc->rst);
-		if (err < 0) {
-			dev_err(&pdev->dev, "failed to power partition: %d\n",
-				err);
-			return err;
-		}
-	} else {
-		err = clk_prepare_enable(dc->clk);
-		if (err < 0) {
-			dev_err(&pdev->dev, "failed to enable clock: %d\n",
-				err);
-			return err;
-		}
-
-		err = reset_control_deassert(dc->rst);
-		if (err < 0) {
-			dev_err(&pdev->dev, "failed to deassert reset: %d\n",
-				err);
-			return err;
-		}
-	}
-
 	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	dc->regs = devm_ioremap_resource(&pdev->dev, regs);
 	if (IS_ERR(dc->regs))
@@ -1961,6 +1976,20 @@ static int tegra_dc_probe(struct platform_device *pdev)
 	dc->client.ops = &dc_client_ops;
 	dc->client.dev = &pdev->dev;
 
+	if (dc->soc->has_powergate) {
+		if (dc->pipe == 0)
+			dc->powergate = TEGRA_POWERGATE_DIS;
+		else
+			dc->powergate = TEGRA_POWERGATE_DISB;
+
+		if (of_property_read_bool(pdev->dev.of_node, "power-domains"))
+			pm_runtime_enable(&pdev->dev);
+	}
+
+	err = tegra_dc_power_on(dc);
+	if (err < 0)
+		return err;
+
 	err = tegra_dc_rgb_probe(dc);
 	if (err < 0 && err != -ENODEV) {
 		dev_err(&pdev->dev, "failed to probe RGB output: %d\n", err);
@@ -2003,12 +2032,7 @@ static int tegra_dc_remove(struct platform_device *pdev)
 		return err;
 	}
 
-	reset_control_assert(dc->rst);
-
-	if (dc->soc->has_powergate)
-		tegra_powergate_power_off(dc->powergate);
-
-	clk_disable_unprepare(dc->clk);
+	tegra_dc_power_off(dc);
 
 	return 0;
 }
-- 
2.1.4

