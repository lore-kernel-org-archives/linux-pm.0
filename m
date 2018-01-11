From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH v2 1/2] ACPI / PM: Use Low Power S0 Idle on more systems
Date: Thu, 11 Jan 2018 02:13:58 +0100
Message-ID: <2293881.tBporBhK0J@aspire.rjw.lan>
References: <4046497.JI7UjL75gC@aspire.rjw.lan> <12541194.33112yYDjW@aspire.rjw.lan> <1515590661.7000.855.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <1515590661.7000.855.camel@linux.intel.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Darren Hart <dvhart@infradead.org>, LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Platform Driver <platform-driver-x86@vger.kernel.org>, Valentin Manea <valy@mrs.ro>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Some systems don't support the ACPI_LPS0_ENTRY and ACPI_LPS0_EXIT
functions in their Low Power S0 Idle _DSM, but still expect EC
events to be processed in the suspend-to-idle state for power button
wakeup (among other things) to work.  Surface Pro3 turns out to be
one of them.

Fortunately, it still provides Low Power S0 Idle _DSM with the screen
on/off functions supported, so modify the ACPI suspend-to-idle to use
the Low Power S0 Idle code path for all systems supporting the
ACPI_LPS0_ENTRY and ACPI_LPS0_EXIT or the ACPI_LPS0_SCREEN_OFF and
ACPI_LPS0_SCREEN_ON functions in their Low Power S0 Idle _DSM.

Potentially, that will cause more systems to use suspend-to-idle by
default, so some future corrections may be necessary if it leads
to issues, but let it remain more straightforward for now.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=198389#add_comment
Reported-by: Valentin Manea <valy@mrs.ro>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

-> v2: Rename ACPI_LPS0_S2I_MASK to ACPI_LPS0_PLATFORM_MASK.

---
 drivers/acpi/sleep.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

Index: linux-pm/drivers/acpi/sleep.c
===================================================================
--- linux-pm.orig/drivers/acpi/sleep.c
+++ linux-pm/drivers/acpi/sleep.c
@@ -707,7 +707,8 @@ static const struct acpi_device_id lps0_
 #define ACPI_LPS0_ENTRY		5
 #define ACPI_LPS0_EXIT		6
 
-#define ACPI_S2IDLE_FUNC_MASK	((1 << ACPI_LPS0_ENTRY) | (1 << ACPI_LPS0_EXIT))
+#define ACPI_LPS0_SCREEN_MASK	((1 << ACPI_LPS0_SCREEN_OFF) | (1 << ACPI_LPS0_SCREEN_ON))
+#define ACPI_LPS0_PLATFORM_MASK	((1 << ACPI_LPS0_ENTRY) | (1 << ACPI_LPS0_EXIT))
 
 static acpi_handle lps0_device_handle;
 static guid_t lps0_dsm_guid;
@@ -910,7 +911,8 @@ static int lps0_device_attach(struct acp
 	if (out_obj && out_obj->type == ACPI_TYPE_BUFFER) {
 		char bitmask = *(char *)out_obj->buffer.pointer;
 
-		if ((bitmask & ACPI_S2IDLE_FUNC_MASK) == ACPI_S2IDLE_FUNC_MASK) {
+		if ((bitmask & ACPI_LPS0_PLATFORM_MASK) == ACPI_LPS0_PLATFORM_MASK ||
+		    (bitmask & ACPI_LPS0_SCREEN_MASK) == ACPI_LPS0_SCREEN_MASK) {
 			lps0_dsm_func_mask = bitmask;
 			lps0_device_handle = adev->handle;
 			/*
