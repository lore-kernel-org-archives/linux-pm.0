From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 4/8] cpuidle: Make cpuidle's sysfs directory dynamically allocated
Date: Wed, 12 Jun 2013 15:08:51 +0200
Message-ID: <1371042535-22630-4-git-send-email-daniel.lezcano@linaro.org>
References: <1371042535-22630-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-we0-f177.google.com ([74.125.82.177]:63804 "EHLO
	mail-we0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752284Ab3FLNJA (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 12 Jun 2013 09:09:00 -0400
Received: by mail-we0-f177.google.com with SMTP id m19so6848547wev.36
        for <linux-pm@vger.kernel.org>; Wed, 12 Jun 2013 06:08:59 -0700 (PDT)
In-Reply-To: <1371042535-22630-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl
Cc: linux-pm@vger.kernel.org, linaro-kernel@lists.linaro.org, patches@linaro.org

The cpuidle sysfs code is designed to have a single instance of per cpu cpuidle
directory. It is not possible to remove the sysfs entry and recreate it. This
is not a problem with the current code but the next patches will add the cpu
hotplug handling to enable/disable the device, thus removing the sysfs entry
like does any other subsystems. Without this patch it is not possible because
the kobj is a static object which can't be reused for kobj_init_and_add.

Create a cpuidle_device_kobj to be allocated dynamically when adding/removing
a sysfs entry. This approach is consistent with the other cpuidle's sysfs
entries.

Another benefit is the sysfs code is more encapsulated and the headers needed
for sysfs are moved from cpuidle.h into the sysfs.c file, preventing useless
header inclusions from cpuidle.h.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/cpuidle/sysfs.c |   63 ++++++++++++++++++++++++++++++++++++-----------
 include/linux/cpuidle.h |    7 +++---
 2 files changed, 51 insertions(+), 19 deletions(-)

diff --git a/drivers/cpuidle/sysfs.c b/drivers/cpuidle/sysfs.c
index 7d4448a..8739cc0 100644
--- a/drivers/cpuidle/sysfs.c
+++ b/drivers/cpuidle/sysfs.c
@@ -11,8 +11,10 @@
 #include <linux/sysfs.h>
 #include <linux/slab.h>
 #include <linux/cpu.h>
+#include <linux/completion.h>
 #include <linux/capability.h>
 #include <linux/device.h>
+#include <linux/kobject.h>
 
 #include "cpuidle.h"
 
@@ -167,14 +169,27 @@ struct cpuidle_attr {
 #define define_one_rw(_name, show, store) \
 	static struct cpuidle_attr attr_##_name = __ATTR(_name, 0644, show, store)
 
-#define kobj_to_cpuidledev(k) container_of(k, struct cpuidle_device, kobj)
 #define attr_to_cpuidleattr(a) container_of(a, struct cpuidle_attr, attr)
 
+struct cpuidle_device_kobj {
+	struct cpuidle_device *dev;
+	struct completion kobj_unregister;
+	struct kobject kobj;
+};
+
+static inline struct cpuidle_device *to_cpuidle_device(struct kobject *kobj)
+{
+	struct cpuidle_device_kobj *kdev =
+		container_of(kobj, struct cpuidle_device_kobj, kobj);
+
+	return kdev->dev;
+}
+
 static ssize_t cpuidle_show(struct kobject *kobj, struct attribute *attr,
 			    char *buf)
 {
 	int ret = -EIO;
-	struct cpuidle_device *dev = kobj_to_cpuidledev(kobj);
+	struct cpuidle_device *dev = to_cpuidle_device(kobj);
 	struct cpuidle_attr *cattr = attr_to_cpuidleattr(attr);
 
 	if (cattr->show) {
@@ -189,7 +204,7 @@ static ssize_t cpuidle_store(struct kobject *kobj, struct attribute *attr,
 			     const char *buf, size_t count)
 {
 	int ret = -EIO;
-	struct cpuidle_device *dev = kobj_to_cpuidledev(kobj);
+	struct cpuidle_device *dev = to_cpuidle_device(kobj);
 	struct cpuidle_attr *cattr = attr_to_cpuidleattr(attr);
 
 	if (cattr->store) {
@@ -207,9 +222,10 @@ static const struct sysfs_ops cpuidle_sysfs_ops = {
 
 static void cpuidle_sysfs_release(struct kobject *kobj)
 {
-	struct cpuidle_device *dev = kobj_to_cpuidledev(kobj);
+	struct cpuidle_device_kobj *kdev =
+		container_of(kobj, struct cpuidle_device_kobj, kobj);
 
-	complete(&dev->kobj_unregister);
+	complete(&kdev->kobj_unregister);
 }
 
 static struct kobj_type ktype_cpuidle = {
@@ -377,6 +393,7 @@ static int cpuidle_add_state_sysfs(struct cpuidle_device *device)
 {
 	int i, ret = -ENOMEM;
 	struct cpuidle_state_kobj *kobj;
+	struct cpuidle_device_kobj *kdev = device->kobj_dev;
 	struct cpuidle_driver *drv = cpuidle_get_cpu_driver(device);
 
 	/* state statistics */
@@ -389,7 +406,7 @@ static int cpuidle_add_state_sysfs(struct cpuidle_device *device)
 		init_completion(&kobj->kobj_unregister);
 
 		ret = kobject_init_and_add(&kobj->kobj, &ktype_state_cpuidle,
-					   &device->kobj, "state%d", i);
+					   &kdev->kobj, "state%d", i);
 		if (ret) {
 			kfree(kobj);
 			goto error_state;
@@ -506,6 +523,7 @@ static struct kobj_type ktype_driver_cpuidle = {
 static int cpuidle_add_driver_sysfs(struct cpuidle_device *dev)
 {
 	struct cpuidle_driver_kobj *kdrv;
+	struct cpuidle_device_kobj *kdev = dev->kobj_dev;
 	struct cpuidle_driver *drv = cpuidle_get_cpu_driver(dev);
 	int ret;
 
@@ -517,7 +535,7 @@ static int cpuidle_add_driver_sysfs(struct cpuidle_device *dev)
 	init_completion(&kdrv->kobj_unregister);
 
 	ret = kobject_init_and_add(&kdrv->kobj, &ktype_driver_cpuidle,
-				   &dev->kobj, "driver");
+				   &kdev->kobj, "driver");
 	if (ret) {
 		kfree(kdrv);
 		return ret;
@@ -586,16 +604,28 @@ void cpuidle_remove_device_sysfs(struct cpuidle_device *device)
  */
 int cpuidle_add_sysfs(struct cpuidle_device *dev)
 {
+	struct cpuidle_device_kobj *kdev;
 	struct device *cpu_dev = get_cpu_device((unsigned long)dev->cpu);
 	int error;
 
-	init_completion(&dev->kobj_unregister);
+	kdev = kzalloc(sizeof(*kdev), GFP_KERNEL);
+	if (!kdev)
+		return -ENOMEM;
+	kdev->dev = dev;
+	dev->kobj_dev = kdev;
+
+	init_completion(&kdev->kobj_unregister);
+
+	error = kobject_init_and_add(&kdev->kobj, &ktype_cpuidle, &cpu_dev->kobj,
+				   "cpuidle");
+	if (error) {
+		kfree(kdev);
+		return error;
+	}
 
-	error = kobject_init_and_add(&dev->kobj, &ktype_cpuidle, &cpu_dev->kobj,
-				     "cpuidle");
-	if (!error)
-		kobject_uevent(&dev->kobj, KOBJ_ADD);
-	return error;
+	kobject_uevent(&kdev->kobj, KOBJ_ADD);
+
+	return 0;
 }
 
 /**
@@ -604,6 +634,9 @@ int cpuidle_add_sysfs(struct cpuidle_device *dev)
  */
 void cpuidle_remove_sysfs(struct cpuidle_device *dev)
 {
-	kobject_put(&dev->kobj);
-	wait_for_completion(&dev->kobj_unregister);
+	struct cpuidle_device_kobj *kdev = dev->kobj_dev;
+
+	kobject_put(&kdev->kobj);
+	wait_for_completion(&kdev->kobj_unregister);
+	kfree(kdev);
 }
diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
index 0bc4b74..b922db5 100644
--- a/include/linux/cpuidle.h
+++ b/include/linux/cpuidle.h
@@ -13,8 +13,6 @@
 
 #include <linux/percpu.h>
 #include <linux/list.h>
-#include <linux/kobject.h>
-#include <linux/completion.h>
 #include <linux/hrtimer.h>
 
 #define CPUIDLE_STATE_MAX	10
@@ -61,6 +59,8 @@ struct cpuidle_state {
 
 #define CPUIDLE_DRIVER_FLAGS_MASK (0xFFFF0000)
 
+struct cpuidle_device_kobj;
+
 struct cpuidle_device {
 	unsigned int		registered:1;
 	unsigned int		enabled:1;
@@ -71,9 +71,8 @@ struct cpuidle_device {
 	struct cpuidle_state_usage	states_usage[CPUIDLE_STATE_MAX];
 	struct cpuidle_state_kobj *kobjs[CPUIDLE_STATE_MAX];
 	struct cpuidle_driver_kobj *kobj_driver;
+	struct cpuidle_device_kobj *kobj_dev;
 	struct list_head 	device_list;
-	struct kobject		kobj;
-	struct completion	kobj_unregister;
 
 #ifdef CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED
 	int			safe_state_index;
-- 
1.7.9.5

