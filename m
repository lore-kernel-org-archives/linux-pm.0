From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [RFC][PATCH 2/2] PM / sleep: Kick devices that might have been reset by firmware
Date: Wed, 30 Sep 2015 02:53:22 +0200
Message-ID: <5732365.XVsXxYIbHS@vostro.rjw.lan>
References: <10641052.oOBhM6BU9G@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <10641052.oOBhM6BU9G@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Daniel Vetter <daniel.vetter@intel.com>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

If the platform firmware was involved in the system resume that's
being completed, there is a concern that some devices might have
been reset by it and if those devices had the power.direct_complete
flag set during the preceding suspend transition, they may stay
in a reset-power-on state indefinitely (until they are runtime-resumed
and then suspended again).  That may not be a big deal from the
individual device's perspective, but if the system is an SoC, it may
be prevented from entering deep SoC-wide low-power states on idle
because of that.

To prevent that from happening, force a runtime resume for devices
with power.direct_complete set if the platform firmware was involved
in the resume transition currently in progress.

Something similar was done by the ACPI PM domain, but regardless of
the platform firmware involvement, and the new mechanism should be
sufficient to replace that code, so drop it.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/device_pm.c  |    7 -------
 drivers/base/power/main.c |    7 +++++++
 2 files changed, 7 insertions(+), 7 deletions(-)

Index: linux-pm/drivers/acpi/device_pm.c
===================================================================
--- linux-pm.orig/drivers/acpi/device_pm.c
+++ linux-pm/drivers/acpi/device_pm.c
@@ -969,13 +969,6 @@ EXPORT_SYMBOL_GPL(acpi_subsys_prepare);
 void acpi_subsys_complete(struct device *dev)
 {
 	pm_generic_complete(dev);
-	/*
-	 * If the device had been runtime-suspended before the system went into
-	 * the sleep state it is going out of and it has never been resumed till
-	 * now, resume it in case the firmware powered it up.
-	 */
-	if (dev->power.direct_complete)
-		pm_request_resume(dev);
 }
 EXPORT_SYMBOL_GPL(acpi_subsys_complete);
 
Index: linux-pm/drivers/base/power/main.c
===================================================================
--- linux-pm.orig/drivers/base/power/main.c
+++ linux-pm/drivers/base/power/main.c
@@ -928,6 +928,13 @@ static void device_complete(struct devic
 	device_unlock(dev);
 
 	pm_runtime_put(dev);
+	/*
+	 * If the device had been runtime-suspended before the system went into
+	 * the sleep state it is going out of and it has never been resumed till
+	 * now, resume it in case the firmware powered it up.
+	 */
+	if (dev->power.direct_complete && pm_resume_via_firmware())
+		pm_request_resume(dev);
 }
 
 /**

