From: David Brownell <david-b@pacbell.net>
Subject: [patch/rft 2.6.17-rc5-git 4/6] PM_EVENT_PRETHAW for
	various graphics cards
Date: Mon, 5 Jun 2006 09:38:34 -0700
Message-ID: <200606050938.34988.david-b@pacbell.net>
References: <200604241429.52022.david-b@pacbell.net>
	<20060527163837.GE4242@ucw.cz>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_K4FhEI5pp+YG2G4"
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

--Boundary-00=_K4FhEI5pp+YG2G4
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Video drivers which explicitly test for messages reporting
PM_EVENT_FREEZE will now handle PM_EVENT_PRETHAW the same way.
---
 drivers/video/aty/radeon_pm.c          |   15 +++++++++------
 drivers/video/i810/i810_main.c         |   12 +++++++-----
 drivers/video/nvidia/nvidia.c          |   13 +++++++------
 drivers/video/savage/savagefb_driver.c |   14 +++++++-------
 4 files changed, 30 insertions(+), 24 deletions(-)



--Boundary-00=_K4FhEI5pp+YG2G4
Content-Type: text/x-diff;
  charset="us-ascii";
  name="prethaw-video.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="prethaw-video.patch"

Video drivers which explicitly test for messages reporting
PM_EVENT_FREEZE will now handle PM_EVENT_PRETHAW the same way.

---
 drivers/video/aty/radeon_pm.c          |   15 +++++++++------
 drivers/video/i810/i810_main.c         |   12 +++++++-----
 drivers/video/nvidia/nvidia.c          |   13 +++++++------
 drivers/video/savage/savagefb_driver.c |   14 +++++++-------
 4 files changed, 30 insertions(+), 24 deletions(-)


Index: g26/drivers/video/aty/radeon_pm.c
===================================================================
--- g26.orig/drivers/video/aty/radeon_pm.c	2006-06-02 18:08:30.000000000 -0700
+++ g26/drivers/video/aty/radeon_pm.c	2006-06-02 18:11:27.000000000 -0700
@@ -2520,25 +2520,28 @@ static int radeon_restore_pci_cfg(struct
 }
 
 
