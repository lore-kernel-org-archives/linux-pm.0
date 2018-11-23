From: Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 3/7] ata: ahci: mvebu: do Armada 38x configuration only on
 relevant SoCs
Date: Fri, 23 Nov 2018 11:15:52 +0100
Message-ID: <20181123101556.29888-4-miquel.raynal@bootlin.com>
References: <20181123101556.29888-1-miquel.raynal@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20181123101556.29888-1-miquel.raynal@bootlin.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Gregory Clement <gregory.clement@bootlin.com>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jens Axboe <axboe@kernel.dk>, Hans de Goede <hdegoede@redhat.com>
Cc: devicetree@vger.kernel.org, linux-pm@vger.kernel.org, Antoine Tenart <antoine.tenart@bootlin.com>, Maxime Chevallier <maxime.chevallier@bootlin.com>, Nadav Haklai <nadavh@marvell.com>, linux-ide@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Miquel Raynal <miquel.raynal@bootlin.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

At the beginning, only Armada 38x SoCs where supported by the
ahci_mvebu.c driver. Commit 15d3ce7b63bd ("ata: ahci_mvebu: add
support for Armada 3700 variant") introduced Armada 3700 support. As
opposed to Armada 38x SoCs, the 3700 variants do not have to configure
mbus and the regret option. This patch took care of avoiding such
configuration when not needed in the probe function, but failed to do
the same in the resume path. While doing so looks harmless by
experience, let's clean the driver logic and avoid doing this useless
configuration with Armada 3700 SoCs.

Because the logic is very similar between these two places, it has
been decided to factorize this code and put it in a "Armada 38x
configuration function". This function is part of a new
(per-compatible) platform data structure, so that the addition of such
configuration function for Armada 3700 will be eased.

Fixes: 15d3ce7b63bd ("ata: ahci_mvebu: add support for Armada 3700 variant")
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/ata/ahci_mvebu.c | 66 +++++++++++++++++++++++++++++-----------
 1 file changed, 49 insertions(+), 17 deletions(-)

diff --git a/drivers/ata/ahci_mvebu.c b/drivers/ata/ahci_mvebu.c
index 128d6f22926d..a1fce848bba9 100644
--- a/drivers/ata/ahci_mvebu.c
+++ b/drivers/ata/ahci_mvebu.c
@@ -28,6 +28,10 @@
 #define AHCI_WINDOW_BASE(win)	(0x64 + ((win) << 4))
 #define AHCI_WINDOW_SIZE(win)	(0x68 + ((win) << 4))
 
+struct ahci_mvebu_plat_data {
+	int (*plat_config)(struct ahci_host_priv *hpriv);
+};
+
 static void ahci_mvebu_mbus_config(struct ahci_host_priv *hpriv,
 				   const struct mbus_dram_target_info *dram)
 {
@@ -62,6 +66,22 @@ static void ahci_mvebu_regret_option(struct ahci_host_priv *hpriv)
 	writel(0x80, hpriv->mmio + AHCI_VENDOR_SPECIFIC_0_DATA);
 }
 
+static int ahci_mvebu_armada_380_config(struct ahci_host_priv *hpriv)
+{
+	const struct mbus_dram_target_info *dram;
+	int rc = 0;
+
+	dram = mv_mbus_dram_info();
+	if (dram)
+		ahci_mvebu_mbus_config(hpriv, dram);
+	else
+		rc = -ENODEV;
+
+	ahci_mvebu_regret_option(hpriv);
+
+	return rc;
+}
+
 /**
  * ahci_mvebu_stop_engine
  *
@@ -126,13 +146,10 @@ static int ahci_mvebu_resume(struct platform_device *pdev)
 {
 	struct ata_host *host = platform_get_drvdata(pdev);
 	struct ahci_host_priv *hpriv = host->private_data;
-	const struct mbus_dram_target_info *dram;
+	const struct ahci_mvebu_plat_data *pdata = hpriv->plat_data;
 
-	dram = mv_mbus_dram_info();
-	if (dram)
-		ahci_mvebu_mbus_config(hpriv, dram);
-
-	ahci_mvebu_regret_option(hpriv);
+	if (pdata->plat_config)
+		pdata->plat_config(hpriv);
 
 	return ahci_platform_resume_host(&pdev->dev);
 }
@@ -154,28 +171,29 @@ static struct scsi_host_template ahci_platform_sht = {
 
 static int ahci_mvebu_probe(struct platform_device *pdev)
 {
+	const struct ahci_mvebu_plat_data *pdata;
 	struct ahci_host_priv *hpriv;
-	const struct mbus_dram_target_info *dram;
 	int rc;
 
 	hpriv = ahci_platform_get_resources(pdev, 0);
 	if (IS_ERR(hpriv))
 		return PTR_ERR(hpriv);
 
+	hpriv->plat_data = (void *)of_device_get_match_data(&pdev->dev);
+	if (!hpriv->plat_data)
+		return -EINVAL;
+
 	rc = ahci_platform_enable_resources(hpriv);
 	if (rc)
 		return rc;
 
 	hpriv->stop_engine = ahci_mvebu_stop_engine;
 
-	if (of_device_is_compatible(pdev->dev.of_node,
-				    "marvell,armada-380-ahci")) {
-		dram = mv_mbus_dram_info();
-		if (!dram)
-			return -ENODEV;
-
-		ahci_mvebu_mbus_config(hpriv, dram);
-		ahci_mvebu_regret_option(hpriv);
+	pdata = hpriv->plat_data;
+	if (pdata->plat_config) {
+		rc = pdata->plat_config(hpriv);
+		if (rc)
+			goto disable_resources;
 	}
 
 	rc = ahci_platform_init_host(pdev, hpriv, &ahci_mvebu_port_info,
@@ -190,9 +208,23 @@ static int ahci_mvebu_probe(struct platform_device *pdev)
 	return rc;
 }
 
+static const struct ahci_mvebu_plat_data ahci_mvebu_armada_380_plat_data = {
+	.plat_config = ahci_mvebu_armada_380_config,
+};
+
+static const struct ahci_mvebu_plat_data ahci_mvebu_armada_3700_plat_data = {
+	.plat_config = NULL,
+};
+
 static const struct of_device_id ahci_mvebu_of_match[] = {
-	{ .compatible = "marvell,armada-380-ahci", },
-	{ .compatible = "marvell,armada-3700-ahci", },
+	{
+		.compatible = "marvell,armada-380-ahci",
+		.data = &ahci_mvebu_armada_380_plat_data,
+	},
+	{
+		.compatible = "marvell,armada-3700-ahci",
+		.data = &ahci_mvebu_armada_3700_plat_data,
+	},
 	{ },
 };
 MODULE_DEVICE_TABLE(of, ahci_mvebu_of_match);
-- 
2.19.1
