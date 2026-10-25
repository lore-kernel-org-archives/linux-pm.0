Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=138.232.1.140
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792956166;
	b=pJW20BOqQUGVzC34tdc7HkQxLJySFM0rKl3k+s6duLjjLBOsqsyzOfSoIQRlKNl8iTmM
	 tEyQHWl07+xD9H8y688/P5AUWUy8Gn5xoUoW58FPCyXvnpgg6oPTvY1aX8U8NMoBuoAB2
	 ojgb+bOUx1VvLm4v9Jol1shodnN/KmXT39wNoouQ2ENs8cGMyrQ8sEeFmBVbJ+vHkpdqZ
	 RvLTdOI6a+wQh+C3pez1kGr5hNa62o1ReoqvupHvpubeAt9/9c9nJP3SMn3B1AFwlIHI7
	 eU/i7cSSNxkY//HcXs8Bba5K/2VVy6+jglDb8iAWl/Btjt1xbAYoFbQXxWVfVkVwlRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792956166;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Spam-Score:X-Scanned-By;
	bh=e8LTZ2uC9f6CiL9OVxVtZ0TOWi7JUjz1QF5J6Yqw/0A=;
	b=PTW9f3CrYRCslh/8tGaIUCliEWPYhMDvzniNDAqmy5WelAU16YmLRG6TbD27KN+xO3v1
	 mns7rKepWQkQcRYI0k6JuXK+Iqw9o8Ve5CIrk4+ffg5PYrm5JQc6QIhS0NeNmK4OWlChR
	 v84wtRRY4sLpmzv9hjlQrttgPU2WOuI6+fEf8WKO9QY7ixjTOSVExhoR2EQkdJH51ur31
	 xjfhtgeghWYOwxhlVjuBKoYSOEJxXN1DJZpgsiLpYBhbS5nPdn/H8Q8ORbz8Ac7y9yk38
	 EEh5FOC8bsYGX1GxnozBTVgBoE0la/f6NTKgUTr1IyDCXNUptYa8RsmbDJNbX7WIhGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=student.uibk.ac.at;
	spf=pass smtp.mailfrom=student.uibk.ac.at;
	dkim=pass header.d=student.uibk.ac.at header.i=@student.uibk.ac.at header.a=rsa-sha256 header.s=prod24a header.b=hOTkCfHn;
	arc=none smtp.remote-ip=138.232.1.140
