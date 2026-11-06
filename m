Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793953633;
	b=21ErAqDrPt01E+F1U0SswSgjXTQ5f4hQxcIF/6igHsvcrSuHDGpNx8timywMRJbThjLb
	 iwogvlpr+aHCALaohqNO4+FsZ8XgJViHTZGw/2WgpWRmcat7SWdK5IEAkBrEjitV9zQ2+
	 7S4nZGIxwPLK5MZLPVqc77if+CKZ5xN0AGfo7a/JwTFuvQop0R6MgN4lu9MwZFWg57SpV
	 pAvyKAYDicC4Sb+gNnQXnPi7Lkogw37wdEyUV4mEbiY45NFY/XxhB/nxph8WtU4aJyNPH
	 lFEpNQ1Ek7OEtxMjzIyxUncDlh0QKM/YTKokFRW1Lm8M0vy4pZ+FR3xRicGE7atEJgw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793953633;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=sUs9Avs4HZB3oWqyilMbofVA1IjEhOtbWRFbvZEGTCU=;
	b=JuXM2wq6eAuK3OubKZC1ofbPH64MGtDG6m5ZUAo3pAIa93ohRYG2Fa1eiyp3HMpwzq5u
	 cmZZL5KQ9SDnYjkrtFiR1tnL6ip7YRHC2uXSwMshIRHOQkCwYK+M30qBYt9qJbpIAFGK4
	 xnQJyp0SN5pLgHAgQQWpYpx9wZg4QmOEACDebYxqReSNdI7NQYwe16IDoMk/y6z4Uardl
	 PYsUr6n0jM53BLG4aYiH+aMwkDWX/BF9DrN/zQMgnYXm096gLNlk88OqdxRjDHrbA+clk
	 S3B0xr/62lAEL8RUdr5ngCwj4frngRdYjo7ONHuTCYIIJppUY4GUH5t98ioG8LJsGNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZUzB5w1f;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18197606A33E;
	Fri,  6 Nov 2026 08:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZUzB5w1f
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 230821F00906;
	Fri,  6 Nov 2026 08:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793953632;
	bh=sUs9Avs4HZB3oWqyilMbofVA1IjEhOtbWRFbvZEGTCU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=ZUzB5w1fwEyaezym3CvRXM1HR0WSMNSLIqJ3D1h+/PvPpaEEckolPiCI0D7oJ17ti
	 pK0Yd+S8L1qRQpQW952al7eXh8kD23WXtb94Ypr7eQdtVbCIILqnAW39727qEb3xvT
	 LUSQNVuSwjNKJ4C62tMxVf8HNh40eh9MM7H1sklD26jQnW5qBVeSNwjletp/+qQa8o
	 6IpwFWeQa5A9McMNJA6B9cn+7L9ajUOh+PzrRqe7ydRwyIcccG+/UoGkqD1OIA9WUx
	 gLLTLWcNX3iDsWghymJmCG1NMWKUW585b3C6Nc4cvYy/qji0Wg4rZJU8qM2ZeGXSnd
	 ERghULHhrz3mw==
From: Linus Walleij <linusw@kernel.org>
Date: Fri, 06 Nov 2026 09:26:46 +0100
Subject: [PATCH v3 3/7] mfd: bcmbca-pmb: Add a shared BCMBCA PMC3 PMB
 transport
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
Message-Id: <20261106-xg6846b-bcmbca-xrdp-reset-v3-3-d6adeb71afc9@kernel.org>
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

Add an MFD driver for shared access to the Processor Monitor Bus (PMB)
of the third generation Power Management Controller (PMC3), initially
for BCM6846.

Expose an uncached regmap to all children, encoding the bus, device and
word offset in each register address. Keep keyhole semaphore acquisition
and transaction recovery inside the MFD driver.

A software timeout does not abort a transaction. If the keyhole is still
busy, retain its hardware lock and reject new callers until delayed work
observes completion and releases it.

The keyhole register layout differs from older Broadcom PMB controllers.
Match only BCM6846 for now.

Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 MAINTAINERS                    |   2 +
 drivers/mfd/Kconfig            |  11 ++
 drivers/mfd/Makefile           |   1 +
 drivers/mfd/bcmbca_pmc3_pmb.c  | 286 +++++++++++++++++++++++++++++++++++++++++
 include/linux/mfd/bcmbca-pmb.h |  11 ++
 5 files changed, 311 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e11fc5064dc5..9c9ef7eddb10 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5453,9 +5453,11 @@ F:	Documentation/devicetree/bindings/mfd/brcm,bcm6846-pmc.yaml
 F:	Documentation/devicetree/bindings/power/brcm,bcm6846-pmb-power.yaml
 F:	Documentation/devicetree/bindings/reset/brcm,bcm6846-pmb-reset.yaml
 F:	Documentation/devicetree/bindings/soc/bcm/brcm,bcm6846-pmb.yaml
