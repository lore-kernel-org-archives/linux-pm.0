Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794895574;
	b=WKAF9Yu+7rzoDuVP0FhVvnXoRqw2G4cG30xuKWIrUMiMRPqyd+xFOZ4DqXYwpV/6HlkP
	 MbyIdjRQMKnMs9080RCZ/SwPSjRWk0Y4nPgF/CillFjLobN5p9JlptJskSAsQZItmc/gY
	 74EuQg2XVhHR6tgn1ZmiLexBWhXZYh8CdW9urRO885iPbIQVXhIPsAuojsmDm3h1htCLA
	 IYG/J2T6im2plXBWkvPtUCGybDggPrUpRUcvLJqhC7C13idUUzAbR2a9dnNq0W5O7+4nl
	 qRqn5ASAKo+flV9FDsRbXNyHIEUTbkBrMZ9Kqnv2z82PTLLUFBPOx/cQHNMtipCeqPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794895574;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=EsIPTfnBcTrltn2jh6R8X7D3E7FmUiavoDyvK703b+g=;
	b=oaBw3TWLq7E3rB8eBAUHSruQ1ZcCWxQhAjeKSKG7EYeOOImSNda4MXovdYTGIZLncHmc
	 /1vCZFOOl3NDekMyZaQujEzx4R2ppvv5W1siICHhn0YxR76JXIjyLtkB0iJHjmIZk1GFd
	 gVXaoXZiEgplTfUxGv2iDoqIaRelp3EaRvIs1gyvDMFfL7tH7LMZrnYdg1XmwW+1OWcOs
	 sEwgHx09b0FkMGKkJcPgaCb9rCLM7gj/V+YwqVnym4ZM1YLxp9fSf2DNZxAJGk0nfINaO
	 Ta+8bhW3ynz9FyZrf4qlaJ7xIxdVhZZohrfzGHjZR3Xf+FkNe2hZ+2mVHk5JDb6URQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nwPNjv87;
	arc=none smtp.remote-ip=209.85.210.180
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F6C606A31C
	for <linux-pm@vger.kernel.org>; Tue, 17 Nov 2026 06:06:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 96F6C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nwPNjv87
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-8b68e59ab33so4007881b3a.2
        for <linux-pm@vger.kernel.org>; Mon, 16 Nov 2026 22:06:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794895573; x=1795500373; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EsIPTfnBcTrltn2jh6R8X7D3E7FmUiavoDyvK703b+g=;
        b=nwPNjv87IxPhk52sXtDpVQuxOTIGCMadvKtfw433+vGm1a9XB+N5cYVBFVSxuC1+QZ
         Gs+xLTJVFQoZWTA/zwOkvohv5Pv8kf7tUtQ+z7MIqvtB6Qp1RgHMXQD+n/JZ+DpNPWRj
         LitkiUADtFoR9j0ktN09xJSg4BmAn29e2P166EJsK2s25uuz1KPlPm5S1WyDhsVrRtqG
         DdFYg173jjYLS7OQQGj2njlx8XEgASRbkg1LfB8ENAhT/nxeErDNBPwSlDTxolzdBUJv
         cF7M5cLzAKWUBGjwl07CaDeFLOVW9mo7EprTmoIgpk1ksbZm1+pYjnk/MCgN5lhiaUid
         ybeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794895573; x=1795500373;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EsIPTfnBcTrltn2jh6R8X7D3E7FmUiavoDyvK703b+g=;
        b=MtG2LpPxpabKytiUn2SsYotsUNJtNfm35G8YORtZe1AMlhVI4VLwazk3hc3FGlmrae
         cf6nPm6iN+XwuoHdB+Ux8gQkS3xipq4+Qgm3OKD8tPlepEwTzwnMS3Xn3yONth/ck4yN
         nXliKgVJ9jpAkJD5Oc0E/YATk3oSeIR8qq8xZ7qtAR2ZCwV+roZsvmh3DBvoRnEkXUr+
         CsUVR8BaXrUBJl+WP80ehrGDKsSGHHWu6BQ4IVOHAUw4UgFzDl7TrGNKWmejKV4mvKvd
         BvyBL+rDXLMDig4MViHfhbaohHDciMphlCG1CHB9dbFQvquEbz19ZegfdYmA8KGa/JsT
         VIag==
