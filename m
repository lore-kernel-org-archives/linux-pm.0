From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Subject: [PATCH v4 3/3] USB / PM: Allow USB devices to remain runtime-suspended when sleeping
Date: Wed, 15 Jul 2015 14:40:08 +0200
Message-ID: <1436964008-15151-4-git-send-email-tomeu.vizoso@collabora.com>
References: <1436964008-15151-1-git-send-email-tomeu.vizoso@collabora.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1436964008-15151-1-git-send-email-tomeu.vizoso@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Tomeu Vizoso <tomeu.vizoso@collabora.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Have dev_pm_ops.prepare return 1 for USB devices and ports so that USB
devices can remain runtime-suspended when the system goes to a sleep
state, if their wakeup state is correct and they have runtime PM enabled.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---

 drivers/usb/core/port.c |  6 ++++++
 drivers/usb/core/usb.c  | 11 ++++++++++-
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/core/port.c b/drivers/usb/core/port.c
index 210618319f10..f49707d73b5a 100644
--- a/drivers/usb/core/port.c
+++ b/drivers/usb/core/port.c
@@ -168,12 +168,18 @@ static int usb_port_runtime_suspend(struct device *dev)
 
 	return retval;
 }
+
+static int usb_port_prepare(struct device *dev)
+{
+	return 1;
+}
 #endif
 
 static const struct dev_pm_ops usb_port_pm_ops = {
 #ifdef CONFIG_PM
 	.runtime_suspend =	usb_port_runtime_suspend,
 	.runtime_resume =	usb_port_runtime_resume,
+	.prepare =		usb_port_prepare,
 #endif
 };
 
diff --git a/drivers/usb/core/usb.c b/drivers/usb/core/usb.c
index 8d5b2f4113cd..cf4dde11db1c 100644
--- a/drivers/usb/core/usb.c
+++ b/drivers/usb/core/usb.c
@@ -316,7 +316,16 @@ static int usb_dev_uevent(struct device *dev, struct kobj_uevent_env *env)
 
 static int usb_dev_prepare(struct device *dev)
 {
-	return 0;		/* Implement eventually? */
+	struct usb_device *udev = to_usb_device(dev);
+
+	if (!pm_runtime_enabled(dev))
+		return 0;
+
+	/* Return 0 if the current wakeup setting is wrong, otherwise 1 */
+	if (udev->do_remote_wakeup != device_may_wakeup(dev))
+		return 0;
+
+	return 1;
 }
 
 static void usb_dev_complete(struct device *dev)
-- 
2.4.3
