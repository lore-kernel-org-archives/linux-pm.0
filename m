From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Subject: [PATCH v4 2/3] PM / sleep: Go direct_complete if driver has no callbacks
Date: Wed, 15 Jul 2015 14:40:07 +0200
Message-ID: <1436964008-15151-3-git-send-email-tomeu.vizoso@collabora.com>
References: <1436964008-15151-1-git-send-email-tomeu.vizoso@collabora.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:36384 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752216AbbGOMoK (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 15 Jul 2015 08:44:10 -0400
In-Reply-To: <1436964008-15151-1-git-send-email-tomeu.vizoso@collabora.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Tomeu Vizoso <tomeu.vizoso@collabora.com>, linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Pavel Machek <pavel@ucw.cz>

If a suitable prepare callback cannot be found for a given device and
its driver has no PM callbacks at all, assume that it can go direct to
complete when the system goes to sleep.

The reason for this is that there's lots of devices in a system that do
no PM at all and there's no reason for them to prevent their ancestors
to do direct_complete if they can support it.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---

 drivers/base/power/main.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index 1710c26ba097..edda3f233c7c 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -1540,6 +1540,21 @@ int dpm_suspend(pm_message_t state)
 	return error;
 }
 
+static bool driver_has_no_pm_callbacks(struct device_driver *drv)
+{
+	if (!drv->pm)
+		return true;
+
+	return !drv->pm->prepare &&
+	       !drv->pm->suspend &&
+	       !drv->pm->suspend_late &&
+	       !drv->pm->suspend_noirq &&
+	       !drv->pm->resume_noirq &&
+	       !drv->pm->resume_early &&
+	       !drv->pm->resume &&
+	       !drv->pm->complete;
+}
+
 /**
  * device_prepare - Prepare a device for system power transition.
  * @dev: Device to handle.
@@ -1590,6 +1605,8 @@ static int device_prepare(struct device *dev, pm_message_t state)
 
 	if (callback)
 		ret = callback(dev);
+	else if (!dev->driver || driver_has_no_pm_callbacks(dev->driver))
+		ret = 1;	/* Let device go direct_complete */
 
 	device_unlock(dev);
 
-- 
2.4.3

