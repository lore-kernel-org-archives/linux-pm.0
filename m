From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 3/7] PCI PM: Fix saving of device state in
	pci_legacy_suspend
Date: Wed, 4 Feb 2009 01:59:09 +0100
Message-ID: <200902040159.10258.rjw__48164.9520727389$1233710992$gmane$org@sisk.pl>
References: <200902040154.36018.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200902040154.36018.rjw@sisk.pl>
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
Cc: pm list <linux-pm@lists.linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Linux PCI <linux-pci@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

Make pci_legacy_suspend() save the state of the device if it is
in PCI_UNKNOWN after its suspend callback has run and warn only if
the power state of the device has been changed by its suspend
callback.

Also, use WARN_ONCE(), which is more useful, in pci_legacy_suspend(),
so that the name of the offending function is printed.

Additionaly, remove the unnecessary line of code setting
pci_dev->state_saved.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Reported-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 drivers/pci/pci-driver.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

Index: linux-2.6/drivers/pci/pci-driver.c
===================================================================
--- linux-2.6.orig/drivers/pci/pci-driver.c
+++ linux-2.6/drivers/pci/pci-driver.c
@@ -355,6 +355,8 @@ static int pci_legacy_suspend(struct dev
 	int i = 0;
 
 	if (drv && drv->suspend) {
+		pci_power_t prev = pci_dev->current_state;
+
 		pci_dev->state_saved = false;
 
 		i = drv->suspend(pci_dev, state);
@@ -365,12 +367,16 @@ static int pci_legacy_suspend(struct dev
 		if (pci_dev->state_saved)
 			goto Fixup;
 
-		if (WARN_ON_ONCE(pci_dev->current_state != PCI_D0))
+		if (pci_dev->current_state != PCI_D0
+		    && pci_dev->current_state != PCI_UNKNOWN) {
+			WARN_ONCE(pci_dev->current_state != prev,
+				"PCI PM: Device state not saved by %pF\n",
+				drv->suspend);
 			goto Fixup;
+		}
 	}
 
 	pci_save_state(pci_dev);
-	pci_dev->state_saved = true;
 	/*
 	 * This is for compatibility with existing code with legacy PM support.
 	 */
