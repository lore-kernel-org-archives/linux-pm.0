From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH] s2ram: add arch irq disable/enable hooks
Date: Sat, 21 Apr 2007 15:57:33 +0200
Message-ID: <1177163853.5941.21.camel@johannes.berg>
References: <1176980411.6141.83.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1176980411.6141.83.camel@johannes.berg>
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
Cc: linux-pm <linux-pm@lists.osdl.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

For powermac, we need to do some things between suspending devices and
device_power_off, for example setting the decrementer. This patch allows
architectures to have arch_s2ram_{en,dis}able_irqs functions to control
this step.

This patch also replaces local_irq_save/restore with
local_irq_disable/enable since the code must be called with interrupts
enabled.

Signed-off-by: Johannes Berg <johannes@sipsolutions.net>

---
This version uses weak symbols instead of macros.

 kernel/power/main.c |   28 +++++++++++++++++++++++++---
 1 file changed, 25 insertions(+), 3 deletions(-)

--- wireless-dev.orig/kernel/power/main.c	2007-04-20 23:35:20.911107385 +0200
+++ wireless-dev/kernel/power/main.c	2007-04-20 23:35:21.511107385 +0200
@@ -128,13 +128,34 @@ static int suspend_prepare(suspend_state
 	return error;
 }
 
+/**
+ * arch_s2ram_disable_irqs - disable IRQs for suspend
+ *
+ * Disables IRQs (in the default case) and allows architectures
+ * to override it if more needs to be done.
+ */
+void __attribute__ ((weak)) arch_s2ram_disable_irqs(void)
+{
+	local_irq_disable();
+}
+
+/**
+ * arch_s2ram_enable_irqs - enable IRQs after suspend
+ *
+ * Enables IRQs (in the default case) and allows architectures
+ * to override it if more needs to be done.
+ */
+void __attribute__ ((weak)) arch_s2ram_enable_irqs(void)
+{
+	local_irq_enable();
+}
 
 int suspend_enter(suspend_state_t state)
 {
 	int error = 0;
-	unsigned long flags;
 
-	local_irq_save(flags);
+	arch_s2ram_disable_irqs();
+	BUG_ON(!irqs_disabled());
 
 	if ((error = device_power_down(PMSG_SUSPEND))) {
 		printk(KERN_ERR "Some devices failed to power down\n");
@@ -143,7 +164,8 @@ int suspend_enter(suspend_state_t state)
 	error = pm_ops->enter(state);
 	device_power_up();
  Done:
-	local_irq_restore(flags);
+	arch_s2ram_enable_irqs();
+	BUG_ON(irqs_disabled());
 	return error;
 }
 
