From: Lubomir Rintel <lkundrak-NGH9Lh4a5iE@public.gmane.org>
Subject: [PATCH] cpufreq: Add Broadcom BCM2835 CPU frequency control driver
Date: Sun, 11 Oct 2015 21:46:55 +0200
Message-ID: <1444592815-15271-1-git-send-email-lkundrak@v3.sk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rpi-kernel-bounces+glkr-linux-rpi-kernel=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rpi-kernel>,
 <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rpi-kernel/>
List-Post: <mailto:linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rpi-kernel>,
 <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "linux-rpi-kernel" <linux-rpi-kernel-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rpi-kernel-bounces+glkr-linux-rpi-kernel=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, cpufreq-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

This adds a device tree binding for Broadcom BCM2834 CPU frequency
control driven via Raspberry Pi VideoCore 4 firmware interface.

Based on a driver by Dom Cobley.

Signed-off-by: Dom Cobley <popcornmix-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Signed-off-by: Lubomir Rintel <lkundrak-NGH9Lh4a5iE@public.gmane.org>
Cc: "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Cc: Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>
Cc: cpufreq-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
---
Depends on the RPi Firmware driver submitted on linux-rpi-kernel a while ago.
Can't see it in arm-soc or linux-next yet though (?). Available in branch
'rpi-firmware' of https://github.com/anholt/linux

 arch/arm/boot/dts/bcm2835-rpi.dtsi |   5 +
 arch/arm/mach-bcm/Kconfig          |   1 +
 drivers/cpufreq/Kconfig.arm        |   9 ++
 drivers/cpufreq/Makefile           |   1 +
 drivers/cpufreq/bcm2835-cpufreq.c  | 199 +++++++++++++++++++++++++++++++++++++
 5 files changed, 215 insertions(+)
 create mode 100644 drivers/cpufreq/bcm2835-cpufreq.c

diff --git a/arch/arm/boot/dts/bcm2835-rpi.dtsi b/arch/arm/boot/dts/bcm2835-rpi.dtsi
index ab5474e..0895307 100644
--- a/arch/arm/boot/dts/bcm2835-rpi.dtsi
+++ b/arch/arm/boot/dts/bcm2835-rpi.dtsi
@@ -20,6 +20,11 @@
 			compatible = "raspberrypi,bcm2835-firmware";
 			mboxes = <&mailbox>;
 		};
+
+		cpufreq {
+			compatible = "raspberrypi,bcm2835-cpufreq";
+			firmware = <&firmware>;
+		};
 	};
 };
 
diff --git a/arch/arm/mach-bcm/Kconfig b/arch/arm/mach-bcm/Kconfig
index 1319c3c..686f950 100644
--- a/arch/arm/mach-bcm/Kconfig
+++ b/arch/arm/mach-bcm/Kconfig
@@ -110,6 +110,7 @@ comment "Other Architectures"
 config ARCH_BCM2835
 	bool "Broadcom BCM2835 family" if ARCH_MULTI_V6
 	select ARCH_REQUIRE_GPIOLIB
+	select ARCH_HAS_CPUFREQ
 	select ARM_AMBA
 	select ARM_ERRATA_411920
 	select ARM_TIMER_SP804
diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index cd0391e..2248373 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -227,3 +227,12 @@ config ARM_PXA2xx_CPUFREQ
 	  This add the CPUFreq driver support for Intel PXA2xx SOCs.
 
 	  If in doubt, say N.
+
+config ARM_BCM2835_CPUFREQ
+	tristate "Raspberry Pi BCM2835 CPUFreq support"
+	depends on RASPBERRYPI_FIRMWARE
+	help
+	  This adds the BCM2835 CPU frequency control driver for Raspberry Pi
+	  devices.
+
+	  If in doubt, say N.
diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
index 4134038..4543df9 100644
--- a/drivers/cpufreq/Makefile
+++ b/drivers/cpufreq/Makefile
@@ -52,6 +52,7 @@ obj-$(CONFIG_ARM_DT_BL_CPUFREQ)		+= arm_big_little_dt.o
 
 obj-$(CONFIG_ARCH_DAVINCI)		+= davinci-cpufreq.o
 obj-$(CONFIG_UX500_SOC_DB8500)		+= dbx500-cpufreq.o
