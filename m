From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH -mm 7/8] ACPI hibernation: Utilize hardware
	signature
Date: Thu, 10 Jul 2008 02:05:51 +0200
Message-ID: <200807100205.52308.rjw__25166.1778231666$1215650235$gmane$org@sisk.pl>
References: <200807100152.17755.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200807100152.17755.rjw@sisk.pl>
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
To: Andrew Morton <akpm@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Pavel Machek <pavel@suse.cz>, Andi Kleen <andi@firstfloor.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

From: Shaohua Li <shaohua.li@intel.com>
Subject: ACPI hibernation: Utilize hardware signature

ACPI defines a hardware signature.  BIOS calculates the signature
according to hardware configure and if hardware changes while
hibernated, the signature will change.  In that case, S4 resume
should fail.

Still, there may be systems on which this mechanism does not work
correctly, so it is better to provide a workaround for them.  For
this reason, add a new switch to the acpi_sleep= command line
argument allowing one to disable hardware signature checking.

Signed-off-by: Shaohua Li <shaohua.li@intel.com>
Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 Documentation/kernel-parameters.txt |    4 +++-
 arch/x86/kernel/acpi/sleep.c        |    2 ++
 drivers/acpi/sleep/main.c           |   22 ++++++++++++++++++++++
 include/linux/acpi.h                |    1 +
 4 files changed, 28 insertions(+), 1 deletion(-)

Index: linux-next/drivers/acpi/sleep/main.c
===================================================================
--- linux-next.orig/drivers/acpi/sleep/main.c
+++ linux-next/drivers/acpi/sleep/main.c
@@ -283,6 +283,15 @@ static struct platform_suspend_ops acpi_
 #endif /* CONFIG_SUSPEND */
 
 #ifdef CONFIG_HIBERNATION
+static unsigned long s4_hardware_signature;
+static struct acpi_table_facs *facs;
+static bool nosigcheck;
+
+void __init acpi_no_s4_hw_signature(void)
+{
+	nosigcheck = true;
+}
+
 static int acpi_hibernation_begin(void)
 {
 	acpi_target_sleep_state = ACPI_STATE_S4;
@@ -316,6 +325,12 @@ static void acpi_hibernation_leave(void)
 	acpi_enable();
 	/* Reprogram control registers and execute _BFS */
 	acpi_leave_sleep_state_prep(ACPI_STATE_S4);
+	/* Check the hardware signature */
+	if (facs && s4_hardware_signature != facs->hardware_signature) {
+		printk(KERN_EMERG "ACPI: Hardware changed while hibernated, "
+			"cannot resume!\n");
+		panic("ACPI S4 hardware signature mismatch");
+	}
 }
 
 static void acpi_pm_enable_gpes(void)
@@ -544,6 +559,13 @@ int __init acpi_sleep_init(void)
 			&acpi_hibernation_ops_old : &acpi_hibernation_ops);
 		sleep_states[ACPI_STATE_S4] = 1;
 		printk(" S4");
+		if (!nosigcheck) {
+			acpi_get_table_by_index(ACPI_TABLE_INDEX_FACS,
+				(struct acpi_table_header **)&facs);
+			if (facs)
+				s4_hardware_signature =
+					facs->hardware_signature;
+		}
 	}
 #endif
 	status = acpi_get_sleep_type_data(ACPI_STATE_S5, &type_a, &type_b);
Index: linux-next/Documentation/kernel-parameters.txt
===================================================================
--- linux-next.orig/Documentation/kernel-parameters.txt
+++ linux-next/Documentation/kernel-parameters.txt
@@ -147,10 +147,12 @@ and is between 256 and 4096 characters. 
 			default: 0
 
 	acpi_sleep=	[HW,ACPI] Sleep options
-			Format: { s3_bios, s3_mode, s3_beep, old_ordering }
+			Format: { s3_bios, s3_mode, s3_beep, s4_nohwsig, old_ordering }
 			See Documentation/power/video.txt for s3_bios and s3_mode.
 			s3_beep is for debugging; it makes the PC's speaker beep
 			as soon as the kernel's real-mode entry point is called.
+			s4_nohwsig prevents ACPI hardware signature from being
+			used during resume from hibernation.
 			old_ordering causes the ACPI 1.0 ordering of the _PTS
 			control method, wrt putting devices into low power
 			states, to be enforced (the ACPI 2.0 ordering of _PTS is
Index: linux-next/arch/x86/kernel/acpi/sleep.c
===================================================================
--- linux-next.orig/arch/x86/kernel/acpi/sleep.c
+++ linux-next/arch/x86/kernel/acpi/sleep.c
@@ -142,6 +142,8 @@ static int __init acpi_sleep_setup(char 
 			acpi_realmode_flags |= 2;
 		if (strncmp(str, "s3_beep", 7) == 0)
 			acpi_realmode_flags |= 4;
+		if (strncmp(str, "s4_nohwsig", 10) == 0)
+			acpi_no_s4_hw_signature();
 		if (strncmp(str, "old_ordering", 12) == 0)
 			acpi_old_suspend_ordering();
 		str = strchr(str, ',');
Index: linux-next/include/linux/acpi.h
===================================================================
--- linux-next.orig/include/linux/acpi.h
+++ linux-next/include/linux/acpi.h
@@ -236,6 +236,7 @@ int acpi_check_mem_region(resource_size_
 		      const char *name);
 
 #ifdef CONFIG_PM_SLEEP
+void __init acpi_no_s4_hw_signature(void);
 void __init acpi_old_suspend_ordering(void);
 #endif /* CONFIG_PM_SLEEP */
 #else	/* CONFIG_ACPI */
