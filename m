From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH 3/8] pm: domains: sync runtime PM status with PM domains
Date: Sat, 14 Feb 2015 15:27:40 +0000
Message-ID: <E1YMedA-00054Z-TK@rmk-PC.arm.linux.org.uk>
References: <20150214152659.GI8656@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:41062 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752743AbbBNP1y (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 14 Feb 2015 10:27:54 -0500
In-Reply-To: <20150214152659.GI8656@n2100.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org

Synchronise the PM domain status with runtime PM's status.  This
provides a better solution to the problem than commit 2ed127697eb1
("PM / Domains: Power on the PM domain right after attach completes").

The above commit added a call to power up the PM domain when a device
attaches to the domain.  The assumption is that the device driver
will cause a runtime PM transition, which will synchronise the PM
domain state with the runtime PM state.

However, runtime PM will, by default, assume that the device is
initially suspended.  So we have two subsystems which have differing
initial state expectations.  This is silly.

Runtime PM requires that pm_runtime_set_active() is called before
pm_runtime_enable() if the device is already powered up.  However, PM
domains are not informed of this, and this is where the problem really
lies.  We need to keep PM domains properly and fully informed of their
associated device status.

We fix this by adding a new callback - runtime_set_status() which is
triggered whenever a successful call to __pm_runtime_set_status().
PM domain code hooks into this, and updates the PM domain appropriately.

This means a driver with the following sequence:

	pm_runtime_set_active(dev);
	pm_runtime_enable(dev);

will trigger the PM domain to be powered up at this point, which keeps
runtime PM and PM domains properly in sync with each other.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/base/power/domain.c  | 16 +++++++++++++++-
 drivers/base/power/runtime.c |  5 +++++
 include/linux/pm.h           |  1 +
 3 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 11a1023fa64a..2a700cea41fc 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -741,6 +741,20 @@ static int pm_genpd_runtime_resume(struct device *dev)
 	return 0;
 }
 
+static int pm_genpd_runtime_set_status(struct device *dev)
+{
+	int ret;
+
+	dev_dbg(dev, "%s()\n", __func__);
+
+	if (pm_runtime_suspended(dev))
+		ret = pm_genpd_runtime_suspend(dev);
+	else
+		ret = pm_genpd_runtime_resume(dev);
+
+	return ret;
+}
+
 static bool pd_ignore_unused;
 static int __init pd_ignore_unused_setup(char *__unused)
 {
@@ -1907,6 +1921,7 @@ void pm_genpd_init(struct generic_pm_domain *genpd,
 	genpd->max_off_time_changed = true;
 	genpd->domain.ops.runtime_suspend = pm_genpd_runtime_suspend;
 	genpd->domain.ops.runtime_resume = pm_genpd_runtime_resume;
+	genpd->domain.ops.runtime_set_status = pm_genpd_runtime_set_status;
 	genpd->domain.ops.prepare = pm_genpd_prepare;
 	genpd->domain.ops.suspend = pm_genpd_suspend;
 	genpd->domain.ops.suspend_late = pm_genpd_suspend_late;
@@ -2223,7 +2238,6 @@ int genpd_dev_pm_attach(struct device *dev)
 	}
 
 	dev->pm_domain->detach = genpd_dev_pm_detach;
-	pm_genpd_poweron(pd);
 
 	return 0;
 }
diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 5070c4fe8542..a958cae67a37 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -981,6 +981,7 @@ int __pm_runtime_set_status(struct device *dev, unsigned int status)
 	struct device *parent = dev->parent;
 	unsigned long flags;
 	bool notify_parent = false;
+	pm_callback_t callback;
 	int error = 0;
 
 	if (status != RPM_ACTIVE && status != RPM_SUSPENDED)
@@ -1029,6 +1030,10 @@ int __pm_runtime_set_status(struct device *dev, unsigned int status)
  out_set:
 	__update_runtime_status(dev, status);
 	dev->power.runtime_error = 0;
+	if (dev->power.no_callbacks)
+		goto out;
+	callback = RPM_GET_CALLBACK(dev, runtime_set_status);
+	rpm_callback(callback, dev);
  out:
 	spin_unlock_irqrestore(&dev->power.lock, flags);
 
diff --git a/include/linux/pm.h b/include/linux/pm.h
index 8b5976364619..ee098585d577 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -316,6 +316,7 @@ struct dev_pm_ops {
 	int (*runtime_suspend)(struct device *dev);
 	int (*runtime_resume)(struct device *dev);
 	int (*runtime_idle)(struct device *dev);
+	int (*runtime_set_status)(struct device *dev);
 };
 
 #ifdef CONFIG_PM_SLEEP
-- 
1.8.3.1

