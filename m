From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Subject: [PATCH v3 2/2] PM / Runtime: Add pm_runtime_enable_recursive
Date: Tue, 19 May 2015 16:11:16 +0200
Message-ID: <1432044679-10256-3-git-send-email-tomeu.vizoso@collabora.com>
References: <1432044679-10256-1-git-send-email-tomeu.vizoso@collabora.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f42.google.com ([74.125.82.42]:33944 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932846AbbESOMG (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 19 May 2015 10:12:06 -0400
In-Reply-To: <1432044679-10256-1-git-send-email-tomeu.vizoso@collabora.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Alan Stern <stern@rowland.harvard.edu>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@linaro.org>, Russell King <rmk+kernel@arm.linux.org.uk>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, linux-kernel@vger.kernel.org

This function makes less cumbersome to enable runtime PM in a device and
its descendants.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---
 drivers/base/power/runtime.c | 15 +++++++++++++++
 include/linux/pm_runtime.h   |  1 +
 2 files changed, 16 insertions(+)

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 5070c4f..2c96f3f 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -1189,6 +1189,21 @@ void pm_runtime_enable(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(pm_runtime_enable);
 
+static int __pm_runtime_enable_recursive(struct device *dev, void *data)
+{
+	pm_runtime_enable(dev);
+
+	device_for_each_child(dev, NULL, __pm_runtime_enable_recursive);
+
+	return 0;
+}
+
+void pm_runtime_enable_recursive(struct device *dev)
+{
+	__pm_runtime_enable_recursive(dev, NULL);
+}
+EXPORT_SYMBOL_GPL(pm_runtime_enable_recursive);
+
 /**
  * pm_runtime_forbid - Block runtime PM of a device.
  * @dev: Device to handle.
diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
index 30e84d4..d393ac3 100644
--- a/include/linux/pm_runtime.h
+++ b/include/linux/pm_runtime.h
@@ -43,6 +43,7 @@ extern int pm_schedule_suspend(struct device *dev, unsigned int delay);
 extern int __pm_runtime_set_status(struct device *dev, unsigned int status);
 extern int pm_runtime_barrier(struct device *dev);
 extern void pm_runtime_enable(struct device *dev);
+extern void pm_runtime_enable_recursive(struct device *dev);
 extern void __pm_runtime_disable(struct device *dev, bool check_resume);
 extern void pm_runtime_allow(struct device *dev);
 extern void pm_runtime_forbid(struct device *dev);
-- 
2.4.1

