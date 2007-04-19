From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH] s2ram: add arch irq disable/enable hooks
Date: Thu, 19 Apr 2007 13:00:11 +0200
Message-ID: <1176980411.6141.83.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain
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
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-pm <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

For powermac, we need to do some things between suspending devices and
device_power_off, for example setting the decrementer. This patch
allows architectures to define arch_s2ram_{en,dis}able_irqs in their
asm/suspend.h to have control over this step.

Signed-off-by: Johannes Berg <johannes@sipsolutions.net>

---
 kernel/power/main.c |   14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

--- wireless-dev.orig/kernel/power/main.c	2007-04-17 18:52:24.536830941 +0200
+++ wireless-dev/kernel/power/main.c	2007-04-17 19:09:40.966830941 +0200
@@ -128,13 +128,22 @@ static int suspend_prepare(suspend_state
 	return error;
 }
 
+#ifndef arch_s2ram_disable_irqs
+#define arch_s2ram_disable_irqs(flags) local_irq_save(*flags)
+#endif
+
+#ifndef arch_s2ram_enable_irqs
+#define arch_s2ram_enable_irqs(flags) local_irq_restore(*flags)
+#endif
+
 
 int suspend_enter(suspend_state_t state)
 {
 	int error = 0;
 	unsigned long flags;
 
-	local_irq_save(flags);
+	arch_s2ram_disable_irqs(&flags);
+	BUG_ON(!irqs_disabled());
 
 	if ((error = device_power_down(PMSG_SUSPEND))) {
 		printk(KERN_ERR "Some devices failed to power down\n");
@@ -143,7 +152,8 @@ int suspend_enter(suspend_state_t state)
 	error = pm_ops->enter(state);
 	device_power_up();
  Done:
-	local_irq_restore(flags);
+	arch_s2ram_enable_irqs(&flags);
+	BUG_ON(irqs_disabled());
 	return error;
 }
 
