Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794503369;
	b=t/nELuu6t02RPIJztuLfY7MMyCqdpJVDih5vwPyEOD0r1wKil7PPga67QgTMKI4cTKz1
	 19PDHlyFHtQqFu6X65p6Jp1FYoA3rlip8pGsd1FtbanJ2v8as9D4oqvMznMhuMyMtdpVs
	 V/fz4FdUuKQYq2QboZ5gt0931EV/RMdTGX0Kbk81Bawtj3xYiyKncwxghIrn+zFXzF7sL
	 R8a2trus3ApC3HPoAP5GxmcPYWKxqTfr2BjLS+z8umhlBUj6nm69MO/tezAQIChj6Qmm+
	 RTSkeJstjMXHyBUt4Ykti6LDXFMPTXsAwk+sU6S+tukVDW1zZE+aT8dg5pxADsvAsag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794503369;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=t8G/GKRVQK2XK4DEVk5XL2FUjSK5EvRTCAhoty44zRc=;
	b=rR4n61MjFdjkRc8aDBoYRaGlySFj3AY0O6Arf8ePxCDy0qVTTet+06akXx1z8SvAscKQ
	 R4FAOInyhbm/REu5soPy0ulJtrZJj9Zbd0iCf+eM96n/rujsyNpwDB1m3zv9qrxElZpnm
	 95UX2bm31NsOgCtAyOaaJSQ/tGyG4bZv/3HzfW9SdkyAjlk+Ehj3kC7D/cNJO04TG02CP
	 pg8k4mfN2rVtwonXs7gorxbBGLQ2zhwRnhJt65TN3NwD6WHALtEclfzOdARPD7ST3cfhp
	 oV5ASpB90hrpheaNXvt4IUsQWHNI3su6LBrv1+D8OE+tC6E8OzuXSSgsOU+DNkZ2N8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=packett.cool;
	spf=pass smtp.mailfrom=packett.cool;
	dkim=pass header.d=packett.cool header.i=@packett.cool header.a=rsa-sha256 header.s=key1 header.b=LgArJKrj;
	arc=none smtp.remote-ip=91.218.175.144
Received: from mta0.migadu.com (out-144.mta0.migadu.com [91.218.175.144])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7075B606A33F
	for <linux-pm@vger.kernel.org>; Thu, 12 Nov 2026 17:09:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7075B606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=packett.cool
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=packett.cool
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=packett.cool header.i=@packett.cool header.a=rsa-sha256 header.s=key1 header.b=LgArJKrj
X-Envelope-To: linux-pm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=BBIIMNvDwAHbvxtp9ouYtNOAGMxki1iN2t9NF6ko7RQ=;
 c=simple/simple; d=packett.cool;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794503366; v=1; x=1795108166;
 b=LgArJKrj4GBZefQ3NIAeJR6jtOC+HArIjStBeh5GQlygnF0cd3orn6EE8izwYIeiBqd00Jxn
 lHsjZV60jDUKpdDHsQXu1laHwpc+HqEB+f0+u1xzogGpE912NgqlYzPfjJElfmJ9nxZxVENCgEI
 PcL8r9nFxOcu1GNHxU39wyWVHFNNX7DHdzHZpxbhqCSoYCE/nuvl7egOxAIs7YsXRdXaqJQGgZ0
 nC9M6H7X8ykkbR6TShNV9f7zCqGiUZbINK/mj1Cr8TxwhUsQV+vAx/AxyT0bUvz5MyJZFQy9IyL
 NPH8w5J7x8gNEbIbPrV4eMOHapKG9c8prvGNxNStTOY7Q==
X-Envelope-To: linux-pm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 468166401f4cc02b;
	Thu, 12 Nov 2026 17:09:26 +0000
X-Mizu-Trace-ID: 468166401f4cc02b
X-Migadu-Flow: FLOW_OUT
From: Val Packett <val@packett.cool>
To: Sebastian Reichel <sre@kernel.org>,
	Val Packett <val@packett.cool>
Cc: Marc Lainez <marc.lainez@gmail.com>,
	Luca Weiss <luca.weiss@fairphone.com>,
	=?UTF-8?q?Barnab=C3=A1s=20Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>,
	Danila Tikhonov <danila@jiaxyga.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Abel Vesa <abelvesa@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	phone-devel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] power: supply: add Qualcomm QGauge (qcom_qg) fuel gauge driver
