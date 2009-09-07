From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFC][PATCH 1/3 update] PCI: Clear saved_state after the
	state has been restored
Date: Tue, 8 Sep 2009 01:29:47 +0200
Message-ID: <200909080129.47665.rjw__29481.0729720213$1252366183$gmane$org@sisk.pl>
References: <200909070102.21056.rjw@sisk.pl> <200909070103.20731.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200909070103.20731.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org
Cc: linux-pci <linux-pci@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>
Subject: PCI: Clear saved_state after the state has been restored

Some PCI devices fail if their standard configuration registers are
restored twice in a row.  Prevent this from happening by making
pci_restore_state() clear the saved_state flag of the device right
after the device's standard configuration registers have been
populated with the previously saved values.

Simplify PCI PM callbacks by removing the direct clearing of
state_saved from them, as it shouldn't be necessary any more, except
in pci_pm_thaw(), where it has to be cleared to so that the values saved
during the "freeze" phase of hibernation are not used later by mistake.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---

Of course, the state_saved flag has to be cleared in pci_pm_thaw() in case
the driver doesn't restore the state saved in ->freeze() (it doesn't need to do
that).

Thanks,
Rafael

---
 drivers/pci/pci-driver.c |   11 ++---------
 drivers/pci/pci.c        |    3 +++
 drivers/pci/probe.c      |    3 +++
 3 files changed, 8 insertions(+), 9 deletions(-)

Index: linux-2.6/drivers/pci/pci-driver.c
===================================================================
--- linux-2.6.orig/drivers/pci/pci-driver.c
+++ linux-2.6/drivers/pci/pci-driver.c
@@ -417,8 +417,6 @@ static int pci_legacy_suspend(struct dev
 	struct pci_dev * pci_dev = to_pci_dev(dev);
 	struct pci_driver * drv = pci_dev->driver;
 
-	pci_dev->state_saved = false;
-
 	if (drv && drv->suspend) {
 		pci_power_t prev = pci_dev->current_state;
 		int error;
@@ -514,7 +512,6 @@ static int pci_restore_standard_config(s
 static void pci_pm_default_resume_noirq(struct pci_dev *pci_dev)
 {
 	pci_restore_standard_config(pci_dev);
-	pci_dev->state_saved = false;
 	pci_fixup_device(pci_fixup_resume_early, pci_dev);
 }
 
@@ -580,8 +577,6 @@ static int pci_pm_suspend(struct device 
 	if (pci_has_legacy_pm_support(pci_dev))
 		return pci_legacy_suspend(dev, PMSG_SUSPEND);
 
-	pci_dev->state_saved = false;
-
 	if (!pm) {
 		pci_pm_default_suspend(pci_dev);
 		goto Fixup;
@@ -716,8 +711,6 @@ static int pci_pm_freeze(struct device *
 	if (pci_has_legacy_pm_support(pci_dev))
 		return pci_legacy_suspend(dev, PMSG_FREEZE);
 
-	pci_dev->state_saved = false;
-
 	if (!pm) {
 		pci_pm_default_suspend(pci_dev);
 		return 0;
@@ -793,6 +786,8 @@ static int pci_pm_thaw(struct device *de
 		pci_pm_reenable_device(pci_dev);
 	}
 
+	pci_dev->state_saved = false;
+
 	return error;
 }
 
@@ -804,8 +799,6 @@ static int pci_pm_poweroff(struct device
 	if (pci_has_legacy_pm_support(pci_dev))
 		return pci_legacy_suspend(dev, PMSG_HIBERNATE);
 
-	pci_dev->state_saved = false;
-
 	if (!pm) {
 		pci_pm_default_suspend(pci_dev);
 		goto Fixup;
Index: linux-2.6/drivers/pci/pci.c
===================================================================
--- linux-2.6.orig/drivers/pci/pci.c
+++ linux-2.6/drivers/pci/pci.c
@@ -852,6 +852,7 @@ pci_restore_state(struct pci_dev *dev)
 
 	if (!dev->state_saved)
 		return 0;
+
 	/* PCI Express register must be restored first */
 	pci_restore_pcie_state(dev);
 
@@ -873,6 +874,8 @@ pci_restore_state(struct pci_dev *dev)
 	pci_restore_msi_state(dev);
 	pci_restore_iov_state(dev);
 
+	dev->state_saved = false;
+
 	return 0;
 }
 
Index: linux-2.6/drivers/pci/probe.c
===================================================================
--- linux-2.6.orig/drivers/pci/probe.c
+++ linux-2.6/drivers/pci/probe.c
@@ -1009,6 +1009,9 @@ void pci_device_add(struct pci_dev *dev,
 	/* Fix up broken headers */
 	pci_fixup_device(pci_fixup_header, dev);
 
+	/* Clear the state_saved flag. */
+	dev->state_saved = false;
+
 	/* Initialize various capabilities */
 	pci_init_capabilities(dev);
 
