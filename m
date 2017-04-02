From: Icenowy Zheng <icenowy-h8G6r0blFSE@public.gmane.org>
Subject: [RFC PATCH v2 3/4] iio: adc: sun4i-gpadc-iio: add
 support for H3 thermal sensor
Date: Sun,  2 Apr 2017 21:33:03 +0800
Message-ID: <20170402133304.56824-4-icenowy@aosc.io>
References: <20170402133304.56824-1-icenowy@aosc.io>
Reply-To: icenowy-h8G6r0blFSE@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBDS6XAN6ZADRBFX4QPDQKGQEQSP6H3Y-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20170402133304.56824-1-icenowy-h8G6r0blFSE@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Quentin Schulz <quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Icenowy Zheng <icenowy-h8G6r0blFSE@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

This adds support for the Allwinner H3 thermal sensor.

Allwinner H3 has a thermal sensor like the one in A33, but have its
registers nearly all re-arranged, sample clock moved to CCU and a pair
of bus clock and reset added. It's also the base of newer SoCs' thermal
sensors.

Some new options is added to gpadc_data struct, to mark the difference
between the old GPADCs and THS's and the new THS's.

The thermal sensors on A64 and H5 is like the one on H3, but with of
course different formula factors.

Signed-off-by: Icenowy Zheng <icenowy-h8G6r0blFSE@public.gmane.org>
---
Changes in v2:
- Many new variables in gpadc_data replaced the old gen2_ths bool variable.
- Splitted A23 renaming to a new patch.

 drivers/iio/adc/sun4i-gpadc-iio.c | 215 +++++++++++++++++++++++++++++++-------
 include/linux/mfd/sun4i-gpadc.h   |  28 +++++
 2 files changed, 203 insertions(+), 40 deletions(-)

diff --git a/drivers/iio/adc/sun4i-gpadc-iio.c b/drivers/iio/adc/sun4i-gpadc-iio.c
index 01cf806f47f8..ba7e07d31468 100644
--- a/drivers/iio/adc/sun4i-gpadc-iio.c
+++ b/drivers/iio/adc/sun4i-gpadc-iio.c
@@ -22,6 +22,7 @@
  * shutdown for not being used.
  */
 
+#include <linux/clk.h>
 #include <linux/completion.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
@@ -31,6 +32,7 @@
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/regmap.h>
+#include <linux/reset.h>
 #include <linux/thermal.h>
 #include <linux/delay.h>
 
@@ -49,6 +51,8 @@ static unsigned int sun6i_gpadc_chan_select(unsigned int chan)
 	return SUN6I_GPADC_CTRL1_ADC_CHAN_SELECT(chan);
 }
 
