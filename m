From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 2/3] Thermal/int340x/processor_thermal: Fix memory leak
Date: Tue, 23 Dec 2014 15:23:35 -0800
Message-ID: <1419377016-13688-2-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1419377016-13688-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:44063 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751575AbaLWXYN (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 23 Dec 2014 18:24:13 -0500
In-Reply-To: <1419377016-13688-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rui.zhang@intel.com, edubezval@gmail.com
Cc: linux-pm@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Address memory leak for buffer allocated with ACPI_ALLOCATE_BUFFER.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 .../int340x_thermal/processor_thermal_device.c     | 29 +++++++++++++++-------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/drivers/thermal/int340x_thermal/processor_thermal_device.c b/drivers/thermal/int340x_thermal/processor_thermal_device.c
index 3fc10ca..4329c75 100644
--- a/drivers/thermal/int340x_thermal/processor_thermal_device.c
+++ b/drivers/thermal/int340x_thermal/processor_thermal_device.c
@@ -127,6 +127,7 @@ static int proc_thermal_add(struct device *dev,
 	union acpi_object *elements, *ppcc;
 	union acpi_object *p;
 	int i;
+	int ret;
 
 	adev = ACPI_COMPANION(dev);
 
@@ -137,16 +138,20 @@ static int proc_thermal_add(struct device *dev,
 	p = buf.pointer;
 	if (!p || (p->type != ACPI_TYPE_PACKAGE)) {
 		dev_err(dev, "Invalid PPCC data\n");
-		return -EFAULT;
+		ret = -EFAULT;
+		goto free_buffer;
 	}
 	if (!p->package.count) {
 		dev_err(dev, "Invalid PPCC package size\n");
-		return -EFAULT;
+		ret = -EFAULT;
+		goto free_buffer;
 	}
 
 	proc_priv = devm_kzalloc(dev, sizeof(*proc_priv), GFP_KERNEL);
-	if (!proc_priv)
-		return -ENOMEM;
+	if (!proc_priv) {
+		ret = -ENOMEM;
+		goto free_buffer;
+	}
 
 	proc_priv->dev = dev;
 	proc_priv->adev = adev;
@@ -154,9 +159,10 @@ static int proc_thermal_add(struct device *dev,
 	for (i = 0; i < min((int)p->package.count - 1, 2); ++i) {
 		elements = &(p->package.elements[i+1]);
 		if (elements->type != ACPI_TYPE_PACKAGE ||
-		    elements->package.count != 6)
-			return -EFAULT;
-
+		    elements->package.count != 6) {
+			ret = -EFAULT;
+			goto free_buffer;
+		}
 		ppcc = elements->package.elements;
 		proc_priv->power_limits[i].index = ppcc[0].integer.value;
 		proc_priv->power_limits[i].min_uw = ppcc[1].integer.value;
@@ -168,8 +174,13 @@ static int proc_thermal_add(struct device *dev,
 
 	*priv = proc_priv;
 
-	return sysfs_create_group(&dev->kobj,
-				  &power_limit_attribute_group);
+	ret = sysfs_create_group(&dev->kobj,
+				 &power_limit_attribute_group);
+
+free_buffer:
+	kfree(buf.pointer);
+
+	return ret;
 }
 
 void proc_thermal_remove(struct proc_thermal_device *proc_priv)
-- 
1.9.3