Date: Thu, 12 Nov 2026 14:07:28 -0300
Message-ID: <20261112170841.2189322-3-val@packett.cool>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261112170841.2189322-1-val@packett.cool>
References: <20261112170841.2189322-1-val@packett.cool>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Marc Lainez <marc.lainez@gmail.com>

Add a driver for the QGauge (QG) fuel-gauge block found in Qualcomm SPMI
PMICs such as PMI632 and PM6150. The QG hardware provides FIFO-based
voltage/current sampling, sleep-time open-circuit-voltage measurement and
coulomb counting; state-of-charge is computed in-kernel from the
monitored-battery OCV-to-capacity tables. Coulomb counting is not
implemented yet.

The driver exposes present/status/health/technology, instantaneous and
running-average voltage and current, OCV, capacity, temperature,
and battery design limits via the power_supply class.

Signed-off-by: Marc Lainez <marc.lainez@gmail.com>
[val: cleanup, implement SDAM full charge, fix batt_info leak]
Signed-off-by: Val Packett <val@packett.cool>
---
Assisted-by: LLM
(as declared by Marc in the GitHub thread)
---
 MAINTAINERS                    |   1 +
 drivers/power/supply/Kconfig   |  13 +
 drivers/power/supply/Makefile  |   1 +
 drivers/power/supply/qcom_qg.c | 807 +++++++++++++++++++++++++++++++++
 4 files changed, 822 insertions(+)
 create mode 100644 drivers/power/supply/qcom_qg.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 7b76b07ed66f..111e56340be8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -23333,6 +23333,7 @@ M:	Val Packett <val@packett.cool>
 L:	linux-arm-msm@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/power/supply/qcom,qg.yaml
+F:	drivers/power/supply/qcom_qg.c
 
 QUALCOMM SMB CHARGER DRIVER
 M:	Casey Connolly <casey.connolly@linaro.org>
diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index 16d0a38b41b7..ad235a9057d1 100644
--- a/drivers/power/supply/Kconfig
+++ b/drivers/power/supply/Kconfig
@@ -228,6 +228,19 @@ config BATTERY_QCOM_BATTMGR
 	  which is used on modern Qualcomm platforms to provide battery and
 	  power supply information.
 
+config BATTERY_QCOM_QG
+	tristate "Qualcomm QGauge fuel gauge support"
+	depends on MFD_SPMI_PMIC || COMPILE_TEST
+	depends on IIO
+	help
+	  Say Y to add support for the QGauge (QG) fuel gauge block found
+	  in Qualcomm PMICs such as PMI632 and PM6150. This hardware provides
+	  battery voltage and current FIFO sampling, open circuit voltage
+	  (OCV) measurement, and coulomb counting for battery state estimation.
+
+	  To compile this driver as module, choose M here: the
+	  module will be called qcom_qg.
+
 config BATTERY_OLPC
 	tristate "One Laptop Per Child battery"
 	depends on OLPC_EC
diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
index cd3640f4b748..07296f3f7914 100644
--- a/drivers/power/supply/Makefile
+++ b/drivers/power/supply/Makefile
@@ -134,6 +134,7 @@ obj-$(CONFIG_CHARGER_SURFACE)	+= surface_charger.o
 obj-$(CONFIG_BATTERY_CHARGER_SURFACE_RT) += surface-rt-ec.o
 obj-$(CONFIG_BATTERY_UG3105)	+= ug3105_battery.o
 obj-$(CONFIG_CHARGER_QCOM_SMB2)	+= qcom_smbx.o
+obj-$(CONFIG_BATTERY_QCOM_QG)	+= qcom_qg.o
 obj-$(CONFIG_FUEL_GAUGE_MM8013)	+= mm8013.o
 obj-$(CONFIG_MACSMC_POWER)	+= macsmc-power.o
 obj-$(CONFIG_CHARGER_MAX77759)	+= max77759_charger.o
