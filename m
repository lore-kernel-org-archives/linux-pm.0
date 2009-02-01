From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 1/3] PCI PM: Do not disable and enable bridges
	during suspend-resume
Date: Sun, 1 Feb 2009 22:31:17 +0100
Message-ID: <200902012231.17933.rjw__15994.7744141848$1233524721$gmane$org@sisk.pl>
References: <200902012229.27517.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200902012229.27517.rjw@sisk.pl>
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
Cc: Linux PCI <linux-pci@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

It is a mistake to disable and enable PCI bridges and PCI Express
ports during suspend-resume (at least at the time when it is
currently done).  Disabling them may lead to problems with accessing
devices behind them and they should be automatically enabled when
their standard config spaces are restored.  Fix this by not attempting
to disable bridges during suspend and enable them during resume.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/pci/pci-driver.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

Index: linux-2.6/drivers/pci/pci-driver.c
===================================================================
--- linux-2.6.orig/drivers/pci/pci-driver.c
+++ linux-2.6/drivers/pci/pci-driver.c
@@ -428,16 +428,18 @@ static int pci_pm_default_resume(struct 
 {
 	pci_fixup_device(pci_fixup_resume, pci_dev);
 
-	if (!pci_is_bridge(pci_dev))
-		pci_enable_wake(pci_dev, PCI_D0, false);
+	if (pci_is_bridge(pci_dev))
+		return 0;
 
+	pci_enable_wake(pci_dev, PCI_D0, false);
 	return pci_pm_reenable_device(pci_dev);
 }
 
 static void pci_pm_default_suspend_generic(struct pci_dev *pci_dev)
 {
-	/* If device is enabled at this point, disable it */
-	pci_disable_enabled_device(pci_dev);
+	/* If a non-bridge device is enabled at this point, disable it */
+	if (!pci_is_bridge(pci_dev))
+		pci_disable_enabled_device(pci_dev);
 	/*
 	 * Save state with interrupts enabled, because in principle the bus the
 	 * device is on may be put into a low power state after this code runs.
