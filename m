From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 1/3] PCI PM: Fix hibernation breakage on EeePC 701
Date: Thu, 22 Jan 2009 23:36:56 +0100
Message-ID: <200901222336.56573.rjw__48522.0654089519$1232664213$gmane$org@sisk.pl>
References: <200901222335.07341.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200901222335.07341.rjw@sisk.pl>
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
Cc: Linux PCI <linux-pci@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Alan Jenkins <alan-jenkins@tuffmail.co.uk>, Matthew Wilcox <matthew@wil.cx>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

Hibernation breaks on EeePC 701 as a result of attempting to put one
of its (driverless) devices into a low power state.  Avoid that by
not attepmting to power manage driverless devices during hibernation.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Reported-and-tested-by: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
---
 drivers/pci/pci-driver.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

Index: linux-2.6/drivers/pci/pci-driver.c
===================================================================
--- linux-2.6.orig/drivers/pci/pci-driver.c
+++ linux-2.6/drivers/pci/pci-driver.c
@@ -660,7 +660,10 @@ static int pci_pm_poweroff(struct device
 	if (pci_has_legacy_pm_support(pci_dev))
 		return pci_legacy_suspend(dev, PMSG_HIBERNATE);
 
-	if (drv && drv->pm && drv->pm->poweroff) {
+	if (!drv || !drv->pm)
+		return 0;
+
+	if (drv->pm->poweroff) {
 		error = drv->pm->poweroff(dev);
 		suspend_report_result(drv->pm->poweroff, error);
 	}
