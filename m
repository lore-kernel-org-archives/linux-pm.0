From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Subject: [PATCH v11 1/4] device core: add device_is_bound()
Date: Tue, 27 Oct 2015 15:38:48 +0100
Message-ID: <1445956731-6304-2-git-send-email-tomeu.vizoso@collabora.com>
References: <1445956731-6304-1-git-send-email-tomeu.vizoso@collabora.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1445956731-6304-1-git-send-email-tomeu.vizoso@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, martyn.welch@collabora.co.uk, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Tomeu Vizoso <tomeu.vizoso@collabora.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Adds a function that tells whether a device is already bound to a
driver.

This is needed to warn when there is an attempt to change the PM domain
of a device that has finished probing already. The reason why we want to
enforce that is because in the general case that can cause problems and
also that we can simplify code quite a bit if we can always assume that.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---

Changes in v9:
- Add docs noting the need for the device lock to be held before calling
  device_is_bound()

Changes in v8:
- Add device_is_bound()

 drivers/base/dd.c      | 18 ++++++++++++++++--
 include/linux/device.h |  2 ++
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index be0eb4639128..d662ed5d08f4 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -192,9 +192,23 @@ static int deferred_probe_initcall(void)
 }
 late_initcall(deferred_probe_initcall);
 
+/**
+ * device_is_bound() - Check if device is bound to a driver
+ * @dev: device to check
+ *
+ * Returns true if passed device has already finished probing successfully
+ * against a driver.
+ *
+ * This function must be called with the device lock held.
+ */
+bool device_is_bound(struct device *dev)
+{
+	return klist_node_attached(&dev->p->knode_driver);
+}
+
 static void driver_bound(struct device *dev)
 {
-	if (klist_node_attached(&dev->p->knode_driver)) {
+	if (device_is_bound(dev)) {
 		printk(KERN_WARNING "%s: device %s already bound\n",
 			__func__, kobject_name(&dev->kobj));
 		return;
@@ -545,7 +559,7 @@ static int __device_attach(struct device *dev, bool allow_async)
 
 	device_lock(dev);
 	if (dev->driver) {
-		if (klist_node_attached(&dev->p->knode_driver)) {
+		if (device_is_bound(dev)) {
 			ret = 1;
 			goto out_unlock;
 		}
diff --git a/include/linux/device.h b/include/linux/device.h
index 5d7bc6349930..9b41c05fb479 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -1035,6 +1035,8 @@ extern int __must_check driver_attach(struct device_driver *drv);
 extern void device_initial_probe(struct device *dev);
 extern int __must_check device_reprobe(struct device *dev);
 
+extern bool device_is_bound(struct device *dev);
+
 /*
  * Easy functions for dynamically creating devices on the fly
  */
-- 
2.5.0
