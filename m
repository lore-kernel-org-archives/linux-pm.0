From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Subject: [PATCH v8 1/4] device core: add device_is_bound()
Date: Fri,  2 Oct 2015 09:14:28 +0200
Message-ID: <1443770071-2570-2-git-send-email-tomeu.vizoso@collabora.com>
References: <1443770071-2570-1-git-send-email-tomeu.vizoso@collabora.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:33297 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751425AbbJBHQl (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 2 Oct 2015 03:16:41 -0400
In-Reply-To: <1443770071-2570-1-git-send-email-tomeu.vizoso@collabora.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, martyn.welch@collabora.co.uk, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Tomeu Vizoso <tomeu.vizoso@collabora.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org

Adds a function that tells whether a device is already bound to a
driver.

This is needed to warn when there is an attempt to change the PM domain
of a device that has finished probing already. The reason why we want to
enforce that is because in the general case that can cause problems and
also that we can simplify code quite a bit if we can always assume that.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---

Changes in v8:
- Add device_is_bound()

 drivers/base/dd.c      | 9 +++++++--
 include/linux/device.h | 2 ++
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index be0eb4639128..f2007fa7316f 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -192,9 +192,14 @@ static int deferred_probe_initcall(void)
 }
 late_initcall(deferred_probe_initcall);
 
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
@@ -545,7 +550,7 @@ static int __device_attach(struct device *dev, bool allow_async)
 
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
2.4.3

