From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 4/4] ACPI hibernate: Introduce new kernel
	parameter acpi_sleep=s4_nonvs
Date: Wed, 22 Oct 2008 22:54:48 +0200
Message-ID: <200810222254.48666.rjw__47305.5756804117$1224709394$gmane$org@sisk.pl>
References: <200810222249.20629.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200810222249.20629.rjw@sisk.pl>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Len Brown <lenb@kernel.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Ingo Molnar <mingo@elte.hu>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

ACPI hibernate: Introduce new kernel parameter acpi_sleep=s4_nonvs

On some machines it may be necessary to disable the saving/restoring
of the ACPI NVS memory region during hibernation/resume.  For this
purpose, introduce new ACPI kernel command line option
acpi_sleep=s4_nonvs.

Based on a patch by Zhang Rui.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Cc: Zhang Rui <rui.zhang@intel.com>
---
 Documentation/kernel-parameters.txt |    5 ++++-
 arch/x86/kernel/acpi/sleep.c        |    2 ++
 drivers/acpi/sleep/main.c           |   19 +++++++++++++++++--
 include/linux/acpi.h                |    1 +
 4 files changed, 24 insertions(+), 3 deletions(-)

Index: linux-2.6/Documentation/kernel-parameters.txt
===================================================================
--- linux-2.6.orig/Documentation/kernel-parameters.txt
+++ linux-2.6/Documentation/kernel-parameters.txt
@@ -149,7 +149,8 @@ and is between 256 and 4096 characters. 
 			default: 0
 
 	acpi_sleep=	[HW,ACPI] Sleep options
-			Format: { s3_bios, s3_mode, s3_beep, s4_nohwsig, old_ordering }
+			Format: { s3_bios, s3_mode, s3_beep, s4_nohwsig,
+				  old_ordering, s4_nonvs }
 			See Documentation/power/video.txt for s3_bios and s3_mode.
 			s3_beep is for debugging; it makes the PC's speaker beep
 			as soon as the kernel's real-mode entry point is called.
@@ -159,6 +160,8 @@ and is between 256 and 4096 characters. 
 			control method, wrt putting devices into low power
 			states, to be enforced (the ACPI 2.0 ordering of _PTS is
 			used by default).
+			s4_nonvs prevents the kernel from saving/restoring the
+			ACPI NVS memory during hibernation.
 
 	acpi_sci=	[HW,ACPI] ACPI System Control Interrupt trigger mode
 			Format: { level | edge | high | low }
Index: linux-2.6/arch/x86/kernel/acpi/sleep.c
===================================================================
--- linux-2.6.orig/arch/x86/kernel/acpi/sleep.c
+++ linux-2.6/arch/x86/kernel/acpi/sleep.c
@@ -161,6 +161,8 @@ static int __init acpi_sleep_setup(char 
 #endif
 		if (strncmp(str, "old_ordering", 12) == 0)
 			acpi_old_suspend_ordering();
+		if (strncmp(str, "s4_nonvs", 13) == 0)
+			acpi_s4_no_nvs();
 		str = strchr(str, ',');
 		if (str != NULL)
 			str += strspn(str, ", \t");
Index: linux-2.6/drivers/acpi/sleep/main.c
===================================================================
--- linux-2.6.orig/drivers/acpi/sleep/main.c
+++ linux-2.6/drivers/acpi/sleep/main.c
@@ -59,6 +59,20 @@ void __init acpi_old_suspend_ordering(vo
 	old_suspend_ordering = true;
 }
 
+/*
+ * The ACPI specification wants us to save NVS memory regions during hibernation
+ * and to restore them during the subsequent resume.  However, it is not certain
+ * if this mechanism is going to work on all machines, so we allow the user to
+ * disable this mechanism using the 'acpi_sleep=s4_nonvs' kernel command line
+ * option.
+ */
+static bool s4_no_nvs;
+
+void __init acpi_s4_no_nvs(void)
+{
+	s4_no_nvs = true;
+}
+
 /**
  *	acpi_pm_disable_gpes - Disable the GPEs.
  */
@@ -323,7 +337,7 @@ static int acpi_hibernation_begin(void)
 {
 	int error;
 
-	error = hibernate_nvs_alloc();
+	error = s4_no_nvs ? 0 : hibernate_nvs_alloc();
 	if (!error)
 		acpi_target_sleep_state = ACPI_STATE_S4;
 
@@ -411,7 +425,8 @@ static int acpi_hibernation_begin_old(vo
 	int error = acpi_sleep_prepare(ACPI_STATE_S4);
 
 	if (!error) {
-		error = hibernate_nvs_alloc();
+		if (!s4_no_nvs)
+			error = hibernate_nvs_alloc();
 		if (!error)
 			acpi_target_sleep_state = ACPI_STATE_S4;
 	}
Index: linux-2.6/include/linux/acpi.h
===================================================================
--- linux-2.6.orig/include/linux/acpi.h
+++ linux-2.6/include/linux/acpi.h
@@ -238,6 +238,7 @@ int acpi_check_mem_region(resource_size_
 #ifdef CONFIG_PM_SLEEP
 void __init acpi_no_s4_hw_signature(void);
 void __init acpi_old_suspend_ordering(void);
+void __init acpi_s4_no_nvs(void);
 #endif /* CONFIG_PM_SLEEP */
 #else	/* CONFIG_ACPI */
 
