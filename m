From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 2/2] ACPI / PM: Add debug statements to acpi_pm_notify_handler()
Date: Fri, 11 Aug 2017 01:32:40 +0200
Message-ID: <2095882.PNZ7KaMCX6@aspire.rjw.lan>
References: <14884530.U9YM2D2TGn@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:49025 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750735AbdHJXlF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 10 Aug 2017 19:41:05 -0400
In-Reply-To: <14884530.U9YM2D2TGn@aspire.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Linux PM <linux-pm@vger.kernel.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Add statements to trace invocations of the ACPI PM notify handler
and the work functions called by it.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/device_pm.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

Index: linux-pm/drivers/acpi/device_pm.c
===================================================================
--- linux-pm.orig/drivers/acpi/device_pm.c
+++ linux-pm/drivers/acpi/device_pm.c
@@ -401,6 +401,8 @@ static void acpi_pm_notify_handler(acpi_
 	if (val != ACPI_NOTIFY_DEVICE_WAKE)
 		return;
 
+	acpi_handle_debug(handle, "Wake notify\n");
+
 	adev = acpi_bus_get_acpi_device(handle);
 	if (!adev)
 		return;
@@ -409,8 +411,12 @@ static void acpi_pm_notify_handler(acpi_
 
 	if (adev->wakeup.flags.notifier_present) {
 		pm_wakeup_ws_event(adev->wakeup.ws, 0, acpi_s2idle_wakeup());
-		if (adev->wakeup.context.func)
+		if (adev->wakeup.context.func) {
+			acpi_handle_debug(handle, "Running %pF for %s\n",
+					  adev->wakeup.context.func,
+					  dev_name(adev->wakeup.context.dev));
 			adev->wakeup.context.func(&adev->wakeup.context);
+		}
 	}
 
 	mutex_unlock(&acpi_pm_notifier_lock);