+struct sun4i_gpadc_iio;
+
 struct gpadc_data {
 	int		temp_offset;
 	int		temp_scale;
@@ -56,39 +60,12 @@ struct gpadc_data {
 	unsigned int	tp_adc_select;
 	unsigned int	(*adc_chan_select)(unsigned int chan);
 	unsigned int	adc_chan_mask;
-};
-
-static const struct gpadc_data sun4i_gpadc_data = {
-	.temp_offset = -1932,
-	.temp_scale = 133,
-	.tp_mode_en = SUN4I_GPADC_CTRL1_TP_MODE_EN,
-	.tp_adc_select = SUN4I_GPADC_CTRL1_TP_ADC_SELECT,
-	.adc_chan_select = &sun4i_gpadc_chan_select,
-	.adc_chan_mask = SUN4I_GPADC_CTRL1_ADC_CHAN_MASK,
-};
-
-static const struct gpadc_data sun5i_gpadc_data = {
-	.temp_offset = -1447,
-	.temp_scale = 100,
-	.tp_mode_en = SUN4I_GPADC_CTRL1_TP_MODE_EN,
-	.tp_adc_select = SUN4I_GPADC_CTRL1_TP_ADC_SELECT,
-	.adc_chan_select = &sun4i_gpadc_chan_select,
-	.adc_chan_mask = SUN4I_GPADC_CTRL1_ADC_CHAN_MASK,
-};
-
-static const struct gpadc_data sun6i_gpadc_data = {
-	.temp_offset = -1623,
-	.temp_scale = 167,
-	.tp_mode_en = SUN6I_GPADC_CTRL1_TP_MODE_EN,
-	.tp_adc_select = SUN6I_GPADC_CTRL1_TP_ADC_SELECT,
-	.adc_chan_select = &sun6i_gpadc_chan_select,
-	.adc_chan_mask = SUN6I_GPADC_CTRL1_ADC_CHAN_MASK,
-};
-
-static const struct gpadc_data sun8i_a33_gpadc_data = {
-	.temp_offset = -1662,
-	.temp_scale = 162,
-	.tp_mode_en = SUN8I_A23_GPADC_CTRL1_CHOP_TEMP_EN,
+	unsigned int	temp_data;
+	int		(*sample_start)(struct sun4i_gpadc_iio *info);
+	int		(*sample_end)(struct sun4i_gpadc_iio *info);
+	bool		has_bus_clk;
+	bool		has_bus_rst;
+	bool		has_ths_clk;
 };
 
 struct sun4i_gpadc_iio {
@@ -103,6 +80,9 @@ struct sun4i_gpadc_iio {
 	atomic_t			ignore_temp_data_irq;
 	const struct gpadc_data		*data;
 	bool				no_irq;
+	struct clk			*ths_bus_clk;
+	struct clk			*ths_clk;
+	struct reset_control		*reset;
 	/* prevents concurrent reads of temperature and ADC */
 	struct mutex			mutex;
 };
@@ -274,7 +254,7 @@ static int sun4i_gpadc_temp_read(struct iio_dev *indio_dev, int *val)
 	if (info->no_irq) {
 		pm_runtime_get_sync(indio_dev->dev.parent);
 
-		regmap_read(info->regmap, SUN4I_GPADC_TEMP_DATA, val);
+		regmap_read(info->regmap, info->data->temp_data, val);
 
 		pm_runtime_mark_last_busy(indio_dev->dev.parent);
 		pm_runtime_put_autosuspend(indio_dev->dev.parent);
@@ -382,10 +362,8 @@ static irqreturn_t sun4i_gpadc_fifo_data_irq_handler(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static int sun4i_gpadc_runtime_suspend(struct device *dev)
+static int sun4i_gpadc_sample_end(struct sun4i_gpadc_iio *info)
 {
-	struct sun4i_gpadc_iio *info = iio_priv(dev_get_drvdata(dev));
-
 	/* Disable the ADC on IP */
 	regmap_write(info->regmap, SUN4I_GPADC_CTRL1, 0);
 	/* Disable temperature sensor on IP */
@@ -394,20 +372,37 @@ static int sun4i_gpadc_runtime_suspend(struct device *dev)
 	return 0;
 }
 
-static int sun4i_gpadc_runtime_resume(struct device *dev)
+static int sun8i_h3_gpadc_sample_end(struct sun4i_gpadc_iio *info)
+{
+	/* Disable temperature sensor */
+	regmap_write(info->regmap, SUN8I_H3_GPADC_CTRL2, 0);
+
+	return 0;
+}
+
+static int sun4i_gpadc_runtime_suspend(struct device *dev)
 {
 	struct sun4i_gpadc_iio *info = iio_priv(dev_get_drvdata(dev));
 
+	return info->data->sample_end(info);
+}
+
+static int sun4i_gpadc_sample_start(struct sun4i_gpadc_iio *info)
+{
 	/* clkin = 6MHz */
 	regmap_write(info->regmap, SUN4I_GPADC_CTRL0,
 		     SUN4I_GPADC_CTRL0_ADC_CLK_DIVIDER(2) |
 		     SUN4I_GPADC_CTRL0_FS_DIV(7) |
 		     SUN4I_GPADC_CTRL0_T_ACQ(63));
-	regmap_write(info->regmap, SUN4I_GPADC_CTRL1, info->data->tp_mode_en);
+	regmap_write(info->regmap, SUN4I_GPADC_CTRL1,
+		     info->data->tp_mode_en);
 	regmap_write(info->regmap, SUN4I_GPADC_CTRL3,
 		     SUN4I_GPADC_CTRL3_FILTER_EN |
 		     SUN4I_GPADC_CTRL3_FILTER_TYPE(1));
-	/* period = SUN4I_GPADC_TPR_TEMP_PERIOD * 256 * 16 / clkin; ~0.6s */
+	/*
+	 * period = SUN4I_GPADC_TPR_TEMP_PERIOD * 256 * 16 / clkin;
+	 * ~0.6s
+	 */
 	regmap_write(info->regmap, SUN4I_GPADC_TPR,
 		     SUN4I_GPADC_TPR_TEMP_ENABLE |
 		     SUN4I_GPADC_TPR_TEMP_PERIOD(800));
@@ -415,6 +410,29 @@ static int sun4i_gpadc_runtime_resume(struct device *dev)
 	return 0;
 }
 
+static int sun8i_h3_gpadc_sample_start(struct sun4i_gpadc_iio *info)
+{
+	regmap_write(info->regmap, SUN8I_H3_GPADC_CTRL2,
+		     SUN8I_H3_GPADC_CTRL2_TEMP_SENSE_EN |
+		     SUN8I_H3_GPADC_CTRL2_T_ACQ1(31));
+	regmap_write(info->regmap, SUN4I_GPADC_CTRL0,
+		     SUN4I_GPADC_CTRL0_T_ACQ(31));
+	regmap_write(info->regmap, SUN8I_H3_GPADC_CTRL3,
+		     SUN4I_GPADC_CTRL3_FILTER_EN |
+		     SUN4I_GPADC_CTRL3_FILTER_TYPE(1));
+	regmap_write(info->regmap, SUN8I_H3_GPADC_INTC,
+		     SUN8I_H3_GPADC_INTC_TEMP_PERIOD(800));
+
+	return 0;
+}
+
+static int sun4i_gpadc_runtime_resume(struct device *dev)
+{
+	struct sun4i_gpadc_iio *info = iio_priv(dev_get_drvdata(dev));
+
+	return info->data->sample_start(info);
+}
+
 static int sun4i_gpadc_get_temp(void *data, int *temp)
 {
 	struct sun4i_gpadc_iio *info = (struct sun4i_gpadc_iio *)data;
@@ -489,11 +507,78 @@ static int sun4i_irq_init(struct platform_device *pdev, const char *name,
 	return 0;
 }
 
+static const struct gpadc_data sun4i_gpadc_data = {
+	.temp_offset = -1932,
+	.temp_scale = 133,
+	.tp_mode_en = SUN4I_GPADC_CTRL1_TP_MODE_EN,
+	.tp_adc_select = SUN4I_GPADC_CTRL1_TP_ADC_SELECT,
+	.adc_chan_select = &sun4i_gpadc_chan_select,
+	.adc_chan_mask = SUN4I_GPADC_CTRL1_ADC_CHAN_MASK,
+	.temp_data = SUN4I_GPADC_TEMP_DATA,
+	.sample_start = sun4i_gpadc_sample_start,
+	.sample_end = sun4i_gpadc_sample_end,
+};
+
+static const struct gpadc_data sun5i_gpadc_data = {
+	.temp_offset = -1447,
+	.temp_scale = 100,
+	.tp_mode_en = SUN4I_GPADC_CTRL1_TP_MODE_EN,
+	.tp_adc_select = SUN4I_GPADC_CTRL1_TP_ADC_SELECT,
+	.adc_chan_select = &sun4i_gpadc_chan_select,
+	.adc_chan_mask = SUN4I_GPADC_CTRL1_ADC_CHAN_MASK,
+	.temp_data = SUN4I_GPADC_TEMP_DATA,
+	.sample_start = sun4i_gpadc_sample_start,
+	.sample_end = sun4i_gpadc_sample_end,
+};
+
+static const struct gpadc_data sun6i_gpadc_data = {
+	.temp_offset = -1623,
+	.temp_scale = 167,
+	.tp_mode_en = SUN6I_GPADC_CTRL1_TP_MODE_EN,
+	.tp_adc_select = SUN6I_GPADC_CTRL1_TP_ADC_SELECT,
+	.adc_chan_select = &sun6i_gpadc_chan_select,
+	.adc_chan_mask = SUN6I_GPADC_CTRL1_ADC_CHAN_MASK,
+	.temp_data = SUN4I_GPADC_TEMP_DATA,
+	.sample_start = sun4i_gpadc_sample_start,
+	.sample_end = sun4i_gpadc_sample_end,
+};
+
+static const struct gpadc_data sun8i_a33_gpadc_data = {
+	.temp_offset = -1662,
+	.temp_scale = 162,
+	.tp_mode_en = SUN8I_A23_GPADC_CTRL1_CHOP_TEMP_EN,
+	.temp_data = SUN4I_GPADC_TEMP_DATA,
+	.sample_start = sun4i_gpadc_sample_start,
+	.sample_end = sun4i_gpadc_sample_end,
+};
+
+static const struct gpadc_data sun8i_h3_gpadc_data = {
+	/*
+	 * The original formula on the datasheet seems to be wrong.
+	 * These factors are calculated based on the formula in the BSP
+	 * kernel, which is originally Tem = 217 - (T / 8.253), in which Tem
+	 * is the temperature in Celsius degree and T is the raw value
+	 * from the sensor.
+	 */
+	.temp_offset = -1791,
+	.temp_scale = -121,
+	.temp_data = SUN8I_H3_GPADC_TEMP_DATA,
+	.sample_start = sun8i_h3_gpadc_sample_start,
+	.sample_end = sun8i_h3_gpadc_sample_end,
+	.has_bus_clk = true,
+	.has_bus_rst = true,
+	.has_ths_clk = true,
+};
+
 static const struct of_device_id sun4i_gpadc_of_id[] = {
 	{
 		.compatible = "allwinner,sun8i-a33-ths",
 		.data = &sun8i_a33_gpadc_data,
 	},
+	{
+		.compatible = "allwinner,sun8i-h3-ths",
+		.data = &sun8i_h3_gpadc_data,
+	},
 	{ /* sentinel */ }
 };
 
@@ -529,6 +614,47 @@ static int sun4i_gpadc_probe_dt(struct platform_device *pdev,
 		return ret;
 	}
 
+	if (info->data->has_bus_rst) {
+		info->reset = devm_reset_control_get(&pdev->dev, NULL);
+		if (IS_ERR(info->reset)) {
+			ret = PTR_ERR(info->reset);
+			return ret;
+		}
+
+		ret = reset_control_deassert(info->reset);
+		if (ret)
+			return ret;
+	}
+
+	if (info->data->has_bus_clk) {
+		info->ths_bus_clk = devm_clk_get(&pdev->dev, "bus");
+		if (IS_ERR(info->ths_bus_clk)) {
+			ret = PTR_ERR(info->ths_bus_clk);
+			return ret;
+		}
+
+		ret = clk_prepare_enable(info->ths_bus_clk);
+		if (ret)
+			return ret;
+	}
+
+	if (info->data->has_ths_clk) {
+		info->ths_clk = devm_clk_get(&pdev->dev, "ths");
+		if (IS_ERR(info->ths_clk)) {
+			ret = PTR_ERR(info->ths_clk);
+			return ret;
+		}
+
+		/* Running at 6MHz */
+		ret = clk_set_rate(info->ths_clk, 6000000);
+		if (ret)
+			return ret;
+
+		ret = clk_prepare_enable(info->ths_clk);
+		if (ret)
+			return ret;
+	}
+
 	if (!IS_ENABLED(CONFIG_THERMAL_OF))
 		return 0;
 
@@ -691,6 +817,15 @@ static int sun4i_gpadc_remove(struct platform_device *pdev)
 	if (!info->no_irq && IS_ENABLED(CONFIG_THERMAL_OF))
 		iio_map_array_unregister(indio_dev);
 
+	if (info->data->has_ths_clk)
+		clk_disable_unprepare(info->ths_clk);
+
+	if (info->data->has_bus_clk)
+		clk_disable_unprepare(info->ths_bus_clk);
+
+	if (info->data->has_bus_rst)
+		reset_control_deassert(info->reset);
+
 	return 0;
 }
 
diff --git a/include/linux/mfd/sun4i-gpadc.h b/include/linux/mfd/sun4i-gpadc.h
index d31d962bb7d8..36046a0d91f3 100644
--- a/include/linux/mfd/sun4i-gpadc.h
+++ b/include/linux/mfd/sun4i-gpadc.h
@@ -39,9 +39,13 @@
 #define SUN6I_GPADC_CTRL1_ADC_CHAN_MASK			GENMASK(3, 0)
 
 /* TP_CTRL1 bits for sun8i A23/A33 SoCs */
+/* TP_CTRL1 bits for sun8i A23/A33 SoCs */
 #define SUN8I_A23_GPADC_CTRL1_CHOP_TEMP_EN		BIT(8)
 #define SUN8I_A23_GPADC_CTRL1_GPADC_CALI_EN		BIT(7)
 
+/* TP_CTRL1 bits for SoCs after H3 */
+#define SUN8I_H3_GPADC_CTRL1_GPADC_CALI_EN		BIT(17)
+ 
 #define SUN4I_GPADC_CTRL2				0x08
 
 #define SUN4I_GPADC_CTRL2_TP_SENSITIVE_ADJUST(x)	((GENMASK(3, 0) & (x)) << 28)
@@ -49,7 +53,17 @@
 #define SUN4I_GPADC_CTRL2_PRE_MEA_EN			BIT(24)
 #define SUN4I_GPADC_CTRL2_PRE_MEA_THRE_CNT(x)		(GENMASK(23, 0) & (x))
 
+#define SUN8I_H3_GPADC_CTRL2				0x40
+
+#define SUN8I_H3_GPADC_CTRL2_TEMP_SENSE_EN		BIT(0)
+#define SUN8I_H3_GPADC_CTRL2_T_ACQ1(x)			((GENMASK(15, 0) * (x)) << 16)
+
 #define SUN4I_GPADC_CTRL3				0x0c
+/*
+ * This register is named "Average filter Control Register" in H3 Datasheet,
+ * but the register's definition is the same as the old CTRL3 register.
+ */
+#define SUN8I_H3_GPADC_CTRL3				0x70
 
 #define SUN4I_GPADC_CTRL3_FILTER_EN			BIT(2)
 #define SUN4I_GPADC_CTRL3_FILTER_TYPE(x)		(GENMASK(1, 0) & (x))
@@ -71,6 +85,13 @@
 #define SUN4I_GPADC_INT_FIFOC_TP_UP_IRQ_EN		BIT(1)
 #define SUN4I_GPADC_INT_FIFOC_TP_DOWN_IRQ_EN		BIT(0)
 
+#define SUN8I_H3_GPADC_INTC				0x44
+
+#define SUN8I_H3_GPADC_INTC_TEMP_PERIOD(x)		((GENMASK(19, 0) & (x)) << 12)
+#define SUN8I_H3_GPADC_INTC_TEMP_DATA			BIT(8)
+#define SUN8I_H3_GPADC_INTC_TEMP_SHUT			BIT(4)
+#define SUN8I_H3_GPADC_INTC_TEMP_ALARM			BIT(0)
+
 #define SUN4I_GPADC_INT_FIFOS				0x14
 
 #define SUN4I_GPADC_INT_FIFOS_TEMP_DATA_PENDING		BIT(18)
@@ -80,9 +101,16 @@
 #define SUN4I_GPADC_INT_FIFOS_TP_UP_PENDING		BIT(1)
 #define SUN4I_GPADC_INT_FIFOS_TP_DOWN_PENDING		BIT(0)
 
+#define SUN8I_H3_GPADC_INTS				0x44
+
+#define SUN8I_H3_GPADC_INTS_TEMP_DATA			BIT(8)
+#define SUN8I_H3_GPADC_INTS_TEMP_SHUT			BIT(4)
+#define SUN8I_H3_GPADC_INTS_TEMP_ALARM			BIT(0)
+
 #define SUN4I_GPADC_CDAT				0x1c
 #define SUN4I_GPADC_TEMP_DATA				0x20
 #define SUN4I_GPADC_DATA				0x24
+#define SUN8I_H3_GPADC_TEMP_DATA			0x80
 
 #define SUN4I_GPADC_IRQ_FIFO_DATA			0
 #define SUN4I_GPADC_IRQ_TEMP_DATA			1
-- 
2.12.2
