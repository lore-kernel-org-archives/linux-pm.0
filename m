From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: [PATCH 3/7] x86/acpi/sleep: Provide registration for
	acpi_suspend_lowlevel.
Date: Wed, 31 Aug 2011 14:31:20 -0400
Message-ID: <1314815484-4668-4-git-send-email-konrad.wilk__34004.7090816826$1314918889$gmane$org@oracle.com>
References: <1314815484-4668-1-git-send-email-konrad.wilk@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1314815484-4668-1-git-send-email-konrad.wilk@oracle.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: x86@kernel.org, tglx@linutronix.de, tboot-devel@lists.sourceforge.net, shane.wang@intel.com, linux-pm@lists.linux-foundation.org, linux-acpi@vger.kernel.org, len.brown@in
Cc: xen-devel@lists.xensource.com, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
List-Id: linux-pm@vger.kernel.org

From: Liang Tang <liang.tang@oracle.com>

Which by default will be x86_acpi_suspend_lowlevel.
This registration allows us to register another callback
if there is a need to use another platform specific callback.

CC: Thomas Gleixner <tglx@linutronix.de>
CC: "H. Peter Anvin" <hpa@zytor.com>
CC: x86@kernel.org
CC: Len Brown <len.brown@intel.com>
CC: Joseph Cihula <joseph.cihula@intel.com>
CC: Shane Wang <shane.wang@intel.com>
CC: linux-pm@lists.linux-foundation.org
CC: linux-acpi@vger.kernel.org
CC: Len Brown <len.brown@intel.com>
Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Signed-off-by: Liang Tang <liang.tang@oracle.com>
---
 arch/x86/include/asm/acpi.h  |    2 +-
 arch/x86/kernel/acpi/boot.c  |    2 ++
 arch/x86/kernel/acpi/sleep.c |    4 ++--
 arch/x86/kernel/acpi/sleep.h |    2 ++
 drivers/acpi/sleep.c         |    2 ++
 5 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/acpi.h b/arch/x86/include/asm/acpi.h
index 49864a1..a5f0b73 100644
--- a/arch/x86/include/asm/acpi.h
+++ b/arch/x86/include/asm/acpi.h
@@ -118,7 +118,7 @@ static inline void acpi_disable_pci(void)
 }
 
 /* Low-level suspend routine. */
-extern int acpi_suspend_lowlevel(void);
+extern int (*acpi_suspend_lowlevel)(void);
 
 extern const unsigned char acpi_wakeup_code[];
 #define acpi_wakeup_address (__pa(TRAMPOLINE_SYM(acpi_wakeup_code)))
diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index d191b4c..92f4f38 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -44,6 +44,7 @@
 #include <asm/mpspec.h>
 #include <asm/smp.h>
 
+#include "sleep.h" /* To include x86_acpi_suspend_lowlevel */
 static int __initdata acpi_force = 0;
 u32 acpi_rsdt_forced;
 int acpi_disabled;
@@ -555,6 +556,7 @@ int (*__acpi_register_gsi)(struct device *dev, u32 gsi,
 int (*__acpi_override_sleep)(u8 sleep_state, u32 pm1a_ctrl,
 			     u32 pm1b_ctrl, bool *skip_rest) = NULL;
 
+int (*acpi_suspend_lowlevel)(void) = x86_acpi_suspend_lowlevel;
 /*
  * success: return IRQ number (>=0)
  * failure: return < 0
diff --git a/arch/x86/kernel/acpi/sleep.c b/arch/x86/kernel/acpi/sleep.c
index 103b6ab..4d2d0b1 100644
--- a/arch/x86/kernel/acpi/sleep.c
+++ b/arch/x86/kernel/acpi/sleep.c
@@ -25,12 +25,12 @@ static char temp_stack[4096];
 #endif
 
 /**
- * acpi_suspend_lowlevel - save kernel state
+ * x86_acpi_suspend_lowlevel - save kernel state
  *
  * Create an identity mapped page table and copy the wakeup routine to
  * low memory.
  */
-int acpi_suspend_lowlevel(void)
+int x86_acpi_suspend_lowlevel(void)
 {
 	struct wakeup_header *header;
 	/* address in low memory of the wakeup routine. */
diff --git a/arch/x86/kernel/acpi/sleep.h b/arch/x86/kernel/acpi/sleep.h
index 416d4be..4d3feb5 100644
--- a/arch/x86/kernel/acpi/sleep.h
+++ b/arch/x86/kernel/acpi/sleep.h
@@ -13,3 +13,5 @@ extern unsigned long acpi_copy_wakeup_routine(unsigned long);
 extern void wakeup_long64(void);
 
 extern void do_suspend_lowlevel(void);
+
+extern int x86_acpi_suspend_lowlevel(void);
diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
index 6c94960..a6da454 100644
--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
@@ -254,6 +254,8 @@ static int acpi_suspend_enter(suspend_state_t pm_state)
 		break;
 
 	case ACPI_STATE_S3:
+		if (!acpi_suspend_lowlevel)
+			return -ENODEV;
 		error = acpi_suspend_lowlevel();
 		if (error)
 			return error;
-- 
1.7.4.1
