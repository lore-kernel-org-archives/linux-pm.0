From: David Wu <david.wu@rock-chips.com>
Subject: [PATCH] PM / AVS: rockchip-io: add io selectors and supplies for rk3399
Date: Wed, 16 Mar 2016 02:45:26 +0800
Message-ID: <1458067526-11319-1-git-send-email-david.wu@rock-chips.com>
Content-Type: text/plain; charset="utf-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.132]:57014 "EHLO
	lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966454AbcCPKjU (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 16 Mar 2016 06:39:20 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: khilman@kernel.org, heiko@sntech.de
Cc: nm@ti.com, huangtao@rock-chips.com, cf@rock-chips.com, zyw@rock-chips.com, xjq@rock-chips.com, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, David Wu <david.wu@rock-chips.com>

This adds the necessary data for handling io voltage domains on the rk3399.
As interesting tidbit, the rk3399 contains two separate iodomain areas.
One in the regular General Register Files (GRF) and one in PMUGRF in the
pmu power domain.

Signed-off-by: David Wu <david.wu@rock-chips.com>
---
 .../bindings/power/rockchip-io-domain.txt          | 11 ++++
 drivers/power/avs/rockchip-io-domain.c             | 58 ++++++++++++++++++++++
 2 files changed, 69 insertions(+)
 mode change 100644 => 100755 drivers/power/avs/rockchip-io-domain.c

diff --git a/Documentation/devicetree/bindings/power/rockchip-io-domain.txt b/Documentation/devicetree/bindings/power/rockchip-io-domain.txt
index b8627e7..c84fb47 100644
--- a/Documentation/devicetree/bindings/power/rockchip-io-domain.txt
+++ b/Documentation/devicetree/bindings/power/rockchip-io-domain.txt
@@ -35,6 +35,8 @@ Required properties:
   - "rockchip,rk3288-io-voltage-domain" for rk3288
   - "rockchip,rk3368-io-voltage-domain" for rk3368
   - "rockchip,rk3368-pmu-io-voltage-domain" for rk3368 pmu-domains
+  - "rockchip,rk3399-io-voltage-domain" for rk3399
+  - "rockchip,rk3399-pmu-io-voltage-domain" for rk3399 pmu-domains
 - rockchip,grf: phandle to the syscon managing the "general register files"
 
 
@@ -79,6 +81,15 @@ Possible supplies for rk3368 pmu-domains:
 - pmu-supply:    The supply connected to PMUIO_VDD.
 - vop-supply:    The supply connected to LCDC_VDD.
 
+Possible supplies for rk3399:
+- bt656-supply:  The supply connected to APIO2_VDD.
+- audio-supply:  The supply connected to APIO5_VDD.
+- sdmmc-supply:  The supply connected to SDMMC0_VDD.
+- gpio1830       The supply connected to APIO4_VDD.
+
+Possible supplies for rk3399 pmu-domains:
+- pmu1830-supply:The supply connected to PMUIO2_VDD.
+
 Example:
 
 	io-domains {
diff --git a/drivers/power/avs/rockchip-io-domain.c b/drivers/power/avs/rockchip-io-domain.c
old mode 100644
new mode 100755
index 8099456..8986382
--- a/drivers/power/avs/rockchip-io-domain.c
+++ b/drivers/power/avs/rockchip-io-domain.c
@@ -47,6 +47,10 @@
 #define RK3368_SOC_CON15_FLASH0		BIT(14)
 #define RK3368_SOC_FLASH_SUPPLY_NUM	2
 
+#define RK3399_PMUGRF_CON0		0x180
+#define RK3399_PMUGRF_CON0_VSEL		BIT(8)
+#define RK3399_PMUGRF_VSEL_SUPPLY_NUM	9
+
 struct rockchip_iodomain;
 
 /**
@@ -181,6 +185,25 @@ static void rk3368_iodomain_init(struct rockchip_iodomain *iod)
 		dev_warn(iod->dev, "couldn't update flash0 ctrl\n");
 }
 
+static void rk3399_pmu_iodomain_init(struct rockchip_iodomain *iod)
+{
+	int ret;
+	u32 val;
+
+	/* if no pmu io supply we should leave things alone */
+	if (!iod->supplies[RK3399_PMUGRF_VSEL_SUPPLY_NUM].reg)
+		return;
+
+	/*
+	 * set pmu io iodomain to also use this framework
+	 * instead of a special gpio.
+	 */
+	val = RK3399_PMUGRF_CON0_VSEL | (RK3399_PMUGRF_CON0_VSEL << 16);
+	ret = regmap_write(iod->grf, RK3399_PMUGRF_CON0, val);
+	if (ret < 0)
+		dev_warn(iod->dev, "couldn't update pmu io iodomain ctrl\n");
+}
+
 /*
  * On the rk3188 the io-domains are handled by a shared register with the
  * lower 8 bits being still being continuing drive-strength settings.
@@ -252,6 +275,33 @@ static const struct rockchip_iodomain_soc_data soc_data_rk3368_pmu = {
 	},
 };
 
+static const struct rockchip_iodomain_soc_data soc_data_rk3399 = {
+	.grf_offset = 0xe640,
+	.supply_names = {
+		"bt656",		/* APIO2_VDD */
+		"audio",		/* APIO5_VDD */
+		"sdmmc",		/* SDMMC0_VDD */
+		"gpio1830",		/* APIO4_VDD */
+	},
+};
+
+static const struct rockchip_iodomain_soc_data soc_data_rk3399_pmu = {
+	.grf_offset = 0x180,
+	.supply_names = {
+		NULL,
+		NULL,
+		NULL,
+		NULL,
+		NULL,
+		NULL,
+		NULL,
+		NULL,
+		NULL,
+		"pmu1830",		/* PMUIO2_VDD */
+	},
+	.init = rk3399_pmu_iodomain_init,
+};
+
 static const struct of_device_id rockchip_iodomain_match[] = {
 	{
 		.compatible = "rockchip,rk3188-io-voltage-domain",
@@ -269,6 +319,14 @@ static const struct of_device_id rockchip_iodomain_match[] = {
 		.compatible = "rockchip,rk3368-pmu-io-voltage-domain",
 		.data = (void *)&soc_data_rk3368_pmu
 	},
+	{
+		.compatible = "rockchip,rk3399-io-voltage-domain",
+		.data = (void *)&soc_data_rk3399
+	},
+	{
+		.compatible = "rockchip,rk3399-pmu-io-voltage-domain",
+		.data = (void *)&soc_data_rk3399_pmu
+	},
 	{ /* sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, rockchip_iodomain_match);
-- 
1.9.1


