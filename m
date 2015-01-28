From: Lina Iyer <lina.iyer@linaro.org>
Subject: Re: [PATCH] thermal: Add msm tsens thermal sensor driver
Date: Wed, 28 Jan 2015 10:01:07 -0700
Message-ID: <20150128170107.GB680@linaro.org>
References: <1422331786-19620-1-git-send-email-nrajan@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:59756 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760706AbbA1Upc (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 28 Jan 2015 15:45:32 -0500
Received: by mail-pa0-f49.google.com with SMTP id fa1so29488749pad.8
        for <linux-pm@vger.kernel.org>; Wed, 28 Jan 2015 12:45:31 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1422331786-19620-1-git-send-email-nrajan@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Narendran Rajan <nrajan@codeaurora.org>
Cc: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Linux ARM MSM <linux-arm-msm@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Siddartha Mohanadoss <smohanad@codeaurora.org>, Stephen Boyd <sboyd@codeaurora.org>

On Mon, Jan 26 2015 at 21:10 -0700, Narendran Rajan wrote:
>TSENS supports reading temperature from multiple thermal
>sensors present in QCOM SOCs.
>TSENS HW is enabled only when the main sensor is requested.
>The TSENS block is disabled if the main senors is disabled
>irrespective of any other sensors that are being enabled.
>TSENS driver supports configurable threshold for temperature
>monitoring in which case it can generate an interrupt when specific
>thresholds are reached
>
>Based on code by Siddartha Mohanadoss and Stephen Boyd.
>
>Cc: Siddartha Mohanadoss <smohanad@codeaurora.org>
>Cc: Stephen Boyd <sboyd@codeaurora.org>
>Signed-off-by: Narendran Rajan  <nrajan@codeaurora.org>
>---
> drivers/thermal/Kconfig         |  14 +
> drivers/thermal/Makefile        |   1 +
> drivers/thermal/msm8960_tsens.c | 841 ++++++++++++++++++++++++++++++++++++++++
> 3 files changed, 856 insertions(+)
> create mode 100644 drivers/thermal/msm8960_tsens.c
>
>diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
>index 20915ca..a4cb2c0 100644
>--- a/drivers/thermal/Kconfig
>+++ b/drivers/thermal/Kconfig
>@@ -261,6 +261,20 @@ config INTEL_SOC_DTS_THERMAL
> 	  notification methods.The other trip is a critical trip point, which
> 	  was set by the driver based on the TJ MAX temperature.
>
>+config THERMAL_TSENS8960
>+	tristate "Qualcomm 8960 Tsens Temperature driver"
>+	depends on THERMAL
>+	depends on ARCH_QCOM
>+	help
>+	  QCOM tsens thermal driver provides support for Temperature sensor
>+	  (TSENS) found on QCOM SoCs. It supports four configurable trip points
>+	  and controls multiple sensors on the SOC. The four trip points are
>+	  common across all sensors present in the SoC. The number of sensors
>+	  present vary from chip to chip and are set through device tree entry.
>+	  The driver presents as a standard thermal zone device with configurable
>+	  trip points and cooling device mapping through standard thermal zone
>+	  device tree
>+
> menu "ACPI INT340X thermal drivers"
> source drivers/thermal/int340x_thermal/Kconfig
> endmenu
>diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
>index fa0dc48..23c7a34 100644
>--- a/drivers/thermal/Makefile
>+++ b/drivers/thermal/Makefile
>@@ -39,3 +39,4 @@ obj-$(CONFIG_TI_SOC_THERMAL)	+= ti-soc-thermal/
> obj-$(CONFIG_INT340X_THERMAL)  += int340x_thermal/
> obj-$(CONFIG_ST_THERMAL)	+= st/
> obj-$(CONFIG_TEGRA_SOCTHERM)	+= tegra_soctherm.o
>+obj-$(CONFIG_THERMAL_TSENS8960)	+= msm8960_tsens.o
>diff --git a/drivers/thermal/msm8960_tsens.c b/drivers/thermal/msm8960_tsens.c
>new file mode 100644
>index 0000000..307bdc8
>--- /dev/null
>+++ b/drivers/thermal/msm8960_tsens.c
>@@ -0,0 +1,841 @@
>+/* Copyright (c) 2015, The Linux Foundation. All rights reserved.
>+ *
>+ * This program is free software; you can redistribute it and/or modify
>+ * it under the terms of the GNU General Public License version 2 and
>+ * only version 2 as published by the Free Software Foundation.
>+ *
>+ * This program is distributed in the hope that it will be useful,
>+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
>+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>+ * GNU General Public License for more details.
>+ *
>+ */
>+
>+#include <linux/kernel.h>
>+#include <linux/module.h>
>+#include <linux/platform_device.h>
>+#include <linux/thermal.h>
>+#include <linux/interrupt.h>
>+#include <linux/delay.h>
>+#include <linux/slab.h>
>+#include <linux/err.h>
>+#include <linux/pm.h>
>+#include <linux/bitops.h>
>+#include <linux/regmap.h>
>+#include <linux/of.h>
>+#include <linux/of_address.h>
>+#include <linux/of_platform.h>
>+#include <linux/io.h>
>+#include <linux/mfd/syscon.h>
>+
>+/* Trips: from very hot to very cold */
>+enum tsens_trip_type {
>+	TSENS_TRIP_STAGE3,
>+	TSENS_TRIP_STAGE2,
>+	TSENS_TRIP_STAGE1,
>+	TSENS_TRIP_STAGE0,
>+	TSENS_TRIP_NUM,
>+};

Care to explain why is this different from the trip_types defined in
linux/thermal.h ?

>+
>+#define TSENS_CAL_MDEGC				30000
>+
>+#define TSENS_MAX_SENSORS			11
>+
>+#define TSENS_8960_CONFIG_ADDR			0x3640
>+#define TSENS_8960_CONFIG			0x9b
>+#define TSENS_8960_CONFIG_MASK			0xf
>+
>+#define TSENS_CNTL_ADDR				0x3620
>+#define TSENS_CNTL_RESUME_MASK			0xfffffff9
>+#define TSENS_EN				BIT(0)
>+#define TSENS_SW_RST				BIT(1)
>+#define SENSOR0_EN				BIT(3)
>+#define TSENS_MIN_STATUS_MASK			BIT(0)
>+#define TSENS_LOWER_STATUS_CLR			BIT(1)
>+#define TSENS_UPPER_STATUS_CLR			BIT(2)
>+#define TSENS_MAX_STATUS_MASK			BIT(3)
>+#define TSENS_MEASURE_PERIOD			1
>+#define TSENS_8960_SLP_CLK_ENA			BIT(26)
>+#define TSENS_8660_SLP_CLK_ENA			BIT(24)
>+#define TSENS_8064_STATUS_CNTL			0x3660
>+
>+#define TSENS_THRESHOLD_ADDR			0x3624
>+#define TSENS_THRESHOLD_MAX_CODE		0xff
>+#define TSENS_THRESHOLD_MIN_CODE		0
>+#define TSENS_THRESHOLD_MAX_LIMIT_SHIFT		24
>+#define TSENS_THRESHOLD_MIN_LIMIT_SHIFT		16
>+#define TSENS_THRESHOLD_UPPER_LIMIT_SHIFT	8
>+#define TSENS_THRESHOLD_LOWER_LIMIT_SHIFT	0
>+
>+/* Initial temperature threshold values */
>+#define TSENS_LOWER_LIMIT_TH			0x50
>+#define TSENS_UPPER_LIMIT_TH			0xdf
>+#define TSENS_MIN_LIMIT_TH			0x0
>+#define TSENS_MAX_LIMIT_TH			0xff
>+
>+#define TSENS_S0_STATUS_ADDR			0x3628
>+
>+#define TSENS_INT_STATUS_ADDR			0x363c
>+#define TSENS_LOWER_INT_MASK			BIT(1)
>+#define TSENS_UPPER_INT_MASK			BIT(2)
>+#define TSENS_MAX_INT_MASK			BIT(3)
>+#define TSENS_TRDY_MASK				BIT(7)
>+
>+#define TSENS_SENSOR_SHIFT			16
>+#define TSENS_REDUND_SHIFT			24
>+#define TSENS_SENSOR0_SHIFT			3
>+
>+#define TSENS_8660_QFPROM_ADDR			0x00bc
>+#define TSENS_8660_CONFIG			1
>+#define TSENS_8660_CONFIG_SHIFT			28
>+#define TSENS_8660_CONFIG_MASK			(3 << TSENS_8660_CONFIG_SHIFT)

Could you align these?
>+
>+struct tsens_device;
>+
>+struct tsens_sensor {
>+	struct thermal_zone_device	*tz_dev;
>+	enum thermal_device_mode	mode;
>+	unsigned int			sensor_num;
>+	int				offset;
>+	u32				slope;
>+	struct tsens_device		*tmdev;
>+	u32                             status;
>+};
>+
>+struct tsens_device {
>+	bool			prev_reading_avail;
>+	unsigned int		num_sensors;
>+	int			pm_tsens_thr_data;
>+	int			pm_tsens_cntl;
>+	unsigned int            calib_offset;
>+	unsigned int            backup_calib_offset;
>+	struct work_struct	tsens_work;
>+	struct regmap		*map;
>+	struct regmap_field	*status_field;
>+	struct tsens_sensor	sensor[0];
>+};
>+
>+static struct device *tsens_dev;
>+
>+/* Temperature on y axis and ADC-code on x-axis */
>+static int
>+tsens_tz_code_to_mdegC(u32 adc_code, const struct tsens_sensor *s)
>+{
>+	return adc_code * s->slope + s->offset;
>+}
>+
>+static int tsens_tz_get_temp(void *_sensor,
>+			     long *temp)
>+{
>+	const struct tsens_sensor *tm_sensor = _sensor;
>+	struct tsens_device *tmdev = tm_sensor->tmdev;
>+	u32 code, trdy;
>+
>+	if (tm_sensor->mode != THERMAL_DEVICE_ENABLED)
>+		return -EINVAL;
>+
>+	if (!tmdev->prev_reading_avail) {
>+		while (!regmap_read(tmdev->map, TSENS_INT_STATUS_ADDR, &trdy) &&
>+		       !(trdy & TSENS_TRDY_MASK))
>+			usleep_range(1000, 1100);
>+		tmdev->prev_reading_avail = true;
>+	}
>+
>+	regmap_read(tmdev->map, tm_sensor->status, &code);
>+	*temp = tsens_tz_code_to_mdegC(code, tm_sensor);
>+
>+	dev_dbg(tsens_dev, "Temperature for sensor %d is: %ld",
>+		tm_sensor->sensor_num, *temp);
>+
>+	return 0;
>+}
>+
>+/*
>+ * If the main sensor is disabled all the sensors are disable and

/s/disable/disabled

>+ * the clock is disabled.
>+ * If the main sensor is disabled and a sub-sensor is enabled
>+ * return with an error.
>+ */
>+static int tsens_tz_set_mode(struct tsens_sensor *tm_sensor,
>+			      enum thermal_device_mode mode)
>+{
>+	struct tsens_device *tmdev = tm_sensor->tmdev;
>+	unsigned int i, n = tmdev->num_sensors;
>+	u32 reg, mask;
>+
>+	if (mode == tm_sensor->mode)
>+		return 0;
>+
>+	regmap_read(tmdev->map, TSENS_CNTL_ADDR, &reg);
>+
>+	mask = BIT(tm_sensor->sensor_num + TSENS_SENSOR0_SHIFT);
>+	if (mode == THERMAL_DEVICE_ENABLED) {
>+		if (!(reg & SENSOR0_EN) && mask != SENSOR0_EN) {
>+			pr_err("Main sensor not enabled\n");
>+			return -EINVAL;
>+		}
>+
>+		regmap_write(tmdev->map, TSENS_CNTL_ADDR, reg | TSENS_SW_RST);
>+		if (tmdev->num_sensors > 1)
>+			reg |= mask | TSENS_8960_SLP_CLK_ENA | TSENS_EN;
>+		else
>+			reg |= mask | TSENS_8660_SLP_CLK_ENA | TSENS_EN;

Instead of doing this check everytime to decide between 8660 and 8960,
at init you could set the right mask value in the tsens_device.

>+		tmdev->prev_reading_avail = false;
>+	} else {
>+		reg &= ~mask;
>+		if (!(reg & SENSOR0_EN)) {
>+			dev_warn(tsens_dev, "Main sensor not enabled. Disabling subsensors\n");
>+
>+			reg &= ~GENMASK(n + TSENS_SENSOR0_SHIFT - 1,
>+					TSENS_SENSOR0_SHIFT);
>+			reg &= ~TSENS_EN;
>+
>+			if (tmdev->num_sensors > 1)
>+				reg &= ~TSENS_8960_SLP_CLK_ENA;
>+			else
>+				reg &= ~TSENS_8660_SLP_CLK_ENA;
>+
>+			/* Disable all sub-sensors */
>+			for (i = 1; i < n; i++)
>+				tmdev->sensor[i].mode = mode;
>+		}
>+	}
>+
>+	regmap_write(tmdev->map, TSENS_CNTL_ADDR, reg);
>+	tm_sensor->mode = mode;
>+
>+	return 0;
>+}
>+
>+#ifdef THERMAL_TSENS8960_HWTRIPS
>+static int tsens_get_trip_temp(struct tsens_sensor *tm_sensor,
>+				   int trip, int *temp)
>+{
>+	struct tsens_device *tmdev = tm_sensor->tmdev;
>+	u32 reg;
>+
>+	regmap_read(tmdev->map, TSENS_THRESHOLD_ADDR, &reg);
>+	switch (trip) {
>+	case TSENS_TRIP_STAGE3:
>+		reg >>= TSENS_THRESHOLD_MAX_LIMIT_SHIFT;
>+		break;
>+	case TSENS_TRIP_STAGE2:
>+		reg >>= TSENS_THRESHOLD_UPPER_LIMIT_SHIFT;
>+		break;
>+	case TSENS_TRIP_STAGE1:
>+		reg >>= TSENS_THRESHOLD_LOWER_LIMIT_SHIFT;
>+		break;
>+	case TSENS_TRIP_STAGE0:
>+		reg >>= TSENS_THRESHOLD_MIN_LIMIT_SHIFT;
>+		break;
>+	default:
>+		return -EINVAL;
>+	}
>+	reg &= TSENS_THRESHOLD_MAX_CODE;
>+
>+	temp = tsens_tz_code_to_mdegC(reg, tm_sensor);
>+
>+	dev_dbg(tsens_dev, "Sensor %d, trip %d temp is :%d",
>+		tm_sensor->sensor_num, trip, *temp);
>+
>+	return 0;
>+}
>+
>+static void tsens_print_trip_temp(struct tsens_sensor *tm_sensor)
>+{
>+	int temp;
>+
>+	tsens_get_trip_temp(tm_sensor, TSENS_TRIP_STAGE0, &temp);
>+	tsens_get_trip_temp(tm_sensor, TSENS_TRIP_STAGE1, &temp);
>+	tsens_get_trip_temp(tm_sensor, TSENS_TRIP_STAGE2, &temp);
>+	tsens_get_trip_temp(tm_sensor, TSENS_TRIP_STAGE3, &temp);
>+}
>+
>+static int tsens_tz_mdegC_to_code(int mdegC, const struct tsens_sensor *s)
>+{
>+	int code;
>+
>+	code = DIV_ROUND_CLOSEST(mdegC - s->offset, s->slope);
>+	return clamp(code, TSENS_THRESHOLD_MIN_CODE, TSENS_THRESHOLD_MAX_CODE);
>+}
>+
>+static u32 tsens_hi_code(int trip, u32 reg_cntl, u32 thresh)
>+{
>+	u32 hi_code;
>+
>+	switch (trip) {
>+	case TSENS_TRIP_STAGE0:
>+		if (!(reg_cntl & TSENS_LOWER_STATUS_CLR)) {
>+			hi_code = thresh >> TSENS_THRESHOLD_LOWER_LIMIT_SHIFT;
>+			break;
>+		}
>+		/* else fall through */
>+	case TSENS_TRIP_STAGE1:
>+		if (!(reg_cntl & TSENS_UPPER_STATUS_CLR)) {
>+			hi_code = thresh >> TSENS_THRESHOLD_UPPER_LIMIT_SHIFT;
>+			break;
>+		}
>+		/* else fall through */
>+	case TSENS_TRIP_STAGE2:
>+		if (!(reg_cntl & TSENS_MAX_STATUS_MASK)) {
>+			hi_code = thresh >> TSENS_THRESHOLD_MAX_LIMIT_SHIFT;
>+			break;
>+		}
>+		/* else fall through */
>+	case TSENS_TRIP_STAGE3:
>+	default:
>+		hi_code = TSENS_THRESHOLD_MAX_CODE;
>+		break;
>+	}
>+
>+	return hi_code & TSENS_THRESHOLD_MAX_CODE;
>+}
>+
>+static u32 tsens_lo_code(int trip, u32 reg_cntl, u32 thresh)
>+{
>+	u32 lo_code;
>+
>+	switch (trip) {
>+	case TSENS_TRIP_STAGE3:
>+		if (!(reg_cntl & TSENS_UPPER_STATUS_CLR)) {
>+			lo_code = thresh >> TSENS_THRESHOLD_UPPER_LIMIT_SHIFT;
>+			break;
>+		}
>+		/* else fall through */
>+	case TSENS_TRIP_STAGE2:
>+		if (!(reg_cntl & TSENS_LOWER_STATUS_CLR)) {
>+			lo_code = thresh >> TSENS_THRESHOLD_LOWER_LIMIT_SHIFT;
>+			break;
>+		}
>+		/* else fall through */
>+	case TSENS_TRIP_STAGE1:
>+		if (!(reg_cntl & TSENS_MIN_STATUS_MASK)) {
>+			lo_code = thresh >> TSENS_THRESHOLD_MIN_LIMIT_SHIFT;
>+			break;
>+		}
>+		/* else fall through */
>+	case TSENS_TRIP_STAGE0:
>+	default:
>+		lo_code = TSENS_THRESHOLD_MIN_CODE;
>+		break;
>+	}
>+
>+	return lo_code & TSENS_THRESHOLD_MAX_CODE;
>+}
>+
>+static int tsens_tz_set_trip_temp(struct tsens_sensor *tm_sensor,
>+	int trip, unsigned long temp)
>+{
>+	struct tsens_device *tmdev = tm_sensor->tmdev;
>+	struct regmap_field *status = tmdev->status_field;
>+	u32 thresh, reg_cntl, mask = TSENS_THRESHOLD_MAX_CODE;
>+	u32 code, hi_code, lo_code, code_err_chk;
>+
>+	code_err_chk = code = tsens_tz_mdegC_to_code(temp, tm_sensor);
>+
>+	regmap_field_read(status, &reg_cntl);
>+	regmap_read(tmdev->map, TSENS_THRESHOLD_ADDR, &thresh);
>+
>+	switch (trip) {
>+	case TSENS_TRIP_STAGE3:
>+		code <<= TSENS_THRESHOLD_MAX_LIMIT_SHIFT;
>+		mask <<= TSENS_THRESHOLD_MAX_LIMIT_SHIFT;
>+		break;
>+	case TSENS_TRIP_STAGE2:
>+		code <<= TSENS_THRESHOLD_UPPER_LIMIT_SHIFT;
>+		mask <<= TSENS_THRESHOLD_UPPER_LIMIT_SHIFT;
>+		break;
>+	case TSENS_TRIP_STAGE1:
>+		code <<= TSENS_THRESHOLD_LOWER_LIMIT_SHIFT;
>+		mask <<= TSENS_THRESHOLD_LOWER_LIMIT_SHIFT;
>+		break;
>+	case TSENS_TRIP_STAGE0:
>+		code <<= TSENS_THRESHOLD_MIN_LIMIT_SHIFT;
>+		mask <<= TSENS_THRESHOLD_MIN_LIMIT_SHIFT;
>+		break;
>+	default:
>+		return -EINVAL;
>+	}
>+
>+	hi_code = tsens_hi_code(trip, reg_cntl, thresh);
>+	lo_code = tsens_lo_code(trip, reg_cntl, thresh);
>+
>+	if (code_err_chk < lo_code || code_err_chk > hi_code)
>+		return -EINVAL;
>+
>+	regmap_update_bits(tmdev->map, TSENS_THRESHOLD_ADDR, mask, code);
>+
>+	return 0;
>+}
>+
>+static int tsens_set_trips(void *_sensor, long low, long high)
>+{
>+	struct tsens_sensor *tm_sensor = _sensor;
>+
>+	tsens_print_trip_temp(tm_sensor);
>+
>+	if (tsens_tz_set_trip_temp(tm_sensor, TSENS_TRIP_STAGE2, high))
>+		return -EINVAL;
>+
>+	if (tsens_tz_set_trip_temp(tm_sensor, TSENS_TRIP_STAGE1, low))
>+		return -EINVAL;
>+
>+	return 0;
>+}
>+#endif
>+
>+static void tsens_scheduler_fn(struct work_struct *work)
>+{
>+	struct tsens_device *tmdev;
>+	struct regmap_field *status;
>+	unsigned int threshold, threshold_low, i, code, bits, mask = 0;
>+	unsigned long sensor;
>+	bool upper_th_x, lower_th_x;
>+
>+	tmdev = container_of(work, struct tsens_device, tsens_work);
>+	status = tmdev->status_field;
>+
>+	regmap_field_update_bits(status,
>+			TSENS_LOWER_STATUS_CLR | TSENS_UPPER_STATUS_CLR,
>+			TSENS_LOWER_STATUS_CLR | TSENS_UPPER_STATUS_CLR);
>+
>+	regmap_read(tmdev->map, TSENS_THRESHOLD_ADDR, &threshold);
>+	threshold_low = threshold >> TSENS_THRESHOLD_LOWER_LIMIT_SHIFT;
>+	threshold_low &= TSENS_THRESHOLD_MAX_CODE;
>+	threshold = threshold >> TSENS_THRESHOLD_UPPER_LIMIT_SHIFT;
>+	threshold &= TSENS_THRESHOLD_MAX_CODE;
>+
>+	regmap_read(tmdev->map, TSENS_CNTL_ADDR, &bits);
>+	sensor = bits;
>+	sensor >>= TSENS_SENSOR0_SHIFT;
>+	for_each_set_bit(i, &sensor, tmdev->num_sensors) {
>+		regmap_read(tmdev->map, tmdev->sensor[i].status, &code);
>+		upper_th_x = code >= threshold;
>+		lower_th_x = code <= threshold_low;
>+
>+		if (upper_th_x)
>+			mask |= TSENS_UPPER_STATUS_CLR;
>+
>+		if (lower_th_x)
>+			mask |= TSENS_LOWER_STATUS_CLR;
>+
>+#ifdef THERMAL_TSENS8960_HWTRIPS
>+		if (upper_th_x || lower_th_x) {
>+			dev_info(tsens_dev,
>+				"Threshold reached for sensor(%d)\n", i);
>+			thermal_zone_device_update(tmdev->sensor[i].tz_dev);
>+		}
>+#endif
>+	}
>+
>+	regmap_field_update_bits(status,
>+			TSENS_UPPER_STATUS_CLR | TSENS_LOWER_STATUS_CLR, mask);
>+}
>+
>+static irqreturn_t tsens_isr(int irq, void *data)
>+{
>+	schedule_work(data);
>+	return IRQ_HANDLED;
>+}
>+
>+#ifdef CONFIG_PM
>+static int tsens_suspend(struct device *dev)
>+{
>+	int i;
>+	struct tsens_device *tmdev = dev_get_drvdata(dev);
>+	struct regmap *map = tmdev->map;
>+
>+	regmap_read(map, TSENS_THRESHOLD_ADDR, &tmdev->pm_tsens_thr_data);
>+	regmap_read(map, TSENS_CNTL_ADDR, &tmdev->pm_tsens_cntl);
>+	regmap_update_bits(map, TSENS_CNTL_ADDR,
>+			   TSENS_8960_SLP_CLK_ENA | TSENS_EN, 0);

No check for num_sensors here?
>+
>+	tmdev->prev_reading_avail = 0;
>+	for (i = 0; i < tmdev->num_sensors; i++)
>+		tmdev->sensor[i].mode = THERMAL_DEVICE_DISABLED;
>+
>+	return 0;
>+}
>+
>+static int tsens_resume(struct device *dev)
>+{
>+	int i;
>+	unsigned long reg_cntl;
>+	struct tsens_device *tmdev = dev_get_drvdata(dev);
>+	struct regmap *map = tmdev->map;
>+
>+	regmap_update_bits(map, TSENS_CNTL_ADDR, TSENS_SW_RST, TSENS_SW_RST);
>+	regmap_field_update_bits(tmdev->status_field,
>+			TSENS_MIN_STATUS_MASK | TSENS_MAX_STATUS_MASK,
>+			TSENS_MIN_STATUS_MASK | TSENS_MAX_STATUS_MASK);
>+
>+	if (tmdev->num_sensors > 1)
>+		regmap_update_bits(map, TSENS_8960_CONFIG_ADDR,
>+				TSENS_8960_CONFIG_MASK,
>+				TSENS_8960_CONFIG);

What about 8660?

>+
>+	regmap_write(map, TSENS_THRESHOLD_ADDR, tmdev->pm_tsens_thr_data);
>+	regmap_write(map, TSENS_CNTL_ADDR, tmdev->pm_tsens_cntl);
>+
>+	reg_cntl = tmdev->pm_tsens_cntl;
>+	reg_cntl >>= TSENS_SENSOR0_SHIFT;
>+	for_each_set_bit(i, &reg_cntl, tmdev->num_sensors)
>+		tmdev->sensor[i].mode = THERMAL_DEVICE_ENABLED;
>+
>+	return 0;
>+}
>+
>+static const struct dev_pm_ops tsens_pm_ops = {
>+	.suspend	= tsens_suspend,
>+	.resume		= tsens_resume,
>+};
>+#endif
>+
>+static void tsens_disable_mode(const struct tsens_device *tmdev)
>+{
>+	u32 reg_cntl;
>+	u32 mask;
>+
>+	mask = GENMASK(tmdev->num_sensors - 1, 0);
>+	mask <<= TSENS_SENSOR0_SHIFT;
>+	mask |= TSENS_EN;
>+
>+	regmap_read(tmdev->map, TSENS_CNTL_ADDR, &reg_cntl);
>+	reg_cntl &= ~mask;
>+	if (tmdev->num_sensors > 1)
>+		reg_cntl &= ~TSENS_8960_SLP_CLK_ENA;
>+	else
>+		reg_cntl &= ~TSENS_8660_SLP_CLK_ENA;
>+	regmap_write(tmdev->map, TSENS_CNTL_ADDR, reg_cntl);
>+}
>+
>+static void tsens_hw_init(struct tsens_device *tmdev)
>+{
>+	u32 reg_cntl, reg_thr;
>+
>+	reg_cntl = TSENS_SW_RST;
>+	regmap_update_bits(tmdev->map, TSENS_CNTL_ADDR, TSENS_SW_RST, reg_cntl);
>+
>+	if (tmdev->num_sensors > 1) {
>+		reg_cntl |= TSENS_8960_SLP_CLK_ENA |
>+			(TSENS_MEASURE_PERIOD << 18);
>+		reg_cntl &= ~TSENS_SW_RST;
>+		regmap_update_bits(tmdev->map, TSENS_8960_CONFIG_ADDR,
>+				   TSENS_8960_CONFIG_MASK, TSENS_8960_CONFIG);
>+	} else {
>+		reg_cntl |= TSENS_8660_SLP_CLK_ENA |
>+			(TSENS_MEASURE_PERIOD << 16);
>+		reg_cntl &= ~TSENS_8660_CONFIG_MASK;
>+		reg_cntl |= TSENS_8660_CONFIG << TSENS_8660_CONFIG_SHIFT;
>+	}
>+
>+	reg_cntl |= GENMASK(tmdev->num_sensors - 1, 0) << TSENS_SENSOR0_SHIFT;
>+	regmap_write(tmdev->map, TSENS_CNTL_ADDR, reg_cntl);
>+
>+	regmap_field_update_bits(tmdev->status_field,
>+			TSENS_LOWER_STATUS_CLR | TSENS_UPPER_STATUS_CLR |
>+			TSENS_MIN_STATUS_MASK | TSENS_MAX_STATUS_MASK,
>+			TSENS_LOWER_STATUS_CLR | TSENS_UPPER_STATUS_CLR |
>+			TSENS_MIN_STATUS_MASK | TSENS_MAX_STATUS_MASK);
>+
>+	reg_cntl |= TSENS_EN;
>+	regmap_write(tmdev->map, TSENS_CNTL_ADDR, reg_cntl);
>+
>+	reg_thr = (TSENS_LOWER_LIMIT_TH << TSENS_THRESHOLD_LOWER_LIMIT_SHIFT) |
>+		(TSENS_UPPER_LIMIT_TH << TSENS_THRESHOLD_UPPER_LIMIT_SHIFT) |
>+		(TSENS_MIN_LIMIT_TH << TSENS_THRESHOLD_MIN_LIMIT_SHIFT) |
>+		(TSENS_MAX_LIMIT_TH << TSENS_THRESHOLD_MAX_LIMIT_SHIFT);
>+	regmap_write(tmdev->map, TSENS_THRESHOLD_ADDR, reg_thr);
>+}
>+
>+static int
>+tsens_calib_sensors8660(struct tsens_device *tmdev, struct regmap *map)
>+{
>+	u32 temp_data, data;
>+	struct tsens_sensor *s = &tmdev->sensor[0];
>+
>+	if (regmap_read(map, tmdev->calib_offset, &temp_data))
>+		return -EINVAL;
>+
>+	data = (temp_data >> 24) & 0xff;
>+
>+	if (!data) {
>+		dev_err(tsens_dev, "QFPROM TSENS calibration data not present\n");
>+		return -EINVAL;
>+	}
>+
>+	s->offset = TSENS_CAL_MDEGC - s->slope * data;
>+
>+	return 0;
>+}
>+
>+static int
>+tsens_calib_sensors8960(struct tsens_device *tmdev, struct regmap *map)
>+{
>+	int i;
>+	u32 temp_data[TSENS_MAX_SENSORS];
>+	u8 *byte_data;
>+	u32 fuse, redun, num_read;
>+	struct tsens_sensor *s = tmdev->sensor;
>+
>+	fuse = tmdev->calib_offset;
>+	redun = tmdev->backup_calib_offset;
>+
>+	/**
>+	* syscon regmap is 32-bit data, but calibration data is 8-bit.
>+	* read 4 bytes from regmap in a loop and then extract bytes seprately
>+	*/
>+
>+	num_read = DIV_ROUND_UP(tmdev->num_sensors, 4);
>+
>+	for (i = 0; i < num_read; i++) {
>+		if (regmap_read(map, (redun + i*4), &temp_data[i]))
>+			return -EINVAL;
>+
>+		if (!temp_data[i]) {
>+			dev_dbg(tsens_dev, "Main calib data not valid\n");
>+			if (regmap_read(map, (fuse + i*4), &temp_data[i]))
>+				return -EINVAL;
>+		}
>+	}
>+
>+	byte_data = (u8 *)temp_data;
>+
>+	for (i = 0; i < tmdev->num_sensors; i++, s++) {
>+		s->offset = TSENS_CAL_MDEGC - s->slope * byte_data[i];
>+		dev_dbg(tsens_dev, "calib data %d is %c", i, byte_data[i]);
>+	}
>+
>+	return 0;
>+}
>+
>+static const struct thermal_zone_of_device_ops tsens_thermal_of_ops = {
>+	.get_temp = tsens_tz_get_temp,
>+};
>+
>+
>+static int tsens_register(struct tsens_device *tmdev, int i)
>+{
>+	char name[18];
>+	u32 addr = TSENS_S0_STATUS_ADDR;
>+	struct tsens_sensor *s = &tmdev->sensor[i];
>+
>+	/*
>+	* The status registers for each sensor are discontiguous
>+	* because some SoCs have 5 sensors while others have more
>+	* but the control registers stay in the same place, i.e.
>+	* directly after the first 5 status registers.
>+	*/
>+	if (i >= 5)
>+		addr += 40;
>+
>+	addr += i * 4;
>+
>+	snprintf(name, sizeof(name), "tsens_tz_sensor%d", i);
>+	s->mode = THERMAL_DEVICE_ENABLED;
>+	s->sensor_num = i;
>+	s->status = addr;
>+	s->tmdev = tmdev;
>+	s->tz_dev = thermal_zone_of_sensor_register(tsens_dev, i, s,
>+						&tsens_thermal_of_ops);
>+
>+	if (IS_ERR(s->tz_dev))
>+		return -ENODEV;
>+
>+	return 0;
>+}
>+
>+static int tsens_probe(struct platform_device *pdev)
>+{
>+	struct device_node *np = pdev->dev.of_node;
>+	struct device_node *base_node;
>+	struct platform_device *base_pdev;
>+	int ret, i, irq, num;
>+	struct tsens_sensor *s;
>+	struct tsens_device *tmdev;
>+	struct regmap *map, *imem_regmap;
>+	struct reg_field *field;
>+	static struct reg_field status_0 = {
>+		.reg = TSENS_8064_STATUS_CNTL,
>+		.lsb = 0,
>+		.msb = 3,
>+	};
>+	static struct reg_field status_8 = {
>+		.reg = TSENS_CNTL_ADDR,
>+		.lsb = 8,
>+		.msb = 11,
>+	};
>+
>+	tsens_dev = &pdev->dev;
>+
>+	num = of_property_count_u32_elems(np, "qcom,tsens-slopes");
>+	if (num <= 0) {
>+		dev_err(tsens_dev, "invalid tsens slopes\n");
>+		return -EINVAL;
>+	}
>+
>+	tmdev = devm_kzalloc(tsens_dev, sizeof(*tmdev) +
>+			     num * sizeof(struct tsens_sensor), GFP_KERNEL);

Any particular reason, the sensors are appended to the tmdev, instead of
allocating separately?

>+	if (tmdev == NULL)
>+		return -ENOMEM;
>+
>+	tmdev->num_sensors = num;
>+	for (i = 0, s = tmdev->sensor; i < num; i++, s++)
>+		of_property_read_u32_index(np, "qcom,tsens-slopes", i,
>+					   &s->slope);
>+
>+	irq = platform_get_irq(pdev, 0);
>+	if (irq < 0) {
>+		dev_err(tsens_dev,  "no irq resource?\n");
>+		return  -EINVAL;
>+	}
>+
>+	ret = of_property_read_u32_index(np, "qcom,calib-offsets", 0,
>+					   &tmdev->calib_offset);
>+	if (ret != 0) {
>+		dev_err(tsens_dev,  "No calibration offset set\n");
>+		return  -EINVAL;
>+	}
>+
>+	ret = of_property_read_u32_index(np, "qcom,calib-offsets", 1,
>+					   &tmdev->backup_calib_offset);
>+	if (ret) {
>+		dev_info(tsens_dev, "Missing backup calibration offset\n");
>+		tmdev->backup_calib_offset = tmdev->calib_offset;
>+	}
>+
>+	imem_regmap = syscon_regmap_lookup_by_phandle(np, "qcom,imem");
>+	if (IS_ERR(imem_regmap)) {
>+		dev_err(tsens_dev, "syscon regmap look up error\n");
>+		return PTR_ERR(imem_regmap);
>+	}
>+
>+	if (num == 1)
>+		ret = tsens_calib_sensors8660(tmdev, imem_regmap);
>+	else
>+		ret = tsens_calib_sensors8960(tmdev, imem_regmap);
>+
>+	if (ret < 0) {
>+		dev_err(tsens_dev, "tsense calibration failed\n");
>+		return ret;
>+	}
>+
>+	base_node = of_parse_phandle(np, "qcom,tsens-base", 0);
>+	if (base_node == NULL) {
>+		dev_err(tsens_dev, "no base node present\n");
>+		return  -EINVAL;
>+	}
>+
>+	base_pdev = of_find_device_by_node(base_node);
>+	if (base_pdev == NULL) {
>+		dev_err(tsens_dev, "no base pdev node\n");
>+		return  -ENODEV;
>+	}
>+
>+	tmdev->map = map = dev_get_regmap(&base_pdev->dev, NULL);
>+	if (map == NULL) {
>+		dev_err(tsens_dev, "base regmap get failed\n");
>+		return  -ENODEV;
>+	}
>+
>+	/* Status bits move when the sensor bits next to them overlap */
>+	if (num > 5)
>+		field = &status_0;
>+	else
>+		field = &status_8;
>+
>+	tmdev->status_field = devm_regmap_field_alloc(tsens_dev, map, *field);
>+	if (IS_ERR(tmdev->status_field)) {
>+		dev_err(tsens_dev, "regmap alloc failed\n");
>+		return PTR_ERR(tmdev->status_field);
>+	}
>+
>+	tsens_hw_init(tmdev);
>+
>+	/*
>+	 * Register sensor 0 separately. This sensor is always
>+	 * expected to be present and if this fails, thermal
>+	 * sensor probe would fail
>+	 * Other sensors are optional and if registration fails
>+	 * disable the sensor and continue
>+	*/
>+	ret = tsens_register(tmdev, 0);
>+	if (ret < 0) {
>+		dev_err(tsens_dev, "Registering failed for primary sensor");
>+		ret = -ENODEV;
>+		goto fail;
>+	} else {
>+		tsens_tz_set_mode(&tmdev->sensor[0], THERMAL_DEVICE_ENABLED);
>+	}
>+
>+	for (i = 1;  i < tmdev->num_sensors; i++) {
>+		ret = tsens_register(tmdev, i);
>+
>+		if (ret < 0) {
>+			dev_err(tsens_dev,
>+				"Registering failed. Sensor(%i), disabled", i);
>+			tsens_tz_set_mode(&tmdev->sensor[i],
>+				THERMAL_DEVICE_DISABLED);
>+		} else {
>+			tsens_tz_set_mode(&tmdev->sensor[i],
>+				THERMAL_DEVICE_ENABLED);
>+		}
>+	}
>+
>+	INIT_WORK(&tmdev->tsens_work, tsens_scheduler_fn);
>+
>+	ret = devm_request_irq(tsens_dev, irq, tsens_isr, IRQF_TRIGGER_RISING,
>+			       "tsens", &tmdev->tsens_work);
>+	if (ret < 0)
>+		goto err_irq;
>+
>+	platform_set_drvdata(pdev, tmdev);
>+
>+	dev_info(tsens_dev, "Tsens driver initialized\n");
>+
>+	return 0;
>+err_irq:
>+	for (i = 0, s = tmdev->sensor; i < tmdev->num_sensors; i++, s++)
>+		thermal_zone_of_sensor_unregister(&pdev->dev, s->tz_dev);
>+fail:
>+	tsens_disable_mode(tmdev);
>+	return ret;
>+}
>+
>+static int tsens_remove(struct platform_device *pdev)
>+{
>+	int i;
>+	struct tsens_sensor *s;
>+	struct tsens_device *tmdev = platform_get_drvdata(pdev);
>+
>+	tsens_disable_mode(tmdev);
>+	for (i = 0, s = tmdev->sensor; i < tmdev->num_sensors; i++, s++)
>+		thermal_zone_device_unregister(s->tz_dev);
>+
>+	return 0;
>+}
>+
>+static struct of_device_id tsens_match_table[] = {
>+	{.compatible = "qcom,ipq806x-tsens"},
>+	{},
>+};
>+
>+MODULE_DEVICE_TABLE(of, tsens_match_table);
>+
>+static struct platform_driver tsens_driver = {
>+	.probe = tsens_probe,
>+	.remove = tsens_remove,
>+	.driver = {
>+		.of_match_table = tsens_match_table,
>+		.name = "tsens8960-thermal",
>+		.owner = THIS_MODULE,
>+#ifdef CONFIG_PM
>+		.pm	= &tsens_pm_ops,
>+#endif
>+	},
>+};
>+module_platform_driver(tsens_driver);
>+
>+MODULE_LICENSE("GPL v2");
>+MODULE_DESCRIPTION("Temperature Sensor driver");
>+MODULE_ALIAS("platform:tsens8960-tm");
>-- 
>Qualcomm Innovation Center, Inc. The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project
>
>--
>To unsubscribe from this list: send the line "unsubscribe linux-pm" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
