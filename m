From: Quentin Schulz <quentin.schulz@free-electrons.com>
Subject: [PATCH v3 04/18] iio: adc: add support for X-Powers AXP20X and AXP22X
 PMICs ADCs
Date: Tue, 14 Feb 2017 10:40:58 +0100
Message-ID: <20170214094112.27426-5-quentin.schulz@free-electrons.com>
References: <20170214094112.27426-1-quentin.schulz@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170214094112.27426-1-quentin.schulz@free-electrons.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net, robh+dt@kernel.org, mark.rutland@arm.com, wens@csie.org, sre@kernel.org, linux@armlinux.org.uk, maxime.ripard@free-electrons.com, lee.jones@linaro.org
Cc: thomas.petazzoni@free-electrons.com, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Quentin Schulz <quentin.schulz@free-electrons.com>, bonbons@linux-vserver.org, icenowy@aosc.xyz, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

The X-Powers AXP20X and AXP22X PMICs have multiple ADCs. They expose the
battery voltage, battery charge and discharge currents, AC-in and VBUS
voltages and currents, 2 GPIOs muxable in ADC mode and PMIC temperature.

This adds support for most of AXP20X and AXP22X ADCs.

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---

v3:
 - moved from switch to if condition in axp20x_adc_raw and
 axp22x_adc_raw,
 - removed DT support as DT node has been dropped,
   - use of platform_device_id
 - correctly defined the name of the iio device (name used to probe the
 driver),
 - added goto for errors in probe,
 - added iio_map_array_unregister to the remove function,

v2:
 - removed unused defines,
 - changed BIT(x) to 1 << x when describing bits purpose for which 2 <<
 x or 3 << x exists, to be consistent,
 - changed ADC rate defines to macro formulas,
 - reordered IIO channels, now different measures (current/voltage) of
 the same part of the PMIC (e.g. battery), have the same IIO channel in
 their respective IIO type. When a part of the PMIC have only one
 measure, a number is jumped,
 - left IIO channel mapping in DT to use iio_map structure,
 - removed indexing of ADC internal temperature,
 - removed unused iio_dev structure in axp20x_adc_iio,
 - added a structure for data specific to AXP20X or AXP22X PMICs instead
 of using an ID and an if condition when needing to separate the
 behaviour of both,
 - added a comment on batt_chrg_i really being on 12bits rather than
 what the Chinese datasheets say (13 bits),
 - corrected the offset for AXP22X PMIC temperature,
 - set the ADC rate to a value (100Hz) shared by the AXP20X and AXP22X,
 - created macro formulas to compute the ADC rate for each,
 - added a condition on presence of ADC_EN2 reg before setting/resetting
 it,
 - switched from devm_iio_device_unregister to the non-devm function
 because of the need for a remove function,
 - removed some dead code,

 drivers/iio/adc/Kconfig      |  10 +
 drivers/iio/adc/Makefile     |   1 +
 drivers/iio/adc/axp20x_adc.c | 606 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 617 insertions(+)
 create mode 100644 drivers/iio/adc/axp20x_adc.c

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 9c8b558..ed17fe1 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -154,6 +154,16 @@ config AT91_SAMA5D2_ADC
 	  To compile this driver as a module, choose M here: the module will be
 	  called at91-sama5d2_adc.
 
+config AXP20X_ADC
+	tristate "X-Powers AXP20X and AXP22X ADC driver"
+	depends on MFD_AXP20X
+	help
+	  Say yes here to have support for X-Powers power management IC (PMIC)
+	  AXP20X and AXP22X ADC devices.
+
+	  To compile this driver as a module, choose M here: the module will be
+	  called axp20x_adc.
+
 config AXP288_ADC
 	tristate "X-Powers AXP288 ADC driver"
 	depends on MFD_AXP20X
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index d36c4be..f5c28a5 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -16,6 +16,7 @@ obj-$(CONFIG_AD7887) += ad7887.o
 obj-$(CONFIG_AD799X) += ad799x.o
 obj-$(CONFIG_AT91_ADC) += at91_adc.o
 obj-$(CONFIG_AT91_SAMA5D2_ADC) += at91-sama5d2_adc.o
