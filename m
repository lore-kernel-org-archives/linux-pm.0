From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Subject: [PATCH 2/2] PM / AVS: rockchip-io: add io selectors and supplies for rk3368
Date: Tue, 04 Aug 2015 21:37:01 +0200
Message-ID: <1481228.KhoIt654ID@diego>
References: <3371948.nX6iqYbHnA@diego>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3371948.nX6iqYbHnA@diego>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

This adds the necessary data for handling io voltage domains on the rk3368.
As interesting tidbit, the rk3368 contains two separate iodomain areas.
One in the regular General Register Files (GRF) and one in PMUGRF in the
pmu power domain.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 .../bindings/power/rockchip-io-domain.txt          | 14 +++++
 drivers/power/avs/rockchip-io-domain.c             | 59 ++++++++++++++++++++++
 2 files changed, 73 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/rockchip-io-domain.txt b/Documentation/devicetree/bindings/power/rockchip-io-domain.txt
index 8b70db1..b8627e7 100644
--- a/Documentation/devicetree/bindings/power/rockchip-io-domain.txt
+++ b/Documentation/devicetree/bindings/power/rockchip-io-domain.txt
@@ -33,6 +33,8 @@ Required properties:
 - compatible: should be one of:
   - "rockchip,rk3188-io-voltage-domain" for rk3188
   - "rockchip,rk3288-io-voltage-domain" for rk3288
+  - "rockchip,rk3368-io-voltage-domain" for rk3368
+  - "rockchip,rk3368-pmu-io-voltage-domain" for rk3368 pmu-domains
 - rockchip,grf: phandle to the syscon managing the "general register files"
 
 
@@ -64,6 +66,18 @@ Possible supplies for rk3288:
 - sdcard-supply: The supply connected to SDMMC0_VDD.
 - wifi-supply:   The supply connected to APIO3_VDD.  Also known as SDIO0.
 
+Possible supplies for rk3368:
+- audio-supply:  The supply connected to APIO3_VDD.
+- dvp-supply:    The supply connected to DVPIO_VDD.
+- flash0-supply: The supply connected to FLASH0_VDD.  Typically for eMMC
+- gpio30-supply: The supply connected to APIO1_VDD.
+- gpio1830       The supply connected to APIO4_VDD.
+- sdcard-supply: The supply connected to SDMMC0_VDD.
+- wifi-supply:   The supply connected to APIO2_VDD.  Also known as SDIO0.
+
+Possible supplies for rk3368 pmu-domains:
+- pmu-supply:    The supply connected to PMUIO_VDD.
+- vop-supply:    The supply connected to LCDC_VDD.
 
 Example:
 
diff --git a/drivers/power/avs/rockchip-io-domain.c b/drivers/power/avs/rockchip-io-domain.c
index 3ae35d0..2e30002 100644
--- a/drivers/power/avs/rockchip-io-domain.c
+++ b/drivers/power/avs/rockchip-io-domain.c
@@ -43,6 +43,10 @@
 #define RK3288_SOC_CON2_FLASH0		BIT(7)
 #define RK3288_SOC_FLASH_SUPPLY_NUM	2
 
+#define RK3368_SOC_CON15		0x43c
+#define RK3368_SOC_CON15_FLASH0		BIT(14)
+#define RK3368_SOC_FLASH_SUPPLY_NUM	2
+
 struct rockchip_iodomain;
 
 /**
@@ -158,6 +162,25 @@ static void rk3288_iodomain_init(struct rockchip_iodomain *iod)
 		dev_warn(iod->dev, "couldn't update flash0 ctrl\n");
 }
 
+static void rk3368_iodomain_init(struct rockchip_iodomain *iod)
+{
+	int ret;
+	u32 val;
+
+	/* if no flash supply we should leave things alone */
+	if (!iod->supplies[RK3368_SOC_FLASH_SUPPLY_NUM].reg)
+		return;
+
+	/*
+	 * set flash0 iodomain to also use this framework
+	 * instead of a special gpio.
+	 */
+	val = RK3368_SOC_CON15_FLASH0 | (RK3368_SOC_CON15_FLASH0 << 16);
+	ret = regmap_write(iod->grf, RK3368_SOC_CON15, val);
+	if (ret < 0)
+		dev_warn(iod->dev, "couldn't update flash0 ctrl\n");
+}
+
 /*
  * On the rk3188 the io-domains are handled by a shared register with the
  * lower 8 bits being still being continuing drive-strength settings.
@@ -201,6 +224,34 @@ static const struct rockchip_iodomain_soc_data soc_data_rk3288 = {
 	.init = rk3288_iodomain_init,
 };
 
+static const struct rockchip_iodomain_soc_data soc_data_rk3368 = {
+	.grf_offset = 0x900,
+	.supply_names = {
+		NULL,		/* reserved */
+		"dvp",		/* DVPIO_VDD */
+		"flash0",	/* FLASH0_VDD (emmc) */
+		"wifi",		/* APIO2_VDD (sdio0) */
+		NULL,
+		"audio",	/* APIO3_VDD */
+		"sdcard",	/* SDMMC0_VDD (sdmmc) */
+		"gpio30",	/* APIO1_VDD */
+		"gpio1830",	/* APIO4_VDD (gpujtag) */
+	},
+	.init = rk3368_iodomain_init,
+};
+
+static const struct rockchip_iodomain_soc_data soc_data_rk3368_pmu = {
+	.grf_offset = 0x100,
+	.supply_names = {
+		NULL,
+		NULL,
+		NULL,
+		NULL,
+		"pmu",	        /*PMU IO domain*/
+		"vop",	        /*LCDC IO domain*/
+	},
+};
+
 static const struct of_device_id rockchip_iodomain_match[] = {
 	{
 		.compatible = "rockchip,rk3188-io-voltage-domain",
@@ -210,6 +261,14 @@ static const struct of_device_id rockchip_iodomain_match[] = {
 		.compatible = "rockchip,rk3288-io-voltage-domain",
 		.data = (void *)&soc_data_rk3288
 	},
+	{
+		.compatible = "rockchip,rk3368-io-voltage-domain",
+		.data = (void *)&soc_data_rk3368
+	},
+	{
+		.compatible = "rockchip,rk3368-pmu-io-voltage-domain",
+		.data = (void *)&soc_data_rk3368_pmu
+	},
 	{ /* sentinel */ },
 };
 
-- 
2.1.4
