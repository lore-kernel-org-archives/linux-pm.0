From: Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH] PM / AVS: rockchip-io: add GRF and PMUGRF types to distinguish
Date: Sat, 30 Jan 2016 13:39:11 +0100
Message-ID: <5387650.lAgTxexlF2@phil>
References: <1454155305-55516-1-git-send-email-david.wu@rock-chips.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="nextPart13984166.nDCb7D3PtO"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1454155305-55516-1-git-send-email-david.wu@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Wu <david.wu@rock-chips.com>
Cc: khilman@kernel.org, nm@ti.com, huangtao@rock-chips.com, cf@rock-chips.com, zyw@rock-chips.com, xjq@rock-chips.com, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

This is a multi-part message in MIME format.

--nextPart13984166.nDCb7D3PtO
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi David,

Am Samstag, 30. Januar 2016, 20:01:45 schrieb David Wu:
> As rk3368 contained two separated iodomain areas, this was
> determined to use which regmap base address.
> 
> Signed-off-by: David Wu <david.wu@rock-chips.com>

I don't think we need to specify this on a driver level. Both GRF areas are 
"General register files" only located in two separate power-domains.
So the rockchip,grf property should work for both. Especially as nothing 
keeps designers from introducing yet another GRF-area somewhere else ;-)

>From when I started working on the rk3368, I still have a preliminary 
patches for that sitting here, so I've attached on how I envisoned that to 
work.


Heiko

