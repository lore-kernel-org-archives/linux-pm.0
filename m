From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 4/4] ACPI hibernate: Introduce new kernel
	parameter acpi_sleep=s4_nonvs
Date: Sun, 26 Oct 2008 20:56:30 +0100
Message-ID: <200810262056.31747.rjw__41157.5736514807$1225051332$gmane$org@sisk.pl>
References: <200810262048.23468.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200810262048.23468.rjw@sisk.pl>
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
Cc: Nigel Cunningham <ncunningham@crca.org.au>, Ingo Molnar <mingo@elte.hu>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Pavel Machek <pavel@suse.cz>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>
Subject: ACPI hibernate: Introduce new kernel parameter acpi_sleep=s4_nonvs

On some machines it may be necessary to disable the saving/restoring
of the ACPI NVS memory region during hibernation/resume.  For this
purpose, introduce new ACPI kernel command line option
acpi_sleep=s4_nonvs.

Based on a patch by Zhang Rui.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Acked-by: Nigel Cunningham <nigel@tuxonice.net>
Acked-by: Pavel Machek <pavel@suse.cz>
Cc: Zhang Rui <rui.zhang@intel.com>
---
 Documentation/kernel-parameters.txt |    5 ++++-
 arch/x86/kernel/acpi/sleep.c        |    2 ++
 drivers/acpi/sleep/main.c           |   19 +++++++++++++++++--
 include/linux/acpi.h                |    1 +
 4 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index 343e0f0..9567123 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -149,7 +149,8 @@ and is between 256 and 4096 characters. It is defined in the file
 			default: 0
 
 	acpi_sleep=	[HW,ACPI] Sleep options
-			Format: { s3_bios, s3_mode, s3_beep, s4_nohwsig, old_ordering }
+			Format: { s3_bios, s3_mode, s3_beep, s4_nohwsig,
+				  old_ordering, s4_nonvs }
 			See Documentation/power/video.txt for s3_bios and s3_mode.
 			s3_beep is for debugging; it makes the PC's speaker beep
 			as soon as the kernel's real-mode entry point is called.
@@ -159,6 +160,8 @@ and is between 256 and 4096 characters. It is defined in the file
 			control method, wrt putting devices into low power
 			states, to be enforced (the ACPI 2.0 ordering of _PTS is
 			used by default).
+			s4_nonvs prevents the kernel from saving/restoring the
+			ACPI NVS memory during hibernation.
 
 	acpi_sci=	[HW,ACPI] ACPI System Control Interrupt trigger mode
 			Format: { level | edge | high | low }
diff --git a/arch/x86/kernel/acpi/sleep.c b/arch/x86/kernel/acpi/sleep.c
index f8a12a8..1d3f36c 100644
--- a/arch/x86/kernel/acpi/sleep.c
+++ b/arch/x86/kernel/acpi/sleep.c
@@ -161,6 +161,8 @@ static int __init acpi_sleep_setup(char *str)
 #endif
 		if (strncmp(str, "old_ordering", 12) == 0)
 			acpi_old_suspend_ordering();
+		if (strncmp(str, "s4_nonvs", 8) == 0)
+			acpi_s4_no_nvs();
 		str = strchr(str, ',');
 		if (str != NULL)
 			str += strspn(str, ", \t");
diff --git a/drivers/acpi/sleep/main.c b/drivers/acpi/sleep/main.c
index f861b73..63bff78 100644
--- a/drivers/acpi/sleep/main.c
+++ b/drivers/acpi/sleep/main.c
@@ -90,6 +90,20 @@ void __init acpi_old_suspend_ordering(void)
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
@@ -358,7 +372,7 @@ static int acpi_hibernation_begin(void)
 {
 	int error;
 
-	error = hibernate_nvs_alloc();
+	error = s4_no_nvs ? 0 : hibernate_nvs_alloc();
 	if (!error) {
 		acpi_target_sleep_state = ACPI_STATE_S4;
 		acpi_sleep_tts_switch(acpi_target_sleep_state);
@@ -456,7 +470,8 @@ static int acpi_hibernation_begin_old(void)
 	error = acpi_sleep_prepare(ACPI_STATE_S4);
 
 	if (!error) {
-		error = hibernate_nvs_alloc();
+		if (!s4_no_nvs)
+			error = hibernate_nvs_alloc();
 		if (!error)
 			acpi_target_sleep_state = ACPI_STATE_S4;
 	}
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index fd6a452..4008f61 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -230,6 +230,7 @@ int acpi_check_mem_region(resource_size_t start, resource_size_t n,
 #ifdef CONFIG_PM_SLEEP
 void __init acpi_no_s4_hw_signature(void);
 void __init acpi_old_suspend_ordering(void);
+void __init acpi_s4_no_nvs(void);
 #endif /* CONFIG_PM_SLEEP */
 #else	/* CONFIG_ACPI */
 
-- 
1.5.6
