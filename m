Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793953657;
	b=kGG/mw2U7cZoiHFKHrBWyy0NK6EX2gUWAZ+qhtEivRpvpHescZbw0DnmXfjTw8/2BOXl
	 Vrz1BlCWmCDhR89sWtWk8zhxeN732CmLKRkXDTulyiSaMyq18WCe817fUkTFMJ59i/563
	 YPVlreqmAxkVLIzLcl/Fu29Or1hSeUdbX2xaWRZ9S1GWOCyPmx8fepXhrDr4xDqpHbuVb
	 SKr8QSUNgd6Mchn44ZXt3wlsMd5PfwYGLtGRiha/kl6YHHyWPVxMuL+EoYZPTihZ+K6l/
	 Ip7U4lSvqqYWPpCvOLqdTYI7gtwZahtw090aGJ0R2WDYxnTObnEUuT3vftXHVYxRDRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793953657;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=01Nxm1BzjjlPQueNKRVIbAFcGO1ejGa2GGYStaQcVMw=;
	b=zhLYfA0rZwvqEnkBwA6iQFcs/e9MEW8CFuB74DhWj3E/CPRExLCP+MtCA4C6cj/peD4p
	 etIQI6ImAgy4bVTWa5LAGYINBqxPxwxdEbus11IK8iG6LARMYOri9kndTbExQIgit7qSP
	 nKHJwaJHKS4of7sLir8brKhy8OjQkBMiFOKfHmB8MzPugPhc6vwSPdGSmV8765Plnj6zr
	 PSnJWg1hqV1H4mXXzMitGegEiIH3Qau7jg4qeE4ABcuCmADNVmaXo9SOPWklom3gxUYmv
	 m8egnkgbxpwDrOwYSNQptLHMfJU/nkjti6g0ZbFJA2ffw70J0tCJGZv5Vczun7Dhjkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YoD9SSQr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29B0606D817;
	Fri,  6 Nov 2026 08:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YoD9SSQr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16E3D1F008A5;
	Fri,  6 Nov 2026 08:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793953656;
	bh=01Nxm1BzjjlPQueNKRVIbAFcGO1ejGa2GGYStaQcVMw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=YoD9SSQrEJbSKdqdD0sq4tIuHN7BflNKZySmLGH5SlteyfG8+pSIjOazuwpTi1cgi
	 rxuxlXLicuNyt29UyJJ4fPNMss3MDLM+9CA46ZMvIKzcDlAzYvbqZRQ0SEB4kT3jZU
	 iLBfuaSTOfBuygZMcoYyC4lR+EcJzXcySck/+11aucrNihUnAVlI48QtSXR6vjetJA
	 aiatG34rdz3DgdzTaoJd/2xlm2QQ+IdsBCHue9gjCmn2nu8yr7/lQKpIvz1hmsk1U1
	 Ctwo8+T9Gv+MNFwZlWqWaMB4Q9SRCq28Az2AfCL7ZA0UC5mhrcjCtL/XREFVdR5aoa
	 oBeV3Abu/id/g==
From: Linus Walleij <linusw@kernel.org>
Date: Fri, 06 Nov 2026 09:26:50 +0100
Subject: [PATCH v3 7/7] hwmon: Add Broadcom PMB PVTMON monitoring
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261106-xg6846b-bcmbca-xrdp-reset-v3-7-d6adeb71afc9@kernel.org>
References: <20261106-xg6846b-bcmbca-xrdp-reset-v3-0-d6adeb71afc9@kernel.org>
In-Reply-To: <20261106-xg6846b-bcmbca-xrdp-reset-v3-0-d6adeb71afc9@kernel.org>
To: Linus Walleij <linusw@kernel.org>, Lee Jones <lee@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 William Zhang <william.zhang@broadcom.com>, 
 Anand Gore <anand.gore@broadcom.com>, 
 Kursad Oney <kursad.oney@broadcom.com>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, 
 Guenter Roeck <linux@roeck-us.net>, Philipp Zabel <p.zabel@pengutronix.de>, 
 Jonathan Corbet <corbet@lwn.net>, Randy Dunlap <rdunlap@infradead.org>, 
 Ulf Hansson <ulfh@kernel.org>, 
 Benjamin Larsson <benjamin.larsson@genexis.eu>
