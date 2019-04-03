From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] ACPI: PM: Print debug messages when enabling GPEs for wakeup
Date: Wed, 03 Apr 2019 23:58:01 +0200
Message-ID: <3571352.AeSAkbixj6@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

In sufficiently complicated GPE configurations it is hard to
determine which GPE could be the source of system wakeup from a sleep
state, so make __acpi_device_wakeup_enable() print that information
to the kernel log if debugging is enabled.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/device_pm.c |    3 +++
 1 file changed, 3 insertions(+)

Index: linux-pm/drivers/acpi/device_pm.c
===================================================================
--- linux-pm.orig/drivers/acpi/device_pm.c
+++ linux-pm/drivers/acpi/device_pm.c
@@ -728,6 +728,9 @@ static int __acpi_device_wakeup_enable(s
 		goto out;
 	}
 
+	acpi_handle_debug(adev->handle, "GPE%2X enabled for wakeup\n",
+			  (unsigned int)wakeup->gpe_number);
+
 inc:
 	wakeup->enable_count++;
 
