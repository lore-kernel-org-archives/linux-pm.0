From: Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH V3 13/19] drm/tegra: gr3d: Add support for generic PM domains
Date: Mon, 13 Jul 2015 13:39:51 +0100
Message-ID: <1436791197-32358-14-git-send-email-jonathanh@nvidia.com>
References: <1436791197-32358-1-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hqemgate16.nvidia.com ([216.228.121.65]:8474 "EHLO
	hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751934AbbGMMlG (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 13 Jul 2015 08:41:06 -0400
In-Reply-To: <1436791197-32358-1-git-send-email-jonathanh@nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, Philipp Zabel <p.zabel@pengutronix.de>, Peter De Schrijver <pdeschrijver@nvidia.com>, Prashant Gaikwad <pgaikwad@nvidia.com>, =?UTF-8?q?Terje=20Bergstr=C3=B6m?= <tbergstrom@nvidia.com>, Hans de Goede <hdegoede@redhat.com>, Tejun Heo <tj@kernel.org>
Cc: Vince Hsu <vinceh@nvidia.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, linux-tegra@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, Jon Hunter <jonathanh@nvidia.com>

Add support to the tegra gr3d driver for generic PM domains. However,
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

Helper functions have been added to the gr3d driver for handling power on
and off the power-domains with and without generic PM domain support.

Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
 drivers/gpu/drm/tegra/gr3d.c | 57 ++++++++++++++++++++++++++++++++++++++------
 1 file changed, 50 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/tegra/gr3d.c b/drivers/gpu/drm/tegra/gr3d.c
index 0b3f2b977ba0..43a9d50e7e44 100644
--- a/drivers/gpu/drm/tegra/gr3d.c
+++ b/drivers/gpu/drm/tegra/gr3d.c
@@ -11,6 +11,7 @@
 #include <linux/host1x.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/reset.h>
 
 #include <soc/tegra/pmc.h>
@@ -238,6 +239,32 @@ static const u32 gr3d_addr_regs[] = {
 	GR3D_GLOBAL_SAMP23SURFADDR(15),
 };
 
+static int gr3d_powergate_on(struct platform_device *pdev, int powergate_id,
+			     struct clk *clk, struct reset_control *rst)
+{
+	int err;
+
+	if (pm_runtime_enabled(&pdev->dev))
+		err = pm_runtime_get_sync(&pdev->dev);
+	else
+		err = tegra_powergate_power_on_legacy(powergate_id,
+						      clk, rst);
+	return err;
+}
+
+static int gr3d_powergate_off(struct platform_device *pdev, int powergate_id,
+			      struct clk *clk, struct reset_control *rst)
+{
+	int err;
+
+	if (pm_runtime_enabled(&pdev->dev))
+		err = pm_runtime_put_sync(&pdev->dev);
+	else
+		err = tegra_powergate_power_off_legacy(powergate_id,
+						       clk, rst);
+	return err;
+}
+
 static int gr3d_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
@@ -281,22 +308,37 @@ static int gr3d_probe(struct platform_device *pdev)
 		}
 	}
 
-	err = tegra_powergate_sequence_power_up(TEGRA_POWERGATE_3D, gr3d->clk,
-						gr3d->rst);
+	if (of_property_read_bool(pdev->dev.of_node, "power-domains"))
+		pm_runtime_enable(&pdev->dev);
+
+	err = gr3d_powergate_on(pdev, TEGRA_POWERGATE_3D, gr3d->clk, gr3d->rst);
 	if (err < 0) {
 		dev_err(&pdev->dev, "failed to power up 3D unit\n");
 		return err;
 	}
 
+	err = clk_prepare_enable(gr3d->clk);
+	if (err < 0) {
+		dev_err(&pdev->dev, "failed to enable 3D unit clock\n");
+		return err;
+	}
+
 	if (gr3d->clk_secondary) {
-		err = tegra_powergate_sequence_power_up(TEGRA_POWERGATE_3D1,
-							gr3d->clk_secondary,
-							gr3d->rst_secondary);
+		err = gr3d_powergate_on(pdev, TEGRA_POWERGATE_3D1,
+					gr3d->clk_secondary,
+					gr3d->rst_secondary);
 		if (err < 0) {
 			dev_err(&pdev->dev,
 				"failed to power up secondary 3D unit\n");
 			return err;
 		}
+
+		err = clk_prepare_enable(gr3d->clk_secondary);
+		if (err < 0) {
+			dev_err(&pdev->dev,
+				"failed to enable secondary 3D unit clock\n");
+			return err;
+		}
 	}
 
 	INIT_LIST_HEAD(&gr3d->client.base.list);
@@ -338,12 +380,13 @@ static int gr3d_remove(struct platform_device *pdev)
 	}
 
 	if (gr3d->clk_secondary) {
-		tegra_powergate_power_off(TEGRA_POWERGATE_3D1);
 		clk_disable_unprepare(gr3d->clk_secondary);
+		gr3d_powergate_off(pdev, TEGRA_POWERGATE_3D1,
+				   gr3d->clk_secondary, gr3d->rst_secondary);
 	}
 
-	tegra_powergate_power_off(TEGRA_POWERGATE_3D);
 	clk_disable_unprepare(gr3d->clk);
+	gr3d_powergate_off(pdev, TEGRA_POWERGATE_3D, gr3d->clk, gr3d->rst);
 
 	return 0;
 }
-- 
2.1.4

