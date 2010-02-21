From: Brian King <brking@linux.vnet.ibm.com>
Subject: [PATCH 1/1] PM: Add arch_suspend_disable_nonboot_cpus
Date: Sun, 21 Feb 2010 10:32:02 -0600
Message-ID: <201002211631.o1LGVsw8022630@d01av02.pok.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: len.brown@intel.com
Cc: brking@linux.vnet.ibm.com, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org


Rather than calling disable_nonboot_cpus and enable_nonboot_cpus
directly, wrapper the calls in a weak arch_suspend_disable_nonboot_cpus
and arch_suspend_enable_nonboot_cpus that can be overridden by
architectures that require different handling of suspending processors
at suspend time than these functions provide. This is needed to enable
suspend/resume on IBM Power servers.

Signed-off-by: Brian King <brking@linux.vnet.ibm.com>
---

 include/linux/suspend.h |   18 ++++++++++++++++++
 kernel/power/suspend.c  |   14 ++++++++++++--
 2 files changed, 30 insertions(+), 2 deletions(-)

diff -puN kernel/power/suspend.c~suspend_arch_smp kernel/power/suspend.c
--- linux-2.6/kernel/power/suspend.c~suspend_arch_smp	2010-02-17 09:46:59.000000000 -0600
+++ linux-2.6-bjking1/kernel/power/suspend.c	2010-02-17 09:46:59.000000000 -0600
@@ -116,6 +116,16 @@ void __attribute__ ((weak)) arch_suspend
 	local_irq_enable();
 }
 
+int __attribute__ ((weak)) arch_suspend_disable_nonboot_cpus(void)
+{
+	return disable_nonboot_cpus();
+}
+
+void __attribute__ ((weak)) arch_suspend_enable_nonboot_cpus(void)
+{
+	return enable_nonboot_cpus();
+}
+
 /**
  *	suspend_enter - enter the desired system sleep state.
  *	@state:		state to enter
@@ -147,7 +157,7 @@ static int suspend_enter(suspend_state_t
 	if (suspend_test(TEST_PLATFORM))
 		goto Platform_wake;
 
-	error = disable_nonboot_cpus();
+	error = arch_suspend_disable_nonboot_cpus();
 	if (error || suspend_test(TEST_CPUS))
 		goto Enable_cpus;
 
@@ -165,7 +175,7 @@ static int suspend_enter(suspend_state_t
 	BUG_ON(irqs_disabled());
 
  Enable_cpus:
-	enable_nonboot_cpus();
+	arch_suspend_enable_nonboot_cpus();
 
  Platform_wake:
 	if (suspend_ops->wake)
diff -puN include/linux/suspend.h~suspend_arch_smp include/linux/suspend.h
--- linux-2.6/include/linux/suspend.h~suspend_arch_smp	2010-02-17 09:46:59.000000000 -0600
+++ linux-2.6-bjking1/include/linux/suspend.h	2010-02-17 09:46:59.000000000 -0600
@@ -141,6 +141,24 @@ extern void arch_suspend_disable_irqs(vo
  */
 extern void arch_suspend_enable_irqs(void);
 
+/**
+ * arch_suspend_disable_nonboot_cpus - disable non boot for suspend
+ *
+ * Disables non boot CPUs (in the default case). This is a weak symbol in the common
+ * code and thus allows architectures to override it if more needs to be
+ * done. Not called for suspend to disk.
+ */
+extern int arch_suspend_disable_nonboot_cpus(void);
+
+/**
+ * arch_suspend_enable_nonboot_cpus - enable non boot after suspend
+ *
+ * Enables non boot CPUs (in the default case). This is a weak symbol in the common
+ * code and thus allows architectures to override it if more needs to be
+ * done. Not called for suspend to disk.
+ */
+extern void arch_suspend_enable_nonboot_cpus(void);
+
 extern int pm_suspend(suspend_state_t state);
 #else /* !CONFIG_SUSPEND */
 #define suspend_valid_only_mem	NULL
_