+F:	drivers/mfd/bcmbca_pmc3_pmb.c
 F:	include/dt-bindings/clock/brcm,bcm6846-pmb.h
 F:	include/dt-bindings/power/brcm,bcm6846-pmb.h
 F:	include/dt-bindings/reset/brcm,bcm6846-pmb.h
+F:	include/linux/mfd/bcmbca-pmb.h
 
 BROADCOM BDC DRIVER
 M:	Justin Chen <justin.chen@broadcom.com>
diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 87ed55c155f0..5207c9505c91 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -173,6 +173,17 @@ config MFD_ATMEL_SMC
 	bool
 	select MFD_SYSCON
 
+config MFD_BCMBCA_PMB
+	bool "Broadcom BCMBCA Processor Monitor Bus"
+	depends on ARCH_BCMBCA || COMPILE_TEST
+	depends on OF
+	select MFD_CORE
+	select REGMAP
+	help
+	  Provide shared Processor Monitor Bus (PMB) access through the third
+	  generation Power Management Controller (PMC3), initially on
+	  BCM6846.
+
 config MFD_BCM590XX
 	tristate "Broadcom BCM590xx PMUs"
 	select MFD_CORE
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index f8101d2a9ce9..f00f5caabe04 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -11,6 +11,7 @@ obj-$(CONFIG_MFD_88PM886_PMIC)	+= 88pm886.o
 obj-$(CONFIG_MFD_ACT8945A)	+= act8945a.o
 obj-$(CONFIG_MFD_SM501)		+= sm501.o
 obj-$(CONFIG_ARCH_BCM2835)	+= bcm2835-pm.o
+obj-$(CONFIG_MFD_BCMBCA_PMB)	+= bcmbca_pmc3_pmb.o
 obj-$(CONFIG_MFD_BCM590XX)	+= bcm590xx.o
 obj-$(CONFIG_MFD_BD9571MWV)	+= bd9571mwv.o
 obj-$(CONFIG_MFD_BQ257XX)	+= bq257xx.o
