Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C8AA4A263D
	for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 20:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792009198; cv=none; b=JtyOPhTcLtEXirClNRcSx04QQQ20yNU0NIsIbchqXjKs94Cd4zi9NN2nitaI5DvhUUQy/x8P2eqwo1W8VPuD1D/dVGvIxH6kxu0uWKxVuiFZPVugYIhbi4NHWY1h+TipsGiGgF3qQ3rUeG5KfeDHswBVXDYomcBXer66IejFCXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792009198; c=relaxed/simple;
	bh=IlahQo3u5eKOXzPmhN7/01OFa6t9wly191FC5oL4OZk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=XnDjOWYxHFkf3NK5V7zXoWD8fml2ICjZJuqbxS7SdGnQrdk3OFaTnd8qVAt5RcReJq/jrmB3Do3GqakPxEVSrTLPI1jFWiR8P00XUqBk8EJxrmCmGMxjvkyWTJn5gLeiFwJ1KiJaD3yCZzycHXCV2jEDbeVWcCYSBlGbXgmtI9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=U8d0zDhk; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7FipUAZJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="U8d0zDhk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7FipUAZJ"
Date: Wed, 14 Oct 2026 20:19:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1792009194;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gJ08Md0s/s0pRLFHE6RXZ9/DQXjMJWJUX6LEBxdeH8M=;
	b=U8d0zDhkTGOaBz8xrhOkaqLESNgRWhxnJHpPlFZmPRuy6nqH7nADWscLZLZxfUk6WV/oPa
	6iz3oE++vlZCxoUaV50WQjs2Pyd7KEFylHuItSVBrlF3gaPZkx5XiVj0xnmjRw4T7QFvkG
	1oHop1KFSKA3wRBl+XwNaARv9htQtFpt2ynlTGtrDf2dd01TQrEsy605pLWLP37MPDW1S/
	p1tpg1eBNq4P0+hiYDEUt1yaA+8eGM8vHB8C9YpC5BXfakzXRLCGWP2YPLEOPjYVaNgSrU
	Zi4lysDosxO92oFGL3xIaxy3mWNDEiEqvZsmBNVWLAAMPqvS/5YzR1Q+t1PXsg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1792009194;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gJ08Md0s/s0pRLFHE6RXZ9/DQXjMJWJUX6LEBxdeH8M=;
	b=7FipUAZJIihHTha8YW/YGvA22ai4d7+dkcW3mSLcy6THeRRw4FftDXsHZgoyKyVhDRYRcM
	wvSVj+LAm4n1j1Cg==
From: "thermal-bot for Tudor Ambarus" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Subject: [thermal: thermal/linux-next] thermal/drivers/samsung: Add Exynos
 ACPM TMU driver GS101
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>,
 Daniel Lezcano <daniel.lezcano@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
 Peter Griffin <peter.griffin@linaro.org>,
 Alexey Klimov <alexey.klimov@linaro.org>, andre.draszik@linaro.org,
 daniel.lezcano@oss.qualcomm.com
In-Reply-To: <20260603-acpm-tmu-v8-2-0f1810a356e6@linaro.org>
References: <20260603-acpm-tmu-v8-2-0f1810a356e6@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <179200919301.2666337.12517504774023278071.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the thermal/linux-next branch of th=
ermal:

Commit-ID:     50a2c5d4062a95146f71f974e1feb2ec5c786ccd
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.=
git//50a2c5d4062a95146f71f974e1feb2ec5c786ccd
Author:        Tudor Ambarus <tudor.ambarus@linaro.org>
AuthorDate:    Wed, 03 Jun 2026 13:00:17=20
Committer:     Daniel Lezcano <daniel.lezcano@kernel.org>
CommitterDate: Tue, 13 Oct 2026 16:26:16 +02:00

thermal/drivers/samsung: Add Exynos ACPM TMU driver GS101

Add driver for the Thermal Management Unit (TMU) managed via the Alive
Clock and Power Manager (ACPM), found on Samsung Exynos SoCs such as
the Google GS101.

