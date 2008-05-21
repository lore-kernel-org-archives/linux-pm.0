From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 1/7] ACPI Hibernation: Use ACPI hardware
	signature (rev. 2)
Date: Wed, 21 May 2008 23:16:00 +0200
Message-ID: <200805212316.01025.rjw__11258.2270092846$1211404685$gmane$org@sisk.pl>
References: <200805200129.19904.rjw@sisk.pl> <20080520151748.GA2067@elf.ucw.cz>
	<200805202151.11448.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200805202151.11448.rjw@sisk.pl>
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
To: Pavel Machek <pavel@suse.cz>, Len Brown <lenb@kernel.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Tuesday, 20 of May 2008, Rafael J. Wysocki wrote:
> On Tuesday, 20 of May 2008, Pavel Machek wrote:
> > Hi!
> > 
> > > From: Shaohua Li <shaohua.li@intel.com>
> > > 
> > > ACPI defines a hardware signature. BIOS calculates the signature
> > > according to hardware configure, if hardware changes, the signature
> > > will change, in this case, S4 resume should fail.
> > > 
> > > Signed-off-by: Shaohua Li <shaohua.li@intel.com>
> > > Acked-by: Pavel Machek <pavel@suse.cz>
> > > Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> > 
> > I guess I'm quite late to the party, but... could we make this use
> > acpi_sleep= command line option, and related variable?
> > 
> > That brings advantage of existing /proc/sys interface, so that s2disk
> > could do blacklist in userspace, and easily...
> 
> If I have the time.

Okay, patch reworked.

Len, please disregard the previous version, the current one is appended.

Thanks,
Rafael

---
From: Shaohua Li <shaohua.li@intel.com>

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
 include/linux/acpi.h                |    3 +++
 4 files changed, 30 insertions(+), 1 deletion(-)

Index: linux-2.6/drivers/acpi/sleep/main.c
===================================================================
--- linux-2.6.orig/drivers/acpi/sleep/main.c
+++ linux-2.6/drivers/acpi/sleep/main.c
@@ -255,6 +255,15 @@ static struct dmi_system_id __initdata a
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
@@ -301,6 +310,12 @@ static void acpi_hibernation_leave(void)
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
 
 static void acpi_hibernation_finish(void)
@@ -501,6 +516,13 @@ int __init acpi_sleep_init(void)
 		hibernation_set_ops(&acpi_hibernation_ops);
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
Index: linux-2.6/Documentation/kernel-parameters.txt
===================================================================
--- linux-2.6.orig/Documentation/kernel-parameters.txt
+++ linux-2.6/Documentation/kernel-parameters.txt
@@ -147,10 +147,12 @@ and is between 256 and 4096 characters. 
 			default: 0
 
 	acpi_sleep=	[HW,ACPI] Sleep options
-			Format: { s3_bios, s3_mode, s3_beep }
+			Format: { s3_bios, s3_mode, s3_beep, s4_nohwsig }
 			See Documentation/power/video.txt for s3_bios and s3_mode.
 			s3_beep is for debugging; it makes the PC's speaker beep
 			as soon as the kernel's real-mode entry point is called.
+			s4_nohwsig prevents ACPI hardware signature from being
+			used during resume from hibernation.
 
 	acpi_sci=	[HW,ACPI] ACPI System Control Interrupt trigger mode
 			Format: { level | edge | high | low }
Index: linux-2.6/arch/x86/kernel/acpi/sleep.c
===================================================================
--- linux-2.6.orig/arch/x86/kernel/acpi/sleep.c
+++ linux-2.6/arch/x86/kernel/acpi/sleep.c
@@ -124,6 +124,8 @@ static int __init acpi_sleep_setup(char 
 			acpi_realmode_flags |= 2;
 		if (strncmp(str, "s3_beep", 7) == 0)
 			acpi_realmode_flags |= 4;
+		if (strncmp(str, "s4_nohwsig", 10) == 0)
+			acpi_no_s4_hw_signature();
 		str = strchr(str, ',');
 		if (str != NULL)
 			str += strspn(str, ", \t");
Index: linux-2.6/include/linux/acpi.h
===================================================================
--- linux-2.6.orig/include/linux/acpi.h
+++ linux-2.6/include/linux/acpi.h
@@ -234,6 +234,9 @@ int acpi_check_region(resource_size_t st
 int acpi_check_mem_region(resource_size_t start, resource_size_t n,
 		      const char *name);
 
+#ifdef CONFIG_PM_SLEEP
+void __init acpi_no_s4_hw_signature(void);
+#endif /* CONFIG_PM_SLEEP */
 #else	/* CONFIG_ACPI */
 
 static inline int early_acpi_boot_init(void)
