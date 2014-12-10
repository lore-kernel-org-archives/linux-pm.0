From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] thermal: int340x: Introduce processor reporting device
Date: Tue,  9 Dec 2014 16:47:17 -0800
Message-ID: <1418172437-8861-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:19710 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751153AbaLJArw (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 9 Dec 2014 19:47:52 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rui.zhang@intel.com, edubezval@gmail.com
Cc: linux-pm@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

The Int340x thermal provides a processor thermal device, which
is used to control processor thermal states. These devices are
either reported as a PCI device or an ACPI device. This
device provides power limits, control states and optional
temperature.
This change implements minimal requirements to expose processor
power limits which can be used during thermal power limiting.
Power limits are exposed via an attribute group called
"power_limits" under the device. The exported attributes
are:
power_limit_0_max_uw
power_limit_1_max_uw
power_limit_0_min_uw
power_limit_1_min_uw
power_limit_0_tmin_us
power_limit_1_tmin_us
power_limit_0_tmax_us
power_limit_1_tmax_us
power_limit_0_step_uw
power_limit_1_step_uw

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/thermal/int340x_thermal/Makefile           |   1 +
 .../int340x_thermal/processor_thermal_device.c     | 299 +++++++++++++++++++++
 2 files changed, 300 insertions(+)
 create mode 100644 drivers/thermal/int340x_thermal/processor_thermal_device.c

diff --git a/drivers/thermal/int340x_thermal/Makefile b/drivers/thermal/int340x_thermal/Makefile
index ffe40bf..d441369 100644
--- a/drivers/thermal/int340x_thermal/Makefile
+++ b/drivers/thermal/int340x_thermal/Makefile
@@ -1,4 +1,5 @@
 obj-$(CONFIG_INT340X_THERMAL)	+= int3400_thermal.o
 obj-$(CONFIG_INT340X_THERMAL)	+= int3402_thermal.o
 obj-$(CONFIG_INT340X_THERMAL)	+= int3403_thermal.o
+obj-$(CONFIG_INT340X_THERMAL)	+= processor_thermal_device.o
 obj-$(CONFIG_ACPI_THERMAL_REL)	+= acpi_thermal_rel.o
diff --git a/drivers/thermal/int340x_thermal/processor_thermal_device.c b/drivers/thermal/int340x_thermal/processor_thermal_device.c
new file mode 100644
index 0000000..3fc10ca
--- /dev/null
+++ b/drivers/thermal/int340x_thermal/processor_thermal_device.c
@@ -0,0 +1,299 @@
+/*
+ * processor_thermal_device.c
+ * Copyright (c) 2014, Intel Corporation.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ */
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/pci.h>
+#include <linux/platform_device.h>
+#include <linux/acpi.h>
+
+/* Broadwell-U/HSB thermal reporting device */
+#define PCI_DEVICE_ID_PROC_BDW_THERMAL	0x1603
+#define PCI_DEVICE_ID_PROC_HSB_THERMAL	0x0A03
+
+/* Braswell thermal reporting device */
+#define PCI_DEVICE_ID_PROC_BSW_THERMAL	0x22DC
+
+struct power_config {
+	u32	index;
+	u32	min_uw;
+	u32	max_uw;
+	u32	tmin_us;
+	u32	tmax_us;
+	u32	step_uw;
+};
+
+struct proc_thermal_device {
+	struct device *dev;
+	struct acpi_device *adev;
+	struct power_config power_limits[2];
+};
+
+enum proc_thermal_emum_mode_type {
+	PROC_THERMAL_NONE,
+	PROC_THERMAL_PCI,
+	PROC_THERMAL_PLATFORM_DEV
+};
+
+/*
+ * We can have only one type of enumeration, PCI or Platform,
+ * not both. So we don't need instance specific data.
+ */
+static enum proc_thermal_emum_mode_type proc_thermal_emum_mode =
+							PROC_THERMAL_NONE;
+
+#define POWER_LIMIT_SHOW(index, suffix) \
+static ssize_t power_limit_##index##_##suffix##_show(struct device *dev, \
+					struct device_attribute *attr, \
+					char *buf) \
+{ \
+	struct pci_dev *pci_dev; \
+	struct platform_device *pdev; \
+	struct proc_thermal_device *proc_dev; \
+\
+	if (proc_thermal_emum_mode == PROC_THERMAL_PLATFORM_DEV) { \
+		pdev = to_platform_device(dev); \
+		proc_dev = platform_get_drvdata(pdev); \
+	} else { \
+		pci_dev = to_pci_dev(dev); \
+		proc_dev = pci_get_drvdata(pci_dev); \
+	} \
+	return sprintf(buf, "%lu\n",\
+	(unsigned long)proc_dev->power_limits[index].suffix * 1000); \
+}
+
+POWER_LIMIT_SHOW(0, min_uw)
+POWER_LIMIT_SHOW(0, max_uw)
+POWER_LIMIT_SHOW(0, step_uw)
+POWER_LIMIT_SHOW(0, tmin_us)
+POWER_LIMIT_SHOW(0, tmax_us)
+
+POWER_LIMIT_SHOW(1, min_uw)
+POWER_LIMIT_SHOW(1, max_uw)
+POWER_LIMIT_SHOW(1, step_uw)
+POWER_LIMIT_SHOW(1, tmin_us)
+POWER_LIMIT_SHOW(1, tmax_us)
+
+static DEVICE_ATTR_RO(power_limit_0_min_uw);
+static DEVICE_ATTR_RO(power_limit_0_max_uw);
+static DEVICE_ATTR_RO(power_limit_0_step_uw);
+static DEVICE_ATTR_RO(power_limit_0_tmin_us);
+static DEVICE_ATTR_RO(power_limit_0_tmax_us);
+
+static DEVICE_ATTR_RO(power_limit_1_min_uw);
+static DEVICE_ATTR_RO(power_limit_1_max_uw);
+static DEVICE_ATTR_RO(power_limit_1_step_uw);
+static DEVICE_ATTR_RO(power_limit_1_tmin_us);
+static DEVICE_ATTR_RO(power_limit_1_tmax_us);
+
+static struct attribute *power_limit_attrs[] = {
+	&dev_attr_power_limit_0_min_uw.attr,
+	&dev_attr_power_limit_1_min_uw.attr,
+	&dev_attr_power_limit_0_max_uw.attr,
+	&dev_attr_power_limit_1_max_uw.attr,
+	&dev_attr_power_limit_0_step_uw.attr,
+	&dev_attr_power_limit_1_step_uw.attr,
+	&dev_attr_power_limit_0_tmin_us.attr,
+	&dev_attr_power_limit_1_tmin_us.attr,
+	&dev_attr_power_limit_0_tmax_us.attr,
+	&dev_attr_power_limit_1_tmax_us.attr,
+	NULL
+};
+
+static struct attribute_group power_limit_attribute_group = {
+	.attrs = power_limit_attrs,
+	.name = "power_limits"
+};
+
+static int proc_thermal_add(struct device *dev,
+			    struct proc_thermal_device **priv)
+{
+	struct proc_thermal_device *proc_priv;
+	struct acpi_device *adev;
+	acpi_status status;
+	struct acpi_buffer buf = { ACPI_ALLOCATE_BUFFER, NULL };
+	union acpi_object *elements, *ppcc;
+	union acpi_object *p;
+	int i;
+
+	adev = ACPI_COMPANION(dev);
+
+	status = acpi_evaluate_object(adev->handle, "PPCC", NULL, &buf);
+	if (ACPI_FAILURE(status))
+		return -ENODEV;
+
+	p = buf.pointer;
+	if (!p || (p->type != ACPI_TYPE_PACKAGE)) {
+		dev_err(dev, "Invalid PPCC data\n");
+		return -EFAULT;
+	}
+	if (!p->package.count) {
+		dev_err(dev, "Invalid PPCC package size\n");
+		return -EFAULT;
+	}
+
+	proc_priv = devm_kzalloc(dev, sizeof(*proc_priv), GFP_KERNEL);
+	if (!proc_priv)
+		return -ENOMEM;
+
+	proc_priv->dev = dev;
+	proc_priv->adev = adev;
+
+	for (i = 0; i < min((int)p->package.count - 1, 2); ++i) {
+		elements = &(p->package.elements[i+1]);
+		if (elements->type != ACPI_TYPE_PACKAGE ||
+		    elements->package.count != 6)
+			return -EFAULT;
+
+		ppcc = elements->package.elements;
+		proc_priv->power_limits[i].index = ppcc[0].integer.value;
+		proc_priv->power_limits[i].min_uw = ppcc[1].integer.value;
+		proc_priv->power_limits[i].max_uw = ppcc[2].integer.value;
+		proc_priv->power_limits[i].tmin_us = ppcc[3].integer.value;
+		proc_priv->power_limits[i].tmax_us = ppcc[4].integer.value;
+		proc_priv->power_limits[i].step_uw = ppcc[5].integer.value;
+	}
+
+	*priv = proc_priv;
+
+	return sysfs_create_group(&dev->kobj,
+				  &power_limit_attribute_group);
+}
+
+void proc_thermal_remove(struct proc_thermal_device *proc_priv)
+{
+	sysfs_remove_group(&proc_priv->dev->kobj,
+			   &power_limit_attribute_group);
+}
+
+static int int3401_add(struct platform_device *pdev)
+{
+	struct proc_thermal_device *proc_priv;
+	int ret;
+
+	if (proc_thermal_emum_mode == PROC_THERMAL_PCI) {
+		dev_err(&pdev->dev, "error: enumerated as PCI dev\n");
+		return -ENODEV;
+	}
+
+	ret = proc_thermal_add(&pdev->dev, &proc_priv);
+	if (ret)
+		return ret;
+
+	platform_set_drvdata(pdev, proc_priv);
+	proc_thermal_emum_mode = PROC_THERMAL_PLATFORM_DEV;
+
+	return 0;
+}
+
+static int int3401_remove(struct platform_device *pdev)
+{
+	proc_thermal_remove(platform_get_drvdata(pdev));
+
+	return 0;
+}
+
+static int  proc_thermal_pci_probe(struct pci_dev *pdev,
+				   const struct pci_device_id *unused)
+{
+	struct proc_thermal_device *proc_priv;
+	int ret;
+
+	if (proc_thermal_emum_mode == PROC_THERMAL_PLATFORM_DEV) {
+		dev_err(&pdev->dev, "error: enumerated as platform dev\n");
+		return -ENODEV;
+	}
+
+	ret = pci_enable_device(pdev);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "error: could not enable device\n");
+		return ret;
+	}
+
+	ret = proc_thermal_add(&pdev->dev, &proc_priv);
+	if (ret) {
+		pci_disable_device(pdev);
+		return ret;
+	}
+
+	pci_set_drvdata(pdev, proc_priv);
+	proc_thermal_emum_mode = PROC_THERMAL_PCI;
+
+	return 0;
+}
+
+static void  proc_thermal_pci_remove(struct pci_dev *pdev)
+{
+	proc_thermal_remove(pci_get_drvdata(pdev));
+	pci_disable_device(pdev);
+}
+
+static const struct pci_device_id proc_thermal_pci_ids[] = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_PROC_BDW_THERMAL)},
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_PROC_HSB_THERMAL)},
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_PROC_BSW_THERMAL)},
+	{ 0, },
+};
+
+MODULE_DEVICE_TABLE(pci, proc_thermal_pci_ids);
+
+static struct pci_driver proc_thermal_pci_driver = {
+	.name		= "proc_thermal",
+	.probe		= proc_thermal_pci_probe,
+	.remove		= proc_thermal_pci_remove,
+	.id_table	= proc_thermal_pci_ids,
+};
+
+static const struct acpi_device_id int3401_device_ids[] = {
+	{"INT3401", 0},
+	{"", 0},
+};
+MODULE_DEVICE_TABLE(acpi, int3401_device_ids);
+
+static struct platform_driver int3401_driver = {
+	.probe = int3401_add,
+	.remove = int3401_remove,
+	.driver = {
+		.name = "int3401 thermal",
+		.owner  = THIS_MODULE,
+		.acpi_match_table = int3401_device_ids,
+	},
+};
+
+static int __init proc_thermal_init(void)
+{
+	int ret;
+
+	ret = platform_driver_register(&int3401_driver);
+	if (ret)
+		return ret;
+
+	ret = pci_register_driver(&proc_thermal_pci_driver);
+
+	return ret;
+}
+
+static void __exit proc_thermal_exit(void)
+{
+	platform_driver_unregister(&int3401_driver);
+	pci_unregister_driver(&proc_thermal_pci_driver);
+}
+
+module_init(proc_thermal_init);
+module_exit(proc_thermal_exit);
+
+MODULE_AUTHOR("Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>");
+MODULE_DESCRIPTION("Processor Thermal Reporting Device Driver");
+MODULE_LICENSE("GPL v2");
-- 
1.9.1

