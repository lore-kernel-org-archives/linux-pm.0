From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Sat, 24 Jun 2006 15:28:33 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606241518380.6483@g5.osdl.org>
References: <Pine.LNX.4.44L0.0606241220100.19990-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.44L0.0606241220100.19990-100000@netrider.rowland.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: David Brownell <david-b@pacbell.net>, linux-pm@lists.osdl.org, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org



On Sat, 24 Jun 2006, Alan Stern wrote:
> =

> >  - "suspend_prepare()" is called for every device (with the semaphore =

> >    held, you are _not_ allowed to try to unlink yourself in the prepare =

> >    function)
> =

> There should be a big fat warning about this somewhere, maybe added to th=
e =

> documentation.

Well, there is, right now, above the only place that does this (ie the =

function itself).

Anyway, would people object to merging the infrastructure work early, even =

if nothing else actually was done before 2.6.18? =


As it stands now, the infrastructure work really shouldn't change any =

existing use (modulo bugs, of course), and I'd expect it to suspend and =

resume as well (or badly) as it ever has.

Actually using suspend_late()/resume_early() runs into issues with the =

"platform_device" also needing to be taught about the thing, and it's =

already too late in the 2.6.18 series to even really try, but I'd like to =

have the infrastructure all in place, and I don't think anybody really =

_disagreed_ with the patch per se.

Which is not to say that we might not do more work on the =

"suspend_prepare" (and the currently unimplemented "resume_finish" side).

In fact, the current limitation of "suspend_prepare()" would go away if we =

took the same approach as the other suspend phases do: move devices one by =

one onto a separate list, and have the "resume_finish()" code then move =

them back.

Does anybody _hate_ this approach? =


I'm re-attaching the patch here. It's identical to the previous version, =

except slightly updated for the current kernel top-of-tree (which has the =

TRACE_RESUME() code merged in).

		Linus

---
commit 62421a15a797a0e7a083b9e11d890c54a5306e10
Author: Linus Torvalds <torvalds@macmini.osdl.org>
Date:   Sat Jun 24 14:50:29 2006 -0700

    Suspend infrastructure cleanup and extension
    =

    Allow devices to participate in the suspend process more intimately,
    in particular, allow the final phase (with interrupts disabled) to
    also be open to normal devices, not just system devices.
    =

    Also, allow classes to participate in device suspend.
    =

    Signed-off-by: Linus Torvalds <torvalds@osdl.org>

diff --git a/drivers/base/power/resume.c b/drivers/base/power/resume.c
index 520679c..6470fd1 100644
--- a/drivers/base/power/resume.c
+++ b/drivers/base/power/resume.c
@@ -38,13 +38,35 @@ int resume_device(struct device * dev)
 		dev_dbg(dev,"resuming\n");
 		error =3D dev->bus->resume(dev);
 	}
+	if (dev->class && dev->class->resume) {
+		dev_dbg(dev,"class resume\n");
+		error =3D dev->class->resume(dev);
+	}
 	up(&dev->sem);
 	TRACE_RESUME(error);
 	return error;
 }
 =

 =

+static int resume_device_early(struct device * dev)
+{
+	int error =3D 0;
+
+	TRACE_DEVICE(dev);
+	TRACE_RESUME(0);
+	if (dev->bus && dev->bus->resume_early) {
+		dev_dbg(dev,"EARLY resume\n");
+		error =3D dev->bus->resume(dev);
+	}
+	TRACE_RESUME(error);
+	return error;
+}
 =

+/*
+ * Resume the devices that have either not gone through
+ * the late suspend, or that did go through it but also
+ * went through the early resume
+ */
 void dpm_resume(void)
 {
 	down(&dpm_list_sem);
@@ -100,11 +122,9 @@ void dpm_power_up(void)
 		struct list_head * entry =3D dpm_off_irq.next;
 		struct device * dev =3D to_device(entry);
 =

-		get_device(dev);
 		list_del_init(entry);
-		list_add_tail(entry, &dpm_active);
-		resume_device(dev);
-		put_device(dev);
+		list_add_tail(entry, &dpm_off);
+		resume_device_early(dev);
 	}
 }
 =

