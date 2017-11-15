From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] ACPI / PM: Make it possible to ignore the system sleep blacklist
Date: Wed, 15 Nov 2017 02:16:55 +0100
Message-ID: <302151591.hxLyGjAOpX@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:49342 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752971AbdKOBRI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Nov 2017 20:17:08 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Mario Limonciello <mario.limonciello@dell.com>, Paul Menzel <pmenzel@molgen.mpg.de>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The ACPI code supporting system transitions to sleep states uses
an internal blacklist to apply special handling to some machines
reported to behave incorrectly in some ways.

However, some entries of that blacklist cover problematic as well as
non-problematic systems, so give the users of the latter a chance to
ignore the blacklist and run their systems in the default way by
adding acpi_sleep=nobl to the kernel command line.

For example, that allows the users of Dell XPS13 9360 systems not
affected by the issue that caused the blacklist entry for this
machine to be added by commit 71630b7a832f (ACPI / PM: Blacklist Low
Power S0 Idle _DSM for Dell XPS13 9360) to use suspend-to-idle with
the Low Power S0 Idle _DSM interface which in principle should be
more energy-efficient than S3 on them.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 Documentation/admin-guide/kernel-parameters.txt |    5 ++++-
 arch/x86/kernel/acpi/sleep.c                    |    2 ++
 drivers/acpi/sleep.c                            |   10 ++++++++++
 include/linux/acpi.h                            |    1 +
 4 files changed, 17 insertions(+), 1 deletion(-)

Index: linux-pm/arch/x86/kernel/acpi/sleep.c
===================================================================
--- linux-pm.orig/arch/x86/kernel/acpi/sleep.c
+++ linux-pm/arch/x86/kernel/acpi/sleep.c
@@ -138,6 +138,8 @@ static int __init acpi_sleep_setup(char
 			acpi_nvs_nosave_s3();
 		if (strncmp(str, "old_ordering", 12) == 0)
 			acpi_old_suspend_ordering();
+		if (strncmp(str, "nobl", 4) == 0)
+			acpi_sleep_no_blacklist();
 		str = strchr(str, ',');
 		if (str != NULL)
 			str += strspn(str, ", \t");
Index: linux-pm/drivers/acpi/sleep.c
===================================================================
--- linux-pm.orig/drivers/acpi/sleep.c
+++ linux-pm/drivers/acpi/sleep.c
@@ -367,10 +367,20 @@ static const struct dmi_system_id acpisl
 	{},
 };
 
+static bool ignore_blacklist;
+
+void __init acpi_sleep_no_blacklist(void)
+{
+	ignore_blacklist = true;
+}
+
 static void __init acpi_sleep_dmi_check(void)
 {
 	int year;
 
+	if (ignore_blacklist)
+		return;
+
 	if (dmi_get_date(DMI_BIOS_DATE, &year, NULL, NULL) && year >= 2012)
 		acpi_nvs_nosave_s3();
 
Index: linux-pm/include/linux/acpi.h
===================================================================
--- linux-pm.orig/include/linux/acpi.h
+++ linux-pm/include/linux/acpi.h
@@ -451,6 +451,7 @@ void __init acpi_no_s4_hw_signature(void
 void __init acpi_old_suspend_ordering(void);
 void __init acpi_nvs_nosave(void);
 void __init acpi_nvs_nosave_s3(void);
+void __init acpi_sleep_no_blacklist(void);
 #endif /* CONFIG_PM_SLEEP */
 
 struct acpi_osc_context {
Index: linux-pm/Documentation/admin-guide/kernel-parameters.txt
===================================================================
--- linux-pm.orig/Documentation/admin-guide/kernel-parameters.txt
+++ linux-pm/Documentation/admin-guide/kernel-parameters.txt
@@ -223,7 +223,7 @@
 
 	acpi_sleep=	[HW,ACPI] Sleep options
 			Format: { s3_bios, s3_mode, s3_beep, s4_nohwsig,
-				  old_ordering, nonvs, sci_force_enable }
+				  old_ordering, nonvs, sci_force_enable, nobl }
 			See Documentation/power/video.txt for information on
 			s3_bios and s3_mode.
 			s3_beep is for debugging; it makes the PC's speaker beep
@@ -239,6 +239,9 @@
 			sci_force_enable causes the kernel to set SCI_EN directly
 			on resume from S1/S3 (which is against the ACPI spec,
 			but some broken systems don't work without it).
+			nobl causes the internal blacklist of systems known to
+			behave incorrectly in some ways with respect to system
+			suspend and resume to be ignored (use wisely).
 
 	acpi_use_timer_override [HW,ACPI]
 			Use timer override. For some broken Nvidia NF5 boards
