From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH] PCI PM: Make pci_prepare_to_sleep() disable
	wake-up if needed
Date: Sat, 28 Mar 2009 22:26:15 +0100
Message-ID: <200903282226.15511.rjw__23067.1425270431$1238275813$gmane$org@sisk.pl>
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
Cc: Linux PCI <linux-pci@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

If the device is not supposed to wake up the system, ie. when
device_may_wakeup(&dev->dev) returns 'false', pci_prepare_to_sleep()
should pass 'false' to pci_enable_wake() so that it calls the
platform to disable the wake-up capability of the device.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/pci/pci.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6/drivers/pci/pci.c
===================================================================
--- linux-2.6.orig/drivers/pci/pci.c
+++ linux-2.6/drivers/pci/pci.c
@@ -1268,7 +1268,7 @@ int pci_prepare_to_sleep(struct pci_dev 
 	if (target_state == PCI_POWER_ERROR)
 		return -EIO;
 
-	pci_enable_wake(dev, target_state, true);
+	pci_enable_wake(dev, target_state, device_may_wakeup(&dev->dev));
 
 	error = pci_set_power_state(dev, target_state);
 
