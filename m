From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 4/4] Thermal/int340x/processor_thermal: Add thermal zone support
Date: Tue, 23 Dec 2014 15:27:30 -0800
Message-ID: <1419377250-13869-4-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1419377250-13869-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:43130 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756563AbaLWX2H (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 23 Dec 2014 18:28:07 -0500
In-Reply-To: <1419377250-13869-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rui.zhang@intel.com, edubezval@gmail.com
Cc: linux-pm@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Added thermal zones for processor thermal using APIs provided by
int340x thermal zone module.
Like other INT340x devices, processor thermal device can also contain
trip points and way to get temperature. On some platform there is
no ACPI _TMP method, in those platform using IA64 architecture MSRs to
get temperature.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 .../int340x_thermal/processor_thermal_device.c     | 90 ++++++++++++++++++++++
 1 file changed, 90 insertions(+)

diff --git a/drivers/thermal/int340x_thermal/processor_thermal_device.c b/drivers/thermal/int340x_thermal/processor_thermal_device.c
index 4329c75..8111f22 100644
--- a/drivers/thermal/int340x_thermal/processor_thermal_device.c
+++ b/drivers/thermal/int340x_thermal/processor_thermal_device.c
@@ -18,6 +18,8 @@
 #include <linux/pci.h>
 #include <linux/platform_device.h>
 #include <linux/acpi.h>
+#include <linux/thermal.h>
+#include "int340x_thermal_zone.h"
 
 /* Broadwell-U/HSB thermal reporting device */
 #define PCI_DEVICE_ID_PROC_BDW_THERMAL	0x1603
@@ -39,6 +41,7 @@ struct proc_thermal_device {
 	struct device *dev;
 	struct acpi_device *adev;
 	struct power_config power_limits[2];
+	struct int34x_thermal_zone *int340x_zone;
 };
 
 enum proc_thermal_emum_mode_type {
@@ -117,6 +120,72 @@ static struct attribute_group power_limit_attribute_group = {
 	.name = "power_limits"
 };
 
+static int stored_tjmax; /* since it is fixed, we can have local storage */
+
+static int get_tjmax(void)
+{
+	u32 eax, edx;
+	u32 val;
+	int err;
+
+	err = rdmsr_safe(MSR_IA32_TEMPERATURE_TARGET, &eax, &edx);
+	if (err)
+		return err;
+
+	val = (eax >> 16) & 0xff;
+	if (val)
+		return val;
+
+	return -EINVAL;
+}
+
+static int read_temp_msr(unsigned long *temp)
+{
+	int cpu;
+	u32 eax, edx;
+	int err;
+	unsigned long curr_temp_off = 0;
+
+	*temp = 0;
+
+	for_each_online_cpu(cpu) {
+		err = rdmsr_safe_on_cpu(cpu, MSR_IA32_THERM_STATUS, &eax,
+					&edx);
+		if (err)
+			goto err_ret;
+		else {
+			if (eax & 0x80000000) {
+				curr_temp_off = (eax >> 16) & 0x7f;
+				if (!*temp || curr_temp_off < *temp)
+					*temp = curr_temp_off;
+			} else {
+				err = -EINVAL;
+				goto err_ret;
+			}
+		}
+	}
+
+	return 0;
+err_ret:
+	return err;
+}
+
+static int proc_thermal_get_zone_temp(struct thermal_zone_device *zone,
+					 unsigned long *temp)
+{
+	int ret;
+
+	ret = read_temp_msr(temp);
+	if (!ret)
+		*temp = (stored_tjmax - *temp) * 1000;
+
+	return ret;
+}
+
+static struct thermal_zone_device_ops proc_thermal_local_ops = {
+	.get_temp       = proc_thermal_get_zone_temp,
+};
+
 static int proc_thermal_add(struct device *dev,
 			    struct proc_thermal_device **priv)
 {
@@ -126,6 +195,8 @@ static int proc_thermal_add(struct device *dev,
 	struct acpi_buffer buf = { ACPI_ALLOCATE_BUFFER, NULL };
 	union acpi_object *elements, *ppcc;
 	union acpi_object *p;
+	unsigned long long tmp;
+	struct thermal_zone_device_ops *ops = NULL;
 	int i;
 	int ret;
 
@@ -176,6 +247,24 @@ static int proc_thermal_add(struct device *dev,
 
 	ret = sysfs_create_group(&dev->kobj,
 				 &power_limit_attribute_group);
+	if (ret)
+		goto free_buffer;
+
+	status = acpi_evaluate_integer(adev->handle, "_TMP", NULL, &tmp);
+	if (ACPI_FAILURE(status)) {
+		/* there is no _TMP method, add local method */
+		stored_tjmax = get_tjmax();
+		if (stored_tjmax > 0)
+			ops = &proc_thermal_local_ops;
+	}
+
+	proc_priv->int340x_zone = int340x_thermal_zone_add(adev, ops);
+	if (IS_ERR(proc_priv->int340x_zone)) {
+		sysfs_remove_group(&proc_priv->dev->kobj,
+			   &power_limit_attribute_group);
+		ret = PTR_ERR(proc_priv->int340x_zone);
+	} else
+		ret = 0;
 
 free_buffer:
 	kfree(buf.pointer);
@@ -185,6 +274,7 @@ free_buffer:
 
 void proc_thermal_remove(struct proc_thermal_device *proc_priv)
 {
+	int340x_thermal_zone_remove(proc_priv->int340x_zone);
 	sysfs_remove_group(&proc_priv->dev->kobj,
 			   &power_limit_attribute_group);
 }
-- 
1.9.3

