From: David Brownell <david-b@pacbell.net>
Subject: [patch/rft 2.6.17-rc5-git 1/6] fix broken/dubious driver
	suspend() methods
Date: Mon, 5 Jun 2006 09:36:28 -0700
Message-ID: <200606050936.28224.david-b@pacbell.net>
References: <200604241429.52022.david-b@pacbell.net>
	<20060527163837.GE4242@ucw.cz>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_M2FhEczCEajuYZd"
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
To: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

--Boundary-00=_M2FhEczCEajuYZd
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Small driver suspend() updates in preparation for the upcoming FREEZE message;

 - Only compare message events for equality against PM_EVENT_* codes;
   not against integers, or using greater/less-than comparisons.
   (PM_EVENT_* should really become a __bitwise thing.)

 - Explicitly test for SUSPEND events (rather than not-something-else)
   before suspending devices.

 - Removes more of the confusion between a pm_message_t (wraps event code)
   and a "state" ... suspend() originally took a target system state.

These updates are correct and appropriate even without new PM_EVENT codes.
---
 drivers/ide/ppc/pmac.c                  |   14 ++++++++------
 drivers/media/dvb/cinergyT2/cinergyT2.c |    2 +-
 drivers/scsi/libata-core.c              |    6 +++---
 drivers/scsi/mesh.c                     |    7 ++++---
 4 files changed, 16 insertions(+), 13 deletions(-)


--Boundary-00=_M2FhEczCEajuYZd
Content-Type: text/x-diff;
  charset="us-ascii";
  name="prethaw-misc.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="prethaw-misc.patch"

Small driver suspend() updates in preparation for the upcoming FREEZE message;

 - Only compare message events for equality against PM_EVENT_* codes;
   not against integers, or using greater/less-than comparisons.
   (PM_EVENT_* should really become a __bitwise thing.)

 - Explicitly test for SUSPEND events (rather than not-something-else)
   before suspending devices.
 
 - Removes more of the confusion between a pm_message_t (wraps event code)
   and a "state" ... suspend() originally took a target system state.

These updates are correct and appropriate even without new PM_EVENT codes.

---
 drivers/ide/ppc/pmac.c                  |   14 ++++++++------
 drivers/media/dvb/cinergyT2/cinergyT2.c |    2 +-
 drivers/scsi/libata-core.c              |    6 +++---
 drivers/scsi/mesh.c                     |    7 ++++---
 4 files changed, 16 insertions(+), 13 deletions(-)

Index: scratch/drivers/ide/ppc/pmac.c
===================================================================
--- scratch.orig/drivers/ide/ppc/pmac.c	2006-06-05 09:06:00.000000000 -0700
+++ scratch/drivers/ide/ppc/pmac.c	2006-06-05 09:19:13.000000000 -0700
@@ -1495,15 +1495,16 @@ pmac_ide_macio_attach(struct macio_dev *
 }
 
 static int
