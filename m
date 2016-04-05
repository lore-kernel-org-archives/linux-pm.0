From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] thermal: int340x: processor_thermal: support acpi notification
Date: Tue,  5 Apr 2016 14:52:57 -0700
Message-ID: <1459893177-12325-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:11886 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760421AbcDEV5E (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 5 Apr 2016 17:57:04 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rui.zhang@intel.com, edubezval@gmail.com
Cc: linux-pm@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

BIOS/EC can change PPCC element dynamically and inform OS about the change.
When this driver receives notification, it will read PPCC element again.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 .../int340x_thermal/processor_thermal_device.c     | 108 +++++++++++++++------
 1 file changed, 77 insertions(+), 31 deletions(-)

diff --git a/drivers/thermal/int340x_thermal/processor_thermal_device.c b/drivers/thermal/int340x_thermal/processor_thermal_device.c
index 36fa724..42c1ac0 100644
--- a/drivers/thermal/int340x_thermal/processor_thermal_device.c
+++ b/drivers/thermal/int340x_thermal/processor_thermal_device.c
@@ -198,49 +198,33 @@ static struct thermal_zone_device_ops proc_thermal_local_ops = {
 	.get_temp       = proc_thermal_get_zone_temp,
 };
 
-static int proc_thermal_add(struct device *dev,
-			    struct proc_thermal_device **priv)
+static int proc_thermal_read_ppcc(struct proc_thermal_device *proc_priv)
 {
-	struct proc_thermal_device *proc_priv;
-	struct acpi_device *adev;
+	int i;
 	acpi_status status;
 	struct acpi_buffer buf = { ACPI_ALLOCATE_BUFFER, NULL };
 	union acpi_object *elements, *ppcc;
 	union acpi_object *p;
-	unsigned long long tmp;
-	struct thermal_zone_device_ops *ops = NULL;
-	int i;
-	int ret;
-
-	adev = ACPI_COMPANION(dev);
-	if (!adev)
-		return -ENODEV;
+	int ret = 0;
 
-	status = acpi_evaluate_object(adev->handle, "PPCC", NULL, &buf);
+	status = acpi_evaluate_object(proc_priv->adev->handle, "PPCC",
+				      NULL, &buf);
 	if (ACPI_FAILURE(status))
 		return -ENODEV;
 
 	p = buf.pointer;
 	if (!p || (p->type != ACPI_TYPE_PACKAGE)) {
-		dev_err(dev, "Invalid PPCC data\n");
+		dev_err(proc_priv->dev, "Invalid PPCC data\n");
 		ret = -EFAULT;
 		goto free_buffer;
 	}
+
 	if (!p->package.count) {
-		dev_err(dev, "Invalid PPCC package size\n");
+		dev_err(proc_priv->dev, "Invalid PPCC package size\n");
 		ret = -EFAULT;
 		goto free_buffer;
 	}
 
-	proc_priv = devm_kzalloc(dev, sizeof(*proc_priv), GFP_KERNEL);
-	if (!proc_priv) {
-		ret = -ENOMEM;
-		goto free_buffer;
-	}
-
-	proc_priv->dev = dev;
-	proc_priv->adev = adev;
-
 	for (i = 0; i < min((int)p->package.count - 1, 2); ++i) {
 		elements = &(p->package.elements[i+1]);
 		if (elements->type != ACPI_TYPE_PACKAGE ||
@@ -257,12 +241,62 @@ static int proc_thermal_add(struct device *dev,
 		proc_priv->power_limits[i].step_uw = ppcc[5].integer.value;
 	}
 
+free_buffer:
+	kfree(buf.pointer);
+
+	return ret;
+}
+
+#define PROC_POWER_CAPABILITY_CHANGED	0x83
+static void proc_thermal_notify(acpi_handle handle, u32 event, void *data)
+{
+	struct proc_thermal_device *proc_priv = data;
+
+	if (!proc_priv)
+		return;
+
+	switch (event) {
+	case PROC_POWER_CAPABILITY_CHANGED:
+		proc_thermal_read_ppcc(proc_priv);
+		int340x_thermal_zone_device_update(proc_priv->int340x_zone);
+		break;
+	default:
+		dev_err(proc_priv->dev, "Unsupported event [0x%x]\n", event);
+		break;
+	}
+}
+
+
+static int proc_thermal_add(struct device *dev,
+			    struct proc_thermal_device **priv)
+{
+	struct proc_thermal_device *proc_priv;
+	struct acpi_device *adev;
+	acpi_status status;
+	unsigned long long tmp;
+	struct thermal_zone_device_ops *ops = NULL;
+	int ret;
+
+	adev = ACPI_COMPANION(dev);
+	if (!adev)
+		return -ENODEV;
+
+	proc_priv = devm_kzalloc(dev, sizeof(*proc_priv), GFP_KERNEL);
+	if (!proc_priv)
+		return -ENOMEM;
+
+	proc_priv->dev = dev;
+	proc_priv->adev = adev;
 	*priv = proc_priv;
 
-	ret = sysfs_create_group(&dev->kobj,
-				 &power_limit_attribute_group);
+	ret = proc_thermal_read_ppcc(proc_priv);
+	if (!ret) {
+		ret = sysfs_create_group(&dev->kobj,
+					 &power_limit_attribute_group);
+
+	}
 	if (ret)
-		goto free_buffer;
+		return ret;
 
 	status = acpi_evaluate_integer(adev->handle, "_TMP", NULL, &tmp);
 	if (ACPI_FAILURE(status)) {
@@ -274,20 +308,32 @@ static int proc_thermal_add(struct device *dev,
 
 	proc_priv->int340x_zone = int340x_thermal_zone_add(adev, ops);
 	if (IS_ERR(proc_priv->int340x_zone)) {
-		sysfs_remove_group(&proc_priv->dev->kobj,
-			   &power_limit_attribute_group);
 		ret = PTR_ERR(proc_priv->int340x_zone);
+		goto remove_group;
 	} else
 		ret = 0;
 
-free_buffer:
-	kfree(buf.pointer);
+	ret = acpi_install_notify_handler(adev->handle, ACPI_DEVICE_NOTIFY,
+					  proc_thermal_notify,
+					  (void *)proc_priv);
+	if (ret)
+		goto remove_zone;
+
+	return 0;
+
+remove_zone:
+	int340x_thermal_zone_remove(proc_priv->int340x_zone);
+remove_group:
+	sysfs_remove_group(&proc_priv->dev->kobj,
+			   &power_limit_attribute_group);
 
 	return ret;
 }
 
 static void proc_thermal_remove(struct proc_thermal_device *proc_priv)
 {
+	acpi_remove_notify_handler(proc_priv->adev->handle,
+				   ACPI_DEVICE_NOTIFY, proc_thermal_notify);
 	int340x_thermal_zone_remove(proc_priv->int340x_zone);
 	sysfs_remove_group(&proc_priv->dev->kobj,
 			   &power_limit_attribute_group);
-- 
2.5.0

