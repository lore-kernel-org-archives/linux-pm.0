From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 8/8] mfd: Add support for Intel Sunrisepoint LPSS devices
Date: Mon, 25 May 2015 19:09:32 +0300
Message-ID: <1432570172-86963-9-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1432570172-86963-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1432570172-86963-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Vinod Koul <vinod.koul@intel.com>, Lee Jones <lee.jones@linaro.org>, Andrew Morton <akpm@linux-foundation.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

The new coming Intel platforms such as Skylake will contain Sunrisepoint PCH.
The main difference to the previous platforms is that the LPSS devices are
compound devices where usually main (SPI, HSUART, or I2C) and DMA IPs are
present.

This patch brings the driver for such devices found on Sunrisepoint PCH.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mfd/Kconfig           |  24 ++
 drivers/mfd/Makefile          |   3 +
 drivers/mfd/intel-lpss-acpi.c |  84 +++++++
 drivers/mfd/intel-lpss-pci.c  | 113 +++++++++
 drivers/mfd/intel-lpss.c      | 534 ++++++++++++++++++++++++++++++++++++++++++
 drivers/mfd/intel-lpss.h      |  62 +++++
 6 files changed, 820 insertions(+)
 create mode 100644 drivers/mfd/intel-lpss-acpi.c
 create mode 100644 drivers/mfd/intel-lpss-pci.c
 create mode 100644 drivers/mfd/intel-lpss.c
 create mode 100644 drivers/mfd/intel-lpss.h

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index d5ad04d..8cdaa12 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -325,6 +325,30 @@ config INTEL_SOC_PMIC
 	  thermal, charger and related power management functions
 	  on these systems.
 
+config MFD_INTEL_LPSS
+	tristate
+	depends on X86
+	select COMMON_CLK
+	select MFD_CORE
+
+config MFD_INTEL_LPSS_ACPI
+	tristate "Intel Low Power Subsystem support in ACPI mode"
+	select MFD_INTEL_LPSS
+	depends on ACPI
+	help
+	  This driver supports Intel Low Power Subsystem (LPSS) devices such as
+	  I2C, SPI and HS-UART starting from Intel Sunrisepoint (Intel Skylake
+	  PCH) in ACPI mode.
+
+config MFD_INTEL_LPSS_PCI
+	tristate "Intel Low Power Subsystem support in PCI mode"
+	select MFD_INTEL_LPSS
+	depends on PCI
+	help
+	  This driver supports Intel Low Power Subsystem (LPSS) devices such as
+	  I2C, SPI and HS-UART starting from Intel Sunrisepoint (Intel Skylake
+	  PCH) in PCI mode.
+
 config MFD_INTEL_MSIC
 	bool "Intel MSIC"
 	depends on INTEL_SCU_IPC
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index 0e5cfeb..cdf29b9 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -161,6 +161,9 @@ obj-$(CONFIG_TPS65911_COMPARATOR)	+= tps65911-comparator.o
 obj-$(CONFIG_MFD_TPS65090)	+= tps65090.o
 obj-$(CONFIG_MFD_AAT2870_CORE)	+= aat2870-core.o
 obj-$(CONFIG_MFD_ATMEL_HLCDC)	+= atmel-hlcdc.o
+obj-$(CONFIG_MFD_INTEL_LPSS)	+= intel-lpss.o
+obj-$(CONFIG_MFD_INTEL_LPSS_PCI)	+= intel-lpss-pci.o
+obj-$(CONFIG_MFD_INTEL_LPSS_ACPI)	+= intel-lpss-acpi.o
 obj-$(CONFIG_MFD_INTEL_MSIC)	+= intel_msic.o
 obj-$(CONFIG_MFD_PALMAS)	+= palmas.o
 obj-$(CONFIG_MFD_VIPERBOARD)    += viperboard.o
