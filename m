From: Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH V3 12/19] ata: ahci_tegra: Add support for generic PM domains
Date: Mon, 13 Jul 2015 13:39:50 +0100
Message-ID: <1436791197-32358-13-git-send-email-jonathanh@nvidia.com>
References: <1436791197-32358-1-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hqemgate15.nvidia.com ([216.228.121.64]:4709 "EHLO
	hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751693AbbGMMlC (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 13 Jul 2015 08:41:02 -0400
In-Reply-To: <1436791197-32358-1-git-send-email-jonathanh@nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, Philipp Zabel <p.zabel@pengutronix.de>, Peter De Schrijver <pdeschrijver@nvidia.com>, Prashant Gaikwad <pgaikwad@nvidia.com>, =?UTF-8?q?Terje=20Bergstr=C3=B6m?= <tbergstrom@nvidia.com>, Hans de Goede <hdegoede@redhat.com>, Tejun Heo <tj@kernel.org>
Cc: Vince Hsu <vinceh@nvidia.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, linux-tegra@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, Jon Hunter <jonathanh@nvidia.com>

Add support to the tegra AHCI driver for generic PM domains. However,
to ensure backward compatibility with older device tree blobs ensure
that the driver can work with or without generic PM domains. In order
to migrate to generic PM domain infrastructure the necessary changes
are:

1. If the "power-domains" property is present in the DT device node then
   generic PM domains is supported and the variable has_genpd should be
   set. The ahci_platform_get_resources()/put_resources() calls the
   appropriate pm_runtime functions and so no further changes are needed
   for rpm support.

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

The helper functions for handling the powering on and off of the AHCI
controller have been updated to support generic PM domains and the
following changes have been made:
a). The clocks for the AHCI controller are managed by
    the ahci_platform_enable_resources() and
    ahci_platform_disable_resources() and so the calls to
    clock_disable_unprepare() are not needed and can be removed.
b). The tegra->sata_rst is handled by the tegra powergate code and
    so does not need to be controlled by the driver.
c). AHCI controller resets should be applied before the clocks are
    disabled and so the call to ahci_platform_disable_resources()
    has been moved to after the reset assertion.

Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
 drivers/ata/ahci_tegra.c | 51 ++++++++++++++++++++++++++++++++++--------------
 1 file changed, 36 insertions(+), 15 deletions(-)

diff --git a/drivers/ata/ahci_tegra.c b/drivers/ata/ahci_tegra.c
index 3a62eb246d80..438849c15e0e 100644
--- a/drivers/ata/ahci_tegra.c
+++ b/drivers/ata/ahci_tegra.c
@@ -23,6 +23,7 @@
 #include <linux/module.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/regulator/consumer.h>
 #include <linux/reset.h>
 
@@ -108,6 +109,7 @@ struct tegra_ahci_priv {
 	/* Needs special handling, cannot use ahci_platform */
 	struct clk		   *sata_clk;
 	struct regulator_bulk_data supplies[5];
+	bool			   has_genpd;
 };
 
 static int tegra_ahci_power_on(struct ahci_host_priv *hpriv)
@@ -120,11 +122,13 @@ static int tegra_ahci_power_on(struct ahci_host_priv *hpriv)
 	if (ret)
 		return ret;
 
-	ret = tegra_powergate_sequence_power_up(TEGRA_POWERGATE_SATA,
-						tegra->sata_clk,
-						tegra->sata_rst);
-	if (ret)
-		goto disable_regulators;
+	if (!tegra->has_genpd) {
+		ret = tegra_powergate_power_on_legacy(TEGRA_POWERGATE_SATA,
+						      tegra->sata_clk,
+						      tegra->sata_rst);
+		if (ret)
+			goto disable_regulators;
+	}
 
 	reset_control_assert(tegra->sata_oob_rst);
 	reset_control_assert(tegra->sata_cold_rst);
@@ -139,9 +143,8 @@ static int tegra_ahci_power_on(struct ahci_host_priv *hpriv)
 	return 0;
 
 disable_power:
-	clk_disable_unprepare(tegra->sata_clk);
-
-	tegra_powergate_power_off(TEGRA_POWERGATE_SATA);
+	tegra_powergate_power_off_legacy(TEGRA_POWERGATE_SATA, tegra->sata_clk,
+					 tegra->sata_rst);
 
 disable_regulators:
 	regulator_bulk_disable(ARRAY_SIZE(tegra->supplies), tegra->supplies);
@@ -149,20 +152,27 @@ disable_regulators:
 	return ret;
 }
 
-static void tegra_ahci_power_off(struct ahci_host_priv *hpriv)
+static int tegra_ahci_power_off(struct ahci_host_priv *hpriv)
 {
 	struct tegra_ahci_priv *tegra = hpriv->plat_data;
+	int ret;
 
-	ahci_platform_disable_resources(hpriv);
-
-	reset_control_assert(tegra->sata_rst);
 	reset_control_assert(tegra->sata_oob_rst);
 	reset_control_assert(tegra->sata_cold_rst);
 
-	clk_disable_unprepare(tegra->sata_clk);
-	tegra_powergate_power_off(TEGRA_POWERGATE_SATA);
+	ahci_platform_disable_resources(hpriv);
+
+	if (!tegra->has_genpd) {
+		ret = tegra_powergate_power_off_legacy(TEGRA_POWERGATE_SATA,
+						       tegra->sata_clk,
+						       tegra->sata_rst);
+		if (ret)
+			return ret;
+	}
 
 	regulator_bulk_disable(ARRAY_SIZE(tegra->supplies), tegra->supplies);
+
+	return 0;
 }
 
 static int tegra_ahci_controller_init(struct ahci_host_priv *hpriv)
@@ -263,7 +273,15 @@ static int tegra_ahci_controller_init(struct ahci_host_priv *hpriv)
 
 static void tegra_ahci_controller_deinit(struct ahci_host_priv *hpriv)
 {
-	tegra_ahci_power_off(hpriv);
+	struct tegra_ahci_priv *tegra = hpriv->plat_data;
+	int ret;
+
+	ret = tegra_ahci_power_off(hpriv);
+
+	if (ret)
+		dev_err(&tegra->pdev->dev,
+			"failed to power off AHCI controller: %d\n", ret);
+
 }
 
 static void tegra_ahci_host_stop(struct ata_host *host)
@@ -356,6 +374,9 @@ static int tegra_ahci_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	if (of_property_read_bool(pdev->dev.of_node, "power-domains"))
+		tegra->has_genpd = true;
+
 	ret = tegra_ahci_controller_init(hpriv);
 	if (ret)
 		return ret;
-- 
2.1.4

