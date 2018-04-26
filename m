From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH] thermal: samsung: Remove support for Exynos5440
Date: Thu, 26 Apr 2018 13:21:12 +0200
Message-ID: <2734003.UHSMxVLybj@amdc3058>
References: <20180424203239.21885-1-krzk@kernel.org>
        <20180424203239.21885-7-krzk@kernel.org> <1951102.VLysaozMLK@amdc3058>
        <CGME20180426112113eucas1p1b5bf6f093442154e29f5541b4aba6b00@eucas1p1.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1951102.VLysaozMLK@amdc3058>
Sender: linux-kernel-owner@vger.kernel.org
To: Krzysztof Kozlowski <krzk@kernel.org>, Eduardo Valentin <edubezval@gmail.com>
Cc: Kukjin Kim <kgene@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Tejun Heo <tj@kernel.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Tomasz Figa <tomasz.figa@gmail.com>, Chanwoo Choi <cw00.choi@samsung.com>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Zhang Rui <rui.zhang@intel.com>, Russell King <linux@armlinux.org.uk>, Hans de Goede <hdegoede@redhat.com>, Linus Walleij <linus.walleij@linaro.org>, Andi Shyti <andi@etezian.org>, Mark Brown <broonie@kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-arm-kernel@lists.infradead.org, linux-samsu
List-Id: linux-pm@vger.kernel.org

From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH] thermal: samsung: Remove support for Exynos5440

The Exynos5440 is not actively developed, there are no development
boards available and probably there are no real products with it.
Remove wide-tree support for Exynos5440.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
[b.zolnierkie: ported over driver changes]
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
Eduardo, here is a version which applies on top of pending Exynos
thermal changes (https://lkml.org/lkml/2018/4/16/256).

 Documentation/devicetree/bindings/thermal/exynos-thermal.txt |   14 
 drivers/thermal/samsung/exynos_tmu.c                         |  161 -----------
 2 files changed, 4 insertions(+), 171 deletions(-)

Index: b/Documentation/devicetree/bindings/thermal/exynos-thermal.txt
===================================================================
--- a/Documentation/devicetree/bindings/thermal/exynos-thermal.txt	2018-04-26 12:29:42.716294204 +0200
+++ b/Documentation/devicetree/bindings/thermal/exynos-thermal.txt	2018-04-26 12:29:42.716294204 +0200
@@ -12,7 +12,6 @@
 	       "samsung,exynos5420-tmu-ext-triminfo" for TMU channels 2, 3 and 4
 			Exynos5420 (Must pass triminfo base and triminfo clock)
                "samsung,exynos5433-tmu"
-	       "samsung,exynos5440-tmu"
 	       "samsung,exynos7-tmu"
 - interrupt-parent : The phandle for the interrupt controller
 - reg : Address range of the thermal registers. For soc's which has multiple
@@ -68,18 +67,7 @@ Example 1):
 		#thermal-sensor-cells = <0>;
 	};
 
