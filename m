From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFC][PATCH 1/2] ACPI PM: Remove obsolete Toshiba
	workaround
Date: Fri, 9 May 2008 19:21:47 +0200
Message-ID: <200805091921.47902.rjw__28824.9417594217$1210354027$gmane$org@sisk.pl>
References: <200805062342.42789.rjw@sisk.pl> <200805071421.19788.rjw@sisk.pl>
	<200805091920.27756.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200805091920.27756.rjw@sisk.pl>
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
To: Pavel Machek <pavel@suse.cz>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Jesse Barnes <jbarnes@virtuousgeek.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

Remove an obsolete workaround for a Toshiba Satellite 4030cdt
S1 problem from drivers/acpi/sleep/main.c .

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/acpi/sleep/main.c |   31 -------------------------------
 1 file changed, 31 deletions(-)

Index: linux-2.6/drivers/acpi/sleep/main.c
===================================================================
--- linux-2.6.orig/drivers/acpi/sleep/main.c
+++ linux-2.6/drivers/acpi/sleep/main.c
@@ -62,8 +62,6 @@ static u32 acpi_suspend_states[] = {
 	[PM_SUSPEND_MAX] = ACPI_STATE_S5
 };
 
-static int init_8259A_after_S1;
-
 /**
  *	acpi_suspend_begin - Set the target system sleep state to the state
  *		associated with given @pm_state, if supported.
@@ -186,13 +184,6 @@ static void acpi_suspend_finish(void)
 	acpi_set_firmware_waking_vector((acpi_physical_address) 0);
 
 	acpi_target_sleep_state = ACPI_STATE_S0;
-
-#ifdef CONFIG_X86
-	if (init_8259A_after_S1) {
-		printk("Broken toshiba laptop -> kicking interrupts\n");
-		init_8259A(0);
-	}
-#endif
 }
 
 /**
@@ -232,26 +223,6 @@ static struct platform_suspend_ops acpi_
 	.finish = acpi_suspend_finish,
 	.end = acpi_suspend_end,
 };
-
-/*
- * Toshiba fails to preserve interrupts over S1, reinitialization
- * of 8259 is needed after S1 resume.
- */
-static int __init init_ints_after_s1(const struct dmi_system_id *d)
-{
-	printk(KERN_WARNING "%s with broken S1 detected.\n", d->ident);
-	init_8259A_after_S1 = 1;
-	return 0;
-}
-
-static struct dmi_system_id __initdata acpisleep_dmi_table[] = {
-	{
-	 .callback = init_ints_after_s1,
-	 .ident = "Toshiba Satellite 4030cdt",
-	 .matches = {DMI_MATCH(DMI_PRODUCT_NAME, "S4030CDT/4.3"),},
-	 },
-	{},
-};
 #endif /* CONFIG_SUSPEND */
 
 #ifdef CONFIG_HIBERNATION
@@ -490,8 +461,6 @@ int __init acpi_sleep_init(void)
 	u8 type_a, type_b;
 #ifdef CONFIG_SUSPEND
 	int i = 0;
-
-	dmi_check_system(acpisleep_dmi_table);
 #endif
 
 	if (acpi_disabled)