X-Forwarded-Encrypted: i=1; AL+hErElMs5lI4VC0J7tyMPgboFz0vuPUo44p3MmHjxvrMIUXZqr3IdncqatOxGx6ouUQpQWdrSumPhyMg==@vger.kernel.org
X-Gm-Message-State: APuU4Z9phw1WjpMLxmY69CcPNrhSx5NcehTlcrR64MaaNkQZ9lru8iqg
	FZAh5TTXO//wKiQhGfv3vrg4KZlO4Lv3BMeMcXsogM3vK/V0AW73So0v
X-Gm-Gg: AYBFou3SHfrjYIE/g6JdXaNnNi+ybMm2vJkoOCOPpTIRkmfAf9lSesN7vPyea5zq0Di
	GsQFFQ8MJMPPiQXTVvH9bXYb6VpY+5vGABMBIdkGjARczjBROW+opC7XiU2C81jbrkVt8W/SeaG
	+02kDnzxPYUpdWE1wW5nCI1RdJdxu7YUKzeBb1L6iNBrDVtm0wrT3l53lwh3xkpD1XM8E6aKLHo
	CXPYwkxxY1LBoMBn6YY0nup/qO8oDsa7vIZWFrXjQ136Yy8tQWJP60I+1anjWBqvjxNKAcypgOO
	mYUh9PKRtOu/HGtXwvB9yoS3gn5hzpL5wTU5P2+jBgdMUf8eEa9COaIvJA8aqMQx1estnxCXRJR
	yPIc5QkboxFo/KJSoE2TM35hKV9HaLwQ7dP49RJImO2PXvdAjbt1r11eA8ssIiEwqk7R59SUNKS
	6LdPKONbaD4psyolAmlCskDYzm0rHM+XMigRKQAfVonFYi4eSnIWdaZ8kV/W29fHy0JiltzZ8RO
	2PrHD6AhVcAef+F3ycyzS9qlukW+eToyaG2z8yJL243CCuL4ZuOlFwPb1WOPG4pq8pq2lB/BqPG
	FI/z9BzZtQtDX1pyDTlbcZ66sLVi73P7qirNyDmzaa7qQFEN7pyJWQCrvdwlLFli4JpCnRJbDNA
	nlOAKEY8r6YdYCr5EMWdVdsxIDaVNFWjm
X-Received: by 2002:a05:6a00:bc04:b0:893:8a6:3801 with SMTP id d2e1a72fcca58-8beb6a763bcmr13607230b3a.24.1794895572807;
        Mon, 16 Nov 2026 22:06:12 -0800 (PST)