diff --git a/drivers/base/power/suspend.c b/drivers/base/power/suspend.c
index 1a1fe43..2e6be8a 100644
--- a/drivers/base/power/suspend.c
+++ b/drivers/base/power/suspend.c
@@ -65,7 +65,19 @@ int suspend_device(struct device * dev, =

 =

 	dev->power.prev_state =3D dev->power.power_state;
 =

-	if (dev->bus && dev->bus->suspend && !dev->power.power_state.event) {
+	if (dev->class && dev->class->suspend && !dev->power.power_state.event) {
+		dev_dbg(dev, "class %s%s\n",
+			suspend_verb(state.event),
+			((state.event =3D=3D PM_EVENT_SUSPEND)
+					&& device_may_wakeup(dev))
+				? ", may wakeup"
+				: ""
+			);
+		error =3D dev->class->suspend(dev, state);
+		suspend_report_result(dev->class->suspend, error);
+	}
+
+	if (!error && dev->bus && dev->bus->suspend && !dev->power.power_state.ev=
ent) {
 		dev_dbg(dev, "%s%s\n",
 			suspend_verb(state.event),
 			((state.event =3D=3D PM_EVENT_SUSPEND)
@@ -81,15 +93,74 @@ int suspend_device(struct device * dev, =

 }
 =

 =

+/*
+ * This is called with interrupts off, only a single CPU
+ * running. We can't do down() on a semaphore (and we don't
+ * need the protection)
+ */
+static int suspend_device_late(struct device *dev, pm_message_t state)
+{
+	int error =3D 0;
+
+	if (dev->power.power_state.event) {
+		dev_dbg(dev, "PM: suspend_late %d-->%d\n",
+			dev->power.power_state.event, state.event);
+	}
+
+	if (dev->bus && dev->bus->suspend_late && !dev->power.power_state.event) {
+		dev_dbg(dev, "LATE %s%s\n",
+			suspend_verb(state.event),
+			((state.event =3D=3D PM_EVENT_SUSPEND)
+					&& device_may_wakeup(dev))
+				? ", may wakeup"
+				: ""
+			);
+		error =3D dev->bus->suspend_late(dev, state);
+		suspend_report_result(dev->bus->suspend_late, error);
+	}
+	return error;
+}
+
+/**
+ *	device_prepare_suspend - save state and prepare to suspend
+ *
+ *	NOTE! Devices cannot detach at this point - not only do we
+ *	hold the device list semaphores over the whole prepare, but
+ *	the whole point is to do non-invasive preparatory work, not
+ *	the actual suspend.
+ */
+int device_prepare_suspend(pm_message_t state)
+{
+	int error =3D 0;
+	struct device * dev;
+
+	down(&dpm_sem);
+	down(&dpm_list_sem);
+	list_for_each_entry_reverse(dev, &dpm_active, power.entry) {
+		if (!dev->bus || !dev->bus->suspend_prepare)
+			continue;
+		error =3D dev->bus->suspend_prepare(dev, state);
+		if (error)
+			break;
+	}
+	up(&dpm_list_sem);
+	up(&dpm_sem);
+	return error;
+}
+
 /**
  *	device_suspend - Save state and stop all devices in system.
  *	@state:		Power state to put each device in.
  *
  *	Walk the dpm_active list, call ->suspend() for each device, and move
- *	it to dpm_off.
- *	Check the return value for each. If it returns 0, then we move the
- *	the device to the dpm_off list. If it returns -EAGAIN, we move it to
- *	the dpm_off_irq list. If we get a different error, try and back out.
+ *	it to the dpm_off list.
+ *
+ *	(For historical reasons, if it returns -EAGAIN, that used to mean
+ *	that the device would be called again with interrupts enabled.
+ *	These days, we use the "suspend_late()" callback for that, so we
+ *	print a warning and consider it an error).
+ *
+ *	If we get a different error, try and back out.
  *
  *	If we hit a failure with any of the devices, call device_resume()
  *	above to bring the suspended devices back to life.
@@ -115,42 +186,29 @@ int device_suspend(pm_message_t state)
 =

 		/* Check if the device got removed */
 		if (!list_empty(&dev->power.entry)) {
-			/* Move it to the dpm_off or dpm_off_irq list */
+			/* Move it to the dpm_off_irq list */
 			if (!error) {
 				list_del(&dev->power.entry);
 				list_add(&dev->power.entry, &dpm_off);
-			} else if (error =3D=3D -EAGAIN) {
-				list_del(&dev->power.entry);
-				list_add(&dev->power.entry, &dpm_off_irq);
-				error =3D 0;
 			}
 		}
 		if (error)
 			printk(KERN_ERR "Could not suspend device %s: "
-				"error %d\n", kobject_name(&dev->kobj), error);
+				"error %d%s\n",
+				kobject_name(&dev->kobj), error,
+				error =3D=3D -EAGAIN ? " (please convert to suspend_late)" : "");
 		put_device(dev);
 	}
 	up(&dpm_list_sem);
-	if (error) {
-		/* we failed... before resuming, bring back devices from
-		 * dpm_off_irq list back to main dpm_off list, we do want
-		 * to call resume() on them, in case they partially suspended
-		 * despite returning -EAGAIN
-		 */
-		while (!list_empty(&dpm_off_irq)) {
-			struct list_head * entry =3D dpm_off_irq.next;
-			list_del(entry);
-			list_add(entry, &dpm_off);
-		}
+	if (error)
 		dpm_resume();
-	}
+
 	up(&dpm_sem);
 	return error;
 }
 =

 EXPORT_SYMBOL_GPL(device_suspend);
 =

-
 /**
  *	device_power_down - Shut down special devices.
  *	@state:		Power state to enter.
@@ -165,14 +223,18 @@ int device_power_down(pm_message_t state
 	int error =3D 0;
 	struct device * dev;
 =

-	list_for_each_entry_reverse(dev, &dpm_off_irq, power.entry) {
-		if ((error =3D suspend_device(dev, state)))
-			break;
+	while (!list_empty(&dpm_off)) {
+		struct list_head * entry =3D dpm_off.prev;
+
+		dev =3D to_device(entry);
+		error =3D suspend_device_late(dev, state);
+		if (error)
+			goto Error;
+		list_del(&dev->power.entry);
+		list_add(&dev->power.entry, &dpm_off_irq);
 	}
-	if (error)
-		goto Error;
-	if ((error =3D sysdev_suspend(state)))
-		goto Error;
+
+	error =3D sysdev_suspend(state);
  Done:
 	return error;
  Error:
diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 10e1a90..6308fed 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -265,6 +265,19 @@ static int pci_device_remove(struct devi
 	return 0;
 }
 =

+static int pci_device_suspend_prepare(struct device * dev, pm_message_t st=
ate)
+{
+	struct pci_dev * pci_dev =3D to_pci_dev(dev);
+	struct pci_driver * drv =3D pci_dev->driver;
+	int i =3D 0;
+
+	if (drv && drv->suspend_prepare) {
+		i =3D drv->suspend_prepare(pci_dev, state);
+		suspend_report_result(drv->suspend_prepare, i);
+	}
+	return i;
+}
+
 static int pci_device_suspend(struct device * dev, pm_message_t state)
 {
 	struct pci_dev * pci_dev =3D to_pci_dev(dev);
@@ -280,6 +293,18 @@ static int pci_device_suspend(struct dev
 	return i;
 }
 =

+static int pci_device_suspend_late(struct device * dev, pm_message_t state)
+{
+	struct pci_dev * pci_dev =3D to_pci_dev(dev);
+	struct pci_driver * drv =3D pci_dev->driver;
+	int i =3D 0;
+
+	if (drv && drv->suspend_late) {
+		i =3D drv->suspend_late(pci_dev, state);
+		suspend_report_result(drv->suspend_late, i);
+	}
+	return i;
+}
 =

 /*
  * Default resume method for devices that have no driver provided resume,
@@ -314,6 +339,17 @@ static int pci_device_resume(struct devi
 	return error;
 }
 =

+static int pci_device_resume_early(struct device * dev)
+{
+	int error =3D 0;
+	struct pci_dev * pci_dev =3D to_pci_dev(dev);
+	struct pci_driver * drv =3D pci_dev->driver;
+
+	if (drv && drv->resume_early)
+		error =3D drv->resume_early(pci_dev);
+	return error;
+}
+
 static void pci_device_shutdown(struct device *dev)
 {
 	struct pci_dev *pci_dev =3D to_pci_dev(dev);
@@ -509,9 +545,12 @@ struct bus_type pci_bus_type =3D {
 	.uevent		=3D pci_uevent,
 	.probe		=3D pci_device_probe,
 	.remove		=3D pci_device_remove,
+	.suspend_prepare=3D pci_device_suspend_prepare,
 	.suspend	=3D pci_device_suspend,
-	.shutdown	=3D pci_device_shutdown,
+	.suspend_late	=3D pci_device_suspend_late,
+	.resume_early	=3D pci_device_resume_early,
 	.resume		=3D pci_device_resume,
+	.shutdown	=3D pci_device_shutdown,
 	.dev_attrs	=3D pci_dev_attrs,
 };
 =

diff --git a/include/linux/device.h b/include/linux/device.h
index 1e5f30d..99d2a18 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -51,8 +51,12 @@ struct bus_type {
 	int		(*probe)(struct device * dev);
 	int		(*remove)(struct device * dev);
 	void		(*shutdown)(struct device * dev);
-	int		(*suspend)(struct device * dev, pm_message_t state);
-	int		(*resume)(struct device * dev);
+
+	int (*suspend_prepare)(struct device * dev, pm_message_t state);
+	int (*suspend)(struct device * dev, pm_message_t state);
+	int (*suspend_late)(struct device * dev, pm_message_t state);
+	int (*resume_early)(struct device * dev);
+	int (*resume)(struct device * dev);
 };
 =

 extern int bus_register(struct bus_type * bus);
@@ -154,6 +158,9 @@ struct class {
 =

 	void	(*release)(struct class_device *dev);
 	void	(*class_release)(struct class *class);
+
+	int	(*suspend)(struct device *, pm_message_t state);
+	int	(*resume)(struct device *);
 };
 =

 extern int class_register(struct class *);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 62a8c22..9a762c8 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -344,7 +344,10 @@ struct pci_driver {
 	const struct pci_device_id *id_table;	/* must be non-NULL for probe to be=
 called */
 	int  (*probe)  (struct pci_dev *dev, const struct pci_device_id *id);	/* =
New device inserted */
 	void (*remove) (struct pci_dev *dev);	/* Device removed (NULL if not a ho=
t-plug capable driver) */
+	int  (*suspend_prepare) (struct pci_dev *dev, pm_message_t state);
 	int  (*suspend) (struct pci_dev *dev, pm_message_t state);	/* Device susp=
ended */
+	int  (*suspend_late) (struct pci_dev *dev, pm_message_t state);
+	int  (*resume_early) (struct pci_dev *dev);
 	int  (*resume) (struct pci_dev *dev);	                /* Device woken up =
*/
 	int  (*enable_wake) (struct pci_dev *dev, pci_power_t state, int enable);=
   /* Enable wake event */
 	void (*shutdown) (struct pci_dev *dev);
diff --git a/include/linux/pm.h b/include/linux/pm.h
index 658c1b9..096fb6f 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -190,6 +190,7 @@ #ifdef CONFIG_PM
 extern suspend_disk_method_t pm_disk_mode;
 =

 extern int device_suspend(pm_message_t state);
+extern int device_prepare_suspend(pm_message_t state);
 =

 #define device_set_wakeup_enable(dev,val) \
 	((dev)->power.should_wakeup =3D !!(val))
diff --git a/kernel/power/main.c b/kernel/power/main.c
index cdf0f07..18a0f91 100644
--- a/kernel/power/main.c
+++ b/kernel/power/main.c
@@ -57,6 +57,10 @@ static int suspend_prepare(suspend_state
 	if (!pm_ops || !pm_ops->enter)
 		return -EPERM;
 =

+	error =3D device_prepare_suspend(PMSG_SUSPEND);
+	if (error)
+		return error;
+
 	pm_prepare_console();
 =

 	disable_nonboot_cpus();
