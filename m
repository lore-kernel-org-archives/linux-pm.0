From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Suspend regression, hang after matroxfb
Date: Fri, 30 Jan 2009 23:59:17 +0100
Message-ID: <200901302359.18309.rjw__18859.5771477141$1233356539$gmane$org@sisk.pl>
References: <20090129125855.GA4597@alice> <200901302327.50887.rjw@sisk.pl>
	<20090130223144.GD13207@alice>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090130223144.GD13207@alice>
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
To: Eric Sesterhenn <snakebyte@gmx.de>
Cc: linux-pm@lists.linux-foundation.org, Kernel Testers <kernel-testers@vger.kernel.org>, vandrove@vc.cvut.cz
List-Id: linux-pm@vger.kernel.org

On Friday 30 January 2009, Eric Sesterhenn wrote:
> * Rafael J. Wysocki (rjw@sisk.pl) wrote:
> > On Friday 30 January 2009, Eric Sesterhenn wrote:
> > > * Rafael J. Wysocki (rjw@sisk.pl) wrote:
> > > > On Friday 30 January 2009, Eric Sesterhenn wrote:
> > > > > * Rafael J. Wysocki (rjw@sisk.pl) wrote:
> > > > > > On Thursday 29 January 2009, Eric Sesterhenn wrote:
> > > > > > > hi,
> > > > > > > 
> > > > > > > on this box standby worked with 2.6.28, but is broken with 2.6.29-rc3.
> > > > > > > 
> > > > > > > Dmesg of startup
> > > > > > > http://www.cccmz.de/~snakebyte/200.log
> > > > > > > .config
> > > > > > > http://www.cccmz.de/~snakebyte/config_200
> > > > > > > 
> > > > > > > When testing the devices 
> > > > > > > 
> > > > > > > root@computer-desktop:/sys/power# echo devices > pm_test 
> > > > > > 
> > > > > > What happens if you replace 'devices' with 'core' ?
> > > > > 
> > > > > no change, it hangs after matroxfb
> > > > > 
> > > > > root@computer-desktop:/sys/power# echo core > pm_test 
> > > > > root@computer-desktop:/sys/power# echo standby > state
> > > > > 
> > > > [--snip--]
> > > > > 
> > > > > > If the same, what happens without the matroxfb driver?
> > > > > 
> > > > > It gets a bit further, suspend seems to complete,
> > > > > but hangs during resume
> > > > 
> > > > Please check if the appended patch helps.
> > > 
> > > It does help in both cases (with matroxfb enabled and disabled)
> > > thanks.
> > 
> > What machine is that?
> 
> I mean the driver enabled in .config.
> 
> box is one of my kernel testgrounds running ubuntu intrepid,
> for .config and dmesg see the links above

Ah, so this is just a desktop.  OK, thanks.

I have prepared a final fix that I'd like to push for merging.  Can you please
test it (it won't apply cleanly to the current -git, but should be easy to fix
up)?

Rafael

---
From: Rafael J. Wysocki <rjw@sisk.pl>
Subject: PCI PM: Fix handling of devices without drivers

Suspend to RAM is reported to break on some machines as a result of
attempting to put one of driverless PCI devices into a low power
state.  Avoid that by not attepmting to power manage driverless
devices during suspend.

Fix up pci_pm_poweroff() after a previous incomplete fix for the same
thing during hibernation.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/pci/pci-driver.c |   27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

Index: linux-2.6/drivers/pci/pci-driver.c
===================================================================
--- linux-2.6.orig/drivers/pci/pci-driver.c
+++ linux-2.6/drivers/pci/pci-driver.c
@@ -445,11 +445,11 @@ static void pci_pm_default_suspend_gener
 	pci_save_state(pci_dev);
 }
 
-static void pci_pm_default_suspend(struct pci_dev *pci_dev)
+static void pci_pm_default_suspend(struct pci_dev *pci_dev, bool prepare)
 {
 	pci_pm_default_suspend_generic(pci_dev);
 
-	if (!pci_is_bridge(pci_dev))
+	if (prepare && !pci_is_bridge(pci_dev))
 		pci_prepare_to_sleep(pci_dev);
 
 	pci_fixup_device(pci_fixup_suspend, pci_dev);
@@ -497,19 +497,19 @@ static void pci_pm_complete(struct devic
 static int pci_pm_suspend(struct device *dev)
 {
 	struct pci_dev *pci_dev = to_pci_dev(dev);
-	struct device_driver *drv = dev->driver;
+	struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
 	int error = 0;
 
 	if (pci_has_legacy_pm_support(pci_dev))
 		return pci_legacy_suspend(dev, PMSG_SUSPEND);
 
-	if (drv && drv->pm && drv->pm->suspend) {
-		error = drv->pm->suspend(dev);
-		suspend_report_result(drv->pm->suspend, error);
+	if (pm && pm->suspend) {
+		error = pm->suspend(dev);
+		suspend_report_result(pm->suspend, error);
 	}
 
 	if (!error)
-		pci_pm_default_suspend(pci_dev);
+		pci_pm_default_suspend(pci_dev, !!pm);
 
 	return error;
 }
@@ -663,22 +663,19 @@ static int pci_pm_thaw(struct device *de
 static int pci_pm_poweroff(struct device *dev)
 {
 	struct pci_dev *pci_dev = to_pci_dev(dev);
-	struct device_driver *drv = dev->driver;
+	struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
 	int error = 0;
 
 	if (pci_has_legacy_pm_support(pci_dev))
 		return pci_legacy_suspend(dev, PMSG_HIBERNATE);
 
-	if (!drv || !drv->pm)
-		return 0;
-
-	if (drv->pm->poweroff) {
-		error = drv->pm->poweroff(dev);
-		suspend_report_result(drv->pm->poweroff, error);
+	if (pm && pm->poweroff) {
+		error = pm->poweroff(dev);
+		suspend_report_result(pm->poweroff, error);
 	}
 
 	if (!error)
-		pci_pm_default_suspend(pci_dev);
+		pci_pm_default_suspend(pci_dev, !!pm);
 
 	return error;
 }
