From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFC][PATCH] PCI PM: Be extra careful when changing
	power states of devices
Date: Sat, 21 Mar 2009 00:03:54 +0100
Message-ID: <200903210003.55161.rjw__696.518240920518$1237590493$gmane$org@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
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
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PCI <linux-pci@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

The story in http://bugzilla.kernel.org/show_bug.cgi?id=12846 shows
that setting the power state of a PCI device by
pci_raw_set_power_state() may sometimes fail.  For this reason,
pci_raw_set_power_state() should not assume that the power state of
the device has actually changed after writing into its PMCSR.
Instead, it should read the value from there and use it to update
dev->current_state.  It also is useful to print a warning if the
device's power state hasn't changed as expected.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/pci/pci.c |   12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

Index: linux-2.6/drivers/pci/pci.c
===================================================================
--- linux-2.6.orig/drivers/pci/pci.c
+++ linux-2.6/drivers/pci/pci.c
@@ -436,7 +436,7 @@ static inline int platform_pci_sleep_wak
  */
 static int pci_raw_set_power_state(struct pci_dev *dev, pci_power_t state)
 {
-	u16 pmcsr;
+	u16 pmcsr, new_pmcsr;
 	bool need_restore = false;
 
 	/* Check if we're already there */
@@ -498,7 +498,15 @@ static int pci_raw_set_power_state(struc
 	else if (state == PCI_D2 || dev->current_state == PCI_D2)
 		udelay(PCI_PM_D2_DELAY);
 
-	dev->current_state = state;
+	pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &new_pmcsr);
+	if (new_pmcsr == pmcsr) {
+		dev->current_state = state;
+	} else {
+		dev->current_state = (new_pmcsr & PCI_PM_CTRL_STATE_MASK);
+		dev_warn(&dev->dev,
+			"failed to set power state to D%d, is D%d\n", state,
+			dev->current_state);
+	}
 
 	/* According to section 5.4.1 of the "PCI BUS POWER MANAGEMENT
 	 * INTERFACE SPECIFICATION, REV. 1.2", a device transitioning
