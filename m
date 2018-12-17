From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [RFT][PATCH 2/2] ACPI: PM: Loop in full LPS0 mode only
Date: Mon, 17 Dec 2018 12:22:43 +0100
Message-ID: <1663330.5FSq7u8peI@aspire.rjw.lan>
References: <4307523.O7RPX2KSmk@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4307523.O7RPX2KSmk@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

After a previous change, all non-wakeup GPEs are disabled for
suspend-to-idle unless full Low-Power S0 (LPS0) mode is in use, so
it is not necessary to do anything in acpi_s2idle_wake() unless in
full LPS0 mode, which is when lps0_device_handle is set only.

Modify the code accordingly.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/sleep.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

Index: linux-pm/drivers/acpi/sleep.c
===================================================================
--- linux-pm.orig/drivers/acpi/sleep.c
+++ linux-pm/drivers/acpi/sleep.c
@@ -985,6 +985,8 @@ static int acpi_s2idle_prepare(void)
 
 static void acpi_s2idle_wake(void)
 {
+	if (!lps0_device_handle)
+		return;
 
 	if (pm_debug_messages_on)
 		lpi_check_constraints();
@@ -1003,8 +1005,7 @@ static void acpi_s2idle_wake(void)
 		 * takes too much time for EC wakeup events to survive, so look
 		 * for them now.
 		 */
-		if (lps0_device_handle)
-			acpi_ec_dispatch_gpe();
+		acpi_ec_dispatch_gpe();
 	}
 }
 