diff --git a/drivers/power/supply/qcom_qg.c b/drivers/power/supply/qcom_qg.c
new file mode 100644
index 000000000000..071e29d4c299
--- /dev/null
+++ b/drivers/power/supply/qcom_qg.c
@@ -0,0 +1,807 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2025, Marc Lainez <marc.lainez@gmail.com>
+ * Copyright (c) 2026, Val Packett <val@packett.cool>
+ *
+ * Qualcomm QGauge (QG) fuel gauge driver (PMI632, PM6150, ...).
+ *
+ * The QG hardware block provides battery voltage and current measurement
+ * via FIFO-based sampling, open circuit voltage (OCV) measurement during
+ * sleep states, and coulomb counting through V/I accumulators.
+ *
+ * This driver exposes battery state via the power_supply subsystem.
+ * SOC is computed in-kernel using OCV-to-capacity lookup tables from
+ * the monitored-battery simple-battery node.
+ */
+
+#include <linux/bitfield.h>
+#include <linux/cleanup.h>
+#include <linux/errno.h>
+#include <linux/iio/consumer.h>
+#include <linux/interrupt.h>
+#include <linux/math64.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/nvmem-consumer.h>
+#include <linux/platform_device.h>
+#include <linux/power_supply.h>
+#include <linux/property.h>
+#include <linux/regmap.h>
+#include <linux/timekeeping.h>
+
+/* Peripheral type register */
+#define QG_PERPH_TYPE			0x04
+#define QG_PERPH_TYPE_VALUE		0x0D
+
+/* Status registers */
+#define QG_STATUS1			0x08
+#define  QG_STATUS1_BATT_PRESENT	BIT(0)
+
+#define QG_STATUS2			0x09
+#define  QG_STATUS2_GOOD_OCV		BIT(1)
+
+#define QG_STATUS3			0x0A
+#define  QG_STATUS3_FIFO_RT_COUNT	GENMASK(3, 0)
+
+/* Data control */
+#define QG_DATA_CTL1			0x41
+#define  QG_DATA_CTL1_MASTER_HOLD	BIT(0)
+
+#define QG_DATA_CTL2			0x42
+#define  QG_DATA_CTL2_BURST_AVG_HOLD	BIT(0)
+
+/* OCV data registers (16-bit little-endian) */
+#define QG_S7_PON_OCV_V		0x70
+#define QG_S3_GOOD_OCV_V		0x74
+
+/* S2 (normal-mode) running-average data registers */
+#define QG_S2_NORMAL_AVG_V		0x80
+#define QG_S2_NORMAL_AVG_I		0x82
+
+/* FIFO data registers */
+#define QG_V_FIFO0			0x90
+#define QG_I_FIFO0			0xA0
+
+/* Last ADC data registers */
+#define QG_LAST_ADC_V			0xC0
+#define QG_LAST_ADC_I			0xC2
+#define QG_LAST_BURST_AVG_I		0xC6
+
+/* Sentinel value indicating FIFO entry is not yet written */
+#define QG_FIFO_RESET_VAL		0x8000
+
+/* Maximum hardware FIFO depth */
+#define QG_MAX_FIFO_LENGTH		8
+
+/* SDAM (shared direct access memory) offsets */
+#define QG_SDAM_VALID_OFFSET		0x46	/* 1-byte validity marker */
+#define QG_SDAM_LEARNED_CAPACITY_OFFSET	0x68	/* 2-byte, mAh */
+
+#define QG_OCV_STALE_SECS		180
+
+struct qcom_qg {
+	struct device *dev;
+	struct regmap *regmap;
+	unsigned int base;
+
+	struct power_supply *psy;
+	struct power_supply_battery_info *batt_info;
+
+	struct iio_channel *batt_therm;
+	struct nvmem_device *sdam;
+
+	struct mutex lock; /* protects the FIFO/burst hold register sequences */
+
+	/* Cached measurements (updated from IRQs and on-demand reads) */
+	unsigned int vbat_uv;
+	int ibat_ua;
+	unsigned int ocv_uv;
+	time64_t ocv_time;
+	bool batt_present;
+};
+
+static inline unsigned int qg_raw_to_uv(u16 raw)
+{
+	return div_u64(194637ULL * raw, 1000);
+}
+
+static inline int qg_raw_to_ua(s16 raw)
+{
+	/*
+	 * Hardware convention: positive = discharge, negative = charge.
+	 * Power supply class convention (ABI): positive = charge.
+	 */
+	return -div_s64(152588LL * raw, 1000);
+}
+
+static int qg_read16(struct qcom_qg *qg, unsigned int reg, u16 *val)
+{
+	int ret;
+	__le16 raw;
+
+	ret = regmap_bulk_read(qg->regmap, qg->base + reg, &raw, sizeof(raw));
+	if (ret)
+		return ret;
+
+	*val = le16_to_cpu(raw);
+	return 0;
+}
+
+static int qg_master_hold(struct qcom_qg *qg, bool hold)
+{
+	int ret;
+
+	/* Clear first (required for 0->1 transition to latch) */
+	ret = regmap_update_bits(qg->regmap, qg->base + QG_DATA_CTL1,
+				 QG_DATA_CTL1_MASTER_HOLD, 0);
+	if (ret)
+		return ret;
+
+	if (hold)
+		ret = regmap_update_bits(qg->regmap, qg->base + QG_DATA_CTL1,
+					 QG_DATA_CTL1_MASTER_HOLD,
+					 QG_DATA_CTL1_MASTER_HOLD);
+
+	return ret;
+}
+
+static int qg_read_battery_present(struct qcom_qg *qg, bool *present)
+{
+	unsigned int val;
+	int ret;
+
+	ret = regmap_read(qg->regmap, qg->base + QG_STATUS1, &val);
+	if (ret)
+		return ret;
+
+	*present = !!(val & QG_STATUS1_BATT_PRESENT);
+	return 0;
+}
+
+static int qg_read_vbat(struct qcom_qg *qg, unsigned int *vbat_uv)
+{
+	u16 raw;
+	int ret;
+
+	ret = qg_read16(qg, QG_LAST_ADC_V, &raw);
+	if (ret)
+		return ret;
+
+	*vbat_uv = qg_raw_to_uv(raw);
+	return 0;
+}
+
+static int qg_read_ibat(struct qcom_qg *qg, int *ibat_ua)
+{
+	u16 raw;
+	int ret;
+
+	guard(mutex)(&qg->lock);
+
+	/* Hold the burst average register to get a coherent reading */
+	ret = regmap_update_bits(qg->regmap, qg->base + QG_DATA_CTL2,
+				 QG_DATA_CTL2_BURST_AVG_HOLD,
+				 QG_DATA_CTL2_BURST_AVG_HOLD);
+	if (ret)
+		return ret;
+
+	ret = qg_read16(qg, QG_LAST_BURST_AVG_I, &raw);
+
+	/* Always release the hold, even if the read failed */
+	regmap_update_bits(qg->regmap, qg->base + QG_DATA_CTL2,
+			   QG_DATA_CTL2_BURST_AVG_HOLD, 0);
+
+	if (ret)
+		return ret;
+
+	*ibat_ua = qg_raw_to_ua((s16)raw);
+	return 0;
+}
+
+static int qg_read_ocv(struct qcom_qg *qg, unsigned int reg,
+		       unsigned int *ocv_uv)
+{
+	u16 raw;
+	int ret;
+
+	ret = qg_read16(qg, reg, &raw);
+	if (ret)
+		return ret;
+
+	*ocv_uv = qg_raw_to_uv(raw);
+	return 0;
+}
+
+static int qg_read_temperature(struct qcom_qg *qg, int *temp_decidegc)
+{
+	int ret, val;
+
+	lockdep_assert_not_held(&qg->lock);
+
+	if (!qg->batt_therm)
+		return -ENODEV;
+
+	ret = iio_read_channel_processed(qg->batt_therm, &val);
+	if (ret < 0)
+		return ret;
+
+	/* SPMI ADC5 bat_therm channel returns millidegrees */
+	*temp_decidegc = DIV_ROUND_CLOSEST(val, 100);
+
+	return 0;
+}
+
+static bool qg_ocv_valid(struct qcom_qg *qg)
+{
+	return qg->ocv_uv &&
+	       ktime_get_seconds() - qg->ocv_time <= QG_OCV_STALE_SECS;
+}
+
+static int qg_read_fifo_vbat(struct qcom_qg *qg)
+{
+	unsigned int count_reg;
+	unsigned int fifo_count;
+	u64 vbat_sum = 0;
+	unsigned int valid = 0;
+	u16 raw;
+	int ret, i;
+
+	guard(mutex)(&qg->lock);
+
+	ret = qg_master_hold(qg, true);
+	if (ret)
+		return ret;
+
+	ret = regmap_read(qg->regmap, qg->base + QG_STATUS3, &count_reg);
+	if (ret)
+		goto release;
+
+	fifo_count = FIELD_GET(QG_STATUS3_FIFO_RT_COUNT, count_reg);
+	fifo_count = min_t(unsigned int, fifo_count, QG_MAX_FIFO_LENGTH);
+
+	for (i = 0; i < fifo_count; i++) {
+		ret = qg_read16(qg, QG_V_FIFO0 + i * 2, &raw);
+		if (ret)
+			goto release;
+
+		if (raw == QG_FIFO_RESET_VAL)
+			continue;
+
+		vbat_sum += qg_raw_to_uv(raw);
+		valid++;
+	}
+
+	if (valid)
+		qg->vbat_uv = div_u64(vbat_sum, valid);
+
+release:
+	qg_master_hold(qg, false);
+	return ret;
+}
+
+static int qg_update_ocv(struct qcom_qg *qg)
+{
+	unsigned int status2;
+	unsigned int ocv_uv;
+	int ret;
+
+	lockdep_assert_held(&qg->lock);
+
+	ret = regmap_read(qg->regmap, qg->base + QG_STATUS2, &status2);
+	if (ret)
+		return ret;
+
+	/* Clear the sticky register by writing back */
+	regmap_write(qg->regmap, qg->base + QG_STATUS2, 0);
+
+	if (!(status2 & QG_STATUS2_GOOD_OCV))
+		return 0;
+
+	ret = qg_read_ocv(qg, QG_S3_GOOD_OCV_V, &ocv_uv);
+	if (ret)
+		return ret;
+
+	qg->ocv_uv = ocv_uv;
+	qg->ocv_time = ktime_get_seconds();
+
+	return 0;
+}
+
+static int qg_get_capacity(struct qcom_qg *qg, int *capacity)
+{
+	int temp_decidegc;
+	int cap, ret;
+
+	if (!qg->batt_info)
+		return -ENODATA;
+
+	/*
+	 * Without OCV, it's impossible to calculate state-of-charge.
+	 * Well, you could try, but you'd get *massive* load swings.
+	 */
+	if (!qg->ocv_uv)
+		return -ENODATA;
+
+	ret = qg_read_temperature(qg, &temp_decidegc);
+	if (ret)
+		temp_decidegc = 250; /* default 25.0 degC */
+
+	cap = power_supply_batinfo_ocv2cap(qg->batt_info, qg->ocv_uv,
+					   temp_decidegc);
+	if (cap < 0)
+		return cap;
+
+	*capacity = clamp(cap, 0, 100);
+
+	return 0;
+}
+
+static int qg_get_charge_full(struct qcom_qg *qg, int *charge_uah)
+{
+	u8 valid;
+	__le16 raw;
+	int ret;
+
+	if (!qg->sdam)
+		return -ENODATA;
+
+	ret = nvmem_device_read(qg->sdam, QG_SDAM_VALID_OFFSET, 1, &valid);
+	if (ret < 0)
+		return ret;
+	if (ret != 1 || !valid)
+		return -ENODATA;
+
+	ret = nvmem_device_read(qg->sdam, QG_SDAM_LEARNED_CAPACITY_OFFSET,
+				sizeof(raw), &raw);
+	if (ret < 0)
+		return ret;
+	if (ret != sizeof(raw))
+		return -EIO;
+
+	/* 0 mAh means no full-charge learning cycle has completed yet */
+	if (!le16_to_cpu(raw))
+		return -ENODATA;
+
+	*charge_uah = le16_to_cpu(raw) * 1000;
+
+	return 0;
+}
+
+static int qg_get_health(struct qcom_qg *qg, int *health)
+{
+	struct power_supply_battery_info *info = qg->batt_info;
+	int temp_decidegc;
+	int ret;
+
+	if (!qg->batt_present) {
+		*health = POWER_SUPPLY_HEALTH_UNKNOWN;
+		return 0;
+	}
+
+	if (info) {
+		ret = qg_read_temperature(qg, &temp_decidegc);
+
+		/* No thermistor is not a health fault */
+		if (ret && ret != -ENODEV)
+			return ret;
+
+		if (!ret) {
+			/* Unset thresholds stay 0; 0 degC is a valid reading. */
+			if (info->temp_alert_max > 0 &&
+			    temp_decidegc >= info->temp_alert_max) {
+				*health = POWER_SUPPLY_HEALTH_HOT;
+				return 0;
+			}
+			if (info->temp_alert_min > 0 &&
+			    temp_decidegc <= info->temp_alert_min) {
+				*health = POWER_SUPPLY_HEALTH_COLD;
+				return 0;
+			}
+			if (info->temp_max > 0 &&
+			    temp_decidegc >= info->temp_max) {
+				*health = POWER_SUPPLY_HEALTH_WARM;
+				return 0;
+			}
+			if (info->temp_min > 0 &&
+			    temp_decidegc <= info->temp_min) {
+				*health = POWER_SUPPLY_HEALTH_COOL;
+				return 0;
+			}
+		}
+	}
+
+	*health = POWER_SUPPLY_HEALTH_GOOD;
+
+	if (info && qg->vbat_uv) {
+		if (qg->vbat_uv < info->voltage_min_design_uv)
+			*health = POWER_SUPPLY_HEALTH_DEAD;
+		else if (qg->vbat_uv > info->voltage_max_design_uv)
+			*health = POWER_SUPPLY_HEALTH_OVERVOLTAGE;
+	}
+
+	return 0;
+}
+
+static irqreturn_t qg_fifo_done_irq(int irq, void *data)
+{
+	struct qcom_qg *qg = data;
+	int ret;
+
+	ret = qg_read_fifo_vbat(qg);
+	if (ret)
+		dev_warn_once(qg->dev, "Failed to read FIFO: %d\n", ret);
+
+	power_supply_changed(qg->psy);
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t qg_good_ocv_irq(int irq, void *data)
+{
+	struct qcom_qg *qg = data;
+
+	scoped_guard(mutex, &qg->lock)
+		qg_update_ocv(qg);
+
+	power_supply_changed(qg->psy);
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t qg_batt_missing_irq(int irq, void *data)
+{
+	struct qcom_qg *qg = data;
+	bool present;
+
+	if (!qg_read_battery_present(qg, &present))
+		qg->batt_present = present;
+
+	power_supply_changed(qg->psy);
+
+	return IRQ_HANDLED;
+}
+
+static int qg_get_property(struct power_supply *psy,
+			   enum power_supply_property psp,
+			   union power_supply_propval *val)
+{
+	struct qcom_qg *qg = power_supply_get_drvdata(psy);
+	int ret;
+
+	/*
+	 * Not locking the mutex as we can't hold locks across the
+	 * temperature ADC read. No writes here, should be fine.
+	 */
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_PRESENT:
+		val->intval = qg->batt_present;
+		return 0;
+
+	case POWER_SUPPLY_PROP_STATUS:
+		if (!qg->batt_present) {
+			val->intval = POWER_SUPPLY_STATUS_UNKNOWN;
+			return 0;
+		}
+		ret = power_supply_am_i_supplied(psy);
+		if (ret < 0 && ret != -ENODEV)
+			return ret;
+		if (ret > 0)
+			val->intval = POWER_SUPPLY_STATUS_CHARGING;
+		else
+			val->intval = POWER_SUPPLY_STATUS_DISCHARGING;
+		return 0;
+
+	case POWER_SUPPLY_PROP_HEALTH:
+		return qg_get_health(qg, &val->intval);
+
+	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
+		if (!qg->batt_present)
+			return -ENODATA;
+		/* Refresh from last ADC register */
+		ret = qg_read_vbat(qg, &qg->vbat_uv);
+		if (ret)
+			return ret;
+		val->intval = qg->vbat_uv;
+		return 0;
+
+	case POWER_SUPPLY_PROP_CURRENT_NOW:
+		if (!qg->batt_present)
+			return -ENODATA;
+		ret = qg_read_ibat(qg, &qg->ibat_ua);
+		if (ret)
+			return ret;
+		val->intval = qg->ibat_ua;
+		return 0;
+
+	case POWER_SUPPLY_PROP_VOLTAGE_OCV:
+		if (!qg->batt_present)
+			return -ENODATA;
+		if (!qg_ocv_valid(qg))
+			return -ENODATA;
+		val->intval = qg->ocv_uv;
+		return 0;
+
+	case POWER_SUPPLY_PROP_CAPACITY:
+		if (!qg->batt_present)
+			return -ENODATA;
+		return qg_get_capacity(qg, &val->intval);
+
+	case POWER_SUPPLY_PROP_TEMP:
+		if (!qg->batt_present)
+			return -ENODATA;
+		return qg_read_temperature(qg, &val->intval);
+
+	case POWER_SUPPLY_PROP_TECHNOLOGY:
+		val->intval = POWER_SUPPLY_TECHNOLOGY_LION;
+		return 0;
+
+	case POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN:
+		if (!qg->batt_info)
+			return -ENODATA;
+		val->intval = qg->batt_info->voltage_max_design_uv;
+		return 0;
+
+	case POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN:
+		if (!qg->batt_info)
+			return -ENODATA;
+		val->intval = qg->batt_info->voltage_min_design_uv;
+		return 0;
+
+	case POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN:
+		if (!qg->batt_info ||
+		    qg->batt_info->charge_full_design_uah < 0)
+			return -ENODATA;
+		val->intval = qg->batt_info->charge_full_design_uah;
+		return 0;
+
+	case POWER_SUPPLY_PROP_CHARGE_FULL:
+		return qg_get_charge_full(qg, &val->intval);
+
+	case POWER_SUPPLY_PROP_VOLTAGE_AVG: {
+		u16 raw;
+
+		if (!qg->batt_present)
+			return -ENODATA;
+		ret = qg_read16(qg, QG_S2_NORMAL_AVG_V, &raw);
+		if (ret)
+			return ret;
+		val->intval = qg_raw_to_uv(raw);
+		return 0;
+	}
+
+	case POWER_SUPPLY_PROP_CURRENT_AVG: {
+		u16 raw;
+
+		if (!qg->batt_present)
+			return -ENODATA;
+		ret = qg_read16(qg, QG_S2_NORMAL_AVG_I, &raw);
+		if (ret)
+			return ret;
+		val->intval = qg_raw_to_ua((s16)raw);
+		return 0;
+	}
+
+	default:
+		return -EINVAL;
+	}
+}
+
+static enum power_supply_property qg_properties[] = {
+	POWER_SUPPLY_PROP_PRESENT,
+	POWER_SUPPLY_PROP_STATUS,
+	POWER_SUPPLY_PROP_HEALTH,
+	POWER_SUPPLY_PROP_TECHNOLOGY,
+	POWER_SUPPLY_PROP_VOLTAGE_NOW,
+	POWER_SUPPLY_PROP_VOLTAGE_AVG,
+	POWER_SUPPLY_PROP_VOLTAGE_OCV,
+	POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN,
+	POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN,
+	POWER_SUPPLY_PROP_CURRENT_NOW,
+	POWER_SUPPLY_PROP_CURRENT_AVG,
+	POWER_SUPPLY_PROP_CAPACITY,
+	POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN,
+	POWER_SUPPLY_PROP_CHARGE_FULL,
+	POWER_SUPPLY_PROP_TEMP,
+};
+
+static const struct power_supply_desc qg_psy_desc = {
+	.name = "qcom-qg",
+	.type = POWER_SUPPLY_TYPE_BATTERY,
+	.properties = qg_properties,
+	.num_properties = ARRAY_SIZE(qg_properties),
+	.get_property = qg_get_property,
+};
+
+static int qg_get_optional_irq(struct qcom_qg *qg, struct platform_device *pdev,
+			       const char *name, irq_handler_t handler)
+{
+	int irq, ret;
+
+	irq = platform_get_irq_byname_optional(pdev, name);
+	if (irq < 0)
+		return irq;
+
+	ret = devm_request_threaded_irq(qg->dev, irq, NULL, handler,
+					IRQF_ONESHOT, name, qg);
+	if (ret)
+		return dev_err_probe(qg->dev, ret,
+				     "Failed to request %s IRQ", name);
+
+	return 0;
+}
+
+static void qg_batt_info_cleanup(void *data)
+{
+	struct qcom_qg *qg = data;
+
+	power_supply_put_battery_info(qg->psy, qg->batt_info);
+}
+
+static int qcom_qg_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct qcom_qg *qg;
+	struct power_supply_config psy_cfg = {};
+	unsigned int perph_type;
+	int ret;
+
+	qg = devm_kzalloc_obj(dev, struct qcom_qg);
+	if (!qg)
+		return -ENOMEM;
+
+	qg->dev = dev;
+	mutex_init(&qg->lock);
+
+	qg->regmap = dev_get_regmap(dev->parent, NULL);
+	if (!qg->regmap)
+		return dev_err_probe(dev, -ENODEV,
+				     "Failed to get parent regmap");
+
+	ret = device_property_read_u32(dev, "reg", &qg->base);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to read reg property");
+
+	ret = regmap_read(qg->regmap, qg->base + QG_PERPH_TYPE, &perph_type);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Failed to read peripheral type");
+
+	if (perph_type != QG_PERPH_TYPE_VALUE)
+		return dev_err_probe(dev, -ENODEV,
+				     "Unexpected peripheral type: 0x%02x",
+				     perph_type);
+
+	ret = qg_read_battery_present(qg, &qg->batt_present);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Failed to read battery presence");
+
+	ret = qg_read_ocv(qg, QG_S7_PON_OCV_V, &qg->ocv_uv);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to read PON OCV");
+
+	qg->ocv_time = ktime_get_seconds();
+
+	ret = qg_read_vbat(qg, &qg->vbat_uv);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Failed to read battery voltage");
+
+	qg->batt_therm = devm_iio_channel_get(dev, "batt-therm");
+	if (IS_ERR(qg->batt_therm)) {
+		ret = PTR_ERR(qg->batt_therm);
+		if (ret == -EPROBE_DEFER)
+			return ret;
+		dev_dbg(dev, "No batt-therm IIO channel: %d\n", ret);
+		qg->batt_therm = NULL;
+	}
+
+	qg->sdam = devm_nvmem_device_get(dev, NULL);
+	if (IS_ERR(qg->sdam)) {
+		ret = PTR_ERR(qg->sdam);
+		if (ret == -EPROBE_DEFER)
+			return ret;
+		dev_dbg(dev, "No SDAM nvmem device: %d\n", ret);
+		qg->sdam = NULL;
+	}
+
+	psy_cfg.drv_data = qg;
+	psy_cfg.fwnode = dev_fwnode(dev);
+
+	qg->psy = devm_power_supply_register(dev, &qg_psy_desc, &psy_cfg);
+	if (IS_ERR(qg->psy))
+		return dev_err_probe(dev, PTR_ERR(qg->psy),
+				     "Failed to register power supply");
+
+	ret = power_supply_get_battery_info(qg->psy, &qg->batt_info);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to get battery info");
+
+	ret = devm_add_action_or_reset(dev, qg_batt_info_cleanup, qg);
+	if (ret)
+		return ret;
+
+	ret = qg_get_optional_irq(qg, pdev, "fifo-done", qg_fifo_done_irq);
+	if (ret && ret != -ENXIO)
+		return ret;
+
+	ret = qg_get_optional_irq(qg, pdev, "good-ocv", qg_good_ocv_irq);
+	if (ret && ret != -ENXIO)
+		return ret;
+
+	ret = qg_get_optional_irq(qg, pdev, "batt-missing",
+				  qg_batt_missing_irq);
+	if (ret && ret != -ENXIO)
+		return ret;
+
+	platform_set_drvdata(pdev, qg);
+
+	dev_dbg(dev, "QG: batt=%s OCV=%u uV VBAT=%u uV\n",
+		qg->batt_present ? "present" : "absent",
+		qg->ocv_uv, qg->vbat_uv);
+
+	return 0;
+}
+
+static int qcom_qg_suspend(struct device *dev)
+{
+	struct qcom_qg *qg = dev_get_drvdata(dev);
+
+	/*
+	 * The QG hardware FSM will automatically transition to sleep
+	 * states (S3) and measure OCV. Nothing special is needed here
+	 * beyond ensuring we pick up the new OCV on resume.
+	 */
+	dev_dbg(qg->dev, "Suspending, last OCV=%u uV\n", qg->ocv_uv);
+
+	return 0;
+}
+
+static int qcom_qg_resume(struct device *dev)
+{
+	struct qcom_qg *qg = dev_get_drvdata(dev);
+
+	/*
+	 * After resume, the hardware may have measured a good OCV during
+	 * the sleep state. Check for it and update our cached value.
+	 * Also refresh the battery voltage.
+	 */
+	scoped_guard(mutex, &qg->lock)
+		qg_update_ocv(qg);
+
+	qg_read_vbat(qg, &qg->vbat_uv);
+
+	dev_dbg(qg->dev, "Resumed, OCV=%u uV VBAT=%u uV\n",
+		qg->ocv_uv, qg->vbat_uv);
+
+	power_supply_changed(qg->psy);
+
+	return 0;
+}
+
+static DEFINE_SIMPLE_DEV_PM_OPS(qcom_qg_pm_ops,
+				qcom_qg_suspend, qcom_qg_resume);
+
+static const struct of_device_id qcom_qg_of_match[] = {
+	{ .compatible = "qcom,pm6150-qg" },
+	{ .compatible = "qcom,pmi632-qg" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, qcom_qg_of_match);
+
+static struct platform_driver qcom_qg_driver = {
+	.driver = {
+		.name = "qcom-qg",
+		.of_match_table = qcom_qg_of_match,
+		.pm = pm_sleep_ptr(&qcom_qg_pm_ops),
+	},
+	.probe = qcom_qg_probe,
+};
+module_platform_driver(qcom_qg_driver);
+
+MODULE_DESCRIPTION("Qualcomm QGauge fuel gauge driver");
+MODULE_AUTHOR("Marc Lainez <marc.lainez@gmail.com>");
+MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS("IIO_CONSUMER");
-- 
2.56.0

