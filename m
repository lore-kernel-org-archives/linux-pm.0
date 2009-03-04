From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [Update,
	rev. 5] Re: [RFC][PATCH 1/4] PM: Rework handling of interrupts
	during suspend-resume (rev. 4)
Date: Wed, 4 Mar 2009 23:03:28 +0100
Message-ID: <200903042303.30357.rjw__39273.8903327428$1236204440$gmane$org@sisk.pl>
References: <200902221837.49396.rjw@sisk.pl> <200903030027.13884.rjw@sisk.pl>
	<d6200be20903031456r7caa3c42qa7c31dc74768449c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <d6200be20903031456r7caa3c42qa7c31dc74768449c@mail.gmail.com>
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
To: Arve =?iso-8859-1?q?Hj=F8nnev=E5g?= <arve@android.com>, Ingo Molnar <mingo@elte.hu>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Johannes Berg <johannes@sipsolutions.net>, "Eric W. Biederman" <ebiederm@xmission.com>, pm list <linux-pm@lists.linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-pm@vger.kernel.org

On Tuesday 03 March 2009, Arve Hj=F8nnev=E5g wrote:
> On Mon, Mar 2, 2009 at 3:27 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > On Tuesday 03 March 2009, Arve Hj=F8nnev=E5g wrote:
> >> On Mon, Mar 2, 2009 at 3:13 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> >> > On Tuesday 03 March 2009, Arve Hj=F8nnev=E5g wrote:
> >> >> On Sun, Mar 1, 2009 at 2:24 PM, Rafael J. Wysocki <rjw@sisk.pl> wro=
te:
[--snip--]
> > Can you show me a _single_ _driver_ currently in the tree doing somethi=
ng
> > like you describe in suspend_late and resume_early?  If you can't, then=
 please
> > give up.
> =

> I don't know if any drivers call disable_irq or enable_irq in their
> suspend hooks, but your change also allow timers, and I assume kernel
> threads, to run during this phase.
> =

> There are several drivers (keypad drivers in particular), in tree and
> out of tree, that call enable_irq from timers, and disable_irq from
> their interrupt handler. If you also apply your later change to
> disable non boot cpus after suspend_device_irqs, then on smp systems
> the interrupt handler may run at the same time as suspend_device_irqs.
> If suspend_device_irqs gets the spinlock first, then IRQ_SUSPENDED
> gets set. If another suspend/resume cycle happens before the timer
> runs, you will incorrectly enable the interrupt.

Well, unfortunately this is a valid point IMO.  I've been thinking for quit=
e a
while how to fix it nicely, but I'm not sure if there is a nice fix.

Below is an updated patch, hopefully everyone will be fine with it.

Ingo, is making __enable_irq() an extern function acceptable?

Rafael

---
From: Rafael J. Wysocki <rjw@sisk.pl>
Subject: PM: Rework handling of interrupts during suspend-resume (rev. 5)

Introduce two helper functions allowing us to prevent device drivers
from getting any interrupts (without disabling interrupts on the CPU)
during suspend (or hibernation) and to make them start to receive
interrupts again during the subsequent resume, respectively.  These
functions make it possible to keep timer interrupts enabled while the
"late" suspend and "early" resume callbacks provided by device
drivers are being executed.

Use these functions to rework the handling of interrupts during
suspend (hibernation) and resume.  Namely, interrupts will only be
disabled on the CPU right before suspending sysdevs, while device
drivers will be prevented from receiving interrupts, with the help of
the new helper function, before their "late" suspend callbacks run
(and analogously during resume).

In addition, since the device interrups are now disabled before the
CPU has turned all interrupts off and the CPU will ACK the interrupts
setting the IRQ_PENDING bit for them, check in sysdev_suspend() if
any wake-up interrupts are pending and abort suspend if that's the
case.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 arch/x86/kernel/apm_32.c  |   15 +++++--
 drivers/base/power/main.c |   20 +++++-----
 drivers/base/sys.c        |    8 ++++
 drivers/xen/manage.c      |   16 ++++----
 include/linux/interrupt.h |    5 ++
 include/linux/irq.h       |    1 =

 kernel/irq/Makefile       |    1 =

 kernel/irq/internals.h    |    1 =

 kernel/irq/manage.c       |    2 -
 kernel/irq/pm.c           |   89 +++++++++++++++++++++++++++++++++++++++++=