+obj-$(CONFIG_AXP20X_ADC) += axp20x_adc.o
 obj-$(CONFIG_AXP288_ADC) += axp288_adc.o
 obj-$(CONFIG_BCM_IPROC_ADC) += bcm_iproc_adc.o
 obj-$(CONFIG_BERLIN2_ADC) += berlin2-adc.o
diff --git a/drivers/iio/adc/axp20x_adc.c b/drivers/iio/adc/axp20x_adc.c
new file mode 100644
index 0000000..5ef6af8
--- /dev/null
+++ b/drivers/iio/adc/axp20x_adc.c
@@ -0,0 +1,606 @@
+/* ADC driver for AXP20X and AXP22X PMICs
+ *
+ * Copyright (c) 2016 Free Electrons NextThing Co.
+ *	Quentin Schulz <quentin.schulz@free-electrons.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it under
+ * the terms of the GNU General Public License version 2 as published by the
+ * Free Software Foundation.
+ */
+
+#include <linux/completion.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/regmap.h>
+#include <linux/thermal.h>
+
+#include <linux/iio/iio.h>
+#include <linux/iio/driver.h>
+#include <linux/iio/machine.h>
+#include <linux/mfd/axp20x.h>
+
+#define AXP20X_ADC_EN1_MASK			GENMASK(7, 0)
+
+#define AXP20X_ADC_EN2_MASK			(GENMASK(3, 2) | BIT(7))
+#define AXP22X_ADC_EN1_MASK			(GENMASK(7, 5) | BIT(0))
+
+#define AXP20X_GPIO10_IN_RANGE_GPIO0		BIT(0)
+#define AXP20X_GPIO10_IN_RANGE_GPIO1		BIT(1)
+#define AXP20X_GPIO10_IN_RANGE_GPIO0_VAL(x)	((x) & BIT(0))
+#define AXP20X_GPIO10_IN_RANGE_GPIO1_VAL(x)	(((x) & BIT(0)) << 1)
+
+#define AXP20X_ADC_RATE_MASK			GENMASK(7, 6)
+#define AXP20X_ADC_RATE_HZ(x)			((ilog2((x) / 25) << 6) & AXP20X_ADC_RATE_MASK)
+#define AXP22X_ADC_RATE_HZ(x)			((ilog2((x) / 100) << 6) & AXP20X_ADC_RATE_MASK)
+
+#define AXP20X_ADC_CHANNEL(_channel, _name, _type, _reg)	\
+	{							\
+		.type = _type,					\
+		.indexed = 1,					\
+		.channel = _channel,				\
+		.address = _reg,				\
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |	\
+				      BIT(IIO_CHAN_INFO_SCALE),	\
+		.datasheet_name = _name,			\
+	}
+
+#define AXP20X_ADC_CHANNEL_OFFSET(_channel, _name, _type, _reg) \
+	{							\
+		.type = _type,					\
+		.indexed = 1,					\
+		.channel = _channel,				\
+		.address = _reg,				\
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |	\
+				      BIT(IIO_CHAN_INFO_SCALE) |\
+				      BIT(IIO_CHAN_INFO_OFFSET),\
+		.datasheet_name = _name,			\
+	}
+
+struct axp_data;
+
+struct axp20x_adc_iio {
+	struct regmap		*regmap;
+	struct axp_data		*data;
+};
+
+enum axp20x_adc_channel_v {
+	AXP20X_ACIN_V = 0,
+	AXP20X_VBUS_V,
+	AXP20X_TS_IN,
+	AXP20X_GPIO0_V,
+	AXP20X_GPIO1_V,
+	AXP20X_IPSOUT_V,
+	AXP20X_BATT_V,
+};
+
+enum axp20x_adc_channel_i {
+	AXP20X_ACIN_I = 0,
+	AXP20X_VBUS_I,
+	AXP20X_BATT_CHRG_I,
+	AXP20X_BATT_DISCHRG_I,
+};
+
+enum axp22x_adc_channel_v {
+	AXP22X_TS_IN = 0,
+	AXP22X_BATT_V,
+};
+
+enum axp22x_adc_channel_i {
+	AXP22X_BATT_CHRG_I = 1,
+	AXP22X_BATT_DISCHRG_I,
+};
+
+static struct iio_map axp20x_maps[] = {
+	{
+		.consumer_dev_name = "axp20x-usb-power-supply",
+		.consumer_channel = "vbus_v",
+		.adc_channel_label = "vbus_v",
+	}, {
+		.consumer_dev_name = "axp20x-usb-power-supply",
+		.consumer_channel = "vbus_i",
+		.adc_channel_label = "vbus_i",
+	}, {
+		.consumer_dev_name = "axp20x-ac-power-supply",
+		.consumer_channel = "acin_v",
+		.adc_channel_label = "acin_v",
+	}, {
+		.consumer_dev_name = "axp20x-ac-power-supply",
+		.consumer_channel = "acin_i",
+		.adc_channel_label = "acin_i",
+	}, {
+		.consumer_dev_name = "axp20x-battery-power-supply",
+		.consumer_channel = "batt_v",
+		.adc_channel_label = "batt_v",
+	}, {
+		.consumer_dev_name = "axp20x-battery-power-supply",
+		.consumer_channel = "batt_chrg_i",
+		.adc_channel_label = "batt_chrg_i",
+	}, {
+		.consumer_dev_name = "axp20x-battery-power-supply",
+		.consumer_channel = "batt_dischrg_i",
+		.adc_channel_label = "batt_dischrg_i",
+	}, { /* sentinel */ }
+};
+
+static struct iio_map axp22x_maps[] = {
+	{
+		.consumer_dev_name = "axp20x-battery-power-supply",
+		.consumer_channel = "batt_v",
+		.adc_channel_label = "batt_v",
+	}, {
+		.consumer_dev_name = "axp20x-battery-power-supply",
+		.consumer_channel = "batt_chrg_i",
+		.adc_channel_label = "batt_chrg_i",
+	}, {
+		.consumer_dev_name = "axp20x-battery-power-supply",
+		.consumer_channel = "batt_dischrg_i",
+		.adc_channel_label = "batt_dischrg_i",
+	}, { /* sentinel */ }
+};
+
+/*
+ * Channels are mapped by physical system. Their channels share the same index.
+ * i.e. acin_i is in_current0_raw and acin_v is in_voltage0_raw.
+ * The only exception is for the battery. batt_v will be in_voltage6_raw and
+ * charge current in_current6_raw and discharge current will be in_current7_raw.
+ */
+static const struct iio_chan_spec axp20x_adc_channels[] = {
+	AXP20X_ADC_CHANNEL(AXP20X_ACIN_V, "acin_v", IIO_VOLTAGE,
+			   AXP20X_ACIN_V_ADC_H),
+	AXP20X_ADC_CHANNEL(AXP20X_ACIN_I, "acin_i", IIO_CURRENT,
+			   AXP20X_ACIN_I_ADC_H),
+	AXP20X_ADC_CHANNEL(AXP20X_VBUS_V, "vbus_v", IIO_VOLTAGE,
+			   AXP20X_VBUS_V_ADC_H),
+	AXP20X_ADC_CHANNEL(AXP20X_VBUS_I, "vbus_i", IIO_CURRENT,
+			   AXP20X_VBUS_I_ADC_H),
+	{
+		.type = IIO_TEMP,
+		.address = AXP20X_TEMP_ADC_H,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_SCALE) |
+				      BIT(IIO_CHAN_INFO_OFFSET),
+		.datasheet_name = "pmic_temp",
+	},
+	AXP20X_ADC_CHANNEL_OFFSET(AXP20X_GPIO0_V, "gpio0_v", IIO_VOLTAGE,
+				  AXP20X_GPIO0_V_ADC_H),
+	AXP20X_ADC_CHANNEL_OFFSET(AXP20X_GPIO1_V, "gpio1_v", IIO_VOLTAGE,
+				  AXP20X_GPIO1_V_ADC_H),
+	AXP20X_ADC_CHANNEL(AXP20X_IPSOUT_V, "ipsout_v", IIO_VOLTAGE,
+			   AXP20X_IPSOUT_V_HIGH_H),
+	AXP20X_ADC_CHANNEL(AXP20X_BATT_V, "batt_v", IIO_VOLTAGE,
+			   AXP20X_BATT_V_H),
+	AXP20X_ADC_CHANNEL(AXP20X_BATT_CHRG_I, "batt_chrg_i", IIO_CURRENT,
+			   AXP20X_BATT_CHRG_I_H),
+	AXP20X_ADC_CHANNEL(AXP20X_BATT_DISCHRG_I, "batt_dischrg_i", IIO_CURRENT,
+			   AXP20X_BATT_DISCHRG_I_H),
+};
+
+static const struct iio_chan_spec axp22x_adc_channels[] = {
+	{
+		.type = IIO_TEMP,
+		.address = AXP22X_PMIC_TEMP_H,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_SCALE) |
+				      BIT(IIO_CHAN_INFO_OFFSET),
+		.datasheet_name = "pmic_temp",
+	},
+	AXP20X_ADC_CHANNEL(AXP22X_BATT_V, "batt_v", IIO_VOLTAGE,
+			   AXP20X_BATT_V_H),
+	AXP20X_ADC_CHANNEL(AXP22X_BATT_CHRG_I, "batt_chrg_i", IIO_CURRENT,
+			   AXP20X_BATT_CHRG_I_H),
+	AXP20X_ADC_CHANNEL(AXP22X_BATT_DISCHRG_I, "batt_dischrg_i", IIO_CURRENT,
+			   AXP20X_BATT_DISCHRG_I_H),
+};
+
+static int axp20x_adc_raw(struct iio_dev *indio_dev,
+			  struct iio_chan_spec const *chan, int *val)
+{
+	struct axp20x_adc_iio *info = iio_priv(indio_dev);
+	int size = 12;
+
+	/*
+	 *N.B.:  Unlike the Chinese datasheets tell, the charging current is
+	 * stored on 12 bits, not 13 bits. Only discharging current is on 13
+	 * bits.
+	 */
+	if (chan->type == IIO_CURRENT && chan->channel == AXP20X_BATT_DISCHRG_I)
+		size = 13;
+	else
+		size = 12;
+
+	*val = axp20x_read_variable_width(info->regmap, chan->address, size);
+	if (*val < 0)
+		return *val;
+
+	return IIO_VAL_INT;
+}
+
+static int axp22x_adc_raw(struct iio_dev *indio_dev,
+			  struct iio_chan_spec const *chan, int *val)
+{
+	struct axp20x_adc_iio *info = iio_priv(indio_dev);
+	int size;
+
+	/*
+	 * N.B.: Unlike the Chinese datasheets tell, the charging current is
+	 * stored on 12 bits, not 13 bits. Only discharging current is on 13
+	 * bits.
+	 */
+	if (chan->type == IIO_CURRENT && chan->channel == AXP22X_BATT_DISCHRG_I)
+		size = 13;
+	else
+		size = 12;
+
+	*val = axp20x_read_variable_width(info->regmap, chan->address, size);
+	if (*val < 0)
+		return *val;
+
+	return IIO_VAL_INT;
+}
+
+static int axp20x_adc_scale_voltage(int channel, int *val, int *val2)
+{
+	switch (channel) {
+	case AXP20X_ACIN_V:
+	case AXP20X_VBUS_V:
+		*val = 1;
+		*val2 = 700000;
+		return IIO_VAL_INT_PLUS_MICRO;
+
+	case AXP20X_GPIO0_V:
+	case AXP20X_GPIO1_V:
+		*val = 0;
+		*val2 = 500000;
+		return IIO_VAL_INT_PLUS_MICRO;
+
+	case AXP20X_BATT_V:
+		*val = 1;
+		*val2 = 100000;
+		return IIO_VAL_INT_PLUS_MICRO;
+
+	case AXP20X_IPSOUT_V:
+		*val = 1;
+		*val2 = 400000;
+		return IIO_VAL_INT_PLUS_MICRO;
+
+	default:
+		return -EINVAL;
+	}
+}
+
+static int axp20x_adc_scale_current(int channel, int *val, int *val2)
+{
+	switch (channel) {
+	case AXP20X_ACIN_I:
+		*val = 0;
+		*val2 = 625000;
+		return IIO_VAL_INT_PLUS_MICRO;
+
+	case AXP20X_VBUS_I:
+		*val = 0;
+		*val2 = 375000;
+		return IIO_VAL_INT_PLUS_MICRO;
+
+	case AXP20X_BATT_DISCHRG_I:
+	case AXP20X_BATT_CHRG_I:
+		*val = 0;
+		*val2 = 500000;
+		return IIO_VAL_INT_PLUS_MICRO;
+
+	default:
+		return -EINVAL;
+	}
+}
+
+static int axp20x_adc_scale(struct iio_chan_spec const *chan, int *val,
+			    int *val2)
+{
+	switch (chan->type) {
+	case IIO_VOLTAGE:
+		return axp20x_adc_scale_voltage(chan->channel, val, val2);
+
+	case IIO_CURRENT:
+		return axp20x_adc_scale_current(chan->channel, val, val2);
+
+	case IIO_TEMP:
+		*val = 100;
+		return IIO_VAL_INT;
+
+	default:
+		return -EINVAL;
+	}
+}
+
+static int axp22x_adc_scale(struct iio_chan_spec const *chan, int *val,
+			    int *val2)
+{
+	switch (chan->type) {
+	case IIO_VOLTAGE:
+		if (chan->channel != AXP22X_BATT_V)
+			return -EINVAL;
+
+		*val = 1;
+		*val2 = 100000;
+		return IIO_VAL_INT_PLUS_MICRO;
+
+	case IIO_CURRENT:
+		*val = 0;
+		*val2 = 500000;
+		return IIO_VAL_INT_PLUS_MICRO;
+
+	case IIO_TEMP:
+		*val = 100;
+		return IIO_VAL_INT;
+
+	default:
+		return -EINVAL;
+	}
+}
+
+static int axp20x_adc_offset_voltage(struct iio_dev *indio_dev, int channel,
+				     int *val)
+{
+	struct axp20x_adc_iio *info = iio_priv(indio_dev);
+	int ret, reg;
+
+	if (channel != AXP20X_GPIO0_V && channel != AXP20X_GPIO1_V)
+		return -EINVAL;
+
+	ret = regmap_read(info->regmap, AXP20X_GPIO10_IN_RANGE, &reg);
+	if (ret < 0)
+		return ret;
+
+	if (channel == AXP20X_GPIO0_V)
+		*val = reg & AXP20X_GPIO10_IN_RANGE_GPIO0;
+	else
+		*val = reg & AXP20X_GPIO10_IN_RANGE_GPIO1;
+
+	*val = !!(*val) * 700000;
+
+	return IIO_VAL_INT;
+}
+
+static int axp20x_adc_offset(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan, int *val)
+{
+	switch (chan->type) {
+	case IIO_VOLTAGE:
+		return axp20x_adc_offset_voltage(indio_dev, chan->channel, val);
+
+	case IIO_TEMP:
+		*val = -1447;
+		return IIO_VAL_INT;
+
+	default:
+		return -EINVAL;
+	}
+}
+
+static int axp20x_read_raw(struct iio_dev *indio_dev,
+			   struct iio_chan_spec const *chan, int *val,
+			   int *val2, long mask)
+{
+	switch (mask) {
+	case IIO_CHAN_INFO_OFFSET:
+		return axp20x_adc_offset(indio_dev, chan, val);
+
+	case IIO_CHAN_INFO_SCALE:
+		return axp20x_adc_scale(chan, val, val2);
+
+	case IIO_CHAN_INFO_RAW:
+		return axp20x_adc_raw(indio_dev, chan, val);
+
+	default:
+		return -EINVAL;
+	}
+}
+
+static int axp22x_read_raw(struct iio_dev *indio_dev,
+			   struct iio_chan_spec const *chan, int *val,
+			   int *val2, long mask)
+{
+	switch (mask) {
+	case IIO_CHAN_INFO_OFFSET:
+		*val = -2677;
+		return IIO_VAL_INT;
+
+	case IIO_CHAN_INFO_SCALE:
+		return axp22x_adc_scale(chan, val, val2);
+
+	case IIO_CHAN_INFO_RAW:
+		return axp22x_adc_raw(indio_dev, chan, val);
+
+	default:
+		return -EINVAL;
+	}
+}
+
+static int axp20x_write_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan, int val, int val2,
+			    long mask)
+{
+	struct axp20x_adc_iio *info = iio_priv(indio_dev);
+
+	/*
+	 * The AXP20X PMIC allows the user to choose between 0V and 0.7V offsets
+	 * for (independently) GPIO0 and GPIO1 when in ADC mode.
+	 */
+	if (mask != IIO_CHAN_INFO_OFFSET)
+		return -EINVAL;
+
+	if (chan->channel != AXP20X_GPIO0_V && chan->channel != AXP20X_GPIO1_V)
+		return -EINVAL;
+
+	if (val != 0 && val != 700000)
+		return -EINVAL;
+
+	if (chan->channel == AXP20X_GPIO0_V)
+		return regmap_update_bits(info->regmap, AXP20X_GPIO10_IN_RANGE,
+					  AXP20X_GPIO10_IN_RANGE_GPIO0,
+					  AXP20X_GPIO10_IN_RANGE_GPIO0_VAL(!!val));
+
+	return regmap_update_bits(info->regmap, AXP20X_GPIO10_IN_RANGE,
+				  AXP20X_GPIO10_IN_RANGE_GPIO1,
+				  AXP20X_GPIO10_IN_RANGE_GPIO1_VAL(!!val));
+}
+
+static const struct iio_info axp20x_adc_iio_info = {
+	.read_raw = axp20x_read_raw,
+	.write_raw = axp20x_write_raw,
+	.driver_module = THIS_MODULE,
+};
+
+static const struct iio_info axp22x_adc_iio_info = {
+	.read_raw = axp22x_read_raw,
+	.driver_module = THIS_MODULE,
+};
+
+static int axp20x_adc_rate(int rate)
+{
+	return AXP20X_ADC_RATE_HZ(rate);
+}
+
+static int axp22x_adc_rate(int rate)
+{
+	return AXP22X_ADC_RATE_HZ(rate);
+}
+
+struct axp_data {
+	const struct iio_info		*iio_info;
+	int				num_channels;
+	struct iio_chan_spec const	*channels;
+	unsigned long			adc_en1_mask;
+	int				(*adc_rate)(int rate);
+	bool				adc_en2;
+	struct iio_map			*maps;
+};
+
+static const struct axp_data axp20x_data = {
+	.iio_info = &axp20x_adc_iio_info,
+	.num_channels = ARRAY_SIZE(axp20x_adc_channels),
+	.channels = axp20x_adc_channels,
+	.adc_en1_mask = AXP20X_ADC_EN1_MASK,
+	.adc_rate = axp20x_adc_rate,
+	.adc_en2 = true,
+	.maps = axp20x_maps,
+};
+
+static const struct axp_data axp22x_data = {
+	.iio_info = &axp22x_adc_iio_info,
+	.num_channels = ARRAY_SIZE(axp22x_adc_channels),
+	.channels = axp22x_adc_channels,
+	.adc_en1_mask = AXP22X_ADC_EN1_MASK,
+	.adc_rate = axp22x_adc_rate,
+	.adc_en2 = false,
+	.maps = axp22x_maps,
+};
+
+static const struct platform_device_id axp20x_adc_id_match[] = {
+	{ .name = "axp20x-adc", .driver_data = (kernel_ulong_t)&axp20x_data, },
+	{ .name = "axp22x-adc", .driver_data = (kernel_ulong_t)&axp22x_data, },
+	{ /* sentinel */ },
+};
+
+static int axp20x_probe(struct platform_device *pdev)
+{
+	struct axp20x_adc_iio *info;
+	struct iio_dev *indio_dev;
+	struct axp20x_dev *axp20x_dev;
+	int ret;
+
+	axp20x_dev = dev_get_drvdata(pdev->dev.parent);
+
+	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*info));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	info = iio_priv(indio_dev);
+	platform_set_drvdata(pdev, indio_dev);
+
+	info->regmap = axp20x_dev->regmap;
+	indio_dev->dev.parent = &pdev->dev;
+	indio_dev->dev.of_node = pdev->dev.of_node;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+
+	info->data = (struct axp_data *)platform_get_device_id(pdev)->driver_data;
+
+	indio_dev->name = platform_get_device_id(pdev)->name;
+	indio_dev->info = info->data->iio_info;
+	indio_dev->num_channels = info->data->num_channels;
+	indio_dev->channels = info->data->channels;
+
+	/* Enable the ADCs on IP */
+	regmap_write(info->regmap, AXP20X_ADC_EN1, info->data->adc_en1_mask);
+
+	if (info->data->adc_en2)
+		/* Enable GPIO0/1 and internal temperature ADCs */
+		regmap_update_bits(info->regmap, AXP20X_ADC_EN2,
+				   AXP20X_ADC_EN2_MASK, AXP20X_ADC_EN2_MASK);
+
+	/* Configure ADCs rate */
+	regmap_update_bits(info->regmap, AXP20X_ADC_RATE, AXP20X_ADC_RATE_MASK,
+			   info->data->adc_rate(100));
+
+	ret = iio_map_array_register(indio_dev, info->data->maps);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "failed to register IIO maps: %d\n", ret);
+		goto fail_map;
+	}
+
+	ret = iio_device_register(indio_dev);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "could not register the device\n");
+		goto fail_register;
+	}
+
+	return 0;
+
+fail_register:
+	iio_map_array_unregister(indio_dev);
+
+fail_map:
+	regmap_write(info->regmap, AXP20X_ADC_EN1, 0);
+
+	if (info->data->adc_en2)
+		regmap_write(info->regmap, AXP20X_ADC_EN2, 0);
+
+	return ret;
+}
+
+static int axp20x_remove(struct platform_device *pdev)
+{
+	struct axp20x_adc_iio *info;
+	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
+
+	info = iio_priv(indio_dev);
+
+	iio_device_unregister(indio_dev);
+	iio_map_array_unregister(indio_dev);
+
+	regmap_write(info->regmap, AXP20X_ADC_EN1, 0);
+
+	if (info->data->adc_en2)
+		regmap_write(info->regmap, AXP20X_ADC_EN2, 0);
+
+	return 0;
+}
+
+static struct platform_driver axp20x_adc_driver = {
+	.driver = {
+		.name = "axp20x-adc",
+	},
+	.id_table = axp20x_adc_id_match,
+	.probe = axp20x_probe,
+	.remove = axp20x_remove,
+};
+
+module_platform_driver(axp20x_adc_driver);
+
+MODULE_DESCRIPTION("ADC driver for AXP20X and AXP22X PMICs");
+MODULE_AUTHOR("Quentin Schulz <quentin.schulz@free-electrons.com>");
+MODULE_LICENSE("GPL");
-- 
2.9.3