-int radeonfb_pci_suspend(struct pci_dev *pdev, pm_message_t state)
+int radeonfb_pci_suspend(struct pci_dev *pdev, pm_message_t mesg)
 {
         struct fb_info *info = pci_get_drvdata(pdev);
         struct radeonfb_info *rinfo = info->par;
 	int i;
 
-	if (state.event == pdev->dev.power.power_state.event)
+	if (mesg.event == pdev->dev.power.power_state.event)
 		return 0;
 
-	printk(KERN_DEBUG "radeonfb (%s): suspending to state: %d...\n",
-	       pci_name(pdev), state.event);
+	printk(KERN_DEBUG "radeonfb (%s): suspending for event: %d...\n",
+	       pci_name(pdev), mesg.event);
 
 	/* For suspend-to-disk, we cheat here. We don't suspend anything and
 	 * let fbcon continue drawing until we are all set. That shouldn't
 	 * really cause any problem at this point, provided that the wakeup
 	 * code knows that any state in memory may not match the HW
 	 */
-	if (state.event == PM_EVENT_FREEZE)
+	switch (mesg.event) {
+	case PM_EVENT_FREEZE:		/* about to take snapshot */
+	case PM_EVENT_PRETHAW:		/* before restoring snapshot */
 		goto done;
+	}
 
 	acquire_console_sem();
 
@@ -2605,7 +2608,7 @@ int radeonfb_pci_suspend(struct pci_dev 
 	release_console_sem();
 
  done:
-	pdev->dev.power.power_state = state;
+	pdev->dev.power.power_state = mesg;
 
 	return 0;
 }
Index: g26/drivers/video/i810/i810_main.c
===================================================================
--- g26.orig/drivers/video/i810/i810_main.c	2006-06-02 18:08:30.000000000 -0700
+++ g26/drivers/video/i810/i810_main.c	2006-06-02 18:11:27.000000000 -0700
@@ -1556,15 +1556,17 @@ static struct fb_ops i810fb_ops __devini
 /***********************************************************************
  *                         Power Management                            *
  ***********************************************************************/
-static int i810fb_suspend(struct pci_dev *dev, pm_message_t state)
+static int i810fb_suspend(struct pci_dev *dev, pm_message_t mesg)
 {
 	struct fb_info *info = pci_get_drvdata(dev);
 	struct i810fb_par *par = info->par;
 
-	par->cur_state = state.event;
+	par->cur_state = mesg.event;
 
-	if (state.event == PM_EVENT_FREEZE) {
-		dev->dev.power.power_state = state;
+	switch (mesg.event) {
+	case PM_EVENT_FREEZE:
+	case PM_EVENT_PRETHAW:
+		dev->dev.power.power_state = mesg;
 		return 0;
 	}
 
@@ -1580,7 +1582,7 @@ static int i810fb_suspend(struct pci_dev
 
 	pci_save_state(dev);
 	pci_disable_device(dev);
-	pci_set_power_state(dev, pci_choose_state(dev, state));
+	pci_set_power_state(dev, pci_choose_state(dev, mesg));
 	release_console_sem();
 
 	return 0;
Index: g26/drivers/video/nvidia/nvidia.c
===================================================================
--- g26.orig/drivers/video/nvidia/nvidia.c	2006-06-02 18:08:30.000000000 -0700
+++ g26/drivers/video/nvidia/nvidia.c	2006-06-02 18:11:27.000000000 -0700
@@ -1381,24 +1381,25 @@ static struct fb_ops nvidia_fb_ops = {
 };
 
 #ifdef CONFIG_PM
-static int nvidiafb_suspend(struct pci_dev *dev, pm_message_t state)
+static int nvidiafb_suspend(struct pci_dev *dev, pm_message_t mesg)
 {
 	struct fb_info *info = pci_get_drvdata(dev);
 	struct nvidia_par *par = info->par;
 
+	if (mesg.event == PM_EVENT_PRETHAW)
+		mesg.event = PM_EVENT_FREEZE;
 	acquire_console_sem();
-	par->pm_state = state.event;
+	par->pm_state = mesg.event;
 
-	if (state.event == PM_EVENT_FREEZE) {
-		dev->dev.power.power_state = state;
-	} else {
+	if (mesg.event == PM_EVENT_SUSPEND) {
 		fb_set_suspend(info, 1);
 		nvidiafb_blank(FB_BLANK_POWERDOWN, info);
 		nvidia_write_regs(par, &par->SavedReg);
 		pci_save_state(dev);
 		pci_disable_device(dev);
-		pci_set_power_state(dev, pci_choose_state(dev, state));
+		pci_set_power_state(dev, pci_choose_state(dev, mesg));
 	}
+	dev->dev.power.power_state = mesg;
 
 	release_console_sem();
 	return 0;
Index: g26/drivers/video/savage/savagefb_driver.c
===================================================================
--- g26.orig/drivers/video/savage/savagefb_driver.c	2006-06-02 18:08:30.000000000 -0700
+++ g26/drivers/video/savage/savagefb_driver.c	2006-06-02 18:11:27.000000000 -0700
@@ -2151,24 +2151,24 @@ static void __devexit savagefb_remove (s
 	}
 }
 
-static int savagefb_suspend (struct pci_dev* dev, pm_message_t state)
+static int savagefb_suspend (struct pci_dev* dev, pm_message_t mesg)
 {
 	struct fb_info *info = pci_get_drvdata(dev);
 	struct savagefb_par *par = info->par;
 
 	DBG("savagefb_suspend");
 
-
-	par->pm_state = state.event;
+	if (mesg.event == PM_EVENT_PRETHAW)
+		mesg.event = PM_EVENT_FREEZE;
+	par->pm_state = mesg.event;
+	dev->dev.power.power_state = mesg;
 
 	/*
 	 * For PM_EVENT_FREEZE, do not power down so the console
 	 * can remain active.
 	 */
-	if (state.event == PM_EVENT_FREEZE) {
-		dev->dev.power.power_state = state;
+	if (mesg.event == PM_EVENT_FREEZE)
 		return 0;
-	}
 
 	acquire_console_sem();
 	fb_set_suspend(info, 1);
@@ -2180,7 +2180,7 @@ static int savagefb_suspend (struct pci_
 	savage_disable_mmio(par);
 	pci_save_state(dev);
 	pci_disable_device(dev);
-	pci_set_power_state(dev, pci_choose_state(dev, state));
+	pci_set_power_state(dev, pci_choose_state(dev, mesg));
 	release_console_sem();
 
 	return 0;

--Boundary-00=_K4FhEI5pp+YG2G4
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--Boundary-00=_K4FhEI5pp+YG2G4--