-pmac_ide_macio_suspend(struct macio_dev *mdev, pm_message_t state)
+pmac_ide_macio_suspend(struct macio_dev *mdev, pm_message_t mesg)
 {
 	ide_hwif_t	*hwif = (ide_hwif_t *)dev_get_drvdata(&mdev->ofdev.dev);
 	int		rc = 0;
 
-	if (state.event != mdev->ofdev.dev.power.power_state.event && state.event >= PM_EVENT_SUSPEND) {
+	if (mesg.event != mdev->ofdev.dev.power.power_state.event
+			&& mesg.event == PM_EVENT_SUSPEND) {
 		rc = pmac_ide_do_suspend(hwif);
 		if (rc == 0)
-			mdev->ofdev.dev.power.power_state = state;
+			mdev->ofdev.dev.power.power_state = mesg;
 	}
 
 	return rc;
@@ -1599,15 +1600,16 @@ pmac_ide_pci_attach(struct pci_dev *pdev
 }
 
 static int
-pmac_ide_pci_suspend(struct pci_dev *pdev, pm_message_t state)
+pmac_ide_pci_suspend(struct pci_dev *pdev, pm_message_t mesg)
 {
 	ide_hwif_t	*hwif = (ide_hwif_t *)pci_get_drvdata(pdev);
 	int		rc = 0;
 	
-	if (state.event != pdev->dev.power.power_state.event && state.event >= 2) {
+	if (mesg.event != pdev->dev.power.power_state.event
+			&& mesg.event == PM_EVENT_SUSPEND) {
 		rc = pmac_ide_do_suspend(hwif);
 		if (rc == 0)
-			pdev->dev.power.power_state = state;
+			pdev->dev.power.power_state = mesg;
 	}
 
 	return rc;
Index: scratch/drivers/scsi/libata-core.c
===================================================================
--- scratch.orig/drivers/scsi/libata-core.c	2006-06-05 09:06:16.000000000 -0700
+++ scratch/drivers/scsi/libata-core.c	2006-06-05 09:19:13.000000000 -0700
@@ -4313,19 +4313,19 @@ int ata_device_resume(struct ata_port *a
  *	ata_device_suspend - prepare a device for suspend
  *	@ap: port the device is connected to
  *	@dev: the device to suspend
- *	@state: target power management state
+ *	@mesg: power management request
  *
  *	Flush the cache on the drive, if appropriate, then issue a
  *	standbynow command.
  */
-int ata_device_suspend(struct ata_port *ap, struct ata_device *dev, pm_message_t state)
+int ata_device_suspend(struct ata_port *ap, struct ata_device *dev, pm_message_t mesg)
 {
 	if (!ata_dev_present(dev))
 		return 0;
 	if (dev->class == ATA_DEV_ATA)
 		ata_flush_cache(ap, dev);
 
-	if (state.event != PM_EVENT_FREEZE)
+	if (mesg.event == PM_EVENT_SUSPEND)
 		ata_standby_drive(ap, dev);
 	ap->flags |= ATA_FLAG_SUSPENDED;
 	return 0;
Index: scratch/drivers/scsi/mesh.c
===================================================================
--- scratch.orig/drivers/scsi/mesh.c	2006-06-05 09:06:16.000000000 -0700
+++ scratch/drivers/scsi/mesh.c	2006-06-05 09:19:13.000000000 -0700
@@ -1761,12 +1761,13 @@ static void set_mesh_power(struct mesh_s
 
 
 #ifdef CONFIG_PM
-static int mesh_suspend(struct macio_dev *mdev, pm_message_t state)
+static int mesh_suspend(struct macio_dev *mdev, pm_message_t mesg)
 {
 	struct mesh_state *ms = (struct mesh_state *)macio_get_drvdata(mdev);
 	unsigned long flags;
 
-	if (state.event == mdev->ofdev.dev.power.power_state.event || state.event < 2)
+	if (mesg.event == mdev->ofdev.dev.power.power_state.event
+			|| mesg.event != PM_EVENT_SUSPEND)
 		return 0;
 
 	scsi_block_requests(ms->host);
@@ -1781,7 +1782,7 @@ static int mesh_suspend(struct macio_dev
 	disable_irq(ms->meshintr);
 	set_mesh_power(ms, 0);
 
-	mdev->ofdev.dev.power.power_state = state;
+	mdev->ofdev.dev.power.power_state = mesg;
 
 	return 0;
 }
Index: scratch/drivers/media/dvb/cinergyT2/cinergyT2.c
===================================================================
--- scratch.orig/drivers/media/dvb/cinergyT2/cinergyT2.c	2006-06-05 09:06:01.000000000 -0700
+++ scratch/drivers/media/dvb/cinergyT2/cinergyT2.c	2006-06-05 09:19:13.000000000 -0700
@@ -978,7 +978,7 @@ static int cinergyt2_suspend (struct usb
 	if (cinergyt2->disconnect_pending || mutex_lock_interruptible(&cinergyt2->sem))
 		return -ERESTARTSYS;
 
-	if (state.event > PM_EVENT_ON) {
+	if (1) {
 		struct cinergyt2 *cinergyt2 = usb_get_intfdata (intf);
 
 		cinergyt2_suspend_rc(cinergyt2);

--Boundary-00=_M2FhEczCEajuYZd
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--Boundary-00=_M2FhEczCEajuYZd--
