From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 2/2] PCI / PM: Report wakeup events before
	resuming devices
Date: Wed, 29 Dec 2010 13:22:08 +0100
Message-ID: <201012291322.08521.rjw__28714.5867165693$1293625497$gmane$org@sisk.pl>
References: <201012291320.22777.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201012291320.22777.rjw@sisk.pl>
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
Cc: linux-pci@vger.kernel.org, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

Make wakeup events be reported by the PCI subsystem before attempting
to resume devices or queuing up runtime resume requests for them,
because wakeup events should be reported as soon as they have been
detected.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/pci/pci-acpi.c |    2 +-
 drivers/pci/pci.c      |    2 +-
 drivers/pci/pcie/pme.c |    4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

Index: linux-2.6/drivers/pci/pci-acpi.c
===================================================================
--- linux-2.6.orig/drivers/pci/pci-acpi.c
+++ linux-2.6/drivers/pci/pci-acpi.c
@@ -46,9 +46,9 @@ static void pci_acpi_wake_dev(acpi_handl
 	struct pci_dev *pci_dev = context;
 
 	if (event == ACPI_NOTIFY_DEVICE_WAKE && pci_dev) {
+		pci_wakeup_event(pci_dev);
 		pci_check_pme_status(pci_dev);
 		pm_runtime_resume(&pci_dev->dev);
-		pci_wakeup_event(pci_dev);
 		if (pci_dev->subordinate)
 			pci_pme_wakeup_bus(pci_dev->subordinate);
 	}
Index: linux-2.6/drivers/pci/pci.c
===================================================================
--- linux-2.6.orig/drivers/pci/pci.c
+++ linux-2.6/drivers/pci/pci.c
@@ -1311,8 +1311,8 @@ bool pci_check_pme_status(struct pci_dev
 static int pci_pme_wakeup(struct pci_dev *dev, void *ign)
 {
 	if (pci_check_pme_status(dev)) {
-		pm_request_resume(&dev->dev);
 		pci_wakeup_event(dev);
+		pm_request_resume(&dev->dev);
 	}
 	return 0;
 }
Index: linux-2.6/drivers/pci/pcie/pme.c
===================================================================
--- linux-2.6.orig/drivers/pci/pcie/pme.c
+++ linux-2.6/drivers/pci/pcie/pme.c
@@ -103,8 +103,8 @@ static bool pcie_pme_walk_bus(struct pci
 	list_for_each_entry(dev, &bus->devices, bus_list) {
 		/* Skip PCIe devices in case we started from a root port. */
 		if (!pci_is_pcie(dev) && pci_check_pme_status(dev)) {
-			pm_request_resume(&dev->dev);
 			pci_wakeup_event(dev);
+			pm_request_resume(&dev->dev);
 			ret = true;
 		}
 
@@ -206,8 +206,8 @@ static void pcie_pme_handle_request(stru
 		/* The device is there, but we have to check its PME status. */
 		found = pci_check_pme_status(dev);
 		if (found) {
-			pm_request_resume(&dev->dev);
 			pci_wakeup_event(dev);
+			pm_request_resume(&dev->dev);
 		}
 		pci_dev_put(dev);
 	} else if (devfn) {
