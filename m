From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH] s2ram: add arch irq disable/enable hooks
Date: Fri, 20 Apr 2007 21:37:18 +0200
Message-ID: <1177097838.5902.10.camel@johannes.berg>
References: <1176980411.6141.83.camel@johannes.berg>
	<20070420065731.GA5831@kroah.com>
	<1177083093.5902.3.camel@johannes.berg>
	<20070420173951.GB14778@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070420173951.GB14778@kroah.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Greg KH <greg@kroah.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-pm <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

Thanks. Does this look good?

Haven't tested it yet but I don't see a reason it shouldn't work for me.

Sparse will probably complain about this, should I define them
somewhere?

---
 kernel/power/main.c |   27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

--- wireless-dev.orig/kernel/power/main.c	2007-04-20 21:34:01.531107385 +0200
+++ wireless-dev/kernel/power/main.c	2007-04-20 21:34:02.141107385 +0200
@@ -128,13 +128,35 @@ static int suspend_prepare(suspend_state
 	return error;
 }
 
+/**
+ * arch_s2ram_disable_irqs - disable IRQs for suspend
+ *
+ * Disables IRQs (in the default case) and allows architectures
+ * to override it if more needs to be done.
+ */
+void __attribute__ ((weak)) arch_s2ram_disable_irqs(unsigned long *flags)
+{
+	local_irq_save(*flags);
+}
+
+/**
+ * arch_s2ram_enable_irqs - enable IRQs after suspend
+ *
+ * Enables IRQs (in the default case) and allows architectures
+ * to override it if more needs to be done.
+ */
+void __attribute__ ((weak)) arch_s2ram_enable_irqs(unsigned long *flags)
+{
+	local_irq_restore(*flags);
+}
 
 int suspend_enter(suspend_state_t state)
 {
 	int error = 0;
 	unsigned long flags;
 
-	local_irq_save(flags);
+	arch_s2ram_disable_irqs(&flags);
+	BUG_ON(!irqs_disabled());
 
 	if ((error = device_power_down(PMSG_SUSPEND))) {
 		printk(KERN_ERR "Some devices failed to power down\n");
@@ -143,7 +165,8 @@ int suspend_enter(suspend_state_t state)
 	error = pm_ops->enter(state);
 	device_power_up();
  Done:
-	local_irq_restore(flags);
+	arch_s2ram_enable_irqs(&flags);
+	BUG_ON(irqs_disabled());
 	return error;
 }
 
