From: David Brownell <david-b@pacbell.net>
Subject: [patch 2.6.18-rc5 + pm patches] PM: no suspend_prepare()
	phase
Date: Wed, 30 Aug 2006 14:09:47 -0700
Message-ID: <200608301409.48033.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Greg KH <greg@kroah.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

[ As previously discussed. ]

Remove the new suspend_prepare() phase.  It doesn't seem very usable,
has never been tested, doesn't address fault cleanup, and would need
a sibling resume_complete(); plus there are no real use cases.  It
could be restored later if those issues get resolved.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>

Index: g26/drivers/base/power/suspend.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- g26.orig/drivers/base/power/suspend.c	2006-08-30 14:05:01.000000000 -07=
00
+++ g26/drivers/base/power/suspend.c	2006-08-30 14:05:15.000000000 -0700
@@ -123,33 +123,6 @@ static int suspend_device_late(struct de
 }
 =

 /**
- *	device_prepare_suspend - save state and prepare to suspend
- *
- *	NOTE! Devices cannot detach at this point - not only do we
- *	hold the device list semaphores over the whole prepare, but
- *	the whole point is to do non-invasive preparatory work, not
- *	the actual suspend.
- */
-int device_prepare_suspend(pm_message_t state)
-{
-	int error =3D 0;
-	struct device * dev;
-
-	down(&dpm_sem);
-	down(&dpm_list_sem);
-	list_for_each_entry_reverse(dev, &dpm_active, power.entry) {
-		if (!dev->bus || !dev->bus->suspend_prepare)
-			continue;
-		error =3D dev->bus->suspend_prepare(dev, state);
-		if (error)
-			break;
-	}
-	up(&dpm_list_sem);
-	up(&dpm_sem);
-	return error;
-}
-
-/**
  *	device_suspend - Save state and stop all devices in system.
  *	@state:		Power state to put each device in.
  *
Index: g26/drivers/pci/pci-driver.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- g26.orig/drivers/pci/pci-driver.c	2006-08-30 14:05:01.000000000 -0700
+++ g26/drivers/pci/pci-driver.c	2006-08-30 14:05:15.000000000 -0700
@@ -264,19 +264,6 @@ static int pci_device_remove(struct devi
 	return 0;
 }
 =

-static int pci_device_suspend_prepare(struct device * dev, pm_message_t st=
ate)
-{
-	struct pci_dev * pci_dev =3D to_pci_dev(dev);
-	struct pci_driver * drv =3D pci_dev->driver;
-	int i =3D 0;
-
-	if (drv && drv->suspend_prepare) {
-		i =3D drv->suspend_prepare(pci_dev, state);
-		suspend_report_result(drv->suspend_prepare, i);
-	}
-	return i;
-}
-
 static int pci_device_suspend(struct device * dev, pm_message_t state)
 {
 	struct pci_dev * pci_dev =3D to_pci_dev(dev);
@@ -544,7 +531,6 @@ struct bus_type pci_bus_type =3D {
 	.uevent		=3D pci_uevent,
 	.probe		=3D pci_device_probe,
 	.remove		=3D pci_device_remove,
-	.suspend_prepare=3D pci_device_suspend_prepare,
 	.suspend	=3D pci_device_suspend,
 	.suspend_late	=3D pci_device_suspend_late,
 	.resume_early	=3D pci_device_resume_early,
Index: g26/include/linux/device.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- g26.orig/include/linux/device.h	2006-08-30 14:05:01.000000000 -0700
+++ g26/include/linux/device.h	2006-08-30 14:05:15.000000000 -0700
@@ -52,7 +52,6 @@ struct bus_type {
 	int		(*remove)(struct device * dev);
 	void		(*shutdown)(struct device * dev);
 =

-	int (*suspend_prepare)(struct device * dev, pm_message_t state);
 	int (*suspend)(struct device * dev, pm_message_t state);
 	int (*suspend_late)(struct device * dev, pm_message_t state);
 	int (*resume_early)(struct device * dev);
Index: g26/include/linux/pci.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- g26.orig/include/linux/pci.h	2006-08-30 14:05:01.000000000 -0700
+++ g26/include/linux/pci.h	2006-08-30 14:05:15.000000000 -0700
@@ -345,7 +345,6 @@ struct pci_driver {
 	const struct pci_device_id *id_table;	/* must be non-NULL for probe to be=
 called */
 	int  (*probe)  (struct pci_dev *dev, const struct pci_device_id *id);	/* =
New device inserted */
 	void (*remove) (struct pci_dev *dev);	/* Device removed (NULL if not a ho=
t-plug capable driver) */
-	int  (*suspend_prepare) (struct pci_dev *dev, pm_message_t state);
 	int  (*suspend) (struct pci_dev *dev, pm_message_t state);	/* Device susp=
ended */
 	int  (*suspend_late) (struct pci_dev *dev, pm_message_t state);
 	int  (*resume_early) (struct pci_dev *dev);
Index: g26/kernel/power/main.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- g26.orig/kernel/power/main.c	2006-08-30 14:05:01.000000000 -0700
+++ g26/kernel/power/main.c	2006-08-30 14:05:15.000000000 -0700
@@ -57,10 +57,6 @@ static int suspend_prepare(suspend_state
 	if (!pm_ops || !pm_ops->enter)
 		return -EPERM;
 =

-	error =3D device_prepare_suspend(PMSG_SUSPEND);
-	if (error)
-		return error;
-
 	pm_prepare_console();
 =

 	disable_nonboot_cpus();