Received: from smtp.uibk.ac.at (smtp.uibk.ac.at [138.232.1.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E954B606A33B;
	Sun, 25 Oct 2026 19:22:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E954B606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=student.uibk.ac.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=student.uibk.ac.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=student.uibk.ac.at header.i=@student.uibk.ac.at header.a=rsa-sha256 header.s=prod24a header.b=hOTkCfHn
Received: from surface-pro-5 (178.115.151.51.wireless.dyn.drei.com [178.115.151.51])
	(authenticated bits=0)
	by smtp.uibk.ac.at (8.15.2/8.15.2/F1) with ESMTPSA id 69PJMK14517096
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sun, 25 Oct 2026 20:22:30 +0100
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp.uibk.ac.at 69PJMK14517096
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=student.uibk.ac.at;
	s=prod24a; t=1792956151;
	bh=e8LTZ2uC9f6CiL9OVxVtZ0TOWi7JUjz1QF5J6Yqw/0A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hOTkCfHn6mU3e2BsU54Y879M/kOUIqVo8Z2wNNy09IZgPh2bgKVdTAYaVMyq6j99+
	 grbIXzceiL3iO7uc4VPEIi8VouyharafAZMm1coRMMHa0gSVwDKX2yOvEPGKKq6uYy
	 CHCsqVL43oafmAH9opZbHJr5+xWnMedcAOb6G7ZM=
From: christian.koever-draxl@student.uibk.ac.at
To: neil.armstrong@linaro.org, jbrunet@baylibre.com, sboyd@kernel.org,
        bmasney+clk@redhat.com, khilman@baylibre.com,
        martin.blumenstingl@googlemail.com, rafael@kernel.org,
        viresh.kumar@linaro.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        =?UTF-8?q?Christian=20Stefan=20K=C3=B6v=C3=A9r-Draxl?= <ckoever@outlook.de>
Subject: [PATCH 4/4] cpufreq: add an Amlogic speed-bin driver
Date: Sun, 25 Oct 2026 20:22:19 +0100
Message-ID: <20261025192219.209137-5-christian.koever-draxl@student.uibk.ac.at>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261025192219.209137-1-christian.koever-draxl@student.uibk.ac.at>
References: <20261025192219.209137-1-christian.koever-draxl@student.uibk.ac.at>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Score: () -13.0 ALL_TRUSTED,RCV_SMTP_AUTH,RCV_SMTP_UIBK,U_H_APTO_LONG,U_RCPTS_11_PLUS
X-Scanned-By: MIMEDefang_3.2_at_uibk.ac.at

From: Christian Stefan Kövér-Draxl <ckoever@outlook.de>

Every S4 speed bin runs the same CPU frequencies but needs its own
voltage curve, and the bin can only be read through the secure monitor.

Read the bin from the firmware, select the matching
"opp-microvolt-speed<bin>" property for all CPUs, then register
cpufreq-dt. Bins outside the known range fall back to bin 0, which
has the highest voltages. Like sun50i-cpufreq-nvmem, the driver binds
on the SoC compatible and needs no node of its own, and S4 is added to
the cpufreq-dt-platdev blocklist so cpufreq-dt is only created after
the bin has been applied.

Signed-off-by: Christian Stefan Kövér-Draxl <ckoever@outlook.de>
---
 MAINTAINERS                          |   1 +
 drivers/cpufreq/Kconfig.arm          |  14 ++
 drivers/cpufreq/Makefile             |   1 +
 drivers/cpufreq/amlogic-cpufreq.c    | 184 +++++++++++++++++++++++++++
 drivers/cpufreq/cpufreq-dt-platdev.c |   2 +
 5 files changed, 202 insertions(+)
 create mode 100644 drivers/cpufreq/amlogic-cpufreq.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 0e9fe9c2a39b..c048aed9f7d9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2597,6 +2597,7 @@ F:	Documentation/devicetree/bindings/phy/amlogic*
 F:	arch/arm/boot/dts/amlogic/
 F:	arch/arm/mach-meson/
 F:	arch/arm64/boot/dts/amlogic/
+F:	drivers/cpufreq/amlogic-cpufreq.c
 F:	drivers/pmdomain/amlogic/
 F:	drivers/mmc/host/meson*
 F:	drivers/phy/amlogic/
diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index a441668f9e0c..c0e60e6801c1 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -24,6 +24,20 @@ config ARM_AIROHA_SOC_CPUFREQ
 	help
 	  This adds the CPUFreq driver for Airoha EN7581 SoCs.
 
+config ARM_AMLOGIC_CPUFREQ
+	tristate "Amlogic CPUFreq speed-bin support"
+	depends on ARCH_MESON || COMPILE_TEST
+	depends on CPUFREQ_DT
+	depends on MESON_SM
+	help
+	  This adds the CPUFreq driver for Amlogic SoCs whose CPU speed bin
+	  is only readable through the secure monitor, such as the S4 family.
+	  It reads the bin from the firmware, selects the matching voltage
+	  curve from the CPU operating points table and then registers
+	  cpufreq-dt.
+
+	  If unsure, say N.
+
 config ARM_APPLE_SOC_CPUFREQ
 	tristate "Apple Silicon SoC CPUFreq support"
 	depends on ARCH_APPLE || (COMPILE_TEST && 64BIT)
diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
index 6c7a39b7f8d2..781b92f9d43f 100644
--- a/drivers/cpufreq/Makefile
+++ b/drivers/cpufreq/Makefile
@@ -54,6 +54,7 @@ obj-$(CONFIG_X86_AMD_FREQ_SENSITIVITY)	+= amd_freq_sensitivity.o
 ##################################################################################
 # ARM SoC drivers
 obj-$(CONFIG_ARM_AIROHA_SOC_CPUFREQ)	+= airoha-cpufreq.o
+obj-$(CONFIG_ARM_AMLOGIC_CPUFREQ)	+= amlogic-cpufreq.o
 obj-$(CONFIG_ARM_APPLE_SOC_CPUFREQ)	+= apple-soc-cpufreq.o
 obj-$(CONFIG_ARM_ARMADA_37XX_CPUFREQ)	+= armada-37xx-cpufreq.o
 obj-$(CONFIG_ARM_ARMADA_8K_CPUFREQ)	+= armada-8k-cpufreq.o
diff --git a/drivers/cpufreq/amlogic-cpufreq.c b/drivers/cpufreq/amlogic-cpufreq.c
new file mode 100644
index 000000000000..60f399d14846
--- /dev/null
+++ b/drivers/cpufreq/amlogic-cpufreq.c
@@ -0,0 +1,184 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Amlogic CPUFreq speed-bin driver
+ *
+ * Amlogic SoCs are binned at manufacturing time and every bin has its own
+ * voltage curve for one and the same set of frequencies. The bin is only
+ * readable through the secure monitor. This driver asks the firmware which
+ * bin the chip is, points the OPP core at the matching
+ * "opp-microvolt-speed<bin>" property, and then hands over to cpufreq-dt.
+ *
+ * Copyright (c) 2026 Christian Stefan Kövér-Draxl <ckoever@outlook.de>
+ */
+
+#include <linux/cpu.h>
+#include <linux/firmware/meson/meson_sm.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/pm_opp.h>
+#include <linux/slab.h>
+
+/* The firmware reports one of four bins, 0 being the one needing most volts */
+#define AMLOGIC_CPUFREQ_MAX_BIN		3
+
+static struct platform_device *amlogic_cpufreq_pdev;
+
+struct amlogic_cpufreq {
+	struct platform_device *cpufreq_dt;
+	unsigned int nr_configured;
+	int opp_tokens[];
+};
+
+static int amlogic_cpufreq_get_speed_bin(struct device *dev)
+{
+	struct meson_sm_firmware *fw;
+	s32 bin;
+	int ret;
+
+	struct device_node *sm_np __free(device_node) =
+		of_find_compatible_node(NULL, NULL, "amlogic,meson-gxbb-sm");
+	if (!sm_np)
+		return dev_err_probe(dev, -ENODEV, "no secure monitor\n");
+
+	fw = meson_sm_get(sm_np);
+	if (!fw)
+		return -EPROBE_DEFER;
+
+	/* The only argument is the cluster, these SoCs have a single one */
+	ret = meson_sm_call(fw, SM_GET_CPU_SPEED_BIN, &bin, 0, 0, 0, 0, 0);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "failed to read the speed bin\n");
+
+	/*
+	 * Treat anything outside the known range as bin 0, whose voltages are
+	 * the highest and therefore safe on any chip.
+	 */
+	if (bin < 0 || bin > AMLOGIC_CPUFREQ_MAX_BIN) {
+		dev_warn(dev, "unknown speed bin %d, assuming 0\n", bin);
+		bin = 0;
+	}
+
+	return bin;
+}
+
+static void amlogic_cpufreq_clear_config(struct amlogic_cpufreq *priv)
+{
+	unsigned int cpu;
+
+	for (cpu = 0; cpu < priv->nr_configured; cpu++)
+		dev_pm_opp_clear_config(priv->opp_tokens[cpu]);
+}
+
+static int amlogic_cpufreq_probe(struct platform_device *pdev)
+{
+	struct dev_pm_opp_config config = {};
+	struct device *dev = &pdev->dev;
+	struct amlogic_cpufreq *priv;
+	char name[16];
+	unsigned int cpu;
+	int bin, ret;
+
+	bin = amlogic_cpufreq_get_speed_bin(dev);
+	if (bin < 0)
+		return bin;
+
+	priv = devm_kzalloc(dev, struct_size(priv, opp_tokens, nr_cpu_ids),
+			    GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	snprintf(name, sizeof(name), "speed%d", bin);
+	config.prop_name = name;
+
+	for_each_present_cpu(cpu) {
+		struct device *cpu_dev = get_cpu_device(cpu);
+
+		if (!cpu_dev) {
+			ret = -ENODEV;
+			goto clear_config;
+		}
+
+		ret = dev_pm_opp_set_config(cpu_dev, &config);
+		if (ret < 0)
+			goto clear_config;
+
+		priv->opp_tokens[cpu] = ret;
+		priv->nr_configured = cpu + 1;
+	}
+
+	priv->cpufreq_dt = platform_device_register_simple("cpufreq-dt", -1,
+							   NULL, 0);
+	if (IS_ERR(priv->cpufreq_dt)) {
+		ret = PTR_ERR(priv->cpufreq_dt);
+		goto clear_config;
+	}
+
+	platform_set_drvdata(pdev, priv);
+	dev_info(dev, "using the voltages of speed bin %d\n", bin);
+
+	return 0;
+
+clear_config:
+	amlogic_cpufreq_clear_config(priv);
+
+	return ret;
+}
+
+static void amlogic_cpufreq_remove(struct platform_device *pdev)
+{
+	struct amlogic_cpufreq *priv = platform_get_drvdata(pdev);
+
+	platform_device_unregister(priv->cpufreq_dt);
+	amlogic_cpufreq_clear_config(priv);
+}
+
+static struct platform_driver amlogic_cpufreq_driver = {
+	.probe = amlogic_cpufreq_probe,
+	.remove = amlogic_cpufreq_remove,
+	.driver = {
+		.name = "amlogic-cpufreq",
+	},
+};
+
+static const struct of_device_id amlogic_cpufreq_match_list[] = {
+	{ .compatible = "amlogic,s4" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, amlogic_cpufreq_match_list);
+
+/*
+ * The secure monitor may not have probed yet, so all the real work happens
+ * in probe, which can be deferred. Init only registers the driver and its
+ * device, on the SoCs the driver knows about.
+ */
+static int __init amlogic_cpufreq_init(void)
+{
+	int ret;
+
+	if (!of_machine_device_match(amlogic_cpufreq_match_list))
+		return -ENODEV;
+
+	ret = platform_driver_register(&amlogic_cpufreq_driver);
+	if (ret)
+		return ret;
+
+	amlogic_cpufreq_pdev = platform_device_register_simple("amlogic-cpufreq",
+							       -1, NULL, 0);
+	ret = PTR_ERR_OR_ZERO(amlogic_cpufreq_pdev);
+	if (ret)
+		platform_driver_unregister(&amlogic_cpufreq_driver);
+
+	return ret;
+}
+module_init(amlogic_cpufreq_init);
+
+static void __exit amlogic_cpufreq_exit(void)
+{
+	platform_device_unregister(amlogic_cpufreq_pdev);
+	platform_driver_unregister(&amlogic_cpufreq_driver);
+}
+module_exit(amlogic_cpufreq_exit);
+
+MODULE_DESCRIPTION("Amlogic CPUFreq speed-bin driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
index bce4c87573a1..f452ddc46b2c 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -115,6 +115,8 @@ static const struct of_device_id blocklist[] __initconst = {
 	{ .compatible = "allwinner,sun50i-h618", },
 	{ .compatible = "allwinner,sun50i-h700", },
 
+	{ .compatible = "amlogic,s4", },
+
 	{ .compatible = "apple,arm-platform", },
 
 	{ .compatible = "arm,vexpress", },
-- 
2.56.0

