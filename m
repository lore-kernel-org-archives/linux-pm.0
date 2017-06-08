From: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>
Subject: [PATCH 4/6] ACPI / PM: Clean up device wakeup enable/disable code
Date: Thu, 08 Jun 2017 02:04:21 +0200
Message-ID: <1592199.UEskShOjr9@aspire.rjw.lan>
References: <8918199.uo13RZ8hZk@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <8918199.uo13RZ8hZk-yvgW3jdyMHm1GS7QM15AGw@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux ACPI <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Linux PCI <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux PM <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Srinivas Pandruvada <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Linux USB <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Mathias Nyman <mathias.nyman-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mario Limonciello <mario_limonciello-8PEkshWhKlo@public.gmane.org>, Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Dominik Brodowski <linux-X3ehHDuj6sIIGcDfoQAp7OTW4wlIGRCZ@public.gmane.org>, Hans De Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

The wakeup.flags.enabled flag in struct acpi_device is not used
consistently, as there is no reason why it should only apply
to the enabling/disabling of the wakeup GPE, so put the invocation
of acpi_enable_wakeup_device_power() under it too.

Moreover, it is not necessary to call
acpi_enable_wakeup_devices() and acpi_disable_wakeup_devices() for
suspend-to-idle, so don't do that.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 drivers/acpi/device_pm.c |   19 ++++++++-----------
 drivers/acpi/sleep.c     |    4 ++--
 2 files changed, 10 insertions(+), 13 deletions(-)

Index: linux-pm/drivers/acpi/device_pm.c
===================================================================
--- linux-pm.orig/drivers/acpi/device_pm.c
+++ linux-pm/drivers/acpi/device_pm.c
@@ -688,26 +688,23 @@ static int acpi_device_wakeup(struct acp
 		acpi_status res;
 		int error;
 
+		if (adev->wakeup.flags.enabled)
+			return 0;
+
 		error = acpi_enable_wakeup_device_power(adev, target_state);
 		if (error)
 			return error;
 
-		if (adev->wakeup.flags.enabled)
-			return 0;
-
 		res = acpi_enable_gpe(wakeup->gpe_device, wakeup->gpe_number);
-		if (ACPI_SUCCESS(res)) {
-			adev->wakeup.flags.enabled = 1;
-		} else {
+		if (ACPI_FAILURE(res)) {
 			acpi_disable_wakeup_device_power(adev);
 			return -EIO;
 		}
-	} else {
-		if (adev->wakeup.flags.enabled) {
-			acpi_disable_gpe(wakeup->gpe_device, wakeup->gpe_number);
-			adev->wakeup.flags.enabled = 0;
-		}
+		adev->wakeup.flags.enabled = 1;
+	} else if (adev->wakeup.flags.enabled) {
+		acpi_disable_gpe(wakeup->gpe_device, wakeup->gpe_number);
 		acpi_disable_wakeup_device_power(adev);
+		adev->wakeup.flags.enabled = 0;
 	}
 	return 0;
 }
Index: linux-pm/drivers/acpi/sleep.c
===================================================================
--- linux-pm.orig/drivers/acpi/sleep.c
+++ linux-pm/drivers/acpi/sleep.c
@@ -658,19 +658,19 @@ static int acpi_freeze_begin(void)
 
 static int acpi_freeze_prepare(void)
 {
-	acpi_enable_wakeup_devices(ACPI_STATE_S0);
 	acpi_enable_all_wakeup_gpes();
 	acpi_os_wait_events_complete();
 	if (acpi_sci_irq_valid())
 		enable_irq_wake(acpi_sci_irq);
+
 	return 0;
 }
 
 static void acpi_freeze_restore(void)
 {
-	acpi_disable_wakeup_devices(ACPI_STATE_S0);
 	if (acpi_sci_irq_valid())
 		disable_irq_wake(acpi_sci_irq);
+
 	acpi_enable_all_runtime_gpes();
 }
 

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
