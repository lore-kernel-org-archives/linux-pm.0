From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCHv2 2/4] ARM: bcm2835: add rpi power domain driver
Date: Sun, 29 Nov 2015 17:59:31 +0100
Message-ID: <1448816373-18235-3-git-send-email-alex.aring@gmail.com>
References: <1448816373-18235-1-git-send-email-alex.aring@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f49.google.com ([74.125.82.49]:37565 "EHLO
	mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751558AbbK2Q7z (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 29 Nov 2015 11:59:55 -0500
In-Reply-To: <1448816373-18235-1-git-send-email-alex.aring@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-rpi-kernel@lists.infradead.org
Cc: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, swarren@wwwdotorg.org, lee@kernel.org, eric@anholt.net, linux@arm.linux.org.uk, f.fainelli@gmail.com, rjui@broadcom.com, sbranden@broadcom.com, rjw@rjwysocki.net, khilman@kernel.org, ulf.hansson@linaro.org, len.brown@intel.com, pavel@ucw.cz, gregkh@linuxfoundation.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, bcm-kernel-feedback-list@broadcom.com, linux-pm@vger.kernel.org, kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch adds support for RPi several Power Domains and enable suppor=
t
to enable the USB Power Domain when it's not enabled before.

This patch based on Eric Anholt's patch to support Power Domains. He ha=
d
an issue about -EPROBE_DEFER inside the power domain subsystem, this
issue was solved by commit <311fa6a> ("PM / Domains: Return -EPROBE_DEF=
ER
if we fail to init or turn-on domain").

Cc: Stephen Warren <swarren@wwwdotorg.org>
Cc: Lee Jones <lee@kernel.org>
Cc: Eric Anholt <eric@anholt.net>
Signed-off-by: Alexander Aring <alex.aring@gmail.com>
Signed-off-by: Eric Anholt <eric@anholt.net>
---
 arch/arm/mach-bcm/Kconfig                   |  10 ++
 arch/arm/mach-bcm/Makefile                  |   1 +
 arch/arm/mach-bcm/raspberrypi-power.c       | 180 ++++++++++++++++++++=
++++++++
 include/dt-bindings/arm/raspberrypi-power.h |  14 +++
 4 files changed, 205 insertions(+)
 create mode 100644 arch/arm/mach-bcm/raspberrypi-power.c
 create mode 100644 include/dt-bindings/arm/raspberrypi-power.h

diff --git a/arch/arm/mach-bcm/Kconfig b/arch/arm/mach-bcm/Kconfig
index 8c53c55..0f23bad 100644
--- a/arch/arm/mach-bcm/Kconfig
+++ b/arch/arm/mach-bcm/Kconfig
@@ -134,6 +134,16 @@ config ARCH_BCM2835
 	  This enables support for the Broadcom BCM2835 SoC. This SoC is
 	  used in the Raspberry Pi and Roku 2 devices.
=20
+config RASPBERRYPI_POWER
+	bool "Raspberry Pi power domain driver"
+	depends on ARCH_BCM2835 || COMPILE_TEST
+	depends on RASPBERRYPI_FIRMWARE
+	select PM_GENERIC_DOMAINS if PM
+	select PM_GENERIC_DOMAINS_OF if PM
+	help
+	  This enables support for the RPi power domains which can be enabled
+	  or disabled via the RPi firmware.
+
 config ARCH_BCM_63XX
 	bool "Broadcom BCM63xx DSL SoC" if ARCH_MULTI_V7
 	depends on MMU
diff --git a/arch/arm/mach-bcm/Makefile b/arch/arm/mach-bcm/Makefile
index 892261f..fec2d6b 100644
--- a/arch/arm/mach-bcm/Makefile
+++ b/arch/arm/mach-bcm/Makefile
@@ -36,6 +36,7 @@ endif
=20
 # BCM2835
 obj-$(CONFIG_ARCH_BCM2835)	+=3D board_bcm2835.o
+obj-$(CONFIG_RASPBERRYPI_POWER)	+=3D raspberrypi-power.o
=20
 # BCM5301X
 obj-$(CONFIG_ARCH_BCM_5301X)	+=3D bcm_5301x.o
diff --git a/arch/arm/mach-bcm/raspberrypi-power.c b/arch/arm/mach-bcm/=
raspberrypi-power.c
new file mode 100644
index 0000000..3b61f18
--- /dev/null
+++ b/arch/arm/mach-bcm/raspberrypi-power.c
@@ -0,0 +1,180 @@
+/*
+ * This program is free software; you can redistribute it and/or modif=
y
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * Authors:
+ * (C) 2015 Pengutronix, Alexander Aring <aar@pengutronix.de>
+ * Eric Anholt <eric@anholt.net>
+ */
+
+#include <linux/module.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/pm_domain.h>
+#include <dt-bindings/arm/raspberrypi-power.h>
+#include <soc/bcm2835/raspberrypi-firmware.h>
+
+#define RPI_POWER_DOMAIN(_domain, _name)			\
+	[_domain] =3D {						\
+		.domain =3D _domain,				\
+		.enabled =3D true,				\
+		.base =3D {					\
+			.name =3D _name,				\
+			.power_off =3D rpi_domain_off,		\
+			.power_on =3D rpi_domain_on,		\
+		},						\
+	}
+
+struct rpi_power_domain {
+	u32 domain;
+	bool enabled;
+	struct generic_pm_domain base;
+};
+
+struct rpi_power_domain_packet {
+	u32 domain;
+	u32 on;
+} __packet;
+
+static struct rpi_firmware *fw;
+static struct genpd_onecell_data rpi_genpd_xlate;
+
+/*
+ * Asks the firmware to enable or disable power on a specific power
+ * domain.
+ */
+static int rpi_firmware_set_power(u32 domain, bool on)
+{
+	struct rpi_power_domain_packet packet;
+
+	packet.domain =3D domain;
+	packet.on =3D on;
+	return rpi_firmware_property(fw, RPI_FIRMWARE_SET_POWER_STATE, &packe=
t,
+				     sizeof(packet));
+}
+
+/* Asks the firmware to if power is on for a specific power domain. */
+static int rpi_firmware_power_is_on(u32 domain)
+{
+	struct rpi_power_domain_packet packet;
+	int ret;
+
+	packet.domain =3D domain;
+	ret =3D rpi_firmware_property(fw, RPI_FIRMWARE_GET_POWER_STATE, &pack=
et,
+				    sizeof(packet));
+	if (ret < 0)
+		return ret;
+
+	return packet.on & BIT(0);
+}
+
+static int rpi_domain_off(struct generic_pm_domain *domain)
+{
+	struct rpi_power_domain *rpi_domain =3D
+		container_of(domain, struct rpi_power_domain, base);
+
+	return rpi_firmware_set_power(rpi_domain->domain, false);
+}
+
+static int rpi_domain_on(struct generic_pm_domain *domain)
+{
+	struct rpi_power_domain *rpi_domain =3D
+		container_of(domain, struct rpi_power_domain, base);
+
+	return rpi_firmware_set_power(rpi_domain->domain, true);
+}
+
+static struct rpi_power_domain rpi_power_domains[] =3D {
+	RPI_POWER_DOMAIN(RPI_POWER_DOMAIN_USB, "USB"),
+};
+
+static int rpi_power_probe(struct platform_device *pdev)
+{
+	struct device_node *fw_np;
+	struct device *dev =3D &pdev->dev;
+	struct generic_pm_domain **power_domains;
+	int i, ret, num_domains =3D ARRAY_SIZE(rpi_power_domains);
+
+	fw_np =3D of_parse_phandle(pdev->dev.of_node, "firmware", 0);
+	if (!fw_np) {
+		dev_err(&pdev->dev, "no firmware node\n");
+		return -ENODEV;
+	}
+
+	fw =3D rpi_firmware_get(fw_np);
+	if (!fw)
+		return -EPROBE_DEFER;
+
+	power_domains =3D devm_kzalloc(dev, sizeof(*power_domains) * num_doma=
ins,
+				     GFP_KERNEL);
+	if (!power_domains)
+		return -ENOMEM;
+
+	rpi_genpd_xlate.domains =3D power_domains;
+	rpi_genpd_xlate.num_domains =3D num_domains;
+
+	for (i =3D 0; i < num_domains; i++) {
+		bool is_off;
+
+		if (!rpi_power_domains[i].enabled)
+			continue;
+
+		/* get the initial state */
+		ret =3D rpi_firmware_power_is_on(rpi_power_domains[i].domain);
+		if (ret < 0)
+			goto exit_pm;
+
+		/* pm_genpd_init needs is_off, invert the logic here */
+		is_off =3D !ret;
+		pm_genpd_init(&rpi_power_domains[i].base, NULL, is_off);
+		/* let power_domains array know about the registered pm */
+		power_domains[i] =3D &rpi_power_domains[i].base;
+	}
+
+	ret =3D of_genpd_add_provider_onecell(dev->of_node, &rpi_genpd_xlate)=
;
+	if (ret < 0)
+		goto exit_pm;
+
+	return 0;
+
+exit_pm:
+	for (i =3D 0; i < num_domains; i++)
+		pm_genpd_exit(power_domains[i]);
+
+	return ret;
+}
+
+static int rpi_power_remove(struct platform_device *pdev)
+{
+	struct device *dev =3D &pdev->dev;
+	int i;
+
+	for (i =3D 0; i < rpi_genpd_xlate.num_domains; i++)
+		pm_genpd_exit(rpi_genpd_xlate.domains[i]);
+
+	of_genpd_del_provider(dev->of_node);
+
+	return 0;
+}
+
+static const struct of_device_id rpi_power_of_match[] =3D {
+	{ .compatible =3D "raspberrypi,bcm2835-power", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, rpi_power_of_match);
+
+static struct platform_driver rpi_power_driver =3D {
+	.driver =3D {
+		.name =3D "raspberrypi-power",
+		.of_match_table =3D rpi_power_of_match,
+	},
+	.probe		=3D rpi_power_probe,
+	.remove		=3D rpi_power_remove,
+};
+module_platform_driver(rpi_power_driver);
+
+MODULE_AUTHOR("Alexander Aring <aar@pengutronix.de>");
+MODULE_AUTHOR("Eric Anholt <eric@anholt.net>");
+MODULE_DESCRIPTION("Raspberry Pi power domain driver");
+MODULE_LICENSE("GPL v2");
diff --git a/include/dt-bindings/arm/raspberrypi-power.h b/include/dt-b=
indings/arm/raspberrypi-power.h
new file mode 100644
index 0000000..c2ffbebc
--- /dev/null
+++ b/include/dt-bindings/arm/raspberrypi-power.h
@@ -0,0 +1,14 @@
+/*
+ *  Copyright =C2=A9 2015 Broadcom
+ *
+ * This program is free software; you can redistribute it and/or modif=
y
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef _DT_BINDINGS_ARM_BCM2835_RPI_POWER_H
+#define _DT_BINDINGS_ARM_BCM2835_RPI_POWER_H
+
+#define RPI_POWER_DOMAIN_USB	3
+
+#endif /* _DT_BINDINGS_ARM_BCM2835_RPI_POWER_H */
--=20
2.6.1

