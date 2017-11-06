From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] ACPI / PM: Blacklist the Low Power S0 Idle _DSM for Dell XPS13 9360
Date: Mon, 06 Nov 2017 13:45:00 +0100
Message-ID: <3247255.eai8UmRkOm@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:55253 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752099AbdKFMpE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 Nov 2017 07:45:04 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Mario Limonciello <mario.limonciello@dell.com>, Paul Menzel <pmenzel@molgen.mpg.de>, Thorsten Leemhuis <regressions@leemhuis.info>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

At least one Dell XPS13 9360 is reported to have serious issues with
the Low Power S0 Idle _DSM interface and since this machine model
generally can do ACPI S3 just fine, add a blacklist entry to disable
that interface for Dell XPS13 9360.

Fixes: 8110dd281e15 (ACPI / sleep: EC-based wakeup from suspend-to-idle on recent systems)
Link: https://bugzilla.kernel.org/show_bug.cgi?id=196907
Reported-by: Paul Menzel <pmenzel@molgen.mpg.de>
Tested-by: Paul Menzel <pmenzel@molgen.mpg.de>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/sleep.c |   32 +++++++++++++++++++++++++++-----
 1 file changed, 27 insertions(+), 5 deletions(-)

Index: linux-pm/drivers/acpi/sleep.c
===================================================================
--- linux-pm.orig/drivers/acpi/sleep.c
+++ linux-pm/drivers/acpi/sleep.c
@@ -90,7 +90,6 @@ static bool acpi_sleep_state_supported(u
 			&& acpi_gbl_FADT.sleep_status.address));
 }
 
-#ifdef CONFIG_ACPI_SLEEP
 static u32 acpi_target_sleep_state = ACPI_STATE_S0;
 
 u32 acpi_target_system_state(void)
@@ -160,6 +159,14 @@ static int __init init_nvs_nosave(const
 	return 0;
 }
 
+static bool acpi_sleep_no_lps0;
+
+static int __init init_no_lps0(const struct dmi_system_id *d)
+{
+	acpi_sleep_no_lps0 = true;
+	return 0;
+}
+
 static const struct dmi_system_id acpisleep_dmi_table[] __initconst = {
 	{
 	.callback = init_old_suspend_ordering,
@@ -343,6 +350,19 @@ static const struct dmi_system_id acpisl
 		DMI_MATCH(DMI_PRODUCT_NAME, "80E3"),
 		},
 	},
+	/*
+	 * https://bugzilla.kernel.org/show_bug.cgi?id=196907
+	 * Some Dell XPS13 9360 cannot do suspend-to-idle using the Low Power
+	 * S0 Idle firmware interface.
+	 */
+	{
+	.callback = init_no_lps0,
+	.ident = "Dell XPS13 9360",
+	.matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+		DMI_MATCH(DMI_PRODUCT_NAME, "XPS 13 9360"),
+		},
+	},
 	{},
 };
 
@@ -483,10 +503,6 @@ static void acpi_pm_end(void)
 	acpi_target_sleep_state = ACPI_STATE_S0;
 	acpi_sleep_tts_switch(acpi_target_sleep_state);
 }
-#else /* !CONFIG_ACPI_SLEEP */
-#define acpi_target_sleep_state	ACPI_STATE_S0
-static inline void acpi_sleep_dmi_check(void) {}
-#endif /* CONFIG_ACPI_SLEEP */
 
 #ifdef CONFIG_SUSPEND
 static u32 acpi_suspend_states[] = {
@@ -863,6 +879,12 @@ static int lps0_device_attach(struct acp
 	if (lps0_device_handle)
 		return 0;
 
+	if (acpi_sleep_no_lps0) {
+		acpi_handle_info(adev->handle,
+				 "Low Power S0 Idle interface disabled\n");
+		return 0;
+	}
+
 	if (!(acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0))
 		return 0;
 
