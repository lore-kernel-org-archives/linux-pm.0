From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 1/2] ACPI: Add debug statements to acpi_global_event_handler()
Date: Fri, 11 Aug 2017 01:31:54 +0200
Message-ID: <1927989.koY9Kj8cp2@aspire.rjw.lan>
References: <14884530.U9YM2D2TGn@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:60035 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750841AbdHJXlG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 10 Aug 2017 19:41:06 -0400
In-Reply-To: <14884530.U9YM2D2TGn@aspire.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Linux PM <linux-pm@vger.kernel.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

It sometimes is useful to examine the timing of ACPI events during
certain operations only, like during system suspend/resume, so add
pr_debug() statements for that to acpi_global_event_handler().

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/sysfs.c |   12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

Index: linux-pm/drivers/acpi/sysfs.c
===================================================================
--- linux-pm.orig/drivers/acpi/sysfs.c
+++ linux-pm/drivers/acpi/sysfs.c
@@ -2,6 +2,8 @@
  * sysfs.c - ACPI sysfs interface to userspace.
  */
 
+#define pr_fmt(fmt) "ACPI: " fmt
+
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/moduleparam.h>
@@ -552,11 +554,15 @@ static void fixed_event_count(u32 event_
 static void acpi_global_event_handler(u32 event_type, acpi_handle device,
 	u32 event_number, void *context)
 {
-	if (event_type == ACPI_EVENT_TYPE_GPE)
+	if (event_type == ACPI_EVENT_TYPE_GPE) {
 		gpe_count(event_number);
-
-	if (event_type == ACPI_EVENT_TYPE_FIXED)
+		pr_debug("GPE event 0x%02x\n", event_number);
+	} else if (event_type == ACPI_EVENT_TYPE_FIXED) {
 		fixed_event_count(event_number);
+		pr_debug("Fixed event 0x%02x\n", event_number);
+	} else {
+		pr_debug("Other event 0x%02x\n", event_number);
+	}
 }
 
 static int get_status(u32 index, acpi_event_status *status,