diff --git a/drivers/mfd/intel-lpss-acpi.c b/drivers/mfd/intel-lpss-acpi.c
new file mode 100644
index 0000000..0d92d73
--- /dev/null
+++ b/drivers/mfd/intel-lpss-acpi.c
@@ -0,0 +1,84 @@
+/*
+ * Intel LPSS ACPI support.
+ *
+ * Copyright (C) 2015, Intel Corporation
+ *
+ * Authors: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
+ *          Mika Westerberg <mika.westerberg@linux.intel.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/acpi.h>
+#include <linux/ioport.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/pm.h>
+#include <linux/pm_runtime.h>
+#include <linux/platform_device.h>
+
+#include "intel-lpss.h"
+
+static const struct intel_lpss_platform_info spt_info = {
+	.clk_rate = 120000000,
+};
+
+static const struct acpi_device_id intel_lpss_acpi_ids[] = {
+	/* SPT */
+	{ "INT3446", (kernel_ulong_t)&spt_info },
+	{ "INT3447", (kernel_ulong_t)&spt_info },
+	{ }
+};
+MODULE_DEVICE_TABLE(acpi, intel_lpss_acpi_ids);
+
+static int intel_lpss_acpi_probe(struct platform_device *pdev)
+{
+	struct intel_lpss_platform_info *info;
+	const struct acpi_device_id *id;
+
+	id = acpi_match_device(intel_lpss_acpi_ids, &pdev->dev);
+	if (!id)
+		return -ENODEV;
+
+	info = devm_kmemdup(&pdev->dev, (void *)id->driver_data, sizeof(*info),
+			    GFP_KERNEL);
+	if (!info)
+		return -ENOMEM;
+
+	info->mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	info->irq = platform_get_irq(pdev, 0);
+
+	pm_runtime_set_active(&pdev->dev);
+	pm_runtime_enable(&pdev->dev);
+
+	return intel_lpss_probe(&pdev->dev, info);
+}
+
+static int intel_lpss_acpi_remove(struct platform_device *pdev)
+{
+	intel_lpss_remove(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
+
+	return 0;
+}
+
+static INTEL_LPSS_PM_OPS(intel_lpss_acpi_pm_ops);
+
+static struct platform_driver intel_lpss_acpi_driver = {
+	.probe = intel_lpss_acpi_probe,
+	.remove = intel_lpss_acpi_remove,
+	.driver = {
+		.name = "intel-lpss",
+		.acpi_match_table = intel_lpss_acpi_ids,
+		.pm = &intel_lpss_acpi_pm_ops,
+	},
+};
+
+module_platform_driver(intel_lpss_acpi_driver);
+
+MODULE_AUTHOR("Andy Shevchenko <andriy.shevchenko@linux.intel.com>");
+MODULE_AUTHOR("Mika Westerberg <mika.westerberg@linux.intel.com>");
+MODULE_DESCRIPTION("Intel LPSS ACPI driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/mfd/intel-lpss-pci.c b/drivers/mfd/intel-lpss-pci.c
new file mode 100644
index 0000000..9236dff
--- /dev/null
+++ b/drivers/mfd/intel-lpss-pci.c
@@ -0,0 +1,113 @@
+/*
+ * Intel LPSS PCI support.
+ *
+ * Copyright (C) 2015, Intel Corporation
+ *
+ * Authors: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
+ *          Mika Westerberg <mika.westerberg@linux.intel.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/ioport.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/pm.h>
+#include <linux/pm_runtime.h>
+
+#include "intel-lpss.h"
+
+static int intel_lpss_pci_probe(struct pci_dev *pdev,
+				const struct pci_device_id *id)
+{
+	struct intel_lpss_platform_info *info;
+	int ret;
+
+	ret = pcim_enable_device(pdev);
+	if (ret)
+		return ret;
+
+	info = devm_kmemdup(&pdev->dev, (void *)id->driver_data, sizeof(*info),
+			    GFP_KERNEL);
+	if (!info)
+		return -ENOMEM;
+
+	info->mem = &pdev->resource[0];
+	info->irq = pdev->irq;
+
+	/* Probably it is enough to set this for iDMA capable devices only */
+	pci_set_master(pdev);
+
+	ret = intel_lpss_probe(&pdev->dev, info);
+	if (ret)
+		return ret;
+
+	pm_runtime_put(&pdev->dev);
+	pm_runtime_allow(&pdev->dev);
+
+	return 0;
+}
+
+static void intel_lpss_pci_remove(struct pci_dev *pdev)
+{
+	pm_runtime_forbid(&pdev->dev);
+	pm_runtime_get_sync(&pdev->dev);
+
+	intel_lpss_remove(&pdev->dev);
+}
+
+static INTEL_LPSS_PM_OPS(intel_lpss_pci_pm_ops);
+
+static const struct intel_lpss_platform_info spt_info = {
+	.clk_rate = 120000000,
+};
+
+static const struct intel_lpss_platform_info spt_uart_info = {
+	.clk_rate = 120000000,
+	.clk_con_id = "baudclk",
+};
+
+static const struct pci_device_id intel_lpss_pci_ids[] = {
+	/* SPT-LP */
+	{ PCI_VDEVICE(INTEL, 0x9d27), (kernel_ulong_t)&spt_uart_info },
+	{ PCI_VDEVICE(INTEL, 0x9d28), (kernel_ulong_t)&spt_uart_info },
+	{ PCI_VDEVICE(INTEL, 0x9d29), (kernel_ulong_t)&spt_info },
+	{ PCI_VDEVICE(INTEL, 0x9d2a), (kernel_ulong_t)&spt_info },
+	{ PCI_VDEVICE(INTEL, 0x9d60), (kernel_ulong_t)&spt_info },
+	{ PCI_VDEVICE(INTEL, 0x9d61), (kernel_ulong_t)&spt_info },
+	{ PCI_VDEVICE(INTEL, 0x9d62), (kernel_ulong_t)&spt_info },
+	{ PCI_VDEVICE(INTEL, 0x9d63), (kernel_ulong_t)&spt_info },
+	{ PCI_VDEVICE(INTEL, 0x9d64), (kernel_ulong_t)&spt_info },
+	{ PCI_VDEVICE(INTEL, 0x9d65), (kernel_ulong_t)&spt_info },
+	{ PCI_VDEVICE(INTEL, 0x9d66), (kernel_ulong_t)&spt_uart_info },
+	/* SPT-H */
+	{ PCI_VDEVICE(INTEL, 0xa127), (kernel_ulong_t)&spt_uart_info },
+	{ PCI_VDEVICE(INTEL, 0xa128), (kernel_ulong_t)&spt_uart_info },
+	{ PCI_VDEVICE(INTEL, 0xa129), (kernel_ulong_t)&spt_info },
+	{ PCI_VDEVICE(INTEL, 0xa12a), (kernel_ulong_t)&spt_info },
+	{ PCI_VDEVICE(INTEL, 0xa160), (kernel_ulong_t)&spt_info },
+	{ PCI_VDEVICE(INTEL, 0xa161), (kernel_ulong_t)&spt_info },
+	{ PCI_VDEVICE(INTEL, 0xa166), (kernel_ulong_t)&spt_uart_info },
+	{ }
+};
+MODULE_DEVICE_TABLE(pci, intel_lpss_pci_ids);
+
+static struct pci_driver intel_lpss_pci_driver = {
+	.name = "intel-lpss",
+	.id_table = intel_lpss_pci_ids,
+	.probe = intel_lpss_pci_probe,
+	.remove = intel_lpss_pci_remove,
+	.driver = {
+		.pm = &intel_lpss_pci_pm_ops,
+	},
+};
+
+module_pci_driver(intel_lpss_pci_driver);
+
+MODULE_AUTHOR("Andy Shevchenko <andriy.shevchenko@linux.intel.com>");
+MODULE_AUTHOR("Mika Westerberg <mika.westerberg@linux.intel.com>");
+MODULE_DESCRIPTION("Intel LPSS PCI driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/mfd/intel-lpss.c b/drivers/mfd/intel-lpss.c
new file mode 100644
index 0000000..28bebf6
--- /dev/null
+++ b/drivers/mfd/intel-lpss.c
@@ -0,0 +1,534 @@
+/*
+ * Intel Sunrisepoint LPSS core support.
+ *
+ * Copyright (C) 2015, Intel Corporation
+ *
+ * Authors: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
+ *          Mika Westerberg <mika.westerberg@linux.intel.com>
+ *          Heikki Krogerus <heikki.krogerus@linux.intel.com>
+ *          Jarkko Nikula <jarkko.nikula@linux.intel.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/clk.h>
+#include <linux/clkdev.h>
+#include <linux/clk-provider.h>
+#include <linux/debugfs.h>
+#include <linux/idr.h>
+#include <linux/ioport.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/mfd/core.h>
+#include <linux/pm_qos.h>
+#include <linux/pm_runtime.h>
+#include <linux/seq_file.h>
+
+#include "intel-lpss.h"
+
+#define LPSS_DEV_OFFSET		0x000
+#define LPSS_DEV_SIZE		0x200
+#define LPSS_PRIV_OFFSET	0x200
+#define LPSS_PRIV_SIZE		0x100
+#define LPSS_IDMA_OFFSET	0x800
+#define LPSS_IDMA_SIZE		0x800
+
+/* Offsets from lpss->priv */
+#define LPSS_PRIV_RESETS		0x04
+#define LPSS_PRIV_RESETS_FUNC		BIT(2)
+#define LPSS_PRIV_RESETS_IDMA		0x3
+
+#define LPSS_PRIV_ACTIVELTR		0x10
+#define LPSS_PRIV_IDLELTR		0x14
+
+#define LPSS_PRIV_LTR_REQ		BIT(15)
+#define LPSS_PRIV_LTR_SCALE_MASK	0xc00
+#define LPSS_PRIV_LTR_SCALE_1US		0x800
+#define LPSS_PRIV_LTR_SCALE_32US	0xc00
+#define LPSS_PRIV_LTR_VALUE_MASK	0x3ff
+
+#define LPSS_PRIV_SSP_REG		0x20
+#define LPSS_PRIV_SSP_REG_DIS_DMA_FIN	BIT(0)
+
+#define LPSS_PRIV_REMAP_ADDR_LO		0x40
+#define LPSS_PRIV_REMAP_ADDR_HI		0x44
+
+#define LPSS_PRIV_CAPS			0xfc
+#define LPSS_PRIV_CAPS_NO_IDMA		BIT(8)
+#define LPSS_PRIV_CAPS_TYPE_SHIFT	4
+#define LPSS_PRIV_CAPS_TYPE_MASK	(0xf << LPSS_PRIV_CAPS_TYPE_SHIFT)
+
+/* This matches the type field in CAPS register */
+enum intel_lpss_dev_type {
+	LPSS_DEV_I2C = 0,
+	LPSS_DEV_UART,
+	LPSS_DEV_SPI,
+};
+
+struct intel_lpss {
+	const struct intel_lpss_platform_info *info;
+	enum intel_lpss_dev_type type;
+	struct clk *clk;
+	struct clk_lookup *clock;
+	const struct mfd_cell *devs;
+	struct device *dev;
+	void __iomem *priv;
+	int devid;
+	u32 caps;
+	u32 active_ltr;
+	u32 idle_ltr;
+	struct dentry *debugfs;
+};
+
+static const struct resource intel_lpss_dev_resources[] = {
+	DEFINE_RES_MEM_NAMED(LPSS_DEV_OFFSET, LPSS_DEV_SIZE, "lpss_dev"),
+	DEFINE_RES_MEM_NAMED(LPSS_PRIV_OFFSET, LPSS_PRIV_SIZE, "lpss_priv"),
+	DEFINE_RES_IRQ(0),
+};
+
+static const struct resource intel_lpss_idma_resources[] = {
+	DEFINE_RES_MEM(LPSS_IDMA_OFFSET, LPSS_IDMA_SIZE),
+	DEFINE_RES_IRQ(0),
+};
+
+#define LPSS_IDMA_DRIVER_NAME		"idma64"
+
+/*
+ * Cells needs to be ordered so that the iDMA is created first. This is
+ * because we need to be sure the DMA is available when the host controller
+ * driver is probed.
+ */
+static const struct mfd_cell intel_lpss_i2c_devs[] = {
+	{
+		.name = LPSS_IDMA_DRIVER_NAME,
+		.num_resources = ARRAY_SIZE(intel_lpss_idma_resources),
+		.resources = intel_lpss_idma_resources,
+	},
+	{
+		.name = "i2c_designware",
+		.num_resources = ARRAY_SIZE(intel_lpss_dev_resources),
+		.resources = intel_lpss_dev_resources,
+	},
+};
+
+static const struct mfd_cell intel_lpss_uart_devs[] = {
+	{
+		.name = LPSS_IDMA_DRIVER_NAME,
+		.num_resources = ARRAY_SIZE(intel_lpss_idma_resources),
+		.resources = intel_lpss_idma_resources,
+	},
+	{
+		.name = "dw-apb-uart",
+		.num_resources = ARRAY_SIZE(intel_lpss_dev_resources),
+		.resources = intel_lpss_dev_resources,
+	},
+};
+
+static const struct mfd_cell intel_lpss_spi_devs[] = {
+	{
+		.name = LPSS_IDMA_DRIVER_NAME,
+		.num_resources = ARRAY_SIZE(intel_lpss_idma_resources),
+		.resources = intel_lpss_idma_resources,
+	},
+	{
+		.name = "pxa2xx-spi",
+		.num_resources = ARRAY_SIZE(intel_lpss_dev_resources),
+		.resources = intel_lpss_dev_resources,
+	},
+};
+
+static DEFINE_IDA(intel_lpss_devid_ida);
+static struct dentry *intel_lpss_debugfs;
+
+static int intel_lpss_request_dma_module(const char *name)
+{
+	static bool intel_lpss_dma_requested;
+
+	if (intel_lpss_dma_requested)
+		return 0;
+
+	intel_lpss_dma_requested = true;
+	return request_module("%s", name);
+}
+
+static void intel_lpss_cache_ltr(struct intel_lpss *lpss)
+{
+	lpss->active_ltr = readl(lpss->priv + LPSS_PRIV_ACTIVELTR);
+	lpss->idle_ltr = readl(lpss->priv + LPSS_PRIV_IDLELTR);
+}
+
+static int intel_lpss_debugfs_add(struct intel_lpss *lpss)
+{
+	struct dentry *dir;
+
+	dir = debugfs_create_dir(dev_name(lpss->dev), intel_lpss_debugfs);
+	if (IS_ERR(dir))
+		return PTR_ERR(dir);
+
+	/* Cache the values into lpss structure */
+	intel_lpss_cache_ltr(lpss);
+
+	debugfs_create_x32("capabilities", S_IRUGO, dir, &lpss->caps);
+	debugfs_create_x32("active_ltr", S_IRUGO, dir, &lpss->active_ltr);
+	debugfs_create_x32("idle_ltr", S_IRUGO, dir, &lpss->idle_ltr);
+
+	lpss->debugfs = dir;
+	return 0;
+}
+
+static void intel_lpss_debugfs_remove(struct intel_lpss *lpss)
+{
+	debugfs_remove_recursive(lpss->debugfs);
+}
+
+static void intel_lpss_ltr_set(struct device *dev, s32 val)
+{
+	struct intel_lpss *lpss = dev_get_drvdata(dev);
+	u32 ltr;
+
+	/*
+	 * Program latency tolerance (LTR) accordingly what has been asked
+	 * by the PM QoS layer or disable it in case we were passed
+	 * negative value or PM_QOS_LATENCY_ANY.
+	 */
+	ltr = readl(lpss->priv + LPSS_PRIV_ACTIVELTR);
+
+	if (val == PM_QOS_LATENCY_ANY || val < 0) {
+		ltr &= ~LPSS_PRIV_LTR_REQ;
+	} else {
+		ltr |= LPSS_PRIV_LTR_REQ;
+		ltr &= ~LPSS_PRIV_LTR_SCALE_MASK;
+		ltr &= ~LPSS_PRIV_LTR_VALUE_MASK;
+
+		if (val > LPSS_PRIV_LTR_VALUE_MASK)
+			ltr |= LPSS_PRIV_LTR_SCALE_32US | val >> 5;
+		else
+			ltr |= LPSS_PRIV_LTR_SCALE_1US | val;
+	}
+
+	if (ltr == lpss->active_ltr)
+		return;
+
+	writel(ltr, lpss->priv + LPSS_PRIV_ACTIVELTR);
+	writel(ltr, lpss->priv + LPSS_PRIV_IDLELTR);
+
+	/* Cache the values into lpss structure */
+	intel_lpss_cache_ltr(lpss);
+}
+
+static void intel_lpss_ltr_expose(struct intel_lpss *lpss)
+{
+	lpss->dev->power.set_latency_tolerance = intel_lpss_ltr_set;
+	dev_pm_qos_expose_latency_tolerance(lpss->dev);
+}
+
+static void intel_lpss_ltr_hide(struct intel_lpss *lpss)
+{
+	dev_pm_qos_hide_latency_tolerance(lpss->dev);
+	lpss->dev->power.set_latency_tolerance = NULL;
+}
+
+static int intel_lpss_assign_devs(struct intel_lpss *lpss)
+{
+	unsigned int type;
+
+	type = lpss->caps & LPSS_PRIV_CAPS_TYPE_MASK;
+	type >>= LPSS_PRIV_CAPS_TYPE_SHIFT;
+
+	switch (type) {
+	case LPSS_DEV_I2C:
+		lpss->devs = intel_lpss_i2c_devs;
+		break;
+	case LPSS_DEV_UART:
+		lpss->devs = intel_lpss_uart_devs;
+		break;
+	case LPSS_DEV_SPI:
+		lpss->devs = intel_lpss_spi_devs;
+		break;
+	default:
+		return -ENODEV;
+	}
+
+	lpss->type = type;
+
+	return 0;
+}
+
+static bool intel_lpss_has_idma(const struct intel_lpss *lpss)
+{
+	return (lpss->caps & LPSS_PRIV_CAPS_NO_IDMA) == 0;
+}
+
+static void intel_lpss_set_remap_addr(const struct intel_lpss *lpss)
+{
+	resource_size_t addr = lpss->info->mem->start;
+
+	writel(addr, lpss->priv + LPSS_PRIV_REMAP_ADDR_LO);
+#if BITS_PER_LONG > 32
+	writel(addr >> 32, lpss->priv + LPSS_PRIV_REMAP_ADDR_HI);
+#else
+	writel(0, lpss->priv + LPSS_PRIV_REMAP_ADDR_HI);
+#endif
+}
+
+static void intel_lpss_deassert_reset(const struct intel_lpss *lpss)
+{
+	u32 value = LPSS_PRIV_RESETS_FUNC | LPSS_PRIV_RESETS_IDMA;
+
+	/* Bring out the device from reset */
+	writel(value, lpss->priv + LPSS_PRIV_RESETS);
+}
+
+static void intel_lpss_init_dev(const struct intel_lpss *lpss)
+{
+	u32 value = LPSS_PRIV_SSP_REG_DIS_DMA_FIN;
+
+	intel_lpss_deassert_reset(lpss);
+
+	if (!intel_lpss_has_idma(lpss))
+		return;
+
+	intel_lpss_set_remap_addr(lpss);
+
+	/* Make sure that SPI multiblock DMA transfers are re-enabled */
+	if (lpss->type == LPSS_DEV_SPI)
+		writel(value, lpss->priv + LPSS_PRIV_SSP_REG);
+}
+
+static void intel_lpss_unregister_clock_tree(struct clk *clk)
+{
+	struct clk *parent;
+
+	while (clk) {
+		parent = clk_get_parent(clk);
+		clk_unregister(clk);
+		clk = parent;
+	}
+}
+
+static int intel_lpss_register_clock_divider(struct intel_lpss *lpss,
+					     const char *devname,
+					     struct clk **clk)
+{
+	char name[32];
+	struct clk *tmp = *clk;
+
+	snprintf(name, sizeof(name), "%s-enable", devname);
+	tmp = clk_register_gate(NULL, name, __clk_get_name(tmp), 0,
+				lpss->priv, 0, 0, NULL);
+	if (IS_ERR(tmp))
+		return PTR_ERR(tmp);
+
+	snprintf(name, sizeof(name), "%s-div", devname);
+	tmp = clk_register_fractional_divider(NULL, name, __clk_get_name(tmp),
+					      0, lpss->priv, 1, 15, 16, 15, 0,
+					      NULL);
+	if (IS_ERR(tmp))
+		return PTR_ERR(tmp);
+	*clk = tmp;
+
+	snprintf(name, sizeof(name), "%s-update", devname);
+	tmp = clk_register_gate(NULL, name, __clk_get_name(tmp),
+				CLK_SET_RATE_PARENT, lpss->priv, 31, 0, NULL);
+	if (IS_ERR(tmp))
+		return PTR_ERR(tmp);
+	*clk = tmp;
+
+	return 0;
+}
+
+static int intel_lpss_register_clock(struct intel_lpss *lpss)
+{
+	const struct mfd_cell *devs = lpss->devs;
+	struct clk *clk;
+	char devname[24];
+	int ret = -ENOMEM;
+
+	if (!lpss->info->clk_rate)
+		return 0;
+
+	/* Root clock */
+	clk = clk_register_fixed_rate(NULL, dev_name(lpss->dev), NULL,
+				      CLK_IS_ROOT, lpss->info->clk_rate);
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
+
+	snprintf(devname, sizeof(devname), "%s.%d", devs[1].name, lpss->devid);
+
+	/*
+	 * Support for clock divider only if it has some preset value.
+	 * Otherwise we assume that the divider is not used.
+	 */
+	if (lpss->type != LPSS_DEV_I2C) {
+		ret = intel_lpss_register_clock_divider(lpss, devname, &clk);
+		if (ret)
+			goto err_clk_register;
+	}
+
+	/* Clock for the host controller */
+	lpss->clock = clkdev_create(clk, lpss->info->clk_con_id, "%s", devname);
+	if (!lpss->clock)
+		goto err_clk_register;
+
+	lpss->clk = clk;
+
+	return 0;
+
+err_clk_register:
+	intel_lpss_unregister_clock_tree(clk);
+
+	return ret;
+}
+
+static void intel_lpss_unregister_clock(struct intel_lpss *lpss)
+{
+	if (IS_ERR_OR_NULL(lpss->clk))
+		return;
+
+	clkdev_drop(lpss->clock);
+	intel_lpss_unregister_clock_tree(lpss->clk);
+}
+
+int intel_lpss_probe(struct device *dev,
+		     const struct intel_lpss_platform_info *info)
+{
+	struct intel_lpss *lpss;
+	int ret;
+
+	if (!info || !info->mem || info->irq <= 0)
+		return -EINVAL;
+
+	lpss = devm_kzalloc(dev, sizeof(*lpss), GFP_KERNEL);
+	if (!lpss)
+		return -ENOMEM;
+
+	lpss->priv = devm_ioremap(dev, info->mem->start + LPSS_PRIV_OFFSET,
+				  LPSS_PRIV_SIZE);
+	if (!lpss->priv)
+		return -ENOMEM;
+
+	lpss->info = info;
+	lpss->dev = dev;
+	lpss->caps = readl(lpss->priv + LPSS_PRIV_CAPS);
+
+	dev_set_drvdata(dev, lpss);
+
+	ret = intel_lpss_assign_devs(lpss);
+	if (ret)
+		return ret;
+
+	intel_lpss_init_dev(lpss);
+
+	lpss->devid = ida_simple_get(&intel_lpss_devid_ida, 0, 0, GFP_KERNEL);
+	if (lpss->devid < 0)
+		return lpss->devid;
+
+	ret = intel_lpss_register_clock(lpss);
+	if (ret < 0)
+		goto err_clk_register;
+
+	intel_lpss_ltr_expose(lpss);
+
+	ret = intel_lpss_debugfs_add(lpss);
+	if (ret)
+		dev_warn(lpss->dev, "Failed to create debugfs entries\n");
+
+	if (intel_lpss_has_idma(lpss)) {
+		/*
+		 * Ensure the DMA driver is loaded before the host
+		 * controller device appears, so that the host controller
+		 * driver can request its DMA channels as early as
+		 * possible.
+		 *
+		 * If the DMA module is not there that's OK as well.
+		 */
+		intel_lpss_request_dma_module(LPSS_IDMA_DRIVER_NAME);
+
+		ret = mfd_add_devices(dev, lpss->devid, lpss->devs, 2,
+				      info->mem, info->irq, NULL);
+	} else {
+		ret = mfd_add_devices(dev, lpss->devid, lpss->devs + 1, 1,
+				      info->mem, info->irq, NULL);
+	}
+	if (ret < 0)
+		goto err_remove_ltr;
+
+	return 0;
+
+err_remove_ltr:
+	intel_lpss_debugfs_remove(lpss);
+	intel_lpss_ltr_hide(lpss);
+
+err_clk_register:
+	ida_simple_remove(&intel_lpss_devid_ida, lpss->devid);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(intel_lpss_probe);
+
+void intel_lpss_remove(struct device *dev)
+{
+	struct intel_lpss *lpss = dev_get_drvdata(dev);
+
+	mfd_remove_devices(dev);
+	intel_lpss_debugfs_remove(lpss);
+	intel_lpss_ltr_hide(lpss);
+	intel_lpss_unregister_clock(lpss);
+	ida_simple_remove(&intel_lpss_devid_ida, lpss->devid);
+}
+EXPORT_SYMBOL_GPL(intel_lpss_remove);
+
+static int resume_lpss_device(struct device *dev, void *data)
+{
+	pm_runtime_resume(dev);
+	return 0;
+}
+
+int intel_lpss_prepare(struct device *dev)
+{
+	/*
+	 * Resume both child devices before entering system sleep. This
+	 * ensures that they are in proper state before they get suspended.
+	 */
+	device_for_each_child_reverse(dev, NULL, resume_lpss_device);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(intel_lpss_prepare);
+
+int intel_lpss_suspend(struct device *dev)
+{
+	return 0;
+}
+EXPORT_SYMBOL_GPL(intel_lpss_suspend);
+
+int intel_lpss_resume(struct device *dev)
+{
+	struct intel_lpss *lpss = dev_get_drvdata(dev);
+
+	intel_lpss_init_dev(lpss);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(intel_lpss_resume);
+
+static int __init intel_lpss_init(void)
+{
+	intel_lpss_debugfs = debugfs_create_dir("intel_lpss", NULL);
+	return 0;
+}
+module_init(intel_lpss_init);
+
+static void __exit intel_lpss_exit(void)
+{
+	debugfs_remove(intel_lpss_debugfs);
+}
+module_exit(intel_lpss_exit);
+
+MODULE_AUTHOR("Andy Shevchenko <andriy.shevchenko@linux.intel.com>");
+MODULE_AUTHOR("Mika Westerberg <mika.westerberg@linux.intel.com>");
+MODULE_AUTHOR("Heikki Krogerus <heikki.krogerus@linux.intel.com>");
+MODULE_AUTHOR("Jarkko Nikula <jarkko.nikula@linux.intel.com>");
+MODULE_DESCRIPTION("Intel LPSS core driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/mfd/intel-lpss.h b/drivers/mfd/intel-lpss.h
new file mode 100644
index 0000000..f28cb28a
--- /dev/null
+++ b/drivers/mfd/intel-lpss.h
@@ -0,0 +1,62 @@
+/*
+ * Intel LPSS core support.
+ *
+ * Copyright (C) 2015, Intel Corporation
+ *
+ * Authors: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
+ *          Mika Westerberg <mika.westerberg@linux.intel.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __MFD_INTEL_LPSS_H
+#define __MFD_INTEL_LPSS_H
+
+struct device;
+struct resource;
+
+struct intel_lpss_platform_info {
+	struct resource *mem;
+	int irq;
+	unsigned long clk_rate;
+	const char *clk_con_id;
+};
+
+int intel_lpss_probe(struct device *dev,
+		     const struct intel_lpss_platform_info *info);
+void intel_lpss_remove(struct device *dev);
+
+#ifdef CONFIG_PM
+int intel_lpss_prepare(struct device *dev);
+int intel_lpss_suspend(struct device *dev);
+int intel_lpss_resume(struct device *dev);
+
+#ifdef CONFIG_PM_SLEEP
+#define INTEL_LPSS_SLEEP_PM_OPS			\
+	.prepare = intel_lpss_prepare,		\
+	.suspend = intel_lpss_suspend,		\
+	.resume = intel_lpss_resume,		\
+	.freeze = intel_lpss_suspend,		\
+	.thaw = intel_lpss_resume,		\
+	.poweroff = intel_lpss_suspend,		\
+	.restore = intel_lpss_resume,
+#endif
+
+#define INTEL_LPSS_RUNTIME_PM_OPS		\
+	.runtime_suspend = intel_lpss_suspend,	\
+	.runtime_resume = intel_lpss_resume,
+
+#else /* !CONFIG_PM */
+#define INTEL_LPSS_SLEEP_PM_OPS
+#define INTEL_LPSS_RUNTIME_PM_OPS
+#endif /* CONFIG_PM */
+
+#define INTEL_LPSS_PM_OPS(name)			\
+const struct dev_pm_ops name = {		\
+	INTEL_LPSS_SLEEP_PM_OPS			\
+	INTEL_LPSS_RUNTIME_PM_OPS		\
+}
+
+#endif /* __MFD_INTEL_LPSS_H */
-- 
2.1.4
