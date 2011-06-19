From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH] PCI / PM: Block races between runtime PM and
	system sleep
Date: Sun, 19 Jun 2011 21:49:19 +0200
Message-ID: <201106192149.19401.rjw__1740.68964920497$1308512946$gmane$org@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Linux PM mailing list <linux-pm@lists.linux-foundation.org>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

After commit e8665002477f0278f84f898145b1f141ba26ee26
(PM: Allow pm_runtime_suspend() to succeed during system suspend) it
is possible that a device resumed by the pm_runtime_resume(dev) in
pci_pm_prepare() will be suspended immediately from a work item,
timer function or otherwise, defeating the very purpose of calling
pm_runtime_resume(dev) from there.  To prevent that from happening
it is necessary to increment the runtime PM usage counter of the
device by replacing pm_runtime_resume() with pm_runtime_get_sync().
Moreover, the incremented runtime PM usage counter has to be
decremented by the corresponding pci_pm_complete(), via
pm_runtime_put_noidle().

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Cc: stable@kernel.org
---
 drivers/pci/pci-driver.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

Index: linux-2.6/drivers/pci/pci-driver.c
===================================================================
--- linux-2.6.orig/drivers/pci/pci-driver.c
+++ linux-2.6/drivers/pci/pci-driver.c
@@ -624,7 +624,7 @@ static int pci_pm_prepare(struct device
 	 * system from the sleep state, we'll have to prevent it from signaling
 	 * wake-up.
 	 */
-	pm_runtime_resume(dev);
+	pm_runtime_get_sync(dev);
 
 	if (drv && drv->pm && drv->pm->prepare)
 		error = drv->pm->prepare(dev);
@@ -638,6 +638,8 @@ static void pci_pm_complete(struct devic
 
 	if (drv && drv->pm && drv->pm->complete)
 		drv->pm->complete(dev);
+
+	pm_runtime_put_noidle(dev);
 }
 
 #else /* !CONFIG_PM_SLEEP */
