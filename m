Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795379569;
	b=k7L0r6/hUm4wdJESKsn2W2WEbQzPflNbv/BjocwmTFaCmN6aRcRgTMgDLghffVwejQ7f
	 948cDCfr4nGIfvzqkG1FhkDTXrTgRz1jOc5vu4/eE6DLJq//fs0At7J8BnE1eePp76tA5
	 yN8Map5G5dOGjGuiAqTPtJD075RHFOZv1SU2k02PQ7rd7ACb+YGZMrXqBtcfcjUak2yRP
	 9Qm/HULwyBeoTU54OI6moZcDE2wYqLU+RZpmAjJ7p5wEH9tjts5TYWSHd60Nx224ziIZV
	 +Bb9d23obVKJCqprL3SHdv5pnBcVClnVhirlORuoVDmE3LeucGqnr2B0zeF/QO2aRwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795379569;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=B4buzsoyp3eNAHVUno7XcHL8YfhPAtQ9r/44YaVH0HE=;
	b=P+h+lHkoCX4o11VF6fG1vbnfKr86kehg/8095wP3viEE2H7sCe8pOJQDjmCMic3i9ZvI
	 GE4g/0tfQe3XZKzgNYFE7E1obQvkkKW1bEtYzSjjVWK4KS0pfHBLg6dNGc8lqjniOMq7u
	 tsYdzjV5V2gVQSM3ja7YA7yVAhiNIZNdRPHnxvKx7bjp795sgYVFhrkp22/OcX1e/i239
	 LyzI5ZODPFgs1/U2KWJyU9CsyQ/QKq+89HTGin1dovh8KjkpyvYkni8yoWhzDqxszbNoq
	 Oy/LdDO6UxosjUjTFaM/yV0eneaIdtGMBlTFk4ODcp0FkZo67HbgUh8n38qkktNqbNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NPXcrijG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A81B606A31D;
	Sun, 22 Nov 2026 20:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NPXcrijG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15BD21F000CA;
	Sun, 22 Nov 2026 20:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795379568;
	bh=B4buzsoyp3eNAHVUno7XcHL8YfhPAtQ9r/44YaVH0HE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=NPXcrijGTRxDQI0htwl70gh2LiRL6ZfXOAlbsCDmHX2ZVoDEgp/rAOOqKdRnOItPJ
	 NBI8w/hDdCw1MmSXpqL8O9D067oVlWujFmNgoCiVZBq3yg8KCydMo3rLNVunu6tmGm
	 XNDN25eAFakpo6Ab+hC5kLp0u5UlFv+84u3R7HyLSE2sIB4eOTgoAdNkX0JABR8epq
	 T1x98RaNMpEpVVRaiphlEJ9ugf4nWkU/CrFqQ3oYcG98sP6laoTBOUfG6kek9VXKm4
	 CWTbRM7AFccReMW4IESFbIqS0jQXdOZNY1T5Cp1m0eYTMr0J6Dz6MIbVyxbyfAwNq+
	 eW0BwhEvhjyNw==
From: Linus Walleij <linusw@kernel.org>
Date: Sun, 22 Nov 2026 21:32:27 +0100
Subject: [PATCH v6 2/6] mfd: bcmbca-pmb: Add a shared BCMBCA PMC3 PMB
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
Message-Id: <20261122-xg6846b-bcmbca-xrdp-reset-v6-2-bf2104a25095@kernel.org>
References: <20261122-xg6846b-bcmbca-xrdp-reset-v6-0-bf2104a25095@kernel.org>
In-Reply-To: <20261122-xg6846b-bcmbca-xrdp-reset-v6-0-bf2104a25095@kernel.org>
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

Add an MFD driver for shared access to the Power Management Bus (PMB)
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
 drivers/mfd/Kconfig            |  12 ++
 drivers/mfd/Makefile           |   1 +
 drivers/mfd/bcmbca_pmc3_pmb.c  | 291 +++++++++++++++++++++++++++++++++++++++++
 include/linux/mfd/bcmbca-pmb.h |  11 ++
 5 files changed, 317 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 67642e2a4ab3..1857e720ce3a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5448,9 +5448,11 @@ BROADCOM BCMBCA PMC3 PMB DRIVER
 M:	Linus Walleij <linusw@kernel.org>
 S:	Maintained
 F:	Documentation/devicetree/bindings/mfd/brcm,bcm6846-pmc.yaml
+F:	drivers/mfd/bcmbca_pmc3_pmb.c
 F:	include/dt-bindings/clock/brcm,bcm6846-pmb.h
 F:	include/dt-bindings/power/brcm,bcm6846-pmb.h
 F:	include/dt-bindings/reset/brcm,bcm6846-pmb.h
