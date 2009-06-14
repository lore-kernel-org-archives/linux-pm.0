From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH] PCI PM: Fix handling of devices without PM
	support by pci_target_state()
Date: Sun, 14 Jun 2009 21:25:02 +0200
Message-ID: <200906142125.03418.rjw__34551.3026034043$1245007553$gmane$org@sisk.pl>
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
Cc: Andreas Mohr <andim2@users.sourceforge.net>, Linux PCI <linux-pci@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

If a PCI device is not power-manageable either by the platform, or
with the help of the native PCI PM interface, pci_target_state() will
return either PCI_D3hot, or PCI_POWER_ERROR for it, depending on
whether or not the device is configured to wake up the system.  Alas,
none of these return values is correct, because each of them causes
pci_prepare_to_sleep() to return error code, although it should
complete successfully in such a case.

Fix this problem by making pci_target_state() always return PCI_D0
for devices that cannot be power managed.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
Hi Jesse,

I think this is 2.6.31 material, probably -stable too.

Best,
Rafael

---
 drivers/pci/pci.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

Index: linux-2.6/drivers/pci/pci.c
===================================================================
--- linux-2.6.orig/drivers/pci/pci.c
+++ linux-2.6/drivers/pci/pci.c
@@ -1288,15 +1288,14 @@ pci_power_t pci_target_state(struct pci_
 		default:
 			target_state = state;
 		}
+	} else if (!dev->pm_cap) {
+		target_state = PCI_D0;
 	} else if (device_may_wakeup(&dev->dev)) {
 		/*
 		 * Find the deepest state from which the device can generate
 		 * wake-up events, make it the target state and enable device
 		 * to generate PME#.
 		 */
-		if (!dev->pm_cap)
-			return PCI_POWER_ERROR;
-
 		if (dev->pme_support) {
 			while (target_state
 			      && !(dev->pme_support & (1 << target_state)))