Cc: mfd@lists.linux.dev, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, 
 linux-hwmon@vger.kernel.org, linux-pm@vger.kernel.org
X-Mailer: b4 0.16.0

Expose the BCM6846 die temperature and seven voltage inputs through
hwmon using the shared Processor Monitor Bus (PMB) regmap.

Register the temperature channel with the thermal framework so
existing zero-cell device-tree thermal sensor references work.

Poll for valid samples with a bounded timeout, releasing the PMB lock
between reads. Report temperature in millidegrees Celsius, including
negative values, and voltages in millivolts.

Acked-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 Documentation/hwmon/bcm_pmb_pvtmon.rst |  53 ++++++++
 Documentation/hwmon/index.rst          |   1 +
 MAINTAINERS                            |   2 +
 drivers/hwmon/Kconfig                  |  18 +++
 drivers/hwmon/Makefile                 |   1 +
 drivers/hwmon/bcm_pmb_pvtmon.c         | 231 +++++++++++++++++++++++++++++++++
 6 files changed, 306 insertions(+)

diff --git a/Documentation/hwmon/bcm_pmb_pvtmon.rst b/Documentation/hwmon/bcm_pmb_pvtmon.rst
new file mode 100644
index 000000000000..7dba658bdc76
--- /dev/null
+++ b/Documentation/hwmon/bcm_pmb_pvtmon.rst
@@ -0,0 +1,53 @@
+.. SPDX-License-Identifier: GPL-2.0-only
+
+Kernel driver bcm_pmb_pvtmon
+============================
+
+Supported chips:
+
+  * Broadcom BCM6846 PVTMON
+
+    Access: Processor Monitor Bus (PMB), bus 1, device 6
+
+Author: Linus Walleij <linusw@kernel.org>
+
+Description
+-----------
+
+The process, voltage and temperature monitor (PVTMON) measures die
+temperature and seven voltage inputs. The driver uses the shared PMB MFD
+transport and obtains its clock and reset from the sibling providers.
+
+With CONFIG_THERMAL_OF enabled, the temperature channel also supplies
+device-tree thermal zones. The PVTMON node uses #thermal-sensor-cells = <0>;
+voltage inputs do not have thermal sensor indices.
+
+Sysfs attributes
+----------------
+
+All attributes are read-only. Temperature is reported in millidegrees
+Celsius and voltages in millivolts, using the BCM6846 vendor conversion
+formulas and input-divider ratios.
+
+================ ================================
+Attribute        Description
+================ ================================
+temp1_input      Die temperature
+in0_input        First 0.85 V input
+in1_input        Second 0.85 V input
+in2_input        VIN input
+in3_input        1.0 V input
+in4_input        1.8 V input
+in5_input        3.3 V input
+in6_input        Diagnostic test input
+in0_label        V0.85_1
+in1_label        V0.85_2
+in2_label        VIN
+in3_label        V1.0
+in4_label        V1.8
+in5_label        V3.3
+in6_label        Vtest
+================ ================================
+
+Labels follow the vendor channel names. Vtest is a diagnostic ADC input,
+not a supply rail. The driver does not change the analog test routing.
diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
index 199ca79621e9..5a579391cf9e 100644
--- a/Documentation/hwmon/index.rst
+++ b/Documentation/hwmon/index.rst
@@ -54,6 +54,7 @@ Hardware Monitoring Kernel Drivers
    axiado-pwm-fan
    axiado-tsadc
    bcm54140
+   bcm_pmb_pvtmon
    bel-pfe
    bpa-rs600
    cgbc-hwmon
diff --git a/MAINTAINERS b/MAINTAINERS
index 2a280ca7d162..f38003b144c5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5453,7 +5453,9 @@ F:	Documentation/devicetree/bindings/mfd/brcm,bcm6846-pmc.yaml
 F:	Documentation/devicetree/bindings/power/brcm,bcm6846-pmb-power.yaml
 F:	Documentation/devicetree/bindings/reset/brcm,bcm6846-pmb-reset.yaml
 F:	Documentation/devicetree/bindings/soc/bcm/brcm,bcm6846-pmb.yaml
