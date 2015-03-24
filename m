From: Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH] [RFC]ACPI: enable wakeup GPE in freeze mode
Date: Tue, 24 Mar 2015 13:38:00 +0800
Message-ID: <1427175480-22066-1-git-send-email-yu.c.chen@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:59407 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751328AbbCXFdy (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 24 Mar 2015 01:33:54 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net
Cc: len.brown@intel.com, rui.zhang@intel.com, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, Chen Yu <yu.c.chen@intel.com>

Currently, in freeze state, wakeup GPE for PCI devices are
handled properly because acpi_pci_sleep_wake() invokes acpi_enable_gpe()
to enable the wakeup GPE directly. But for the other wakeup-capable
devices in ACPI bus, acpi_enable_wakeup_devices() should be invoked
to update enable_for_wake mask in gpe_register_info structure, thus
acpi_enable_all_wakeup_gpes() can enable the wakeup GPE referred in
_PRW methods.

This patch fixes a power button wakeup problem on Surface Pro 3,
on which platform power button uses EC to deliver event
(EC GPE is referred in _PRW).

Note: enabling EC GPE during freeze state may bring some risks
because EC events are expected to fire more frequently than others.
Thus it may bring the system out of freeze state unnecessarily.
(We already have comments about this in bugzilla)

Fixes https://bugzilla.kernel.org/show_bug.cgi?id=84651

Reported-and-tested-by: Ethan Schoonover <es@ethanschoonover.com>
Tested-by: Peter Amidon <psa.pub.0@picnicpark.org>
Tested-by: Yani Ioadnnou <yani.ioannou@gmail.com>
Tested-by: Mister Wardrop <mister.wardrop@gmail.com>
Tested-by: Anton Anikin <anton@anikin.name>
Tested-by: Keith McClelland <zismylaptop@gmail.com>
Reviewed-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 drivers/acpi/sleep.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
index 7f251dd..91b55e6 100644
--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
@@ -629,6 +629,7 @@ static int acpi_freeze_begin(void)
 
 static int acpi_freeze_prepare(void)
 {
+	acpi_enable_wakeup_devices(ACPI_STATE_S0);
 	acpi_enable_all_wakeup_gpes();
 	acpi_os_wait_events_complete();
 	enable_irq_wake(acpi_gbl_FADT.sci_interrupt);
-- 
1.8.4.2

