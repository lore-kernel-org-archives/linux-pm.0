Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794394868;
	b=o8mFa904n/R/FabV0alBDzZrqKjT/1wYIEX/CysoPclJOEOW/+PGwNVbgg/WcAdzXgjw
	 v5BN5sCx2urjyZRL1NQg8RG4d00nM4ivEPniylEmKBzVMUsNoNwQpQjKTa07l2fvBNws9
	 oSgg2dUYz48js+LWu/gRVVMwno6Yyg3lPA/uPsINiVUfgi07vhvPHEeA/8URAP4sq8+Zn
	 XUkdTR5NmltcjDgE+6wmzP+avPF3nTIk0jpXFAfYyX67Zlq8zcE96Sqauk/J0vTB/5voS
	 ZixANjWYwnLBGXFS5YmU4YS9YejtJ1ohpaWr1oGpCfAeKlXKdiIB2hJo9SU5HpomOuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794394868;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=6RTlysA/PIhgVO/sQXdm0+7fS1X+z00w+wTFf2rImLU=;
	b=4+oZDoXjnFzH054UWKqAq7AdM7EmPFix2vHUuWG7/u2nxJ7E6PJu5vuhYpff43orJUoz
	 29CxL9ImgL5of+B22c1oTPe2vBYJBgglnj22nxDuTgzAnGrwZBJTXXRmIu4N2Rmb50MHb
	 1t9kAyZ5P/8cHEvwLfP/M9mAtuJqhZDE7CM394ezYM5ssy09Zww2CSqZuevGUsrfOAPg5
	 9puQllj+HfXyp8QuXq3kYr8Ag7ubWzNs/JLwTLFtbU3Mx0T4lyMT9WVfUo2B9YAfJ1VPP
	 Kgpo71vuRCp+EsK5ofCA7ZCvq/WpDaOv11jcTCPZDDXUsC5BPLCV9wBEu3Uoe3Ecnhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Bv2JknqV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B2F606A31C;
	Wed, 11 Nov 2026 11:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Bv2JknqV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7DF51F00A05;
	Wed, 11 Nov 2026 11:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794394868;
	bh=6RTlysA/PIhgVO/sQXdm0+7fS1X+z00w+wTFf2rImLU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Bv2JknqV9Sw28zfa1en4CDeAFXfdbpgewGSumULUlNd11w3JL5m2d5z2AtaDDGqHx
	 PKRsDl2K9y/16v4cB6pEeE2blLyQpHua0xHgxRkTGaxUsgkI/fXgV1FGczQ45cQF5Z
	 BpelbvCIlsHMTBR/34sgeQKL1FpK5ie0SNVTYqfewWRqJzH+Fp6zeJ5r5BU8L6/QpK
	 5HpfjLP8TrJVDG35eXETQHn/OSI9sZtSpfPd7pffejGrZlCwMY8/WwIgWg/SsoFTBO
	 zHCFcXzv4ldLZAe7wOmT0elZdsj5bfkVK0rUoHmi0fCk64Z/ktfjJYzSVhPodPO0Mi
	 GC20lUy/tIcYw==
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 11 Nov 2026 12:00:44 +0100
Subject: [PATCH v4 3/7] mfd: bcmbca-pmb: Add a shared BCMBCA PMC3 PMB
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
Message-Id: <20261111-xg6846b-bcmbca-xrdp-reset-v4-3-17035a5e8ad2@kernel.org>
References: <20261111-xg6846b-bcmbca-xrdp-reset-v4-0-17035a5e8ad2@kernel.org>
In-Reply-To: <20261111-xg6846b-bcmbca-xrdp-reset-v4-0-17035a5e8ad2@kernel.org>
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
 drivers/mfd/Kconfig            |  11 ++
 drivers/mfd/Makefile           |   1 +
 drivers/mfd/bcmbca_pmc3_pmb.c  | 308 +++++++++++++++++++++++++++++++++++++++++
 include/linux/mfd/bcmbca-pmb.h |  11 ++
 5 files changed, 333 insertions(+)

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
index 87ed55c155f0..95e93ea155e1 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -173,6 +173,17 @@ config MFD_ATMEL_SMC
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
index 000000000000..8607429e8b9a
--- /dev/null
+++ b/drivers/mfd/bcmbca_pmc3_pmb.c
@@ -0,0 +1,308 @@
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
+	bcmbca_pmb_regmap_lock(pmb);
+	ret = bcmbca_pmb_acquire(pmb);
+	if (!ret)
+		ret = bcmbca_pmb_op(pmb, reg >> 24, (reg >> 16) & 0xff,
+				    reg & 0xffff, value, false);
+	bcmbca_pmb_regmap_unlock(pmb);
+	return ret;
+}
+
+static int bcmbca_pmb_reg_write(void *context, unsigned int reg, unsigned int value)
+{
+	struct bcmbca_pmb *pmb = context;
+	int ret;
+
+	bcmbca_pmb_regmap_lock(pmb);
+	ret = bcmbca_pmb_acquire(pmb);
+	if (!ret)
+		ret = bcmbca_pmb_op(pmb, reg >> 24, (reg >> 16) & 0xff,
+				    reg & 0xffff, &value, true);
+	bcmbca_pmb_regmap_unlock(pmb);
+	return ret;
+}
+
+static int bcmbca_pmb_reg_update_bits(void *context, unsigned int reg,
+				      unsigned int mask, unsigned int value)
+{
+	struct bcmbca_pmb *pmb = context;
+	unsigned int tmp;
+	int ret;
+
+	bcmbca_pmb_regmap_lock(pmb);
+	ret = bcmbca_pmb_acquire(pmb);
+	if (ret)
+		goto out;
+
+	ret = bcmbca_pmb_op(pmb, reg >> 24, (reg >> 16) & 0xff,
+			    reg & 0xffff, &tmp, false);
+	if (ret)
+		goto out;
+
+	tmp = (tmp & ~mask) | (value & mask);
+	ret = bcmbca_pmb_op(pmb, reg >> 24, (reg >> 16) & 0xff,
+			    reg & 0xffff, &tmp, true);
+out:
+	bcmbca_pmb_regmap_unlock(pmb);
+	return ret;
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
+		/* Callbacks serialize I/O; suppress unsafe debugfs probing. */
+		.disable_locking = true,
+		.reg_read = bcmbca_pmb_reg_read,
+		.reg_write = bcmbca_pmb_reg_write,
+		.reg_update_bits = bcmbca_pmb_reg_update_bits,
+		.can_sleep = true,
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
2.56.0