diff --git a/drivers/mfd/bcmbca_pmc3_pmb.c b/drivers/mfd/bcmbca_pmc3_pmb.c
new file mode 100644
index 000000000000..8ebcbc26a502
--- /dev/null
+++ b/drivers/mfd/bcmbca_pmc3_pmb.c
@@ -0,0 +1,286 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Broadcom BCMBCA Processor Monitor Bus (PMB) transport for the third
+ * generation Power Management Controller (PMC3).
+ *
+ * Children access keyhole 0 through a shared regmap.
+ */
+
+#include <linux/bitfield.h>
+#include <linux/cleanup.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/ioport.h>
+#include <linux/log2.h>
+#include <linux/mfd/bcmbca-pmb.h>
+#include <linux/mfd/core.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/workqueue.h>
+
+#define PMB_CONFIG		0x00
+#define PMB_REGS_PER_DEVICE	GENMASK(29, 20)
+#define PMB_CONTROL		0x10
+#define PMB_WRITE_DATA		0x14
+#define PMB_MUTEX		0x18
+#define PMB_READ_DATA		0x1c
+#define PMB_START		BIT(31)
+#define PMB_TIMEOUT		BIT(30)
+#define PMB_SLAVE_ERROR		BIT(29)
+#define PMB_BUSY			BIT(28)
+#define PMB_WRITE		BIT(24)
+#define PMB_BUS			GENMASK(21, 20)
+#define PMB_LOCKED		BIT(0)
+
+struct bcmbca_pmb {
+	struct device *dev;
+	void __iomem *base;
+	/* Serializes regmap operations and recovery state. */
+	struct mutex lock;
+	struct delayed_work recovery;
+	u32 regs_per_device;
+	bool keyhole_acquired;
+	bool recovering;
+	bool stopping;
+};
+
+static void bcmbca_pmb_recover(struct work_struct *work)
+{
+	struct bcmbca_pmb *pmb = container_of(to_delayed_work(work),
+					   struct bcmbca_pmb, recovery);
+
+	guard(mutex)(&pmb->lock);
+	if (!pmb->stopping) {
+		if (readl(pmb->base + PMB_CONTROL) & PMB_BUSY) {
+			queue_delayed_work(system_dfl_wq, &pmb->recovery,
+					   msecs_to_jiffies(100));
+		} else {
+			writel(PMB_LOCKED, pmb->base + PMB_MUTEX);
+			pmb->recovering = false;
+		}
+	}
+}
+
+static int bcmbca_pmb_acquire(struct bcmbca_pmb *pmb)
+{
+	u32 value;
+	int ret;
+
+	lockdep_assert_held(&pmb->lock);
+	if (pmb->stopping)
+		return -ENODEV;
+	if (pmb->recovering)
+		return -EBUSY;
+	if (pmb->keyhole_acquired)
+		return 0;
+
+	/* Reading bit 0 acquires the hardware lock; writing 1 releases it. */
+	ret = readl_poll_timeout(pmb->base + PMB_MUTEX, value,
+				 value & PMB_LOCKED, 1, 1000);
+	if (!ret)
+		pmb->keyhole_acquired = true;
+	return ret;
+}
+
+static int bcmbca_pmb_op(struct bcmbca_pmb *pmb, u8 bus, u8 device,
+			 u16 offset, u32 *value, bool write)
+{
+	u32 status, command;
+	int ret;
+
+	lockdep_assert_held(&pmb->lock);
+	if (bus > FIELD_MAX(PMB_BUS) || offset >= pmb->regs_per_device)
+		return -EINVAL;
+
+	ret = readl_poll_timeout(pmb->base + PMB_CONTROL, status,
+				 !(status & PMB_BUSY), 1, 1000);
+	if (ret)
+		return ret;
+	command = PMB_START | FIELD_PREP(PMB_BUS, bus) |
+		  (device * pmb->regs_per_device) | offset;
+	if (write) {
+		writel(*value, pmb->base + PMB_WRITE_DATA);
+		command |= PMB_WRITE;
+	}
+	writel(command, pmb->base + PMB_CONTROL);
+	ret = readl_poll_timeout(pmb->base + PMB_CONTROL, status,
+				 !(status & PMB_BUSY), 1, 1000);
+	if (ret || status & PMB_TIMEOUT)
+		return -ETIMEDOUT;
+	if (status & PMB_SLAVE_ERROR)
+		return -EIO;
+	if (!write)
+		*value = readl(pmb->base + PMB_READ_DATA);
+	return 0;
+}
+
+static void bcmbca_pmb_regmap_lock(void *arg)
+{
+	struct bcmbca_pmb *pmb = arg;
+
+	mutex_lock(&pmb->lock);
+}
+
+static void bcmbca_pmb_regmap_unlock(void *arg)
+{
+	struct bcmbca_pmb *pmb = arg;
+
+	if (pmb->keyhole_acquired) {
+		if (readl(pmb->base + PMB_CONTROL) & PMB_BUSY) {
+			pmb->recovering = true;
+			dev_err(pmb->dev, "PMB keyhole still busy; deferring unlock\n");
+			queue_delayed_work(system_dfl_wq, &pmb->recovery,
+					   msecs_to_jiffies(100));
+		} else {
+			writel(PMB_LOCKED, pmb->base + PMB_MUTEX);
+		}
+		pmb->keyhole_acquired = false;
+	}
+	mutex_unlock(&pmb->lock);
+}
+
+/* Acquire lazily so semaphore errors reach the caller of the regmap API. */
+static int bcmbca_pmb_reg_read(void *context, unsigned int reg, unsigned int *value)
+{
+	struct bcmbca_pmb *pmb = context;
+	int ret;
+
+	ret = bcmbca_pmb_acquire(pmb);
+	if (ret)
+		return ret;
+	return bcmbca_pmb_op(pmb, reg >> 24, (reg >> 16) & 0xff,
+			     reg & 0xffff, value, false);
+}
+
+static int bcmbca_pmb_reg_write(void *context, unsigned int reg, unsigned int value)
+{
+	struct bcmbca_pmb *pmb = context;
+	int ret;
+
+	ret = bcmbca_pmb_acquire(pmb);
+	if (ret)
+		return ret;
+	return bcmbca_pmb_op(pmb, reg >> 24, (reg >> 16) & 0xff,
+			     reg & 0xffff, &value, true);
+}
+
+static bool bcmbca_pmb_precious_reg(struct device *dev, unsigned int reg)
+{
+	/* Do not let debugfs probe unimplemented or firmware-owned registers. */
+	return true;
+}
+
+static struct regmap *bcmbca_pmb_regmap_init(struct bcmbca_pmb *pmb)
+{
+	const struct regmap_config config = {
+		.reg_bits = 32,
+		.val_bits = 32,
+		.reg_stride = 1,
+		.max_register = BCMBCA_PMB_REG(3, 255, 65535),
+		.cache_type = REGCACHE_NONE,
+		.precious_reg = bcmbca_pmb_precious_reg,
+		.reg_read = bcmbca_pmb_reg_read,
+		.reg_write = bcmbca_pmb_reg_write,
+		.lock = bcmbca_pmb_regmap_lock,
+		.unlock = bcmbca_pmb_regmap_unlock,
+		.can_sleep = true,
+		.lock_arg = pmb,
+	};
+
+	return devm_regmap_init(pmb->dev, NULL, pmb, &config);
+}
+
+/* Children are removed before this action, while MMIO is still mapped. */
+static void bcmbca_pmb_stop(void *data)
+{
+	struct bcmbca_pmb *pmb = data;
+
+	scoped_guard(mutex, &pmb->lock)
+		pmb->stopping = true;
+	cancel_delayed_work_sync(&pmb->recovery);
+
+	if (pmb->recovering) {
+		if (readl(pmb->base + PMB_CONTROL) & PMB_BUSY)
+			dev_err(pmb->dev, "PMB keyhole remains busy; hardware reset required\n");
+		else
+			writel(PMB_LOCKED, pmb->base + PMB_MUTEX);
+	}
+}
+
+static const struct mfd_cell bcm6846_pmb_cells[] = {
+	{
+		.name = "bcm6846-pmb-power",
+		.of_compatible = "brcm,bcm6846-pmb-power",
+	},
+	{
+		.name = "bcm6846-pmb-clock",
+		.of_compatible = "brcm,bcm6846-pmb-clock",
+	},
+	{
+		.name = "bcm6846-pmb-reset",
+		.of_compatible = "brcm,bcm6846-pmb-reset",
+	},
+	{
+		.name = "bcm6846-pmb-pvtmon",
+		.of_compatible = "brcm,bcm6846-pmb-pvtmon",
+	},
+};
+
+static int bcmbca_pmb_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct bcmbca_pmb *pmb;
+	struct regmap *regmap;
+	struct resource *res;
+	int ret;
+
+	pmb = devm_kzalloc(dev, sizeof(*pmb), GFP_KERNEL);
+	if (!pmb)
+		return -ENOMEM;
+	pmb->dev = dev;
+	pmb->base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
+	if (IS_ERR(pmb->base))
+		return PTR_ERR(pmb->base);
+	if (resource_size(res) < PMB_READ_DATA + sizeof(u32))
+		return dev_err_probe(dev, -EINVAL, "PMB register range is too small\n");
+	pmb->regs_per_device = FIELD_GET(PMB_REGS_PER_DEVICE,
+					 readl(pmb->base + PMB_CONFIG));
+	if (!is_power_of_2(pmb->regs_per_device))
+		return dev_err_probe(dev, -EINVAL, "invalid PMB register stride\n");
+	mutex_init(&pmb->lock);
+	INIT_DELAYED_WORK(&pmb->recovery, bcmbca_pmb_recover);
+	ret = devm_add_action_or_reset(dev, bcmbca_pmb_stop, pmb);
+	if (ret)
+		return ret;
+	regmap = bcmbca_pmb_regmap_init(pmb);
+	if (IS_ERR(regmap))
+		return dev_err_probe(dev, PTR_ERR(regmap), "failed to register PMB regmap\n");
+	ret = devm_mfd_add_devices(dev, PLATFORM_DEVID_AUTO, bcm6846_pmb_cells,
+				   ARRAY_SIZE(bcm6846_pmb_cells), NULL, 0, NULL);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "failed to register PMB functions\n");
+
+	return 0;
+}
+
+static const struct of_device_id bcmbca_pmb_match[] = {
+	{ .compatible = "brcm,bcm6846-pmb" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, bcmbca_pmb_match);
+
+static struct platform_driver bcmbca_pmb_driver = {
+	.probe = bcmbca_pmb_probe,
+	.driver = {
+		.name = "bcmbca-pmb",
+		.of_match_table = bcmbca_pmb_match,
+		.suppress_bind_attrs = true,
+	},
+};
+builtin_platform_driver(bcmbca_pmb_driver);
+
+MODULE_DESCRIPTION("Broadcom BCMBCA Processor Monitor Bus transport for PMC3");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/mfd/bcmbca-pmb.h b/include/linux/mfd/bcmbca-pmb.h
new file mode 100644
index 000000000000..36e2b42bf053
--- /dev/null
+++ b/include/linux/mfd/bcmbca-pmb.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef __LINUX_MFD_BCMBCA_PMB_H
+#define __LINUX_MFD_BCMBCA_PMB_H
+
+#include <linux/types.h>
+
+/* Logical regmap addresses: 8-bit bus, 8-bit device, 16-bit word offset. */
+#define BCMBCA_PMB_REG(bus, device, offset) \
+	(((u32)(bus) << 24) | ((u32)(device) << 16) | (offset))
+
+#endif

-- 
2.56.0