Received: from localhost.localdomain (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8bed12a8172sm4464623b3a.13.2026.11.16.22.06.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 22:06:12 -0800 (PST)
From: Zi-Yu Chen <zychennvt@gmail.com>
To: rafael@kernel.org,
	daniel.lezcano@kernel.org
Cc: ychuang3@nuvoton.com,
	schung@nuvoton.com,
	p.zabel@pengutronix.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	rui.zhang@intel.com,
	lukasz.luba@arm.com,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zi-Yu Chen <zychennvt@gmail.com>
Subject: [PATCH 3/4] thermal/drivers/ma35d1: Add Nuvoton MA35D1 thermal sensor driver
Date: Tue, 17 Nov 2026 14:05:00 +0800
Message-Id: <20261117060501.2611071-4-zychennvt@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261117060501.2611071-1-zychennvt@gmail.com>
References: <20261117060501.2611071-1-zychennvt@gmail.com>
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

Add a driver for the on-chip temperature sensor of the Nuvoton MA35D1
SoC. The sensor is controlled through a register in the system
management (SYS) block and is instantiated as an auxiliary device by
the MA35D1 reset driver.

The sensor converts continuously while powered on. The 12-bit result
is converted to millidegrees Celsius using a linear fit of the
temperature table from the sensor datasheet.

Signed-off-by: Zi-Yu Chen <zychennvt@gmail.com>
---
 drivers/thermal/Kconfig          |  11 +++
 drivers/thermal/Makefile         |   1 +
 drivers/thermal/ma35d1_thermal.c | 149 +++++++++++++++++++++++++++++++
 3 files changed, 161 insertions(+)
 create mode 100644 drivers/thermal/ma35d1_thermal.c

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index 810eeccedfba..571b2c026311 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -530,4 +530,15 @@ config LOONGSON2_THERMAL
 	  is higher than the high temperature threshold or lower than the low
 	  temperature threshold, the interrupt will occur.
 
+config MA35D1_THERMAL
+	tristate "Nuvoton MA35D1 thermal sensor"
+	depends on RESET_NUVOTON_MA35D1
+	depends on THERMAL_OF
+	select MFD_SYSCON
+	help
+	  Support for the on-chip temperature sensor found on Nuvoton
+	  MA35D1 SoCs. The driver provides temperature readings through the
+	  Linux thermal framework. The sensor registers are accessed through
+	  the system register block.
+
 endif
diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
index 3b249195c088..bf2796e3dd3f 100644
--- a/drivers/thermal/Makefile
+++ b/drivers/thermal/Makefile
@@ -70,3 +70,4 @@ obj-$(CONFIG_SPRD_THERMAL)	+= sprd_thermal.o
 obj-$(CONFIG_KHADAS_MCU_FAN_THERMAL)	+= khadas_mcu_fan.o
 obj-$(CONFIG_LOONGSON2_THERMAL)	+= loongson2_thermal.o
 obj-$(CONFIG_THERMAL_CORE_TESTING)	+= testing/
+obj-$(CONFIG_MA35D1_THERMAL)	+= ma35d1_thermal.o
diff --git a/drivers/thermal/ma35d1_thermal.c b/drivers/thermal/ma35d1_thermal.c
new file mode 100644
index 000000000000..453f57d236ec
--- /dev/null
+++ b/drivers/thermal/ma35d1_thermal.c
@@ -0,0 +1,149 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2026 Nuvoton Technology Corp.
+ *
+ * Author: Zi-Yu Chen <zychennvt@gmail.com>
+ */
+
+#include <linux/auxiliary_bus.h>
+#include <linux/bitfield.h>
+#include <linux/bits.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/mfd/syscon.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+#include <linux/thermal.h>
+
+#include "thermal_hwmon.h"
+
+#define MA35_SYS_TSENSRFCR		0x104
+#define MA35_TSEN_DATA_VALID	BIT(31)
+#define MA35_TSEN_POWER_DOWN	BIT(28)
+#define MA35_TSEN_DATA			GENMASK(27, 16)
+
+/*
+ * Conversion from the 12-bit sensor data to millidegrees Celsius:
+ *   temp (mC) = data * MA35_TS_CAL_A / 4096 - MA35_TS_CAL_B
+ * A and B come from a linear fit of the S40LLV33_TEMPSENSOR temperature table.
+ */
+#define MA35_TS_CAL_A			274350
+#define MA35_TS_CAL_B			93330
+
+struct ma35d1_thermal {
+	struct device *dev;
+	struct regmap *regmap;
+};
+
+static int ma35d1_thermal_get_temp(struct thermal_zone_device *tzd, int *temp)
+{
+	struct ma35d1_thermal *sensor = thermal_zone_device_priv(tzd);
+	unsigned int reg;
+	int data, ret;
+
+	ret = regmap_read(sensor->regmap, MA35_SYS_TSENSRFCR, &reg);
+	if (ret)
+		return ret;
+
+	if (!(reg & MA35_TSEN_DATA_VALID))
+		return -EAGAIN;
+
+	data = FIELD_GET(MA35_TSEN_DATA, reg);
+	*temp = data * MA35_TS_CAL_A / 4096 - MA35_TS_CAL_B;
+
+	return 0;
+}
+
+static int ma35d1_thermal_power_on(struct ma35d1_thermal *sensor)
+{
+	return regmap_clear_bits(sensor->regmap, MA35_SYS_TSENSRFCR,
+				 MA35_TSEN_POWER_DOWN);
+}
+
+static int ma35d1_thermal_power_off(struct ma35d1_thermal *sensor)
+{
+	return regmap_set_bits(sensor->regmap, MA35_SYS_TSENSRFCR,
+			       MA35_TSEN_POWER_DOWN);
+}
+
+static int ma35d1_thermal_change_mode(struct thermal_zone_device *tzd,
+				      enum thermal_device_mode mode)
+{
+	struct ma35d1_thermal *sensor = thermal_zone_device_priv(tzd);
+
+	if (mode == THERMAL_DEVICE_ENABLED)
+		return ma35d1_thermal_power_on(sensor);
+
+	return ma35d1_thermal_power_off(sensor);
+}
+
+static void ma35d1_thermal_power_off_action(void *data)
+{
+	struct ma35d1_thermal *sensor = data;
+
+	if (ma35d1_thermal_power_off(sensor))
+		dev_warn(sensor->dev, "failed to power off sensor\n");
+}
+
+static const struct thermal_zone_device_ops ma35d1_tz_ops = {
+	.get_temp = ma35d1_thermal_get_temp,
+	.change_mode = ma35d1_thermal_change_mode,
+};
+
+static int ma35d1_thermal_probe(struct auxiliary_device *adev,
+				const struct auxiliary_device_id *id)
+{
+	struct device *dev = &adev->dev;
+	struct thermal_zone_device *tzd;
+	struct ma35d1_thermal *sensor;
+	int ret;
+
+	sensor = devm_kzalloc_obj(dev, *sensor);
+	if (!sensor)
+		return -ENOMEM;
+
+	sensor->dev = dev;
+
+	sensor->regmap = syscon_node_to_regmap(dev->parent->of_node);
+	if (IS_ERR(sensor->regmap))
+		return dev_err_probe(dev, PTR_ERR(sensor->regmap),
+				     "failed to get SYS regmap\n");
+
+	/*
+	 * Registered before the thermal zone so that the sensor is powered
+	 * off only after the zone has been unregistered.
+	 */
+	ret = devm_add_action_or_reset(dev, ma35d1_thermal_power_off_action,
+				       sensor);
+	if (ret)
+		return ret;
+
+	tzd = devm_thermal_of_zone_register(dev, 0, sensor, &ma35d1_tz_ops);
+	if (IS_ERR(tzd))
+		return dev_err_probe(dev, PTR_ERR(tzd),
+				     "failed to register thermal zone\n");
+
+	/* thermal_of disables hwmon by default */
+	ret = devm_thermal_add_hwmon_sysfs(dev, tzd);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to add hwmon sysfs\n");
+
+	return 0;
+}
+
+static const struct auxiliary_device_id ma35d1_thermal_id_table[] = {
+	{ .name = "reset_ma35d1.thermal" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(auxiliary, ma35d1_thermal_id_table);
+
+static struct auxiliary_driver ma35d1_thermal_driver = {
+	.probe		= ma35d1_thermal_probe,
+	.id_table	= ma35d1_thermal_id_table,
+};
+module_auxiliary_driver(ma35d1_thermal_driver);
+
+MODULE_AUTHOR("Zi-Yu Chen <zychennvt@gmail.com>");
+MODULE_DESCRIPTION("Nuvoton MA35D1 Temperature Sensor Driver");
+MODULE_LICENSE("GPL");
-- 
2.34.1