+++++
 kernel/kexec.c            |    8 ++--
 kernel/power/disk.c       |   39 ++++++++++++++------
 kernel/power/main.c       |   17 +++++---
 13 files changed, 181 insertions(+), 41 deletions(-)

Index: linux-2.6/include/linux/interrupt.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.orig/include/linux/interrupt.h
+++ linux-2.6/include/linux/interrupt.h
@@ -106,6 +106,11 @@ extern void disable_irq_nosync(unsigned =

 extern void disable_irq(unsigned int irq);
 extern void enable_irq(unsigned int irq);
 =

+/* The following three functions are for the core kernel use only. */
+extern void suspend_device_irqs(void);
+extern void resume_device_irqs(void);
+extern int check_wakeup_irqs(void);
+
 #if defined(CONFIG_SMP) && defined(CONFIG_GENERIC_HARDIRQS)
 =

 extern cpumask_var_t irq_default_affinity;
Index: linux-2.6/kernel/power/main.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.orig/kernel/power/main.c
+++ linux-2.6/kernel/power/main.c
@@ -287,17 +287,19 @@ void __attribute__ ((weak)) arch_suspend
  */
 static int suspend_enter(suspend_state_t state)
 {
-	int error =3D 0;
+	int error;
 =

 	device_pm_lock();
-	arch_suspend_disable_irqs();
-	BUG_ON(!irqs_disabled());
 =

-	if ((error =3D device_power_down(PMSG_SUSPEND))) {
+	error =3D device_power_down(PMSG_SUSPEND);
+	if (error) {
 		printk(KERN_ERR "PM: Some devices failed to power down\n");
 		goto Done;
 	}
 =

+	arch_suspend_disable_irqs();
+	BUG_ON(!irqs_disabled());
+
 	error =3D sysdev_suspend(PMSG_SUSPEND);
 	if (!error) {
 		if (!suspend_test(TEST_CORE))
@@ -305,11 +307,14 @@ static int suspend_enter(suspend_state_t
 		sysdev_resume();
 	}
 =

-	device_power_up(PMSG_RESUME);
- Done:
 	arch_suspend_enable_irqs();
 	BUG_ON(irqs_disabled());
+
+	device_power_up(PMSG_RESUME);
+
+ Done:
 	device_pm_unlock();
+
 	return error;
 }
 =

Index: linux-2.6/kernel/power/disk.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.orig/kernel/power/disk.c
+++ linux-2.6/kernel/power/disk.c
@@ -214,7 +214,7 @@ static int create_image(int platform_mod
 		return error;
 =

 	device_pm_lock();
-	local_irq_disable();
+
 	/* At this point, device_suspend() has been called, but *not*
 	 * device_power_down(). We *must* call device_power_down() now.
 	 * Otherwise, drivers for some devices (e.g. interrupt controllers)
@@ -225,8 +225,11 @@ static int create_image(int platform_mod
 	if (error) {
 		printk(KERN_ERR "PM: Some devices failed to power down, "
 			"aborting hibernation\n");
-		goto Enable_irqs;
+		goto Unlock;
 	}
+
+	local_irq_disable();
+
 	sysdev_suspend(PMSG_FREEZE);
 	if (error) {
 		printk(KERN_ERR "PM: Some devices failed to power down, "
@@ -252,12 +255,16 @@ static int create_image(int platform_mod
 	/* NOTE:  device_power_up() is just a resume() for devices
 	 * that suspended with irqs off ... no overall powerup.
 	 */
+
  Power_up_devices:
+	local_irq_enable();
+
 	device_power_up(in_suspend ?
 		(error ? PMSG_RECOVER : PMSG_THAW) : PMSG_RESTORE);
- Enable_irqs:
-	local_irq_enable();
+
+ Unlock:
 	device_pm_unlock();
+
 	return error;
 }
 =

@@ -336,13 +343,16 @@ static int resume_target_kernel(void)
 	int error;
 =

 	device_pm_lock();
-	local_irq_disable();
+
 	error =3D device_power_down(PMSG_QUIESCE);
 	if (error) {
 		printk(KERN_ERR "PM: Some devices failed to power down, "
 			"aborting resume\n");
-		goto Enable_irqs;
+		goto Unlock;
 	}
+
+	local_irq_disable();
+
 	sysdev_suspend(PMSG_QUIESCE);
 	/* We'll ignore saved state, but this gets preempt count (etc) right */
 	save_processor_state();
@@ -366,11 +376,16 @@ static int resume_target_kernel(void)
 	swsusp_free();
 	restore_processor_state();
 	touch_softlockup_watchdog();
+
 	sysdev_resume();
-	device_power_up(PMSG_RECOVER);
- Enable_irqs:
+
 	local_irq_enable();
+
+	device_power_up(PMSG_RECOVER);
+
+ Unlock:
 	device_pm_unlock();
+
 	return error;
 }
 =

@@ -447,15 +462,16 @@ int hibernation_platform_enter(void)
 		goto Finish;
 =

 	device_pm_lock();
-	local_irq_disable();
+
 	error =3D device_power_down(PMSG_HIBERNATE);
 	if (!error) {
+		local_irq_disable();
 		sysdev_suspend(PMSG_HIBERNATE);
 		hibernation_ops->enter();
 		/* We should never get here */
 		while (1);
 	}
-	local_irq_enable();
+
 	device_pm_unlock();
 =

 	/*
@@ -464,12 +480,15 @@ int hibernation_platform_enter(void)
 	 */
  Finish:
 	hibernation_ops->finish();
+
  Resume_devices:
 	entering_platform_hibernation =3D false;
 	device_resume(PMSG_RESTORE);
 	resume_console();
+
  Close:
 	hibernation_ops->end();
+
 	return error;
 }
 =

Index: linux-2.6/arch/x86/kernel/apm_32.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.orig/arch/x86/kernel/apm_32.c
+++ linux-2.6/arch/x86/kernel/apm_32.c
@@ -1190,8 +1190,10 @@ static int suspend(int vetoable)
 	struct apm_user	*as;
 =

 	device_suspend(PMSG_SUSPEND);
-	local_irq_disable();
+
 	device_power_down(PMSG_SUSPEND);
+
+	local_irq_disable();
 	sysdev_suspend(PMSG_SUSPEND);
 =

 	local_irq_enable();
@@ -1209,9 +1211,12 @@ static int suspend(int vetoable)
 	if (err !=3D APM_SUCCESS)
 		apm_error("suspend", err);
 	err =3D (err =3D=3D APM_SUCCESS) ? 0 : -EIO;
+
 	sysdev_resume();
-	device_power_up(PMSG_RESUME);
 	local_irq_enable();
+
+	device_power_up(PMSG_RESUME);
+
 	device_resume(PMSG_RESUME);
 	queue_event(APM_NORMAL_RESUME, NULL);
 	spin_lock(&user_list_lock);
@@ -1228,8 +1233,9 @@ static void standby(void)
 {
 	int err;
 =

-	local_irq_disable();
 	device_power_down(PMSG_SUSPEND);
+
+	local_irq_disable();
 	sysdev_suspend(PMSG_SUSPEND);
 	local_irq_enable();
 =

@@ -1239,8 +1245,9 @@ static void standby(void)
 =

 	local_irq_disable();
 	sysdev_resume();
-	device_power_up(PMSG_RESUME);
 	local_irq_enable();
+
+	device_power_up(PMSG_RESUME);
 }
 =

 static apm_event_t get_event(void)
Index: linux-2.6/drivers/xen/manage.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.orig/drivers/xen/manage.c
+++ linux-2.6/drivers/xen/manage.c
@@ -39,12 +39,6 @@ static int xen_suspend(void *data)
 =

 	BUG_ON(!irqs_disabled());
 =

-	err =3D device_power_down(PMSG_SUSPEND);
-	if (err) {
-		printk(KERN_ERR "xen_suspend: device_power_down failed: %d\n",
-		       err);
-		return err;
-	}
 	err =3D sysdev_suspend(PMSG_SUSPEND);
 	if (err) {
 		printk(KERN_ERR "xen_suspend: sysdev_suspend failed: %d\n",
@@ -69,7 +63,6 @@ static int xen_suspend(void *data)
 	xen_mm_unpin_all();
 =

 	sysdev_resume();
-	device_power_up(PMSG_RESUME);
 =

 	if (!*cancelled) {
 		xen_irq_resume();
@@ -108,6 +101,12 @@ static void do_suspend(void)
 	/* XXX use normal device tree? */
 	xenbus_suspend();
 =

+	err =3D device_power_down(PMSG_SUSPEND);
+	if (err) {
+		printk(KERN_ERR "device_power_down failed: %d\n", err);
+		goto resume_devices;
+	}
+
 	err =3D stop_machine(xen_suspend, &cancelled, &cpumask_of_cpu(0));
 	if (err) {
 		printk(KERN_ERR "failed to start xen_suspend: %d\n", err);
@@ -120,6 +119,9 @@ static void do_suspend(void)
 	} else
 		xenbus_suspend_cancel();
 =

+	device_power_up(PMSG_RESUME);
+
+resume_devices:
 	device_resume(PMSG_RESUME);
 =

 	/* Make sure timer events get retriggered on all CPUs */
Index: linux-2.6/kernel/kexec.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.orig/kernel/kexec.c
+++ linux-2.6/kernel/kexec.c
@@ -1454,7 +1454,6 @@ int kernel_kexec(void)
 		if (error)
 			goto Resume_devices;
 		device_pm_lock();
-		local_irq_disable();
 		/* At this point, device_suspend() has been called,
 		 * but *not* device_power_down(). We *must*
 		 * device_power_down() now.  Otherwise, drivers for
@@ -1464,8 +1463,9 @@ int kernel_kexec(void)
 		 */
 		error =3D device_power_down(PMSG_FREEZE);
 		if (error)
-			goto Enable_irqs;
+			goto Unlock_pm;
 =

+		local_irq_disable();
 		/* Suspend system devices */
 		error =3D sysdev_suspend(PMSG_FREEZE);
 		if (error)
@@ -1484,9 +1484,9 @@ int kernel_kexec(void)
 	if (kexec_image->preserve_context) {
 		sysdev_resume();
  Power_up_devices:
-		device_power_up(PMSG_RESTORE);
- Enable_irqs:
 		local_irq_enable();
+		device_power_up(PMSG_RESTORE);
+ Unlock_pm:
 		device_pm_unlock();
 		enable_nonboot_cpus();
  Resume_devices:
Index: linux-2.6/include/linux/irq.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.orig/include/linux/irq.h
+++ linux-2.6/include/linux/irq.h
@@ -65,6 +65,7 @@ typedef	void (*irq_flow_handler_t)(unsig
 #define IRQ_SPURIOUS_DISABLED	0x00800000	/* IRQ was disabled by the spurio=
us trap */
 #define IRQ_MOVE_PCNTXT		0x01000000	/* IRQ migration from process context =
*/
 #define IRQ_AFFINITY_SET	0x02000000	/* IRQ affinity was set from userspace=
*/
+#define IRQ_SUSPENDED		0x04000000	/* IRQ has gone through suspend sequence=
 */
 =

 #ifdef CONFIG_IRQ_PER_CPU
 # define CHECK_IRQ_PER_CPU(var) ((var) & IRQ_PER_CPU)
Index: linux-2.6/kernel/irq/pm.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- /dev/null
+++ linux-2.6/kernel/irq/pm.c
@@ -0,0 +1,89 @@
+/*
+ * linux/kernel/irq/pm.c
+ *
+ * Copyright (C) 2009 Rafael J. Wysocki <rjw@sisk.pl>, Novell Inc.
+ *
+ * This file contains power management functions related to interrupts.
+ */
+
+#include <linux/irq.h>
+#include <linux/module.h>
+#include <linux/interrupt.h>
+
+#include "internals.h"
+
+/**
+ * suspend_device_irqs - disable all currently enabled interrupt lines
+ *
+ * During system-wide suspend or hibernation device interrupts need to be
+ * disabled at the chip level and this function is provided for this purpo=
se.
+ * It disables all interrupt lines that are enabled at the moment and sets=
 the
+ * IRQ_SUSPENDED flag for them.
+ */
+void suspend_device_irqs(void)
+{
+	struct irq_desc *desc;
+	int irq;
+
+	for_each_irq_desc(irq, desc) {
+		unsigned long flags;
+		bool sync =3D false;
+
+		spin_lock_irqsave(&desc->lock, flags);
+
+		if (desc->action && !(desc->action->flags & IRQF_TIMER)) {
+			if (!desc->depth++) {
+				desc->status |=3D IRQ_DISABLED;
+				desc->chip->disable(irq);
+				sync =3D true;
+			}
+			desc->status |=3D IRQ_SUSPENDED;
+		}
+
+		spin_unlock_irqrestore(&desc->lock, flags);
+
+		if (sync)
+			synchronize_irq(irq);
+	}
+}
+EXPORT_SYMBOL_GPL(suspend_device_irqs);
+
+/**
+ * resume_device_irqs - enable interrupt lines disabled by suspend_device_=
irqs()
+ *
+ * Enable all interrupt lines previously disabled by suspend_device_irqs()=
 that
+ * have the IRQ_SUSPENDED flag set.
+ */
+void resume_device_irqs(void)
+{
+	struct irq_desc *desc;
+	int irq;
+
+	for_each_irq_desc(irq, desc) {
+		unsigned long flags;
+
+		if (!(desc->status & IRQ_SUSPENDED))
+			continue;
+
+		spin_lock_irqsave(&desc->lock, flags);
+		desc->status &=3D ~IRQ_SUSPENDED;
+		__enable_irq(desc, irq);
+		spin_unlock_irqrestore(&desc->lock, flags);
+	}
+}
+EXPORT_SYMBOL_GPL(resume_device_irqs);
+
+/**
+ * check_wakeup_irqs - check if any wake-up interrupts are pending
+ */
+int check_wakeup_irqs(void)
+{
+	struct irq_desc *desc;
+	int irq;
+
+	for_each_irq_desc(irq, desc)
+		if ((desc->status & IRQ_WAKEUP) && (desc->status & IRQ_PENDING))
+			return -EBUSY;
+
+	return 0;
+}
Index: linux-2.6/kernel/irq/Makefile
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.orig/kernel/irq/Makefile
+++ linux-2.6/kernel/irq/Makefile
@@ -4,3 +4,4 @@ obj-$(CONFIG_GENERIC_IRQ_PROBE) +=3D autop
 obj-$(CONFIG_PROC_FS) +=3D proc.o
 obj-$(CONFIG_GENERIC_PENDING_IRQ) +=3D migration.o
 obj-$(CONFIG_NUMA_MIGRATE_IRQ_DESC) +=3D numa_migrate.o
+obj-$(CONFIG_PM_SLEEP) +=3D pm.o
Index: linux-2.6/kernel/irq/manage.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.orig/kernel/irq/manage.c
+++ linux-2.6/kernel/irq/manage.c
@@ -215,7 +215,7 @@ void disable_irq(unsigned int irq)
 }
 EXPORT_SYMBOL(disable_irq);
 =

-static void __enable_irq(struct irq_desc *desc, unsigned int irq)
+void __enable_irq(struct irq_desc *desc, unsigned int irq)
 {
 	switch (desc->depth) {
 	case 0:
Index: linux-2.6/drivers/base/power/main.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.orig/drivers/base/power/main.c
+++ linux-2.6/drivers/base/power/main.c
@@ -23,6 +23,7 @@
 #include <linux/pm.h>
 #include <linux/resume-trace.h>
 #include <linux/rwsem.h>
+#include <linux/interrupt.h>
 =

 #include "../base.h"
 #include "power.h"
@@ -305,7 +306,8 @@ static int resume_device_noirq(struct de
  *	Execute the appropriate "noirq resume" callback for all devices marked
  *	as DPM_OFF_IRQ.
  *
- *	Must be called with interrupts disabled and only one CPU running.
+ *	Must be called under dpm_list_mtx.  Device drivers should not receive
+ *	interrupts while it's being executed.
  */
 static void dpm_power_up(pm_message_t state)
 {
@@ -326,14 +328,13 @@ static void dpm_power_up(pm_message_t st
  *	device_power_up - Turn on all devices that need special attention.
  *	@state: PM transition of the system being carried out.
  *
- *	Power on system devices, then devices that required we shut them down
- *	with interrupts disabled.
- *
- *	Must be called with interrupts disabled.
+ *	Call the "early" resume handlers and enable device drivers to receive
+ *	interrupts.
  */
 void device_power_up(pm_message_t state)
 {
 	dpm_power_up(state);
+	resume_device_irqs();
 }
 EXPORT_SYMBOL_GPL(device_power_up);
 =

@@ -558,16 +559,17 @@ static int suspend_device_noirq(struct d
  *	device_power_down - Shut down special devices.
  *	@state: PM transition of the system being carried out.
  *
- *	Power down devices that require interrupts to be disabled.
- *	Then power down system devices.
+ *	Prevent device drivers from receiving interrupts and call the "late"
+ *	suspend handlers.
  *
- *	Must be called with interrupts disabled and only one CPU running.
+ *	Must be called under dpm_list_mtx.
  */
 int device_power_down(pm_message_t state)
 {
 	struct device *dev;
 	int error =3D 0;
 =

+	suspend_device_irqs();
 	list_for_each_entry_reverse(dev, &dpm_list, power.entry) {
 		error =3D suspend_device_noirq(dev, state);
 		if (error) {
@@ -577,7 +579,7 @@ int device_power_down(pm_message_t state
 		dev->power.status =3D DPM_OFF_IRQ;
 	}
 	if (error)
-		dpm_power_up(resume_event(state));
+		device_power_up(resume_event(state));
 	return error;
 }
 EXPORT_SYMBOL_GPL(device_power_down);
Index: linux-2.6/drivers/base/sys.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.orig/drivers/base/sys.c
+++ linux-2.6/drivers/base/sys.c
@@ -22,6 +22,7 @@
 #include <linux/pm.h>
 #include <linux/device.h>
 #include <linux/mutex.h>
+#include <linux/interrupt.h>
 =

 #include "base.h"
 =

@@ -369,6 +370,13 @@ int sysdev_suspend(pm_message_t state)
 	struct sysdev_driver *drv, *err_drv;
 	int ret;
 =

+	pr_debug("Checking wake-up interrupts\n");
+
+	/* Return error code if there are any wake-up interrupts pending */
+	ret =3D check_wakeup_irqs();
+	if (ret)
+		return ret;
+
 	pr_debug("Suspending System Devices\n");
 =

 	list_for_each_entry_reverse(cls, &system_kset->list, kset.kobj.entry) {
Index: linux-2.6/kernel/irq/internals.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.orig/kernel/irq/internals.h
+++ linux-2.6/kernel/irq/internals.h
@@ -12,6 +12,7 @@ extern void compat_irq_chip_set_default_
 =

 extern int __irq_set_trigger(struct irq_desc *desc, unsigned int irq,
 		unsigned long flags);
+extern void __enable_irq(struct irq_desc *desc, unsigned int irq);
 =

 extern struct lock_class_key irq_desc_lock_class;
 extern void init_kstat_irqs(struct irq_desc *desc, int cpu, int nr);