The TMU on the GS101 utilizes a hybrid management model shared between
the Application Processor (AP) and the ACPM firmware. The driver
maintains direct memory-mapped access to the TMU interrupt pending
registers to identify thermal events, while delegating functional
tasks - such as sensor initialization, threshold configuration, and
temperature acquisition, to the ACPM firmware via the ACPM IPC
protocol.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@kernel.org>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Acked-by: Peter Griffin <peter.griffin@linaro.org>
Reviewed-by: Alexey Klimov <alexey.klimov@linaro.org>
Reviewed-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>
Link: https://patch.msgid.link/20260603-acpm-tmu-v8-2-0f1810a356e6@linaro.org
---
 drivers/thermal/samsung/Kconfig    |  19 +-
 drivers/thermal/samsung/Makefile   |   2 +-
 drivers/thermal/samsung/acpm-tmu.c | 651 ++++++++++++++++++++++++++++-
 3 files changed, 672 insertions(+)
 create mode 100644 drivers/thermal/samsung/acpm-tmu.c

diff --git a/drivers/thermal/samsung/Kconfig b/drivers/thermal/samsung/Kconfig
index e1e8035..f63eeae 100644
--- a/drivers/thermal/samsung/Kconfig
+++ b/drivers/thermal/samsung/Kconfig
@@ -10,3 +10,22 @@ config EXYNOS_THERMAL
 	  the TMU, reports temperature and handles cooling action if defined.
 	  This driver uses the Exynos core thermal APIs and TMU configuration
 	  data from the supported SoCs.
+
+config EXYNOS_ACPM_THERMAL
+	tristate "Exynos ACPM thermal management unit driver"
+	depends on THERMAL_OF
+	depends on HAS_IOMEM
+	depends on EXYNOS_ACPM_PROTOCOL
+	default ARCH_EXYNOS
+	help
+	  Support for the Thermal Management Unit (TMU) on Samsung Exynos SoCs
+	  utilizing the ACPM IPC protocol, such as the Google GS101.
+
+	  The TMU on these platforms is managed through a hybrid architecture.
+	  This driver handles direct register access for thermal interrupt status
+	  monitoring and communicates with the Alive Clock and Power Manager
+	  (ACPM) firmware via the ACPM IPC protocol for functional sensor control
+	  and configuration.
+
+	  Select this if you want to monitor device temperature and enable
+	  thermal mitigation on Samsung Exynos ACPM based devices.
diff --git a/drivers/thermal/samsung/Makefile b/drivers/thermal/samsung/Makef=
ile
index f139407..daed806 100644
--- a/drivers/thermal/samsung/Makefile
+++ b/drivers/thermal/samsung/Makefile
@@ -4,3 +4,5 @@
 #
 obj-$(CONFIG_EXYNOS_THERMAL)			+=3D exynos_thermal.o
 exynos_thermal-y				:=3D exynos_tmu.o