-Example 2):
-
-	tmuctrl_0: tmuctrl@160118 {
-		compatible = "samsung,exynos5440-tmu";
-		reg = <0x160118 0x230>, <0x160368 0x10>;
-		interrupts = <0 58 0>;
-		clocks = <&clock 21>;
-		clock-names = "tmu_apbif";
-		#thermal-sensor-cells = <0>;
-	};
-
-Example 3): (In case of Exynos5420 "with misplaced TRIMINFO register")
+Example 2): (In case of Exynos5420 "with misplaced TRIMINFO register")
 	tmu_cpu2: tmu@10068000 {
 		compatible = "samsung,exynos5420-tmu-ext-triminfo";
 		reg = <0x10068000 0x100>, <0x1006c000 0x4>;
Index: b/drivers/thermal/samsung/exynos_tmu.c
===================================================================
--- a/drivers/thermal/samsung/exynos_tmu.c	2018-04-26 12:29:42.716294204 +0200
+++ b/drivers/thermal/samsung/exynos_tmu.c	2018-04-26 12:30:52.648295965 +0200
@@ -126,28 +126,6 @@
 
 #define EXYNOS5433_G3D_BASE			0x10070000
 
-/*exynos5440 specific registers*/
-#define EXYNOS5440_TMU_S0_7_TRIM		0x000
-#define EXYNOS5440_TMU_S0_7_CTRL		0x020
-#define EXYNOS5440_TMU_S0_7_DEBUG		0x040
-#define EXYNOS5440_TMU_S0_7_TEMP		0x0f0
-#define EXYNOS5440_TMU_S0_7_TH0			0x110
-#define EXYNOS5440_TMU_S0_7_TH1			0x130
-#define EXYNOS5440_TMU_S0_7_TH2			0x150
-#define EXYNOS5440_TMU_S0_7_IRQEN		0x210
-#define EXYNOS5440_TMU_S0_7_IRQ			0x230
-/* exynos5440 common registers */
-#define EXYNOS5440_TMU_IRQ_STATUS		0x000
-#define EXYNOS5440_TMU_PMIN			0x004
-
-#define EXYNOS5440_TMU_INTEN_RISE0_SHIFT	0
-#define EXYNOS5440_TMU_INTEN_RISE1_SHIFT	1
-#define EXYNOS5440_TMU_INTEN_RISE2_SHIFT	2
-#define EXYNOS5440_TMU_INTEN_RISE3_SHIFT	3
-#define EXYNOS5440_TMU_INTEN_FALL0_SHIFT	4
-#define EXYNOS5440_TMU_TH_RISE4_SHIFT		24
-#define EXYNOS5440_EFUSE_SWAP_OFFSET		8
-
 /* Exynos7 specific registers */
 #define EXYNOS7_THD_TEMP_RISE7_6		0x50
 #define EXYNOS7_THD_TEMP_FALL7_6		0x60
@@ -184,7 +162,6 @@ enum soc_type {
 	SOC_ARCH_EXYNOS5420,
 	SOC_ARCH_EXYNOS5420_TRIMINFO,
 	SOC_ARCH_EXYNOS5433,
-	SOC_ARCH_EXYNOS5440,
 	SOC_ARCH_EXYNOS7,
 };
 
@@ -619,57 +596,6 @@ out:
 	return ret;
 }
 
