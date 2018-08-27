From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: [RESEND PATCH v5] PM / devfreq: Fix devfreq_add_device() when drivers are built as modules.
Date: Mon, 27 Aug 2018 13:05:32 +0200
Message-ID: <20180827110532.28551-1-enric.balletbo@collabora.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: kernel@collabora.com, Chanwoo Choi <cw00.choi@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

When the devfreq driver and the governor driver are built as modules,
the call to devfreq_add_device() or governor_store() fails because the
governor driver is not loaded at the time the devfreq driver loads. The
devfreq driver has a build dependency on the governor but also should
have a runtime dependency. We need to make sure that the governor driver
is loaded before the devfreq driver.

This patch fixes this bug by adding a try_then_request_governor()
function. First tries to find the governor, and then, if it is not
found, it requests the module and tries again.

Fixes: 1b5c1be2c88e (PM / devfreq: map devfreq drivers to governor using name)
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
---

Changes in v5:
- Requested by MyungJoo and Chanwoo.
  - Fix returning without the lock acquired after request_module.
- Requested by Chanwoo.
  - In request governor function check if governor name is NULL or not.
  - Remove some unrelated changes (added/removed some blank lines).

Changes in v4:
- Kept "locked" devfreq_list from the return of find_devfreq_governor() to
  the unlock of governor_store(). Requested by MyungJoo Ham.

Changes in v3:
- Remove unneded change in dev_err message.
- Fix err returned value in case to not find the governor.

Changes in v2:
- Add a new function to request the module and call that function from
  devfreq_add_device and governor_store.

 drivers/devfreq/devfreq.c | 53 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 49 insertions(+), 4 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 4c49bb1330b5..62ead442a872 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -11,6 +11,7 @@
  */
 
 #include <linux/kernel.h>
+#include <linux/kmod.h>
 #include <linux/sched.h>
 #include <linux/errno.h>
 #include <linux/err.h>
@@ -221,6 +222,49 @@ static struct devfreq_governor *find_devfreq_governor(const char *name)
 	return ERR_PTR(-ENODEV);
 }
 
+/**
+ * try_then_request_governor() - Try to find the governor and request the
+ *                               module if is not found.
+ * @name:	name of the governor
+ *
+ * Search the list of devfreq governors and request the module and try again
+ * if is not found. This can happen when both drivers (the governor driver
+ * and the driver that call devfreq_add_device) are built as modules.
+ * devfreq_list_lock should be held by the caller. Returns the matched
+ * governor's pointer.
+ */
+static struct devfreq_governor *try_then_request_governor(const char *name)
+{
+	struct devfreq_governor *governor;
+	int err = 0;
+
+	if (IS_ERR_OR_NULL(name)) {
+		pr_err("DEVFREQ: %s: Invalid parameters\n", __func__);
+		return ERR_PTR(-EINVAL);
+	}
+	WARN(!mutex_is_locked(&devfreq_list_lock),
+	     "devfreq_list_lock must be locked.");
+
+	governor = find_devfreq_governor(name);
+	if (IS_ERR(governor)) {
+		mutex_unlock(&devfreq_list_lock);
+
+		if (!strncmp(name, DEVFREQ_GOV_SIMPLE_ONDEMAND,
+			     DEVFREQ_NAME_LEN))
+			err = request_module("governor_%s", "simpleondemand");
+		else
+			err = request_module("governor_%s", name);
+		/* Restore previous state before return */
+		mutex_lock(&devfreq_list_lock);
+		if (err)
+			return NULL;
+
+		governor = find_devfreq_governor(name);
+	}
+
+	return governor;
+}
+
 static int devfreq_notify_transition(struct devfreq *devfreq,
 		struct devfreq_freqs *freqs, unsigned int state)
 {
@@ -646,9 +690,8 @@ struct devfreq *devfreq_add_device(struct device *dev,
 	mutex_unlock(&devfreq->lock);
 
 	mutex_lock(&devfreq_list_lock);
-	list_add(&devfreq->node, &devfreq_list);
 
-	governor = find_devfreq_governor(devfreq->governor_name);
+	governor = try_then_request_governor(devfreq->governor_name);
 	if (IS_ERR(governor)) {
 		dev_err(dev, "%s: Unable to find governor for the device\n",
 			__func__);
@@ -664,12 +707,14 @@ struct devfreq *devfreq_add_device(struct device *dev,
 			__func__);
 		goto err_init;
 	}
+
+	list_add(&devfreq->node, &devfreq_list);
+
 	mutex_unlock(&devfreq_list_lock);
 
 	return devfreq;
 
 err_init:
-	list_del(&devfreq->node);
 	mutex_unlock(&devfreq_list_lock);
 
 	device_unregister(&devfreq->dev);
@@ -991,7 +1036,7 @@ static ssize_t governor_store(struct device *dev, struct device_attribute *attr,
 		return -EINVAL;
 
 	mutex_lock(&devfreq_list_lock);
-	governor = find_devfreq_governor(str_governor);
+	governor = try_then_request_governor(str_governor);
 	if (IS_ERR(governor)) {
 		ret = PTR_ERR(governor);
 		goto out;
-- 
2.18.0
