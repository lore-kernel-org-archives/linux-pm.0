From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] ACPI / PM: Set wakeup GPE masks in acpi_s2idle_prepare()
Date: Fri, 16 Feb 2018 13:44:37 +0100
Message-ID: <1758350.ii3lBJcPKt@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.pl ([79.96.170.134]:52936 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966411AbeBPMqa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 16 Feb 2018 07:46:30 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: Du Wenkai <wenkai.du@intel.com>, Linux PM <linux-pm@vger.kernel.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

It is reported that commit 235d81a630ca (ACPI / PM: Clean up device
wakeup enable/disable code) broke wakeup from suspend-to-idle on
some platforms.  That is due to the acpi_enable_all_wakeup_gpes() in
acpi_s2idle_prepare() which needs acpi_enable_wakeup_devices() to be
called before it as the latter sets up the GPE masks used by the
former and commit 235d81a630ca removed acpi_enable_wakeup_devices()
invocation from the suspend-to-idle path.

However, acpi_enable_wakeup_devices() does more than just setting
the GPE masks and the remaining part of it is not necessary for
suspend-to-idle, so introduce special functions just for setting and
clearing the wakeup GPE masks and use them in acpi_s2idle_prepare(),
before calling acpi_enable_all_wakeup_gpes(), and in
acpi_s2idle_restore(), respectively.

Fixes: 235d81a630ca (ACPI / PM: Clean up device wakeup enable/disable code)
Reported-by: Du Wenkai <wenkai.du@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/sleep.c  |    2 ++
 drivers/acpi/sleep.h  |    2 ++
 drivers/acpi/wakeup.c |   29 +++++++++++++++++++++++++++++
 3 files changed, 33 insertions(+)

Index: linux-pm/drivers/acpi/wakeup.c
===================================================================
--- linux-pm.orig/drivers/acpi/wakeup.c
+++ linux-pm/drivers/acpi/wakeup.c
@@ -21,6 +21,35 @@
 ACPI_MODULE_NAME("wakeup_devices")
 
 /**
+ * acpi_set_wakeup_gpe_masks - Set wakeup GPE masks.
+ *
+ * Set wakeup GPE masks used by acpi_enable_all_wakeup_gpes().
+ */
+void acpi_set_wakeup_gpe_masks(void)
+{
+	struct acpi_device *adev;
+
+	list_for_each_entry(adev, &acpi_wakeup_device_list, wakeup_list)
+		if (device_may_wakeup(&adev->dev) || adev->wakeup.prepare_count)
+			acpi_set_gpe_wake_mask(adev->wakeup.gpe_device,
+					       adev->wakeup.gpe_number,
+					       ACPI_GPE_ENABLE);
+}
+
+/**
+ * acpi_clear_wakeup_gpe_masks - Clear wakeup GPE masks.
+ */
+void acpi_clear_wakeup_gpe_masks(void)
+{
+	struct acpi_device *adev;
+
+	list_for_each_entry(adev, &acpi_wakeup_device_list, wakeup_list)
+		acpi_set_gpe_wake_mask(adev->wakeup.gpe_device,
+				       adev->wakeup.gpe_number,
+				       ACPI_GPE_DISABLE);
+}
+
+/**
  * acpi_enable_wakeup_devices - Enable wake-up device GPEs.
  * @sleep_state: ACPI system sleep state.
  *
Index: linux-pm/drivers/acpi/sleep.h
===================================================================
--- linux-pm.orig/drivers/acpi/sleep.h
+++ linux-pm/drivers/acpi/sleep.h
@@ -1,5 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 
+extern void acpi_set_wakeup_gpe_masks(void);
+extern void acpi_clear_wakeup_gpe_masks(void);
 extern void acpi_enable_wakeup_devices(u8 sleep_state);
 extern void acpi_disable_wakeup_devices(u8 sleep_state);
 
Index: linux-pm/drivers/acpi/sleep.c
===================================================================
--- linux-pm.orig/drivers/acpi/sleep.c
+++ linux-pm/drivers/acpi/sleep.c
@@ -959,6 +959,7 @@ static int acpi_s2idle_prepare(void)
 		 * wakeups, but that should not be necessary if this is a
 		 * "low-power S0" platform and the low-power S0 _DSM is present.
 		 */
+		acpi_set_wakeup_gpe_masks();
 		acpi_enable_all_wakeup_gpes();
 		acpi_os_wait_events_complete();
 	}
@@ -1008,6 +1009,7 @@ static void acpi_s2idle_restore(void)
 		acpi_sleep_run_lps0_dsm(ACPI_LPS0_EXIT);
 		acpi_sleep_run_lps0_dsm(ACPI_LPS0_SCREEN_ON);
 	} else {
+		acpi_clear_wakeup_gpe_masks();
 		acpi_enable_all_runtime_gpes();
 	}
 }
