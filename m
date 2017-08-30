From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [RFT][PATCH v2 1/3] PM / core: Add SAFE_SUSPEND driver flag
Date: Wed, 30 Aug 2017 02:02:47 +0200
Message-ID: <2182441.mIMLyndpmi@aspire.rjw.lan>
References: <1551534.5XKjjnxbAy@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:62307 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751294AbdH3AWN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 29 Aug 2017 20:22:13 -0400
In-Reply-To: <1551534.5XKjjnxbAy@aspire.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-acpi@vger.kernel.org, Kevin Hilman <khilman@kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Jisheng Zhang <jszhang@marvell.com>, John Stultz <john.stultz@linaro.org>, Guodong Xu <guodong.xu@linaro.org>, Sumit Semwal <sumit.semwal@linaro.org>, Haojian Zhuang <haojian.zhuang@linaro.org>, Johannes Stezenbach <js@sig21.net>, linux-i2c@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Add a driver_flags field to struct dev_pm_info for flags that can be
set by device drivers at the probe time to inform the PM core and/or
bus types, PM domains and so on on the capabilities and/or
preferences of device drivers.  It is anticipated that more than one
flag of this kind will be necessary going forward.

Define and document a SAFE_SUSPEND flag to instruct bus types and PM
domains that the system suspend callbacks provided by the driver can
cope with runtime suspended devices, so from the driver's perspective
it should be safe to leave devices in runtime suspend during system
suspend.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

-> v2: No changes.

---
 Documentation/driver-api/pm/devices.rst |    7 +++++++
 drivers/base/dd.c                       |    2 ++
 include/linux/pm.h                      |   16 ++++++++++++++++
 3 files changed, 25 insertions(+)

Index: linux-pm/include/linux/pm.h
===================================================================
--- linux-pm.orig/include/linux/pm.h
+++ linux-pm/include/linux/pm.h
@@ -550,6 +550,21 @@ struct pm_subsys_data {
 #endif
 };
 
+/*
+ * Driver flags to control system suspend/resume behavior.
+ *
+ * These flags can be set by device drivers at the probe time.  They need not be
+ * cleared by the drivers as the driver core will take care of that.
+ *
+ * SAFE_SUSPEND: No need to runtime resume the device during system suspend.
+ *
+ * Setting SAFE_SUSPEND instructs bus types and PM domains which may want to
+ * runtime resume the device upfront during system suspend that doing so is not
+ * necessary from the driver's perspective, because the system suspend callbacks
+ * provided by it can cope with a runtime suspended device.
+ */
+#define DPM_FLAG_SAFE_SUSPEND	BIT(0)
+
 struct dev_pm_info {
 	pm_message_t		power_state;
 	unsigned int		can_wakeup:1;
@@ -561,6 +576,7 @@ struct dev_pm_info {
 	bool			is_late_suspended:1;
 	bool			early_init:1;	/* Owned by the PM core */
 	bool			direct_complete:1;	/* Owned by the PM core */
+	unsigned int		driver_flags;
 	spinlock_t		lock;
 #ifdef CONFIG_PM_SLEEP
 	struct list_head	entry;
Index: linux-pm/drivers/base/dd.c
===================================================================
--- linux-pm.orig/drivers/base/dd.c
+++ linux-pm/drivers/base/dd.c
@@ -436,6 +436,7 @@ pinctrl_bind_failed:
 	if (dev->pm_domain && dev->pm_domain->dismiss)
 		dev->pm_domain->dismiss(dev);
 	pm_runtime_reinit(dev);
+	dev->power.driver_flags = 0;
 
 	switch (ret) {
 	case -EPROBE_DEFER:
@@ -841,6 +842,7 @@ static void __device_release_driver(stru
 		if (dev->pm_domain && dev->pm_domain->dismiss)
 			dev->pm_domain->dismiss(dev);
 		pm_runtime_reinit(dev);
+		dev->power.driver_flags = 0;
 
 		klist_remove(&dev->p->knode_driver);
 		device_pm_check_callbacks(dev);
Index: linux-pm/Documentation/driver-api/pm/devices.rst
===================================================================
--- linux-pm.orig/Documentation/driver-api/pm/devices.rst
+++ linux-pm/Documentation/driver-api/pm/devices.rst
@@ -729,6 +729,13 @@ state temporarily, for example so that i
 disabled.  This all depends on the hardware and the design of the subsystem and
 device driver in question.
 
+Some bus types and PM domains have a policy to runtime resume all
+devices upfront in their ``->suspend`` callbacks, but that may not be really
+necessary if the system suspend-resume callbacks provided by the device's
+driver can cope with a runtime-suspended device.  The driver can indicate that
+by setting ``DPM_FLAG_SAFE_SUSPEND`` in :c:member:`power.driver_flags` at the
+probe time.
+
 During system-wide resume from a sleep state it's easiest to put devices into
 the full-power state, as explained in :file:`Documentation/power/runtime_pm.txt`.
 Refer to that document for more information regarding this particular issue as