+F:	include/linux/mfd/bcmbca-pmb.h
 
 BROADCOM BDC DRIVER
 M:	Justin Chen <justin.chen@broadcom.com>
diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 87ed55c155f0..cd601896c462 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -173,6 +173,18 @@ config MFD_ATMEL_SMC
 	bool
 	select MFD_SYSCON
 
+config MFD_BCMBCA_PMB
+	bool "Broadcom BCMBCA Power Management Bus"
+	depends on ARCH_BCMBCA || COMPILE_TEST
+	depends on OF
+	select MFD_CORE
+	select REGMAP
+	help
+	  Provide shared Power Management Bus (PMB) access through the third
+	  generation Power Management Controller (PMC3) on BCM6846.
+	  This driver provides a shared register map for the power-domain,
+	  clock, reset and hardware monitoring drivers.
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
index 000000000000..c49bf3de8d48
--- /dev/null
+++ b/drivers/mfd/bcmbca_pmc3_pmb.c
@@ -0,0 +1,291 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Broadcom BCMBCA Power Management Bus (PMB) transport for the third
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
+#include <linux/jiffies.h>
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
+/* Limit MMIO polling if the keyhole stays busy after a software timeout. */
+#define PMB_RECOVERY_INTERVAL_MS	100
+
+static const struct mfd_cell bcm6846_pmb_cells[] = {
+	MFD_CELL_OF("bcm6846-pmb-power", NULL, NULL, 0, 0,
+		    "brcm,bcm6846-pmb-power"),
+	MFD_CELL_OF("bcm6846-pmb-clock", NULL, NULL, 0, 0,
+		    "brcm,bcm6846-pmb-clock"),
+	MFD_CELL_OF("bcm6846-pmb-reset", NULL, NULL, 0, 0,
+		    "brcm,bcm6846-pmb-reset"),
+	MFD_CELL_OF("bcm6846-pmb-pvtmon", NULL, NULL, 0, 0,
+		    "brcm,bcm6846-pmb-pvtmon"),
+};
+
+struct bcmbca_pmb {
+	struct device *dev;
+	void __iomem *base;
+	/* Serializes regmap operations and recovery state. */
+	struct mutex lock;
+	struct delayed_work recovery;
+	u32 regs_per_device;
+	/* The worker owns semaphore release while a transaction is still busy. */
+	bool recovering;
+};
+
+static void bcmbca_pmb_recover(struct work_struct *work)
+{
+	struct bcmbca_pmb *pmb = container_of(to_delayed_work(work),
+					   struct bcmbca_pmb, recovery);
+
+	guard(mutex)(&pmb->lock);
+	if (readl(pmb->base + PMB_CONTROL) & PMB_BUSY) {
+		queue_delayed_work(system_dfl_wq, &pmb->recovery,
+				   msecs_to_jiffies(PMB_RECOVERY_INTERVAL_MS));
+		return;
+	}
+
+	writel(PMB_LOCKED, pmb->base + PMB_MUTEX);
+	pmb->recovering = false;
+}
+
+static int bcmbca_pmb_acquire(struct bcmbca_pmb *pmb)
+{
+	u32 value;
+
+	lockdep_assert_held(&pmb->lock);
+	if (pmb->recovering)
+		return -EBUSY;
+
+	/* Reading bit 0 acquires the hardware lock; writing 1 releases it. */
+	return readl_poll_timeout(pmb->base + PMB_MUTEX, value,
+				  value & PMB_LOCKED, 1, 1000);
+}
+
+static void bcmbca_pmb_release(struct bcmbca_pmb *pmb)
+{
+	lockdep_assert_held(&pmb->lock);
+	if (!(readl(pmb->base + PMB_CONTROL) & PMB_BUSY)) {
+		writel(PMB_LOCKED, pmb->base + PMB_MUTEX);
+		return;
+	}
+
+	/*
+	 * A software timeout leaves the transaction running. Hold the lock
+	 * until the worker sees it complete so nobody can reuse the keyhole.
+	 */
+	pmb->recovering = true;
+	dev_err(pmb->dev, "PMB keyhole still busy; deferring unlock\n");
+	queue_delayed_work(system_dfl_wq, &pmb->recovery,
+			   msecs_to_jiffies(PMB_RECOVERY_INTERVAL_MS));
+}
+
+static int bcmbca_pmb_op(struct bcmbca_pmb *pmb, unsigned int reg,
+			 u32 *value, bool write)
+{
+	u8 bus = reg >> 24;
+	u8 device = reg >> 16;
+	u16 offset = reg;
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
+static int bcmbca_pmb_transfer(struct bcmbca_pmb *pmb, unsigned int reg,
+			       u32 *value, bool write)
+{
+	int ret;
+
+	guard(mutex)(&pmb->lock);
+	ret = bcmbca_pmb_acquire(pmb);
+	if (ret)
+		return ret;
+
+	ret = bcmbca_pmb_op(pmb, reg, value, write);
+	bcmbca_pmb_release(pmb);
+
+	return ret;
+}
+
+static int bcmbca_pmb_reg_read(void *context, unsigned int reg, unsigned int *value)
+{
+	return bcmbca_pmb_transfer(context, reg, value, false);
+}
+
+static int bcmbca_pmb_reg_write(void *context, unsigned int reg, unsigned int value)
+{
+	return bcmbca_pmb_transfer(context, reg, &value, true);
+}
+
+static int bcmbca_pmb_reg_update_bits(void *context, unsigned int reg,
+				      unsigned int mask, unsigned int value)
+{
+	struct bcmbca_pmb *pmb = context;
+	unsigned int tmp;
+	int ret;
+
+	/* Hold the hardware semaphore across both operations. */
+	guard(mutex)(&pmb->lock);
+	ret = bcmbca_pmb_acquire(pmb);
+	if (ret)
+		return ret;
+
+	ret = bcmbca_pmb_op(pmb, reg, &tmp, false);
+	if (!ret) {
+		tmp = (tmp & ~mask) | (value & mask);
+		ret = bcmbca_pmb_op(pmb, reg, &tmp, true);
+	}
+
+	bcmbca_pmb_release(pmb);
+
+	return ret;
+}
+
+static const struct regmap_config bcmbca_pmb_regmap_config = {
+	.reg_bits = 32,
+	.val_bits = 32,
+	.reg_stride = 1,
+	.max_register = BCMBCA_PMB_REG(3, 255, 65535),
+	.cache_type = REGCACHE_NONE,
+	/* Callbacks serialize I/O and disable_locking suppresses debugfs scans. */
+	.disable_locking = true,
+	.reg_read = bcmbca_pmb_reg_read,
+	.reg_write = bcmbca_pmb_reg_write,
+	.reg_update_bits = bcmbca_pmb_reg_update_bits,
+	.can_sleep = true,
+};
+
+/* Children are removed before this action, while MMIO is still mapped. */
+static void bcmbca_pmb_stop(void *data)
+{
+	struct bcmbca_pmb *pmb = data;
+
+	disable_delayed_work_sync(&pmb->recovery);
+
+	guard(mutex)(&pmb->lock);
+	if (!pmb->recovering)
+		return;
+
+	if (readl(pmb->base + PMB_CONTROL) & PMB_BUSY) {
+		dev_err(pmb->dev, "PMB keyhole remains busy; hardware reset required\n");
+		return;
+	}
+
+	writel(PMB_LOCKED, pmb->base + PMB_MUTEX);
+}
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
+
+	pmb->base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
+	if (IS_ERR(pmb->base))
+		return PTR_ERR(pmb->base);
+
+	if (resource_size(res) < PMB_READ_DATA + sizeof(u32))
+		return dev_err_probe(dev, -EINVAL, "PMB register range is too small\n");
+
+	pmb->regs_per_device = FIELD_GET(PMB_REGS_PER_DEVICE,
+					 readl(pmb->base + PMB_CONFIG));
+	if (!is_power_of_2(pmb->regs_per_device))
+		return dev_err_probe(dev, -EINVAL, "invalid PMB register stride\n");
+
+	ret = devm_mutex_init(dev, &pmb->lock);
+	if (ret)
+		return ret;
+
+	INIT_DELAYED_WORK(&pmb->recovery, bcmbca_pmb_recover);
+	ret = devm_add_action_or_reset(dev, bcmbca_pmb_stop, pmb);
+	if (ret)
+		return ret;
+
+	regmap = devm_regmap_init(dev, NULL, pmb, &bcmbca_pmb_regmap_config);
+	if (IS_ERR(regmap))
+		return dev_err_probe(dev, PTR_ERR(regmap), "failed to register PMB regmap\n");
+
+	ret = devm_mfd_add_devices(dev, PLATFORM_DEVID_AUTO, bcm6846_pmb_cells,
+				   ARRAY_SIZE(bcm6846_pmb_cells), NULL, 0, NULL);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to register PMB functions\n");
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
+MODULE_DESCRIPTION("Broadcom BCMBCA Power Management Bus transport for PMC3");
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
2.56.1