+obj-$(CONFIG_EXYNOS_ACPM_THERMAL)		+=3D exynos_acpm_thermal.o
+exynos_acpm_thermal-y				:=3D acpm-tmu.o
diff --git a/drivers/thermal/samsung/acpm-tmu.c b/drivers/thermal/samsung/acp=
m-tmu.c
new file mode 100644
index 0000000..f980208
--- /dev/null
+++ b/drivers/thermal/samsung/acpm-tmu.c
@@ -0,0 +1,651 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright 2019 Samsung Electronics Co., Ltd.
+ * Copyright 2025 Google LLC.
+ * Copyright 2026 Linaro Ltd.
+ */
+
+#include <linux/cleanup.h>
+#include <linux/clk.h>
+#include <linux/device/devres.h>
+#include <linux/err.h>
+#include <linux/firmware/samsung/exynos-acpm-protocol.h>
+#include <linux/interrupt.h>
+#include <linux/minmax.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/regmap.h>
+#include <linux/thermal.h>
+#include <linux/units.h>
+
+#include "../thermal_hwmon.h"
+
+#define EXYNOS_TMU_SENSOR(i)		BIT(i)
+#define EXYNOS_TMU_SENSORS_MAX_COUNT	16
+
+#define GS101_CPUCL2_SENSOR_MASK (EXYNOS_TMU_SENSOR(0) |	\
+				  EXYNOS_TMU_SENSOR(6) |	\
+				  EXYNOS_TMU_SENSOR(7) |	\
+				  EXYNOS_TMU_SENSOR(8) |	\
+				  EXYNOS_TMU_SENSOR(9))
+#define GS101_CPUCL1_SENSOR_MASK (EXYNOS_TMU_SENSOR(4) |	\
+				  EXYNOS_TMU_SENSOR(5))
+#define GS101_CPUCL0_SENSOR_MASK (EXYNOS_TMU_SENSOR(1) |	\
+				  EXYNOS_TMU_SENSOR(2))
+
+#define GS101_REG_INTPEND(i)		((i) * 0x50 + 0xf8)
+
+enum {
+	P0_INTPEND,
+	P1_INTPEND,
+	P2_INTPEND,
+	P3_INTPEND,
+	P4_INTPEND,
+	P5_INTPEND,
+	P6_INTPEND,
+	P7_INTPEND,
+	P8_INTPEND,
+	P9_INTPEND,
+	P10_INTPEND,
+	P11_INTPEND,
+	P12_INTPEND,
+	P13_INTPEND,
+	P14_INTPEND,
+	P15_INTPEND,
+	REG_INTPEND_COUNT,
+};
+
+struct acpm_tmu_sensor_group {
+	u16 mask;
+	u8 id;
+};
+
+struct acpm_tmu_sensor {
+	const struct acpm_tmu_sensor_group *group;
+	struct thermal_zone_device *tzd;
+	struct acpm_tmu_priv *priv;
+	struct mutex lock; /* protects sensor state */
+	bool enabled;
+};
+
+struct acpm_tmu_priv {
+	struct regmap_field *regmap_fields[REG_INTPEND_COUNT];
+	struct acpm_handle *handle;
+	struct device *dev;
+	struct clk *clk;
+	unsigned int mbox_chan_id;
+	unsigned int num_sensors;
+	int irq;
+	struct acpm_tmu_sensor sensors[] __counted_by(num_sensors);
+};
+
+struct acpm_tmu_driver_data {
+	const struct reg_field *reg_fields;
+	const struct acpm_tmu_sensor_group *sensor_groups;
+	unsigned int num_sensor_groups;
+	unsigned int mbox_chan_id;
+};
+
+#define ACPM_TMU_SENSOR_GROUP(_mask, _id)		\
+	{					\
+		.mask	=3D _mask,		\
+		.id	=3D _id,			\
+	}
+
+static const struct acpm_tmu_sensor_group gs101_sensor_groups[] =3D {
+	ACPM_TMU_SENSOR_GROUP(GS101_CPUCL2_SENSOR_MASK, 0),
+	ACPM_TMU_SENSOR_GROUP(GS101_CPUCL1_SENSOR_MASK, 1),
+	ACPM_TMU_SENSOR_GROUP(GS101_CPUCL0_SENSOR_MASK, 2),
+};
+
+static const struct reg_field gs101_reg_fields[REG_INTPEND_COUNT] =3D {
+	[P0_INTPEND] =3D REG_FIELD(GS101_REG_INTPEND(0), 0, 31),
+	[P1_INTPEND] =3D REG_FIELD(GS101_REG_INTPEND(1), 0, 31),
+	[P2_INTPEND] =3D REG_FIELD(GS101_REG_INTPEND(2), 0, 31),
+	[P3_INTPEND] =3D REG_FIELD(GS101_REG_INTPEND(3), 0, 31),
+	[P4_INTPEND] =3D REG_FIELD(GS101_REG_INTPEND(4), 0, 31),
+	[P5_INTPEND] =3D REG_FIELD(GS101_REG_INTPEND(5), 0, 31),
+	[P6_INTPEND] =3D REG_FIELD(GS101_REG_INTPEND(6), 0, 31),
+	[P7_INTPEND] =3D REG_FIELD(GS101_REG_INTPEND(7), 0, 31),
+	[P8_INTPEND] =3D REG_FIELD(GS101_REG_INTPEND(8), 0, 31),
+	[P9_INTPEND] =3D REG_FIELD(GS101_REG_INTPEND(9), 0, 31),
+	[P10_INTPEND] =3D REG_FIELD(GS101_REG_INTPEND(10), 0, 31),
+	[P11_INTPEND] =3D REG_FIELD(GS101_REG_INTPEND(11), 0, 31),
+	[P12_INTPEND] =3D REG_FIELD(GS101_REG_INTPEND(12), 0, 31),
+	[P13_INTPEND] =3D REG_FIELD(GS101_REG_INTPEND(13), 0, 31),
+	[P14_INTPEND] =3D REG_FIELD(GS101_REG_INTPEND(14), 0, 31),
+	[P15_INTPEND] =3D REG_FIELD(GS101_REG_INTPEND(15), 0, 31),
+};
+
+static const struct regmap_config gs101_regmap_config =3D {
+	.reg_bits =3D 32,
+	.reg_stride =3D 4,
+	.val_bits =3D 32,
+	.use_relaxed_mmio =3D true,
+	.max_register =3D GS101_REG_INTPEND(15),
+};
+
+static const struct acpm_tmu_driver_data acpm_tmu_gs101 =3D {
+	.reg_fields =3D gs101_reg_fields,
+	.sensor_groups =3D gs101_sensor_groups,
+	.num_sensor_groups =3D ARRAY_SIZE(gs101_sensor_groups),
+	.mbox_chan_id =3D 9,
+};
+
+static int acpm_tmu_op_tz_control(struct acpm_tmu_sensor *sensor, bool on)
+{
+	struct acpm_tmu_priv *priv =3D sensor->priv;
+	struct acpm_handle *handle =3D priv->handle;
+	const struct acpm_tmu_ops *ops =3D &handle->ops->tmu;
+	int ret;
+
+	ret =3D ops->tz_control(handle, priv->mbox_chan_id, sensor->group->id,
+			      on);
+	if (ret)
+		return ret;
+
+	sensor->enabled =3D on;
+
+	return 0;
+}
+
+static void acpm_tmu_control_rollback(struct acpm_tmu_priv *priv, int start_=
idx)
+{
+	int i;
+
+	for (i =3D start_idx; i >=3D 0; i--) {
+		struct acpm_tmu_sensor *sensor =3D &priv->sensors[i];
+		int ret;
+
+		if (!sensor->tzd)
+			continue;
+
+		mutex_lock(&sensor->lock);
+		ret =3D acpm_tmu_op_tz_control(sensor, false);
+		mutex_unlock(&sensor->lock);
+		if (ret)
+			dev_err(priv->dev, "Rollback: Failed to disable sensor %d: %d\n",
+				i, ret);
+	}
+}
+
+static int acpm_tmu_control(struct acpm_tmu_priv *priv, bool on, bool rollba=
ck)
+{
+	struct device *dev =3D priv->dev;
+	int i, ret, err =3D 0;
+
+	ret =3D pm_runtime_resume_and_get(dev);
+	if (ret < 0)
+		return ret;
+
+	for (i =3D 0; i < priv->num_sensors; i++) {
+		struct acpm_tmu_sensor *sensor =3D &priv->sensors[i];
+
+		/* Skip sensors that weren't found in DT */
+		if (!sensor->tzd)
+			continue;
+
+		mutex_lock(&sensor->lock);
+		ret =3D acpm_tmu_op_tz_control(sensor, on);
+		mutex_unlock(&sensor->lock);
+		if (ret) {
+			if (!err)
+				err =3D ret;
+
+			/* On enable, stop on first error if rollback is requested */
+			if (on && rollback) {
+				acpm_tmu_control_rollback(priv, i - 1);
+				break;
+			}
+		}
+	}
+
+	pm_runtime_put_sync(dev);
+
+	return err;
+}
+
+static int acpm_tmu_get_temp(struct thermal_zone_device *tz, int *temp)
+{
+	struct acpm_tmu_sensor *sensor =3D thermal_zone_device_priv(tz);
+	struct acpm_tmu_priv *priv =3D sensor->priv;
+	struct acpm_handle *handle =3D priv->handle;
+	const struct acpm_tmu_ops *ops =3D &handle->ops->tmu;
+	struct device *dev =3D priv->dev;
+	int acpm_temp =3D 0, ret;
+
+	/*
+	 * Fast path: check locklessly if the sensor is enabled to avoid
+	 * expensive runtime PM operations when it is disabled. Any race with
+	 * concurrent disabling is caught by the second check under the lock
+	 * after PM resume.
+	 */
+	if (!sensor->enabled)
+		return -EAGAIN;
+
+	ret =3D pm_runtime_resume_and_get(dev);
+	if (ret < 0)
+		return ret;
+
+	scoped_guard(mutex, &sensor->lock) {
+		if (!sensor->enabled) {
+			ret =3D -EAGAIN;
+		} else {
+			ret =3D ops->read_temp(handle, priv->mbox_chan_id,
+					     sensor->group->id, &acpm_temp);
+		}
+	}
+
+	pm_runtime_put_autosuspend(dev);
+
+	if (ret)
+		return ret;
+
+	*temp =3D acpm_temp * MILLIDEGREE_PER_DEGREE;
+
+	return 0;
+}
+
+static int acpm_tmu_update_thresholds(struct acpm_tmu_sensor *sensor,
+				      u8 thresholds[2], u8 inten)
+{
+	struct acpm_tmu_priv *priv =3D sensor->priv;
+	struct acpm_handle *handle =3D priv->handle;
+	const struct acpm_tmu_ops *ops =3D &handle->ops->tmu;
+	unsigned int mbox_chan_id =3D priv->mbox_chan_id;
+	u8 acpm_sensor_id =3D sensor->group->id;
+	bool was_enabled;
+	int ret, restore_ret;
+
+	guard(mutex)(&sensor->lock);
+
+	was_enabled =3D sensor->enabled;
+
+	if (was_enabled) {
+		ret =3D acpm_tmu_op_tz_control(sensor, false);
+		if (ret)
+			return ret;
+	}
+
+	ret =3D ops->set_threshold(handle, mbox_chan_id, acpm_sensor_id,
+				 thresholds, 2);
+	if (!ret) {
+		ret =3D ops->set_interrupt_enable(handle, mbox_chan_id,
+						acpm_sensor_id, inten);
+	}
+
+	if (was_enabled) {
+		restore_ret =3D acpm_tmu_op_tz_control(sensor, true);
+		if (restore_ret)
+			dev_err(priv->dev, "Failed to restore sensor state: %d\n",
+				restore_ret);
+		if (!ret)
+			ret =3D restore_ret;
+	}
+
+	return ret;
+}
+
+static int acpm_tmu_set_trips(struct thermal_zone_device *tz, int low, int h=
igh)
+{
+	struct acpm_tmu_sensor *sensor =3D thermal_zone_device_priv(tz);
+	struct acpm_tmu_priv *priv =3D sensor->priv;
+	struct device *dev =3D priv->dev;
+	u8 thresholds[2] =3D {};
+	u8 inten =3D 0;
+	int ret;
+
+	/* If a valid lower bound exists, set the threshold and enable its interrup=
t */
+	if (low > -INT_MAX) {
+		thresholds[0] =3D clamp_val(low / MILLIDEGREE_PER_DEGREE, 0, 255);
+		inten |=3D BIT(0);
+	}
+
+	/* If a valid upper bound exists, set the threshold and enable its interrup=
t */
+	if (high < INT_MAX) {
+		thresholds[1] =3D clamp_val(high / MILLIDEGREE_PER_DEGREE, 0, 255);
+		inten |=3D BIT(1);
+	}
+
+	ret =3D pm_runtime_resume_and_get(dev);
+	if (ret)
+		return ret;
+
+	ret =3D acpm_tmu_update_thresholds(sensor, thresholds, inten);
+
+	pm_runtime_put_autosuspend(dev);
+
+	return ret;
+}
+
+static const struct thermal_zone_device_ops acpm_tmu_sensor_ops =3D {
+	.get_temp =3D acpm_tmu_get_temp,
+	.set_trips =3D acpm_tmu_set_trips,
+};
+
+static int acpm_tmu_has_pending_irq(struct acpm_tmu_sensor *sensor,
+				    bool *pending_irq)
+{
+	struct acpm_tmu_priv *priv =3D sensor->priv;
+	unsigned long mask =3D sensor->group->mask;
+	int i, ret;
+	u32 val;
+
+	guard(mutex)(&sensor->lock);
+
+	for_each_set_bit(i, &mask, EXYNOS_TMU_SENSORS_MAX_COUNT) {
+		ret =3D regmap_field_read(priv->regmap_fields[i], &val);
+		if (ret)
+			return ret;
+
+		if (val) {
+			*pending_irq =3D true;
+			break;
+		}
+	}
+
+	return 0;
+}
+
+static irqreturn_t acpm_tmu_thread_fn(int irq, void *id)
+{
+	struct acpm_tmu_priv *priv =3D id;
+	struct acpm_handle *handle =3D priv->handle;
+	const struct acpm_tmu_ops *ops =3D &handle->ops->tmu;
+	struct device *dev =3D priv->dev;
+	bool handled =3D false;
+	int i, ret;
+
+	ret =3D pm_runtime_resume_and_get(dev);
+	if (ret) {
+		dev_err(dev, "Failed to resume: %d\n", ret);
+		return IRQ_NONE;
+	}
+
+	for (i =3D 0; i < priv->num_sensors; i++) {
+		struct acpm_tmu_sensor *sensor =3D &priv->sensors[i];
+		bool pending_irq =3D false;
+
+		if (!sensor->tzd)
+			continue;
+
+		ret =3D acpm_tmu_has_pending_irq(sensor, &pending_irq);
+		if (ret || !pending_irq)
+			continue;
+
+		handled =3D true;
+
+		scoped_guard(mutex, &sensor->lock) {
+			ret =3D ops->clear_tz_irq(handle, priv->mbox_chan_id,
+						sensor->group->id);
+			if (ret)
+				dev_err(priv->dev, "Sensor %d: failed to clear IRQ (%d)\n",
+					i, ret);
+		}
+
+		thermal_zone_device_update(sensor->tzd,
+					   THERMAL_EVENT_UNSPECIFIED);
+	}
+
+	pm_runtime_put_autosuspend(dev);
+
+	return handled ? IRQ_HANDLED : IRQ_NONE;
+}
+
+static const struct of_device_id acpm_tmu_match[] =3D {
+	{ .compatible =3D "google,gs101-tmu-top" },
+	{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(of, acpm_tmu_match);
+
+static int acpm_tmu_probe(struct platform_device *pdev)
+{
+	const struct acpm_tmu_driver_data *data =3D &acpm_tmu_gs101;
+	struct acpm_handle *acpm_handle;
+	struct device *dev =3D &pdev->dev;
+	struct acpm_tmu_priv *priv;
+	struct regmap *regmap;
+	void __iomem *base;
+	int i, ret;
+
+	acpm_handle =3D devm_acpm_get_by_phandle(dev);
+	if (IS_ERR(acpm_handle))
+		return dev_err_probe(dev, PTR_ERR(acpm_handle),
+				     "Failed to get ACPM handle\n");
+
+	priv =3D devm_kzalloc(dev,
+			    struct_size(priv, sensors, data->num_sensor_groups),
+			    GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->dev =3D dev;
+	priv->handle =3D acpm_handle;
+	priv->mbox_chan_id =3D data->mbox_chan_id;
+	priv->num_sensors =3D data->num_sensor_groups;
+
+	platform_set_drvdata(pdev, priv);
+
+	base =3D devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(base))
+		return dev_err_probe(dev, PTR_ERR(base), "Failed to ioremap resource\n");
+
+	regmap =3D devm_regmap_init_mmio(dev, base, &gs101_regmap_config);
+	if (IS_ERR(regmap))
+		return dev_err_probe(dev, PTR_ERR(regmap), "Failed to init regmap\n");
+
+	ret =3D devm_regmap_field_bulk_alloc(dev, regmap, priv->regmap_fields,
+					   data->reg_fields, REG_INTPEND_COUNT);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Unable to map syscon registers\n");
+
+	priv->clk =3D devm_clk_get(dev, NULL);
+	if (IS_ERR(priv->clk))
+		return dev_err_probe(dev, PTR_ERR(priv->clk),
+				     "Failed to get the clock\n");
+
+	priv->irq =3D platform_get_irq(pdev, 0);
+	if (priv->irq < 0)
+		return dev_err_probe(dev, priv->irq, "Failed to get irq\n");
+
+	pm_runtime_set_autosuspend_delay(dev, 100);
+	pm_runtime_use_autosuspend(dev);
+
+	ret =3D devm_pm_runtime_enable(dev);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to enable runtime PM\n");
+
+	ret =3D pm_runtime_resume_and_get(dev);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "Failed to resume device\n");
+
+	ret =3D acpm_handle->ops->tmu.init(acpm_handle, priv->mbox_chan_id);
+	if (ret) {
+		ret =3D dev_err_probe(dev, ret, "Failed to init TMU\n");
+		goto err_pm_put;
+	}
+
+	for (i =3D 0; i < priv->num_sensors; i++) {
+		struct acpm_tmu_sensor *sensor =3D &priv->sensors[i];
+
+		mutex_init(&sensor->lock);
+		sensor->group =3D &data->sensor_groups[i];
+		sensor->priv =3D priv;
+
+		sensor->tzd =3D devm_thermal_of_zone_register(dev, i, sensor,
+							    &acpm_tmu_sensor_ops);
+		if (IS_ERR(sensor->tzd)) {
+			ret =3D PTR_ERR(sensor->tzd);
+			if (ret =3D=3D -ENODEV) {
+				sensor->tzd =3D NULL;
+				dev_dbg(dev, "Sensor %d not used in DT, skipping\n", i);
+				continue;
+			}
+
+			ret =3D dev_err_probe(dev, ret, "Failed to register sensor %d\n", i);
+			goto err_rollback;
+		}
+
+		mutex_lock(&sensor->lock);
+		ret =3D acpm_tmu_op_tz_control(sensor, true);
+		mutex_unlock(&sensor->lock);
+		if (ret) {
+			ret =3D dev_err_probe(dev, ret, "Failed to enable sensor %d\n", i);
+			goto err_rollback;
+		}
+
+		thermal_zone_device_update(sensor->tzd,
+					   THERMAL_EVENT_UNSPECIFIED);
+
+		ret =3D devm_thermal_add_hwmon_sysfs(dev, sensor->tzd);
+		if (ret)
+			dev_warn(dev, "Failed to add hwmon sysfs!\n");
+	}
+
+	ret =3D devm_request_threaded_irq(dev, priv->irq, NULL,
+					acpm_tmu_thread_fn, IRQF_ONESHOT,
+					dev_name(dev), priv);
+	if (ret) {
+		ret =3D dev_err_probe(dev, ret, "Failed to request irq\n");
+		goto err_rollback;
+	}
+
+	pm_runtime_put_autosuspend(dev);
+
+	return 0;
+
+err_rollback:
+	acpm_tmu_control_rollback(priv, i - 1);
+err_pm_put:
+	pm_runtime_dont_use_autosuspend(dev);
+	pm_runtime_put_sync(dev);
+	return ret;
+}
+
+static void acpm_tmu_remove(struct platform_device *pdev)
+{
+	struct acpm_tmu_priv *priv =3D platform_get_drvdata(pdev);
+
+	/* Stop IRQ first to prevent race with thread_fn */
+	disable_irq(priv->irq);
+
+	/*
+	 * Disable autosuspend to force the subsequent pm_runtime_put_sync()
+	 * inside acpm_tmu_control() to synchronously suspend the device
+	 * immediately, preventing clock leaks when the driver is removed.
+	 */
+	pm_runtime_dont_use_autosuspend(&pdev->dev);
+	acpm_tmu_control(priv, false, false);
+}
+
+static int acpm_tmu_suspend(struct device *dev)
+{
+	struct acpm_tmu_priv *priv =3D dev_get_drvdata(dev);
+	struct acpm_handle *handle =3D priv->handle;
+	const struct acpm_tmu_ops *ops =3D &handle->ops->tmu;
+	int ret, restore_ret;
+
+	ret =3D acpm_tmu_control(priv, false, false);
+	if (ret)
+		goto err_restore_sensors;
+
+	/* APB clock not required for this specific msg */
+	ret =3D ops->suspend(handle, priv->mbox_chan_id);
+	if (ret)
+		goto err_restore_sensors;
+
+	ret =3D pm_runtime_force_suspend(dev);
+	if (ret)
+		goto err_resume_acpm;
+
+	return 0;
+
+err_resume_acpm:
+	restore_ret =3D ops->resume(handle, priv->mbox_chan_id);
+	if (restore_ret)
+		dev_err(dev, "Failed to resume ACPM after force suspend failure: %d\n",
+			restore_ret);
+
+err_restore_sensors:
+	restore_ret =3D acpm_tmu_control(priv, true, false);
+	if (restore_ret)
+		dev_err(dev, "Failed to re-enable TMU after suspend failure: %d\n",
+			restore_ret);
+
+	return ret;
+}
+
+static int acpm_tmu_resume(struct device *dev)
+{
+	struct acpm_tmu_priv *priv =3D dev_get_drvdata(dev);
+	struct acpm_handle *handle =3D priv->handle;
+	const struct acpm_tmu_ops *ops =3D &handle->ops->tmu;
+	int ret, restore_ret;
+
+	/* APB clock not required for this specific msg */
+	ret =3D ops->resume(handle, priv->mbox_chan_id);
+	if (ret)
+		return ret;
+
+	ret =3D pm_runtime_force_resume(dev);
+	if (ret)
+		goto err_suspend_acpm;
+
+	ret =3D acpm_tmu_control(priv, true, true);
+	if (ret)
+		goto err_suspend_pm;
+
+	return 0;
+
+err_suspend_pm:
+	restore_ret =3D pm_runtime_force_suspend(dev);
+	if (restore_ret)
+		dev_err(dev, "Failed to force suspend during resume rollback: %d\n",
+			restore_ret);
+err_suspend_acpm:
+	restore_ret =3D ops->suspend(handle, priv->mbox_chan_id);
+	if (restore_ret)
+		dev_err(dev, "Failed to suspend ACPM during resume rollback: %d\n",
+			restore_ret);
+	return ret;
+}
+
+static int acpm_tmu_runtime_suspend(struct device *dev)
+{
+	struct acpm_tmu_priv *priv =3D dev_get_drvdata(dev);
+
+	clk_disable_unprepare(priv->clk);
+
+	return 0;
+}
+
+static int acpm_tmu_runtime_resume(struct device *dev)
+{
+	struct acpm_tmu_priv *priv =3D dev_get_drvdata(dev);
+
+	return clk_prepare_enable(priv->clk);
+}
+
+static const struct dev_pm_ops acpm_tmu_pm_ops =3D {
+	SYSTEM_SLEEP_PM_OPS(acpm_tmu_suspend, acpm_tmu_resume)
+	RUNTIME_PM_OPS(acpm_tmu_runtime_suspend, acpm_tmu_runtime_resume, NULL)
+};
+
+static struct platform_driver acpm_tmu_driver =3D {
+	.driver =3D {
+		.name   =3D "gs-tmu",
+		.pm     =3D pm_ptr(&acpm_tmu_pm_ops),
+		.of_match_table =3D acpm_tmu_match,
+	},
+	.probe =3D acpm_tmu_probe,
+	.remove =3D acpm_tmu_remove,
+};
+module_platform_driver(acpm_tmu_driver);
+
+MODULE_AUTHOR("Tudor Ambarus <tudor.ambarus@linaro.org>");
+MODULE_DESCRIPTION("Samsung Exynos ACPM TMU Driver");
+MODULE_LICENSE("GPL");