> ---
>  drivers/power/avs/rockchip-io-domain.c | 32
> ++++++++++++++++++++++++-------- 1 file changed, 24 insertions(+), 8
> deletions(-)
> 
> diff --git a/drivers/power/avs/rockchip-io-domain.c
> b/drivers/power/avs/rockchip-io-domain.c index 8099456..b17aeb7 100644
> --- a/drivers/power/avs/rockchip-io-domain.c
> +++ b/drivers/power/avs/rockchip-io-domain.c
> @@ -47,6 +47,11 @@
>  #define RK3368_SOC_CON15_FLASH0		BIT(14)
>  #define RK3368_SOC_FLASH_SUPPLY_NUM	2
> 
> +enum rockchip_iodomain_grf_type {
> +	GRF,
> +	PMUGRF
> +};
> +
>  struct rockchip_iodomain;
> 
>  /**
> @@ -54,6 +59,7 @@ struct rockchip_iodomain;
>   */
>  struct rockchip_iodomain_soc_data {
>  	int grf_offset;
> +	enum rockchip_iodomain_grf_type type;
>  	const char *supply_names[MAX_SUPPLIES];
>  	void (*init)(struct rockchip_iodomain *iod);
>  };
> @@ -67,7 +73,7 @@ struct rockchip_iodomain_supply {
> 
>  struct rockchip_iodomain {
>  	struct device *dev;
> -	struct regmap *grf;
> +	struct regmap *base;
>  	struct rockchip_iodomain_soc_data *soc_data;
>  	struct rockchip_iodomain_supply supplies[MAX_SUPPLIES];
>  };
> @@ -86,7 +92,7 @@ static int rockchip_iodomain_write(struct
> rockchip_iodomain_supply *supply, /* apply hiword-mask */
>  	val |= (BIT(supply->idx) << 16);
> 
> -	ret = regmap_write(iod->grf, iod->soc_data->grf_offset, val);
> +	ret = regmap_write(iod->base, iod->soc_data->grf_offset, val);
>  	if (ret)
>  		dev_err(iod->dev, "Couldn't write to GRF\n");
> 
> @@ -157,7 +163,7 @@ static void rk3288_iodomain_init(struct
> rockchip_iodomain *iod) * instead of a special gpio.
>  	 */
>  	val = RK3288_SOC_CON2_FLASH0 | (RK3288_SOC_CON2_FLASH0 << 16);
> -	ret = regmap_write(iod->grf, RK3288_SOC_CON2, val);
> +	ret = regmap_write(iod->base, RK3288_SOC_CON2, val);
>  	if (ret < 0)
>  		dev_warn(iod->dev, "couldn't update flash0 ctrl\n");
>  }
> @@ -176,7 +182,7 @@ static void rk3368_iodomain_init(struct
> rockchip_iodomain *iod) * instead of a special gpio.
>  	 */
>  	val = RK3368_SOC_CON15_FLASH0 | (RK3368_SOC_CON15_FLASH0 << 16);
> -	ret = regmap_write(iod->grf, RK3368_SOC_CON15, val);
> +	ret = regmap_write(iod->base, RK3368_SOC_CON15, val);
>  	if (ret < 0)
>  		dev_warn(iod->dev, "couldn't update flash0 ctrl\n");
>  }
> @@ -187,6 +193,7 @@ static void rk3368_iodomain_init(struct
> rockchip_iodomain *iod) */
>  static const struct rockchip_iodomain_soc_data soc_data_rk3188 = {
>  	.grf_offset = 0x104,
> +	.type = GRF,
>  	.supply_names = {
>  		NULL,
>  		NULL,
> @@ -209,6 +216,7 @@ static const struct rockchip_iodomain_soc_data
> soc_data_rk3188 = {
> 
>  static const struct rockchip_iodomain_soc_data soc_data_rk3288 = {
>  	.grf_offset = 0x380,
> +	.type = GRF,
>  	.supply_names = {
>  		"lcdc",		/* LCDC_VDD */
>  		"dvp",		/* DVPIO_VDD */
> @@ -226,6 +234,7 @@ static const struct rockchip_iodomain_soc_data
> soc_data_rk3288 = {
> 
>  static const struct rockchip_iodomain_soc_data soc_data_rk3368 = {
>  	.grf_offset = 0x900,
> +	.type = GRF,
>  	.supply_names = {
>  		NULL,		/* reserved */
>  		"dvp",		/* DVPIO_VDD */
> @@ -242,6 +251,7 @@ static const struct rockchip_iodomain_soc_data
> soc_data_rk3368 = {
> 
>  static const struct rockchip_iodomain_soc_data soc_data_rk3368_pmu = {
>  	.grf_offset = 0x100,
> +	.type = PMUGRF,
>  	.supply_names = {
>  		NULL,
>  		NULL,
> @@ -293,10 +303,16 @@ static int rockchip_iodomain_probe(struct
> platform_device *pdev) match = of_match_node(rockchip_iodomain_match,
> np);
>  	iod->soc_data = (struct rockchip_iodomain_soc_data *)match->data;
> 
> -	iod->grf = syscon_regmap_lookup_by_phandle(np, "rockchip,grf");
> -	if (IS_ERR(iod->grf)) {
> -		dev_err(&pdev->dev, "couldn't find grf regmap\n");
> -		return PTR_ERR(iod->grf);
> +	if (iod->soc_data->type == PMUGRF)
> +		iod->base = syscon_regmap_lookup_by_phandle(
> +				np, "rockchip,pmugrf");
> +	else
> +		iod->base = syscon_regmap_lookup_by_phandle(
> +				np, "rockchip,grf");
> +	if (IS_ERR(iod->base)) {
> +		dev_err(&pdev->dev, "couldn't find %s regmap\n",
> +			(iod->soc_data->type == PMUGRF) ? "pmugrf" : "grf");
> +		return PTR_ERR(iod->base);
>  	}
> 
>  	for (i = 0; i < MAX_SUPPLIES; i++) {

--nextPart13984166.nDCb7D3PtO
Content-Disposition: attachment; filename="0001-PM-AVS-rockchip-io-add-io-selectors-and-supplies-for.patch"
Content-Transfer-Encoding: 7Bit
Content-Type: text/x-patch; charset="UTF-8"; name="0001-PM-AVS-rockchip-io-add-io-selectors-and-supplies-for.patch"

>From cb71dd1bc8afb825e200c0c116186fed43df83ea Mon Sep 17 00:00:00 2001
From: Heiko Stuebner <heiko@sntech.de>
Date: Wed, 17 Jun 2015 13:33:18 +0200
Subject: [PATCH 1/2] PM / AVS: rockchip-io: add io selectors and supplies for
 rk3368

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
+		"pmu",		/*PMU IO domain*/
+		"vop",		/*LCDC IO domain*/
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
2.6.4


--nextPart13984166.nDCb7D3PtO
Content-Disposition: attachment; filename="0002-ARM64-dts-rockchip-add-iodomains-and-stuff.patch"
Content-Transfer-Encoding: 7Bit
Content-Type: text/x-patch; charset="UTF-8"; name="0002-ARM64-dts-rockchip-add-iodomains-and-stuff.patch"

>From 76fc704626e611180223ac99e4067c30c464dd23 Mon Sep 17 00:00:00 2001
From: Heiko Stuebner <heiko@sntech.de>
Date: Wed, 29 Jul 2015 16:13:35 +0200
Subject: [PATCH 2/2] arm64: dts: rockchip: add rk3368 iodomains


probably unfinished
---

diff --git a/arch/arm64/boot/dts/rockchip/rk3368-r88.dts b/arch/arm64/boot/dts/rockchip/rk3368-r88.dts
index 401a812..6547f1e 100644
--- a/arch/arm64/boot/dts/rockchip/rk3368-r88.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3368-r88.dts
@@ -89,6 +89,25 @@
 		};
 	};
 
+	io-domains {
+		compatible = "rockchip,rk3368-io-voltage-domain";
+		rockchip,grf = <&grf>;
+
+		audio-supply = <&vcc_io>;
+		gpio30-supply = <&vcc_io>;
+		gpio1830-supply = <&vcc_io>;
+		sdcard-supply = <&vccio_sd>;
+		wifi-supply = <&vccio_wl>;
+	};
+
+	pmu-io-domains {
+		compatible = "rockchip,rk3368-pmu-io-voltage-domain";
+		rockchip,grf = <&pmugrf>;
+
+		pmu-supply = <&vcc_io>;
+		vop-supply = <&vcc_io>;
+	};
+
 	ir: ir-receiver {
 		compatible = "gpio-ir-receiver";
 		gpios = <&gpio3 30 GPIO_ACTIVE_LOW>;
-- 
2.6.4


--nextPart13984166.nDCb7D3PtO--
