From: David Wu <david.wu@rock-chips.com>
Subject: [PATCH] PM / AVS: rockchip-io: add io selectors and supplies for rk3328
Date: Mon, 20 Feb 2017 10:08:05 +0800
Message-ID: <1487556485-18871-1-git-send-email-david.wu@rock-chips.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.135]:35786 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751789AbdBTCGv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 19 Feb 2017 21:06:51 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: khilman@kernel.org, nm@ti.com, heiko@sntech.de
Cc: huangtao@rock-chips.com, linux-rockchip@lists.infradead.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, "david.wu" <david.wu@rock-chips.com>

From: "david.wu" <david.wu@rock-chips.com>

This adds the necessary data for handling io voltage domains on the rk3328.
As interesting tidbit, the rk3328 only contains one iodomain area in the
regular General Register Files (GRF).

Signed-off-by: david.wu <david.wu@rock-chips.com>
---
 .../bindings/power/rockchip-io-domain.txt          |  1 +
 drivers/power/avs/rockchip-io-domain.c             | 41 ++++++++++++++++++++++
 2 files changed, 42 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/rockchip-io-domain.txt b/Documentation/devicetree/bindings/power/rockchip-io-domain.txt
index d23dc00..d3a5a93 100644
--- a/Documentation/devicetree/bindings/power/rockchip-io-domain.txt
+++ b/Documentation/devicetree/bindings/power/rockchip-io-domain.txt
@@ -33,6 +33,7 @@ Required properties:
 - compatible: should be one of:
   - "rockchip,rk3188-io-voltage-domain" for rk3188
   - "rockchip,rk3288-io-voltage-domain" for rk3288
+  - "rockchip,rk3328-io-voltage-domain" for rk3328
   - "rockchip,rk3368-io-voltage-domain" for rk3368
   - "rockchip,rk3368-pmu-io-voltage-domain" for rk3368 pmu-domains
   - "rockchip,rk3399-io-voltage-domain" for rk3399
diff --git a/drivers/power/avs/rockchip-io-domain.c b/drivers/power/avs/rockchip-io-domain.c
index 56bce19..8581252 100644
--- a/drivers/power/avs/rockchip-io-domain.c
+++ b/drivers/power/avs/rockchip-io-domain.c
@@ -43,6 +43,10 @@
 #define RK3288_SOC_CON2_FLASH0		BIT(7)
 #define RK3288_SOC_FLASH_SUPPLY_NUM	2
 
+#define RK3328_SOC_CON4			0x410
+#define RK3328_SOC_CON4_VCCIO2		BIT(7)
+#define RK3328_SOC_VCCIO2_SUPPLY_NUM	1
+
 #define RK3368_SOC_CON15		0x43c
 #define RK3368_SOC_CON15_FLASH0		BIT(14)
 #define RK3368_SOC_FLASH_SUPPLY_NUM	2
@@ -166,6 +170,25 @@ static void rk3288_iodomain_init(struct rockchip_iodomain *iod)
 		dev_warn(iod->dev, "couldn't update flash0 ctrl\n");
 }
 
+static void rk3328_iodomain_init(struct rockchip_iodomain *iod)
+{
+	int ret;
+	u32 val;
+
+	/* if no vccio2 supply we should leave things alone */
+	if (!iod->supplies[RK3328_SOC_VCCIO2_SUPPLY_NUM].reg)
+		return;
+
+	/*
+	 * set vccio2 iodomain to also use this framework
+	 * instead of a special gpio.
+	 */
+	val = RK3328_SOC_CON4_VCCIO2 | (RK3328_SOC_CON4_VCCIO2 << 16);
+	ret = regmap_write(iod->grf, RK3328_SOC_CON4, val);
+	if (ret < 0)
+		dev_warn(iod->dev, "couldn't update vccio2 vsel ctrl\n");
+}
+
 static void rk3368_iodomain_init(struct rockchip_iodomain *iod)
 {
 	int ret;
@@ -247,6 +270,20 @@ static void rk3399_pmu_iodomain_init(struct rockchip_iodomain *iod)
 	.init = rk3288_iodomain_init,
 };
 
+static const struct rockchip_iodomain_soc_data soc_data_rk3328 = {
+	.grf_offset = 0x410,
+	.supply_names = {
+		"vccio1",
+		"vccio2",
+		"vccio3",
+		"vccio4",
+		"vccio5",
+		"vccio6",
+		"pmuio",
+	},
+	.init = rk3328_iodomain_init,
+};
+
 static const struct rockchip_iodomain_soc_data soc_data_rk3368 = {
 	.grf_offset = 0x900,
 	.supply_names = {
@@ -312,6 +349,10 @@ static void rk3399_pmu_iodomain_init(struct rockchip_iodomain *iod)
 		.data = (void *)&soc_data_rk3288
 	},
 	{
+		.compatible = "rockchip,rk3328-io-voltage-domain",
+		.data = (void *)&soc_data_rk3328
+	},
+	{
 		.compatible = "rockchip,rk3368-io-voltage-domain",
 		.data = (void *)&soc_data_rk3368
 	},
-- 
1.9.1
