From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Subject: [PATCH v12 4/4] USB / PM: Allow USB devices to remain runtime-suspended when sleeping
Date: Thu,  7 Jan 2016 16:46:15 +0100
Message-ID: <1452181575-9206-5-git-send-email-tomeu.vizoso@collabora.com>
References: <1452181575-9206-1-git-send-email-tomeu.vizoso@collabora.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1452181575-9206-1-git-send-email-tomeu.vizoso@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, martyn.welch@collabora.co.uk, Ulf Hansson <ulf.hansson@linaro.org>, Daniel Kurtz <djkurtz@chromium.org>
Cc: Tomeu Vizoso <tomeu.vizoso@collabora.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Have dev_pm_ops.prepare return 1 for USB devices and ports so that USB
devices can remain runtime-suspended when the system goes to a sleep
state, if their wakeup state is correct and they have runtime PM enabled.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
---

Changes in v10:
- Remove superfluous call to pm_runtime_enabled() as suggested by Alan

 drivers/usb/core/port.c | 6 ++++++
 drivers/usb/core/usb.c  | 8 +++++++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/core/port.c b/drivers/usb/core/port.c
index 460c855be0d0..14718a9ffcfb 100644
--- a/drivers/usb/core/port.c
+++ b/drivers/usb/core/port.c
@@ -249,12 +249,18 @@ static int usb_port_runtime_suspend(struct device *dev)
 
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
index 77e4c9bc0ab1..ebb29caa3fe4 100644
--- a/drivers/usb/core/usb.c
+++ b/drivers/usb/core/usb.c
@@ -311,7 +311,13 @@ static int usb_dev_uevent(struct device *dev, struct kobj_uevent_env *env)
 
 static int usb_dev_prepare(struct device *dev)
 {
-	return 0;		/* Implement eventually? */
+	struct usb_device *udev = to_usb_device(dev);
+
+	/* Return 0 if the current wakeup setting is wrong, otherwise 1 */
+	if (udev->do_remote_wakeup != device_may_wakeup(dev))
+		return 0;
+
+	return 1;
 }
 
 static void usb_dev_complete(struct device *dev)
-- 
2.5.0
