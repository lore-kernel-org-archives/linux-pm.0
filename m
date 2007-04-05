From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH] pm_ops: add irq enable/disable hooks
Date: Thu, 05 Apr 2007 23:54:14 +0200
Message-ID: <1175810054.3489.34.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
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
To: linux-pm <linux-pm@lists.osdl.org>
Cc: Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

For powermac, we need to do some things between suspending devices and
device_power_off, for example setting the decrementer. This patch
introduces pm_ops.irq_off and pm_ops.irq_on which will be called instead
of disabling/enabling irqs so platforms can do a bit more work there if
necessary.

Signed-off-by: Johannes Berg <johannes@sipsolutions.net>

---
My previous patches moving to the pm_ops interface for powermac were
buggy due to exactly this issue, but the bug never surfaced on my
machine, only on machines with an Apple Desktop Bus (or an emulation
thereof)

Does this look ok to you? Would you want different names? Should I stick
in a BUG_ON(interrupts_enabled()) or such?

 include/linux/pm.h  |   10 ++++++++++
 kernel/power/main.c |   10 ++++++++--
 2 files changed, 18 insertions(+), 2 deletions(-)

--- wireless-dev.orig/include/linux/pm.h	2007-04-05 18:14:07.948549941 +0200
+++ wireless-dev/include/linux/pm.h	2007-04-05 23:15:29.934829459 +0200
@@ -131,9 +131,17 @@ typedef int __bitwise suspend_disk_metho
  * @prepare: Prepare the platform for the given suspend state. Can return a
  *	negative error code if necessary.
  *
+ * @irq_off: If assigned, the generic suspend code does not turn off IRQs
+ *	but relies on this callback instead. It is currently not called for
+ *	%PM_SUSPEND_DISK.
+ *
  * @enter: Enter the given suspend state, must be assigned. Can return a
  *	negative error code if necessary.
  *
+ * @irq_on: If assigned, the generic suspend code does not turn on IRQs
+ *	but relies on this callback instead. It is currently not called for
+ *	%PM_SUSPEND_DISK.
+ *
  * @finish: Called when the system has left the given state and all devices
  *	are resumed. The return value is ignored.
  *
@@ -152,7 +160,9 @@ typedef int __bitwise suspend_disk_metho
 struct pm_ops {
 	int (*valid)(suspend_state_t state);
 	int (*prepare)(suspend_state_t state);
+	void (*irq_off)(suspend_state_t state);
 	int (*enter)(suspend_state_t state);
+	void (*irq_on)(suspend_state_t state);
 	int (*finish)(suspend_state_t state);
 	suspend_disk_method_t pm_disk_mode;
 };
--- wireless-dev.orig/kernel/power/main.c	2007-04-05 18:14:07.988549941 +02=
00
+++ wireless-dev/kernel/power/main.c	2007-04-05 18:25:21.108549941 +0200
@@ -117,7 +117,10 @@ int suspend_enter(suspend_state_t state)
 	int error =3D 0;
 	unsigned long flags;
 =

-	local_irq_save(flags);
+	if (pm_ops->irq_off)
+		pm_ops->irq_off(state);
+	else
+		local_irq_save(flags);
 =

 	if ((error =3D device_power_down(PMSG_SUSPEND))) {
 		printk(KERN_ERR "Some devices failed to power down\n");
@@ -126,7 +129,10 @@ int suspend_enter(suspend_state_t state)
 	error =3D pm_ops->enter(state);
 	device_power_up();
  Done:
-	local_irq_restore(flags);
+	if (pm_ops->irq_on)
+		pm_ops->irq_on(state);
+	else
+		local_irq_restore(flags);
 	return error;
 }
 =