-static int exynos5440_tmu_initialize(struct platform_device *pdev)
-{
-	struct exynos_tmu_data *data = platform_get_drvdata(pdev);
-	unsigned int trim_info = 0, con, rising_threshold;
-	int threshold_code;
-	int crit_temp = 0;
-
-	/*
-	 * For exynos5440 soc triminfo value is swapped between TMU0 and
-	 * TMU2, so the below logic is needed.
-	 */
-	switch (data->id) {
-	case 0:
-		trim_info = readl(data->base + EXYNOS5440_EFUSE_SWAP_OFFSET +
-				 EXYNOS5440_TMU_S0_7_TRIM);
-		break;
-	case 1:
-		trim_info = readl(data->base + EXYNOS5440_TMU_S0_7_TRIM);
-		break;
-	case 2:
-		trim_info = readl(data->base - EXYNOS5440_EFUSE_SWAP_OFFSET +
-				  EXYNOS5440_TMU_S0_7_TRIM);
-	}
-	sanitize_temp_error(data, trim_info);
-
-	/* Write temperature code for rising and falling threshold */
-	rising_threshold = readl(data->base + EXYNOS5440_TMU_S0_7_TH0);
-	rising_threshold = get_th_reg(data, rising_threshold, false);
-	writel(rising_threshold, data->base + EXYNOS5440_TMU_S0_7_TH0);
-	writel(0, data->base + EXYNOS5440_TMU_S0_7_TH1);
-
-	data->tmu_clear_irqs(data);
-
-	/* if last threshold limit is also present */
-	if (!data->tzd->ops->get_crit_temp(data->tzd, &crit_temp)) {
-		threshold_code = temp_to_code(data, crit_temp / MCELSIUS);
-		/* 5th level to be assigned in th2 reg */
-		rising_threshold =
-			threshold_code << EXYNOS5440_TMU_TH_RISE4_SHIFT;
-		writel(rising_threshold, data->base + EXYNOS5440_TMU_S0_7_TH2);
-		con = readl(data->base + EXYNOS5440_TMU_S0_7_CTRL);
-		con |= (1 << EXYNOS_TMU_THERM_TRIP_EN_SHIFT);
-		writel(con, data->base + EXYNOS5440_TMU_S0_7_CTRL);
-	}
-	/* Clear the PMIN in the common TMU register */
-	if (!data->id)
-		writel(0, data->base_second + EXYNOS5440_TMU_PMIN);
-
-	return 0;
-}
-
 static int exynos7_tmu_initialize(struct platform_device *pdev)
 {
 	struct exynos_tmu_data *data = platform_get_drvdata(pdev);
@@ -820,35 +746,6 @@ static void exynos5433_tmu_control(struc
 	writel(con, data->base + EXYNOS_TMU_REG_CONTROL);
 }
 
-static void exynos5440_tmu_control(struct platform_device *pdev, bool on)
-{
-	struct exynos_tmu_data *data = platform_get_drvdata(pdev);
-	struct thermal_zone_device *tz = data->tzd;
-	unsigned int con, interrupt_en;
-
-	con = get_con_reg(data, readl(data->base + EXYNOS5440_TMU_S0_7_CTRL));
-
-	if (on) {
-		con |= (1 << EXYNOS_TMU_CORE_EN_SHIFT);
-		interrupt_en =
-			(of_thermal_is_trip_valid(tz, 3)
-			 << EXYNOS5440_TMU_INTEN_RISE3_SHIFT) |
-			(of_thermal_is_trip_valid(tz, 2)
-			 << EXYNOS5440_TMU_INTEN_RISE2_SHIFT) |
-			(of_thermal_is_trip_valid(tz, 1)
-			 << EXYNOS5440_TMU_INTEN_RISE1_SHIFT) |
-			(of_thermal_is_trip_valid(tz, 0)
-			 << EXYNOS5440_TMU_INTEN_RISE0_SHIFT);
-		interrupt_en |=
-			interrupt_en << EXYNOS5440_TMU_INTEN_FALL0_SHIFT;
-	} else {
-		con &= ~(1 << EXYNOS_TMU_CORE_EN_SHIFT);
-		interrupt_en = 0; /* Disable all interrupts */
-	}
-	writel(interrupt_en, data->base + EXYNOS5440_TMU_S0_7_IRQEN);
-	writel(con, data->base + EXYNOS5440_TMU_S0_7_CTRL);
-}
-
 static void exynos7_tmu_control(struct platform_device *pdev, bool on)
 {
 	struct exynos_tmu_data *data = platform_get_drvdata(pdev);
@@ -920,10 +817,8 @@ static u32 get_emul_con_reg(struct exyno
 	if (temp) {
 		temp /= MCELSIUS;
 
-		if (data->soc != SOC_ARCH_EXYNOS5440) {
-			val &= ~(EXYNOS_EMUL_TIME_MASK << EXYNOS_EMUL_TIME_SHIFT);
-			val |= (EXYNOS_EMUL_TIME << EXYNOS_EMUL_TIME_SHIFT);
-		}
+		val &= ~(EXYNOS_EMUL_TIME_MASK << EXYNOS_EMUL_TIME_SHIFT);
+		val |= (EXYNOS_EMUL_TIME << EXYNOS_EMUL_TIME_SHIFT);
 		if (data->soc == SOC_ARCH_EXYNOS7) {
 			val &= ~(EXYNOS7_EMUL_DATA_MASK <<
 				EXYNOS7_EMUL_DATA_SHIFT);
@@ -964,16 +859,6 @@ static void exynos4412_tmu_set_emulation
 	writel(val, data->base + emul_con);
 }
 
-static void exynos5440_tmu_set_emulation(struct exynos_tmu_data *data,
-					 int temp)
-{
-	unsigned int val;
-
-	val = readl(data->base + EXYNOS5440_TMU_S0_7_DEBUG);
-	val = get_emul_con_reg(data, val, temp);
-	writel(val, data->base + EXYNOS5440_TMU_S0_7_DEBUG);
-}
-
 static int exynos_tmu_set_emulation(void *drv_data, int temp)
 {
 	struct exynos_tmu_data *data = drv_data;
@@ -996,7 +881,6 @@ out:
 }
 #else
 #define exynos4412_tmu_set_emulation NULL
-#define exynos5440_tmu_set_emulation NULL
 static int exynos_tmu_set_emulation(void *drv_data, int temp)
 	{ return -EINVAL; }
 #endif /* CONFIG_THERMAL_EMULATION */
@@ -1014,11 +898,6 @@ static int exynos4412_tmu_read(struct ex
 	return readb(data->base + EXYNOS_TMU_REG_CURRENT_TEMP);
 }
 
-static int exynos5440_tmu_read(struct exynos_tmu_data *data)
-{
-	return readb(data->base + EXYNOS5440_TMU_S0_7_TEMP);
-}
-
 static int exynos7_tmu_read(struct exynos_tmu_data *data)
 {
 	return readw(data->base + EXYNOS_TMU_REG_CURRENT_TEMP) &
@@ -1029,16 +908,9 @@ static void exynos_tmu_work(struct work_
 {
 	struct exynos_tmu_data *data = container_of(work,
 			struct exynos_tmu_data, irq_work);
-	unsigned int val_type;
 
 	if (!IS_ERR(data->clk_sec))
 		clk_enable(data->clk_sec);
-	/* Find which sensor generated this interrupt */
-	if (data->soc == SOC_ARCH_EXYNOS5440) {
-		val_type = readl(data->base_second + EXYNOS5440_TMU_IRQ_STATUS);
-		if (!((val_type >> data->id) & 0x1))
-			goto out;
-	}
 	if (!IS_ERR(data->clk_sec))
 		clk_disable(data->clk_sec);
 
@@ -1051,7 +923,6 @@ static void exynos_tmu_work(struct work_
 
 	clk_disable(data->clk);
 	mutex_unlock(&data->lock);
-out:
 	enable_irq(data->irq);
 }
 
@@ -1086,15 +957,6 @@ static void exynos4210_tmu_clear_irqs(st
 	writel(val_irq, data->base + tmu_intclear);
 }
 
-static void exynos5440_tmu_clear_irqs(struct exynos_tmu_data *data)
-{
-	unsigned int val_irq;
-
-	val_irq = readl(data->base + EXYNOS5440_TMU_S0_7_IRQ);
-	/* clear the interrupts */
-	writel(val_irq, data->base + EXYNOS5440_TMU_S0_7_IRQ);
-}
-
 static irqreturn_t exynos_tmu_irq(int irq, void *id)
 {
 	struct exynos_tmu_data *data = id;
@@ -1131,9 +993,6 @@ static const struct of_device_id exynos_
 		.compatible = "samsung,exynos5433-tmu",
 		.data = (const void *)SOC_ARCH_EXYNOS5433,
 	}, {
-		.compatible = "samsung,exynos5440-tmu",
-		.data = (const void *)SOC_ARCH_EXYNOS5440,
-	}, {
 		.compatible = "samsung,exynos7-tmu",
 		.data = (const void *)SOC_ARCH_EXYNOS7,
 	},
@@ -1223,19 +1082,6 @@ static int exynos_map_dt_data(struct pla
 		data->min_efuse_value = 40;
 		data->max_efuse_value = 150;
 		break;
-	case SOC_ARCH_EXYNOS5440:
-		data->tmu_initialize = exynos5440_tmu_initialize;
-		data->tmu_control = exynos5440_tmu_control;
-		data->tmu_read = exynos5440_tmu_read;
-		data->tmu_set_emulation = exynos5440_tmu_set_emulation;
-		data->tmu_clear_irqs = exynos5440_tmu_clear_irqs;
-		data->ntrip = 4;
-		data->gain = 5;
-		data->reference_voltage = 16;
-		data->efuse_value = 0x5d2d;
-		data->min_efuse_value = 16;
-		data->max_efuse_value = 76;
-		break;
 	case SOC_ARCH_EXYNOS7:
 		data->tmu_initialize = exynos7_tmu_initialize;
 		data->tmu_control = exynos7_tmu_control;
@@ -1260,8 +1106,7 @@ static int exynos_map_dt_data(struct pla
 	 * Check if the TMU shares some registers and then try to map the
 	 * memory of common registers.
 	 */
-	if (data->soc != SOC_ARCH_EXYNOS5420_TRIMINFO &&
-	    data->soc != SOC_ARCH_EXYNOS5440)
+	if (data->soc != SOC_ARCH_EXYNOS5420_TRIMINFO)
 		return 0;
 
 	if (of_address_to_resource(pdev->dev.of_node, 1, &res)) {
