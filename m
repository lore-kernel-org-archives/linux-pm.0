From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 1/5] ACPI / PM: Move references to pm_flags into
	sleep.c
Date: Tue, 8 Feb 2011 22:20:24 +0100
Message-ID: <201102082220.25240.rjw__41713.3210729391$1297200520$gmane$org@sisk.pl>
References: <1297081335-13631-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<20110208122159.GA8284@elte.hu> <201102082218.28015.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201102082218.28015.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Ingo Molnar <mingo@elte.hu>
Cc: Len Brown <len.brown@intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, linux-embedded@vger.kernel.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

If direct references to pm_flags are moved from bus.c to sleep.c,
CONFIG_ACPI will not need to depend on CONFIG_PM any more.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/acpi/Kconfig    |    1 -
 drivers/acpi/bus.c      |    4 +---
 drivers/acpi/internal.h |    6 ++++++
 drivers/acpi/sleep.c    |   12 ++++++++++++
 4 files changed, 19 insertions(+), 4 deletions(-)

Index: linux-2.6/drivers/acpi/bus.c
===================================================================
--- linux-2.6.orig/drivers/acpi/bus.c
+++ linux-2.6/drivers/acpi/bus.c
@@ -1025,9 +1025,7 @@ static int __init acpi_init(void)
 
 	if (!result) {
 		pci_mmcfg_late_init();
-		if (!(pm_flags & PM_APM))
-			pm_flags |= PM_ACPI;
-		else {
+		if (!acpi_pm_enabled()) {
 			printk(KERN_INFO PREFIX
 			       "APM is already active, exiting\n");
 			disable_acpi();
Index: linux-2.6/drivers/acpi/internal.h
===================================================================
--- linux-2.6.orig/drivers/acpi/internal.h
+++ linux-2.6/drivers/acpi/internal.h
@@ -82,12 +82,18 @@ void acpi_ec_unblock_transactions_early(
 extern int acpi_sleep_init(void);
 
 #ifdef CONFIG_ACPI_SLEEP
+/* drivers/acpi/sleep.c */
+bool acpi_pm_enabled(void);
+
+/* drivers/acpi/nvs.c */
 int acpi_sleep_proc_init(void);
 int suspend_nvs_alloc(void);
 void suspend_nvs_free(void);
 int suspend_nvs_save(void);
 void suspend_nvs_restore(void);
 #else
+static inline bool acpi_pm_enabled(void) { return true; }
+
 static inline int acpi_sleep_proc_init(void) { return 0; }
 static inline int suspend_nvs_alloc(void) { return 0; }
 static inline void suspend_nvs_free(void) {}
Index: linux-2.6/drivers/acpi/sleep.c
===================================================================
--- linux-2.6.orig/drivers/acpi/sleep.c
+++ linux-2.6/drivers/acpi/sleep.c
@@ -657,6 +657,18 @@ int acpi_pm_device_sleep_state(struct de
 
 #ifdef CONFIG_PM_SLEEP
 /**
+ *
+ */
+bool acpi_pm_enabled(void)
+{
+	if (!(pm_flags & PM_APM)) {
+		pm_flags |= PM_ACPI;
+		return true;
+	}
+	return false;
+}
+
+/**
  *	acpi_pm_device_sleep_wake - enable or disable the system wake-up
  *                                  capability of given device
  *	@dev: device to handle
Index: linux-2.6/drivers/acpi/Kconfig
===================================================================
--- linux-2.6.orig/drivers/acpi/Kconfig
+++ linux-2.6/drivers/acpi/Kconfig
@@ -7,7 +7,6 @@ menuconfig ACPI
 	depends on !IA64_HP_SIM
 	depends on IA64 || X86
 	depends on PCI
-	depends on PM
 	select PNP
 	default y
 	help
