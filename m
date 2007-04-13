From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH v4] pm_ops: add system quiesce/activate hooks
Date: Fri, 13 Apr 2007 15:26:59 +0200
Message-ID: <1176470819.7052.108.camel@johannes.berg>
References: <1175810054.3489.34.camel@johannes.berg>
	<1176454756.7052.98.camel@johannes.berg>
	<1176455273.5764.74.camel@localhost.localdomain>
	<200704131347.30001.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200704131347.30001.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pm@lists.linux-foundation.org, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

For powermac, we need to do some things between suspending devices and
device_power_off, for example setting the decrementer. This patch
introduces pm_ops.quiesce and pm_ops.activate which will be called instead
of disabling/enabling irqs so platforms get control over this step.

If not assigned, these two calls will be assigned with defaults during
set_pm_ops.

Signed-off-by: Johannes Berg <johannes@sipsolutions.net>

---
 include/linux/pm.h  |   12 ++++++++++++
 kernel/power/main.c |   35 ++++++++++++++++++++++++++++++++---
 2 files changed, 44 insertions(+), 3 deletions(-)

--- wireless-dev.orig/include/linux/pm.h	2007-04-13 10:09:17.835356880 +0200
+++ wireless-dev/include/linux/pm.h	2007-04-13 14:57:01.525356880 +0200
@@ -135,9 +135,19 @@ typedef int __bitwise suspend_disk_metho
  * @prepare: Prepare the platform for the given suspend state. Can return a
  *	negative error code if necessary.
  *
+ * @quiesce: This callback is called after devices are suspended but before
+ *	they are powered down. If assigned, this callback must at least turn
+ *	off local IRQs. If left unassigned, a default callback that does
+ *	nothing but turn off local IRQs is assigned during pm_set_ops().
+ *
  * @enter: Enter the given suspend state, must be assigned. Can return a
  *	negative error code if necessary.
  *
+ * @activate: This callback is called after devices are powered up but
+ *	before they resume. If assigned, this callback must at least turn
+ *	on local IRQs. If left unassigned, a default callback that does
+ *	nothing but turn on local IRQs is assigned during pm_set_ops().
+ *
  * @finish: Called when the system has left the given state and all devices
  *	are resumed. The return value is ignored.
  *
@@ -155,7 +165,9 @@ typedef int __bitwise suspend_disk_metho
 struct pm_ops {
 	int (*valid)(suspend_state_t state);
 	int (*prepare)(suspend_state_t state);
+	void (*quiesce)(suspend_state_t state);
 	int (*enter)(suspend_state_t state);
+	void (*activate)(suspend_state_t state);
 	int (*finish)(suspend_state_t state);
 	suspend_disk_method_t pm_disk_mode;
 };
--- wireless-dev.orig/kernel/power/main.c	2007-04-13 10:09:17.835356880 +02=
00
+++ wireless-dev/kernel/power/main.c	2007-04-13 14:53:44.975356880 +0200
@@ -33,6 +33,28 @@ struct pm_ops *pm_ops;
 suspend_disk_method_t pm_disk_mode =3D PM_DISK_SHUTDOWN;
 =

 /**
+ * pm_default_quiesce - default quiesce callback
+ *
+ * pm_ops drivers that need to do nothing but disable IRQs
+ * leave .quiesce unassigned and pm_set_ops() assigns this.
+ */
+static void pm_default_quiesce(suspend_state_t state)
+{
+	local_irq_disable();
+}
+
+/**
+ * pm_default_activate - default activate callback
+ *
+ * pm_ops drivers that need to do nothing but enable IRQs
+ * leave .activate unassigned and pm_set_ops assigns this.
+ */
+static void pm_default_activate(suspend_state_t state)
+{
+	local_irq_enable();
+}
+
+/**
  *	pm_set_ops - Set the global power method table. =

  *	@ops:	Pointer to ops structure.
  */
@@ -45,6 +67,12 @@ void pm_set_ops(struct pm_ops * ops)
 		pm_disk_mode =3D ops->pm_disk_mode;
 	} else
 		pm_disk_mode =3D PM_DISK_SHUTDOWN;
+
+	if (!ops->quiesce)
+		ops->quiesce =3D pm_default_quiesce;
+	if (!ops->activate)
+		ops->activate =3D pm_default_activate;
+
 	mutex_unlock(&pm_mutex);
 }
 =

@@ -132,9 +160,9 @@ static int suspend_prepare(suspend_state
 int suspend_enter(suspend_state_t state)
 {
 	int error =3D 0;
-	unsigned long flags;
 =

-	local_irq_save(flags);
+	pm_ops->quiesce(state);
+	BUG_ON(!irqs_disabled());
 =

 	if ((error =3D device_power_down(PMSG_SUSPEND))) {
 		printk(KERN_ERR "Some devices failed to power down\n");
@@ -143,7 +171,8 @@ int suspend_enter(suspend_state_t state)
 	error =3D pm_ops->enter(state);
 	device_power_up();
  Done:
-	local_irq_restore(flags);
+	pm_ops->activate(state);
+	BUG_ON(irqs_disabled());
 	return error;
 }
 =