+F:	Documentation/hwmon/bcm_pmb_pvtmon.rst
 F:	drivers/clk/bcm/clk-bcmbca-pmb.c
+F:	drivers/hwmon/bcm_pmb_pvtmon.c
 F:	drivers/mfd/bcmbca_pmc3_pmb.c
 F:	drivers/pmdomain/bcm/bcmbca-pmb.c
 F:	drivers/reset/reset-bcmbca-pmb.c
diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 18c682e1a475..7e2bc32628d4 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -334,6 +334,24 @@ config SENSORS_AXIADO_TSADC
 	  This driver can also be built as a module. If so, the module
 	  will be called axiado-tsadc.
 
+config SENSORS_BCM_PMB_PVTMON
+	tristate "Broadcom PMB PVTMON hardware monitoring"
+	depends on ARCH_BCMBCA || COMPILE_TEST
+	depends on MFD_BCMBCA_PMB
+	depends on COMMON_CLK
+	depends on RESET_CONTROLLER
+	select CLK_BCMBCA_PMB
+	select RESET_BCMBCA_PMB
+	select REGMAP
+	default MFD_BCMBCA_PMB
+	help
+	  Enable temperature and voltage monitoring through the Processor
+	  Monitor Bus on Broadcom BCM6846. With THERMAL_OF enabled, the
+	  temperature channel also supplies the thermal zones described in
+	  the device tree.
+
+	  This driver can also be built as a module called bcm_pmb_pvtmon.
+
 config SENSORS_K8TEMP
 	tristate "AMD Athlon64/FX or Opteron temperature sensor"
 	depends on X86 && PCI
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index d4c345ed7261..edf8e8d2f345 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -62,6 +62,7 @@ obj-$(CONFIG_SENSORS_ATXP1)	+= atxp1.o
 obj-$(CONFIG_SENSORS_AXI_FAN_CONTROL) += axi-fan-control.o
 obj-$(CONFIG_SENSORS_AXIADO_PWM_FAN) += axiado-pwm-fan.o
 obj-$(CONFIG_SENSORS_AXIADO_TSADC)	+= axiado-tsadc.o
+obj-$(CONFIG_SENSORS_BCM_PMB_PVTMON) += bcm_pmb_pvtmon.o
 obj-$(CONFIG_SENSORS_CGBC)	+= cgbc-hwmon.o
 obj-$(CONFIG_SENSORS_CHIPCAP2) += chipcap2.o
 obj-$(CONFIG_SENSORS_CORETEMP)	+= coretemp.o
