From: Eric Anholt <eric@anholt.net>
Subject: [PATCH v2 3/5] ARM: bcm2835: add rpi power domain driver
Date: Fri,  4 Dec 2015 09:45:46 -0800
Message-ID: <1449251148-19344-4-git-send-email-eric@anholt.net>
References: <1449251148-19344-1-git-send-email-eric@anholt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from gabe.freedesktop.org ([131.252.210.177]:58648 "EHLO
	gabe.freedesktop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753118AbbLDRpu (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 4 Dec 2015 12:45:50 -0500
In-Reply-To: <1449251148-19344-1-git-send-email-eric@anholt.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-arm-kernel@lists.infradead.org, linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Stephen Warren <swarren@wwwdotorg.org>, Lee Jones <lee@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alexander Aring <alex.aring@gmail.com>, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Eric Anholt <eric@anholt.net>

=46rom: Alexander Aring <alex.aring@gmail.com>

This patch adds support for several power domains on Raspberry Pi,
including USB (so it can be enabled even if the bootloader didn't do
it), and graphics.

This patch is the combined work of Eric Anholt (who wrote USB support
inside of the Raspberry Pi firmware driver, and wrote the non-USB
domain support) and Alexander Aring (who separated the original USB
work out from the firmware driver).

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
Signed-off-by: Eric Anholt <eric@anholt.net>
---

v2: Add support for power domains other than USB, using the new
    firmware interface, reword commit message (changes by Eric)

 arch/arm/mach-bcm/Kconfig                   |  10 ++
 arch/arm/mach-bcm/Makefile                  |   1 +
 arch/arm/mach-bcm/raspberrypi-power.c       | 269 ++++++++++++++++++++=
++++++++
 include/dt-bindings/arm/raspberrypi-power.h |  41 +++++
 4 files changed, 321 insertions(+)
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
index 0000000..3444301
--- /dev/null
+++ b/arch/arm/mach-bcm/raspberrypi-power.c
@@ -0,0 +1,269 @@
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
+/*
+ * Firmware indices for the old power domains interface.  Only a few
+ * of them were actually implemented.
+ */
+#define RPI_OLD_POWER_DOMAIN_USB		3
+#define RPI_OLD_POWER_DOMAIN_V3D		10
+
+struct rpi_power_domain {
+	u32 domain;
+	bool enabled;
+	bool old_interface;
+	struct generic_pm_domain base;
+	struct rpi_firmware *fw;
+};
+
+struct rpi_power_domains {
+	bool has_new_interface;
+	struct genpd_onecell_data xlate;
+	struct rpi_firmware *fw;
+	struct rpi_power_domain domains[RPI_POWER_DOMAIN_COUNT];
+};
+
+/*
+ * Packet definition used by RPI_FIRMWARE_SET_POWER_STATE and
+ * RPI_FIRMWARE_SET_DOMAIN_STATE
+ */
+struct rpi_power_domain_packet {
+	u32 domain;
+	u32 on;
+} __packet;
+
+/*
+ * Asks the firmware to enable or disable power on a specific power
+ * domain.
+ */
+static int rpi_firmware_set_power(struct rpi_power_domain *rpi_domain,=
 bool on)
+{
+	struct rpi_power_domain_packet packet;
+
+	packet.domain =3D rpi_domain->domain;
+	packet.on =3D on;
+	return rpi_firmware_property(rpi_domain->fw,
+				     rpi_domain->old_interface ?
+				     RPI_FIRMWARE_SET_POWER_STATE :
+				     RPI_FIRMWARE_SET_DOMAIN_STATE,
+				     &packet, sizeof(packet));
+}
+
+static int rpi_domain_off(struct generic_pm_domain *domain)
+{
+	struct rpi_power_domain *rpi_domain =3D
+		container_of(domain, struct rpi_power_domain, base);
+
+	return rpi_firmware_set_power(rpi_domain, false);
+}
+
+static int rpi_domain_on(struct generic_pm_domain *domain)
+{
+	struct rpi_power_domain *rpi_domain =3D
+		container_of(domain, struct rpi_power_domain, base);
+
+	return rpi_firmware_set_power(rpi_domain, true);
+}
+
+static void rpi_common_init_power_domain(struct rpi_power_domains *rpi=
_domains,
+					 int xlate_index, const char *name)
+{
+	struct rpi_power_domain *dom =3D &rpi_domains->domains[xlate_index];
+
+	dom->fw =3D rpi_domains->fw;
+
+	dom->base.name =3D name;
+	dom->base.power_on =3D rpi_domain_on;
+	dom->base.power_off =3D rpi_domain_off;
+
+	/*
+	 * Treat all power domains as off at boot.
+	 *
+	 * The firmware itself may be keeping some domains on, but
+	 * from Linux's perspective all we control is the refcounts
+	 * that we give to the firmware, and we can't ask the firmware
+	 * to turn off something that we haven't ourselves turned on.
+	 */
+	pm_genpd_init(&dom->base, NULL, true);
+
+	rpi_domains->xlate.domains[xlate_index] =3D &dom->base;
+}
+
+static void rpi_init_power_domain(struct rpi_power_domains *rpi_domain=
s,
+				  int xlate_index, const char *name)
+{
+	struct rpi_power_domain *dom =3D &rpi_domains->domains[xlate_index];
+
+	if (!rpi_domains->has_new_interface)
+		return;
+
+	/* The DT binding index is the firmware's domain index minus one. */
+	dom->domain =3D xlate_index + 1;
+
+	rpi_common_init_power_domain(rpi_domains, xlate_index, name);
+}
+
+static void rpi_init_old_power_domain(struct rpi_power_domains *rpi_do=
mains,
+				      int xlate_index, int domain,
+				      const char *name)
+{
+	struct rpi_power_domain *dom =3D &rpi_domains->domains[xlate_index];
+
+	dom->old_interface =3D true;
+	dom->domain =3D domain;
+
+	rpi_common_init_power_domain(rpi_domains, xlate_index, name);
+}
+
+/*
+ * Detects whether the firmware supports the new power domains interfa=
ce.
+ *
+ * The firmware doesn't actually return an error on an unknown tag,
+ * and just skips over it, so we do the detection by putting an
+ * unexpected value in the return field and checking if it was
+ * unchanged.
+ */
+static bool
+rpi_has_new_domain_support(struct rpi_power_domains *rpi_domains)
+{
+	struct rpi_power_domain_packet packet;
+	int ret;
+
+	packet.domain =3D RPI_POWER_DOMAIN_ARM;
+	packet.on =3D ~0;
+
+	ret =3D rpi_firmware_property(rpi_domains->fw,
+				    RPI_FIRMWARE_GET_DOMAIN_STATE,
+				    &packet, sizeof(packet));
+
+	return ret =3D=3D 0 && packet.on !=3D ~0;
+}
+
+static int rpi_power_probe(struct platform_device *pdev)
+{
+	struct device_node *fw_np;
+	struct device *dev =3D &pdev->dev;
+	struct rpi_power_domains *rpi_domains;
+	int ret, i;
+
+	rpi_domains =3D devm_kzalloc(dev, sizeof(*rpi_domains), GFP_KERNEL);
+	if (!rpi_domains)
+		return -ENOMEM;
+
+	rpi_domains->xlate.domains =3D
+		devm_kzalloc(dev, sizeof(*rpi_domains->xlate.domains) *
+			     RPI_POWER_DOMAIN_COUNT, GFP_KERNEL);
+	if (!rpi_domains->xlate.domains)
+		return -ENOMEM;
+
+	rpi_domains->xlate.num_domains =3D RPI_POWER_DOMAIN_COUNT;
+
+	fw_np =3D of_parse_phandle(pdev->dev.of_node, "firmware", 0);
+	if (!fw_np) {
+		dev_err(&pdev->dev, "no firmware node\n");
+		return -ENODEV;
+	}
+
+	rpi_domains->fw =3D rpi_firmware_get(fw_np);
+	of_node_put(fw_np);
+	if (!rpi_domains->fw)
+		return -EPROBE_DEFER;
+
+	rpi_domains->has_new_interface =3D
+		rpi_has_new_domain_support(rpi_domains);
+
+	rpi_init_power_domain(rpi_domains, RPI_POWER_DOMAIN_I2C0, "I2C0");
+	rpi_init_power_domain(rpi_domains, RPI_POWER_DOMAIN_I2C1, "I2C1");
+	rpi_init_power_domain(rpi_domains, RPI_POWER_DOMAIN_I2C2, "I2C2");
+	rpi_init_power_domain(rpi_domains, RPI_POWER_DOMAIN_VIDEO_SCALER,
+			      "VIDEO_SCALER");
+	rpi_init_power_domain(rpi_domains, RPI_POWER_DOMAIN_VPU1, "VPU1");
+	rpi_init_power_domain(rpi_domains, RPI_POWER_DOMAIN_HDMI, "HDMI");
+
+	/*
+	 * Use the old firmware interface for USB power, so that we
+	 * can turn it on even if the firmware hasn't been updated.
+	 */
+	rpi_init_old_power_domain(rpi_domains, RPI_POWER_DOMAIN_USB,
+				  RPI_OLD_POWER_DOMAIN_USB, "USB");
+
+	rpi_init_power_domain(rpi_domains, RPI_POWER_DOMAIN_VEC, "VEC");
+	rpi_init_power_domain(rpi_domains, RPI_POWER_DOMAIN_JPEG, "JPEG");
+	rpi_init_power_domain(rpi_domains, RPI_POWER_DOMAIN_H264, "H264");
+	rpi_init_power_domain(rpi_domains, RPI_POWER_DOMAIN_V3D, "V3D");
+	rpi_init_power_domain(rpi_domains, RPI_POWER_DOMAIN_UNICAM0, "UNICAM0=
");
+	rpi_init_power_domain(rpi_domains, RPI_POWER_DOMAIN_UNICAM1, "UNICAM1=
");
+	rpi_init_power_domain(rpi_domains, RPI_POWER_DOMAIN_CCP2RX, "CCP2RX")=
;
+	rpi_init_power_domain(rpi_domains, RPI_POWER_DOMAIN_CSI2, "CSI2");
+	rpi_init_power_domain(rpi_domains, RPI_POWER_DOMAIN_CPI, "CPI");
+	rpi_init_power_domain(rpi_domains, RPI_POWER_DOMAIN_DSI0, "DSI0");
+	rpi_init_power_domain(rpi_domains, RPI_POWER_DOMAIN_DSI1, "DSI1");
+	rpi_init_power_domain(rpi_domains, RPI_POWER_DOMAIN_TRANSPOSER,
+			      "TRANPOSER");
+	rpi_init_power_domain(rpi_domains, RPI_POWER_DOMAIN_CCP2TX, "CCP2TX")=
;
+	rpi_init_power_domain(rpi_domains, RPI_POWER_DOMAIN_CDP, "CDP");
+	rpi_init_power_domain(rpi_domains, RPI_POWER_DOMAIN_ARM, "ARM");
+
+	ret =3D of_genpd_add_provider_onecell(dev->of_node, &rpi_domains->xla=
te);
+	if (ret < 0)
+		goto exit_pm;
+
+	platform_set_drvdata(pdev, rpi_domains);
+
+	return 0;
+
+exit_pm:
+	for (i =3D 0; i < rpi_domains->xlate.num_domains; i++)
+		pm_genpd_exit(rpi_domains->xlate.domains[i]);
+
+	return ret;
+}
+
+static int rpi_power_remove(struct platform_device *pdev)
+{
+	struct rpi_power_domains *rpi_domains =3D platform_get_drvdata(pdev);
+	struct device *dev =3D &pdev->dev;
+	int i;
+
+	for (i =3D 0; i < rpi_domains->xlate.num_domains; i++)
+		pm_genpd_exit(rpi_domains->xlate.domains[i]);
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
index 0000000..b3ff8e0
--- /dev/null
+++ b/include/dt-bindings/arm/raspberrypi-power.h
@@ -0,0 +1,41 @@
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
+/* These power domain indices are the firmware interface's indices
+ * minus one.
+ */
+#define RPI_POWER_DOMAIN_I2C0		0
+#define RPI_POWER_DOMAIN_I2C1		1
+#define RPI_POWER_DOMAIN_I2C2		2
+#define RPI_POWER_DOMAIN_VIDEO_SCALER	3
+#define RPI_POWER_DOMAIN_VPU1		4
+#define RPI_POWER_DOMAIN_HDMI		5
+#define RPI_POWER_DOMAIN_USB		6
+#define RPI_POWER_DOMAIN_VEC		7
+#define RPI_POWER_DOMAIN_JPEG		8
+#define RPI_POWER_DOMAIN_H264		9
+#define RPI_POWER_DOMAIN_V3D		10
+#define RPI_POWER_DOMAIN_ISP		11
+#define RPI_POWER_DOMAIN_UNICAM0	12
+#define RPI_POWER_DOMAIN_UNICAM1	13
+#define RPI_POWER_DOMAIN_CCP2RX		14
+#define RPI_POWER_DOMAIN_CSI2		15
+#define RPI_POWER_DOMAIN_CPI		16
+#define RPI_POWER_DOMAIN_DSI0		17
+#define RPI_POWER_DOMAIN_DSI1		18
+#define RPI_POWER_DOMAIN_TRANSPOSER	19
+#define RPI_POWER_DOMAIN_CCP2TX		20
+#define RPI_POWER_DOMAIN_CDP		21
+#define RPI_POWER_DOMAIN_ARM		22
+
+#define RPI_POWER_DOMAIN_COUNT		23
+
+#endif /* _DT_BINDINGS_ARM_BCM2835_RPI_POWER_H */
--=20
2.6.2