+obj-$(CONFIG_ARM_BCM2835_CPUFREQ)	+= bcm2835-cpufreq.o
 obj-$(CONFIG_ARM_EXYNOS5440_CPUFREQ)	+= exynos5440-cpufreq.o
 obj-$(CONFIG_ARM_HIGHBANK_CPUFREQ)	+= highbank-cpufreq.o
 obj-$(CONFIG_ARM_HISI_ACPU_CPUFREQ)	+= hisi-acpu-cpufreq.o
diff --git a/drivers/cpufreq/bcm2835-cpufreq.c b/drivers/cpufreq/bcm2835-cpufreq.c
new file mode 100644
index 0000000..0fc4cb5
--- /dev/null
+++ b/drivers/cpufreq/bcm2835-cpufreq.c
@@ -0,0 +1,199 @@
+/*
+ * This driver dynamically manages the CPU Frequency of the ARM processor.
+ * Messages are sent to Videocore either setting or requesting the
+ * frequency of the ARM in order to match an appropriate frequency to the
+ * current usage of the processor. The policy which selects the frequency
+ * to use is defined in the kernel .config file, but can be changed during
+ * runtime.
+ *
+ * Copyright 2011 Broadcom Corporation.  All rights reserved.
+ * Copyright 2013,2015 Lubomir Rintel
+ *
+ * Unless you and Broadcom execute a separate written software license
+ * agreement governing use of this software, this software is licensed to you
+ * under the terms of the GNU General Public License version 2, available at
+ * http://www.broadcom.com/licenses/GPLv2.php (the "GPL").
+ *
+ * Notwithstanding the above, under no circumstances may you combine this
+ * software in any way with any other Broadcom software provided under a
+ * license other than the GPL, without Broadcom's express prior written
+ * consent.
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/cpufreq.h>
+#include <linux/dma-mapping.h>
+#include <linux/mailbox_client.h>
+#include <linux/platform_device.h>
+#include <soc/bcm2835/raspberrypi-firmware.h>
+
+#define VCMSG_SET_CLOCK_RATE	0x00038002
+#define VCMSG_GET_CLOCK_RATE	0x00030002
+#define VCMSG_GET_MIN_CLOCK	0x00030007
+#define VCMSG_GET_MAX_CLOCK	0x00030004
+#define VCMSG_ID_ARM_CLOCK	0x00000003	/* Clock/Voltage ID's */
+
+struct rpi_firmware *fw;
+
+/* tag part of the message */
+struct prop {
+	u32 dev_id;		/* the ID of the clock/voltage to get or set */
+	u32 val;		/* the value (e.g. rate (in Hz)) to set */
+} __packed;
+
+static u32 bcm2835_cpufreq_set_clock(int cur_rate, int arm_rate)
+{
+	int ret = 0;
+	struct prop msg = {
+		.dev_id = VCMSG_ID_ARM_CLOCK,
+		.val = arm_rate * 1000,
+	};
+
+	/* send the message */
+	ret = rpi_firmware_property(fw, VCMSG_SET_CLOCK_RATE, &msg,
+							sizeof(msg));
+
+	/* check if it was all ok and return the rate in KHz */
+	if (ret) {
+		pr_err("bcm2835_cpufreq: could not set clock rate\n");
+		return 0;
+	}
+
+	return msg.val / 1000;
+}
+
+static u32 bcm2835_cpufreq_get_clock(int tag)
+{
+	int ret = 0;
+	struct prop msg = {
+		.dev_id = VCMSG_ID_ARM_CLOCK,
+		.val = 0,
+	};
+
+	/* send the message */
+	ret = rpi_firmware_property(fw, tag, &msg, sizeof(msg));
+
+	/* check if it was all ok and return the rate in KHz */
+	if (ret) {
+		pr_err("bcm2835_cpufreq: could not get clock %d\n", tag);
+		return 0;
+	}
+
+	return msg.val / 1000;
+}
+
+static int bcm2835_cpufreq_init(struct cpufreq_policy *policy)
+{
+	/* measured value of how long it takes to change frequency */
+	policy->cpuinfo.transition_latency = 355000; /* ns */
+
+	/* now find out what the maximum and minimum frequencies are */
+	policy->min = bcm2835_cpufreq_get_clock(VCMSG_GET_MIN_CLOCK);
+	policy->max = bcm2835_cpufreq_get_clock(VCMSG_GET_MAX_CLOCK);
+	policy->cur = bcm2835_cpufreq_get_clock(VCMSG_GET_CLOCK_RATE);
+
+	policy->cpuinfo.min_freq = policy->min;
+	policy->cpuinfo.max_freq = policy->max;
+
+	return 0;
+}
+
+static int bcm2835_cpufreq_target(struct cpufreq_policy *policy,
+						unsigned int target_freq,
+						unsigned int relation)
+{
+	unsigned int target = target_freq;
+	u32 cur;
+
+	/* if we are above min and using ondemand, then just use max */
+	if (strcmp("ondemand", policy->governor->name) == 0 &&
+					target > policy->min)
+		target = policy->max;
+
+	/* if the frequency is the same, just quit */
+	if (target == policy->cur)
+		return 0;
+
+	/* otherwise were good to set the clock frequency */
+	policy->cur = bcm2835_cpufreq_set_clock(policy->cur, target);
+
+	cur = bcm2835_cpufreq_set_clock(policy->cur, target);
+	if (!cur)
+		return -EINVAL;
+
+	policy->cur = cur;
+	return 0;
+}
+
+static unsigned int bcm2835_cpufreq_get(unsigned int cpu)
+{
+	return bcm2835_cpufreq_get_clock(VCMSG_GET_CLOCK_RATE);
+}
+
+static int bcm2835_cpufreq_verify(struct cpufreq_policy *policy)
+{
+	return 0;
+}
+
+static struct cpufreq_driver bcm2835_cpufreq = {
+	.name = "bcm2835-cpufreq",
+	.init = bcm2835_cpufreq_init,
+	.verify = bcm2835_cpufreq_verify,
+	.target = bcm2835_cpufreq_target,
+	.get = bcm2835_cpufreq_get
+};
+
+static int bcm2835_cpufreq_probe(struct platform_device *pdev)
+{
+	int ret;
+	struct device *dev = &pdev->dev;
+	struct device_node *fw_node;
+
+	fw_node = of_parse_phandle(pdev->dev.of_node, "firmware", 0);
+	if (!fw_node) {
+		dev_err(dev, "no firmware node");
+		return -ENODEV;
+	}
+
+	fw = rpi_firmware_get(fw_node);
+	if (!fw)
+		return -EPROBE_DEFER;
+
+	ret = cpufreq_register_driver(&bcm2835_cpufreq);
+	if (ret) {
+		dev_err(dev, "Could not register cpufreq driver\n");
+		return ret;
+	}
+
+	dev_info(dev, "Broadcom BCM2835 CPU frequency control\n");
+	return 0;
+}
+
+static int bcm2835_cpufreq_remove(struct platform_device *dev)
+{
+	cpufreq_unregister_driver(&bcm2835_cpufreq);
+	return 0;
+}
+
+static const struct of_device_id bcm2835_cpufreq_of_match[] = {
+	{ .compatible = "raspberrypi,bcm2835-cpufreq", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, bcm2835_cpufreq_of_match);
+
+static struct platform_driver bcm2835_cpufreq_driver = {
+	.probe = bcm2835_cpufreq_probe,
+	.remove = bcm2835_cpufreq_remove,
+	.driver = {
+		.name = "bcm2835-cpufreq",
+		.owner = THIS_MODULE,
+		.of_match_table = bcm2835_cpufreq_of_match,
+	},
+};
+module_platform_driver(bcm2835_cpufreq_driver);
+
+MODULE_AUTHOR("Dorian Peake and Dom Cobley and Lubomir Rintel");
+MODULE_DESCRIPTION("BCM2835 CPU frequency control driver");
+MODULE_LICENSE("GPL v2");
-- 
2.4.3