diff --git a/drivers/hwmon/bcm_pmb_pvtmon.c b/drivers/hwmon/bcm_pmb_pvtmon.c
new file mode 100644
index 000000000000..3c58e0be3251
--- /dev/null
+++ b/drivers/hwmon/bcm_pmb_pvtmon.c
@@ -0,0 +1,231 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Broadcom BCM6846 process, voltage and temperature monitor (PVTMON).
+ */
+
+#include <linux/bitfield.h>
+#include <linux/clk.h>
+#include <linux/hwmon.h>
+#include <linux/mfd/bcmbca-pmb.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/reset.h>
+
+#define PVTMON_BUS		1
+#define PVTMON_DEVICE		6
+
+/* PMB register offsets are in 32-bit words. */
+#define PVTMON_CONFIG		17
+#define PVTMON_RESET_N		BIT(0)
+#define PVTMON_POWER_DOWN		BIT(1)
+
+#define PVTMON_ACQ_CONFIG		20
+#define PVTMON_ACCUM_ENABLE	BIT(0)
+#define PVTMON_SKIP_LENGTH	GENMASK(11, 8)
+
+#define PVTMON_CHANNEL_BASE	24
+#define PVTMON_NUM_CHANNELS	8
+#define PVTMON_VALUE		GENMASK(9, 0)
+#define PVTMON_VALID		BIT(18)
+#define PVTMON_SAMPLES		GENMASK(26, 24)
+#define PVTMON_CHANNEL_ENABLE	BIT(31)
+
+/* BCM6846 voltage channel labels and input-divider ratios. */
+static const struct {
+	const char *label;
+	unsigned int divisor;
+} bcm6846_pvtmon_voltages[] = {
+	{ "V0.85_1", 10 },
+	{ "V0.85_2", 10 },
+	{ "VIN", 7 },
+	{ "V1.0", 7 },
+	{ "V1.8", 4 },
+	{ "V3.3", 2 },
+	{ "Vtest", 10 },
+};
+
+static int bcm_pmb_pvtmon_init(struct regmap *regmap,
+			       struct reset_control *reset)
+{
+	unsigned int reg = BCMBCA_PMB_REG(PVTMON_BUS, PVTMON_DEVICE, PVTMON_CONFIG);
+	u32 config, acq, channel;
+	unsigned int i;
+	int ret;
+
+	ret = regmap_read(regmap, reg, &config);
+	if (ret)
+		return ret;
+
+	/* Do not reset acquisition already running for the PMC firmware. */
+	if ((config & (PVTMON_RESET_N | PVTMON_POWER_DOWN)) != PVTMON_RESET_N) {
+		ret = regmap_update_bits(regmap, reg, PVTMON_POWER_DOWN, 0);
+		if (ret)
+			return ret;
+		ret = reset_control_reset(reset);
+		if (ret)
+			return ret;
+	}
+
+	ret = regmap_read(regmap, BCMBCA_PMB_REG(PVTMON_BUS, PVTMON_DEVICE,
+						 PVTMON_ACQ_CONFIG), &acq);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < PVTMON_NUM_CHANNELS; i++) {
+		reg = BCMBCA_PMB_REG(PVTMON_BUS, PVTMON_DEVICE, PVTMON_CHANNEL_BASE + i);
+		ret = regmap_read(regmap, reg, &channel);
+		if (ret)
+			return ret;
+
+		if (channel & PVTMON_CHANNEL_ENABLE)
+			continue;
+
+		/* Average 32 samples. */
+		ret = regmap_update_bits(regmap, reg, PVTMON_CHANNEL_ENABLE | PVTMON_SAMPLES,
+					 PVTMON_CHANNEL_ENABLE | FIELD_PREP(PVTMON_SAMPLES, 5));
+		if (ret)
+			return ret;
+	}
+
+	if (!(acq & PVTMON_ACCUM_ENABLE))
+		return regmap_update_bits(regmap,
+					  BCMBCA_PMB_REG(PVTMON_BUS, PVTMON_DEVICE,
+							 PVTMON_ACQ_CONFIG),
+					  PVTMON_SKIP_LENGTH | PVTMON_ACCUM_ENABLE,
+					  PVTMON_ACCUM_ENABLE | FIELD_PREP(PVTMON_SKIP_LENGTH, 8));
+
+	return 0;
+}
+
+static int bcm_pmb_pvtmon_read(struct device *dev, enum hwmon_sensor_types type,
+			       u32 attr, int channel, long *val)
+{
+	struct regmap *map = dev_get_drvdata(dev);
+	unsigned int index;
+	u32 value;
+	int ret;
+
+	switch (type) {
+	case hwmon_temp:
+		if (attr != hwmon_temp_input)
+			return -EOPNOTSUPP;
+		index = 0;
+		break;
+	case hwmon_in:
+		if (attr != hwmon_in_input)
+			return -EOPNOTSUPP;
+		index = channel + 1;
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	/* Release the PMB between samples so other clients can make progress. */
+	ret = regmap_read_poll_timeout(map,
+				       BCMBCA_PMB_REG(PVTMON_BUS, PVTMON_DEVICE,
+						      PVTMON_CHANNEL_BASE + index),
+				       value, value & PVTMON_VALID, 1000, 100000);
+	if (ret)
+		return ret;
+
+	value = FIELD_GET(PVTMON_VALUE, value);
+	if (type == hwmon_temp) {
+		/* Signed arithmetic allows temperatures below zero Celsius. */
+		*val = (41335000 - 49055 * (int)value) / 100;
+	} else {
+		/* 880 mV ADC reference, accounting for each input divider. */
+		*val = 880 * value * 10 /
+			(bcm6846_pvtmon_voltages[channel].divisor * 1024);
+	}
+
+	return 0;
+}
+
+static int bcm_pmb_pvtmon_read_string(struct device *dev,
+				      enum hwmon_sensor_types type, u32 attr,
+				      int channel, const char **str)
+{
+	if (type != hwmon_in || attr != hwmon_in_label)
+		return -EOPNOTSUPP;
+
+	*str = bcm6846_pvtmon_voltages[channel].label;
+	return 0;
+}
+
+static const struct hwmon_ops bcm_pmb_pvtmon_ops = {
+	.visible = 0444,
+	.read = bcm_pmb_pvtmon_read,
+	.read_string = bcm_pmb_pvtmon_read_string,
+};
+
+static const struct hwmon_channel_info * const bcm_pmb_pvtmon_info[] = {
+	HWMON_CHANNEL_INFO(chip, HWMON_C_REGISTER_TZ),
+	HWMON_CHANNEL_INFO(temp, HWMON_T_INPUT),
+	HWMON_CHANNEL_INFO(in,
+			   HWMON_I_INPUT | HWMON_I_LABEL,
+			   HWMON_I_INPUT | HWMON_I_LABEL,
+			   HWMON_I_INPUT | HWMON_I_LABEL,
+			   HWMON_I_INPUT | HWMON_I_LABEL,
+			   HWMON_I_INPUT | HWMON_I_LABEL,
+			   HWMON_I_INPUT | HWMON_I_LABEL,
+			   HWMON_I_INPUT | HWMON_I_LABEL),
+	NULL
+};
+
+static const struct hwmon_chip_info bcm_pmb_pvtmon_chip_info = {
+	.ops = &bcm_pmb_pvtmon_ops,
+	.info = bcm_pmb_pvtmon_info,
+};
+
+static int bcm_pmb_pvtmon_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct regmap *regmap = dev_get_regmap(dev->parent, NULL);
+	struct device *hwmon;
+	struct reset_control *reset;
+	struct clk *clk;
+	int ret;
+
+	if (!regmap)
+		return -ENODEV;
+
+	reset = devm_reset_control_get_exclusive(dev, NULL);
+	if (IS_ERR(reset))
+		return dev_err_probe(dev, PTR_ERR(reset), "failed to get PVTMON reset\n");
+
+	clk = devm_clk_get_enabled(dev, NULL);
+	if (IS_ERR(clk))
+		return dev_err_probe(dev, PTR_ERR(clk), "failed to enable PVTMON clock\n");
+
+	ret = bcm_pmb_pvtmon_init(regmap, reset);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to initialize PVTMON\n");
+
+	hwmon = devm_hwmon_device_register_with_info(dev, "bcm6846_pvtmon", regmap,
+						     &bcm_pmb_pvtmon_chip_info, NULL);
+	if (IS_ERR(hwmon))
+		return dev_err_probe(dev, PTR_ERR(hwmon), "failed to register hwmon device\n");
+
+	/* Acquisition remains enabled for the PMC firmware after unbinding. */
+	return 0;
+}
+
+static const struct of_device_id bcm_pmb_pvtmon_of_match[] = {
+	{ .compatible = "brcm,bcm6846-pmb-pvtmon" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, bcm_pmb_pvtmon_of_match);
+
+static struct platform_driver bcm_pmb_pvtmon_driver = {
+	.probe = bcm_pmb_pvtmon_probe,
+	.driver = {
+		.name = "bcm6846-pmb-pvtmon",
+		.of_match_table = bcm_pmb_pvtmon_of_match,
+	},
+};
+module_platform_driver(bcm_pmb_pvtmon_driver);
+
+MODULE_AUTHOR("Linus Walleij <linusw@kernel.org>");
+MODULE_DESCRIPTION("Broadcom PMB PVTMON hardware monitoring driver");
+MODULE_LICENSE("GPL");

-- 
2.56.0

