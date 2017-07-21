From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 1/3] PCI / PM: Skip bridges in pci_enable_wake()
Date: Fri, 21 Jul 2017 14:38:08 +0200
Message-ID: <1895122.yvmCHzQO3z@aspire.rjw.lan>
References: <3116391.JNS1F4DjTg@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <3116391.JNS1F4DjTg@aspire.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
To: Linux PCI <linux-pci@vger.kernel.org>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Bjorn Helgaas <bhelgaas@google.com>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

PCI bridges only have a reason to generate wakeup signals on behalf
of devices below them, so avoid preparing bridges for wakeup directly
in pci_enable_wake().

Also drop the pci_has_subordinate() check from pci_pm_default_resume()
as this will be done by pci_enable_wake() itself now.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/pci/pci-driver.c |    4 +---
 drivers/pci/pci.c        |    7 +++++++
 2 files changed, 8 insertions(+), 3 deletions(-)

Index: linux-pm/drivers/pci/pci.c
===================================================================
--- linux-pm.orig/drivers/pci/pci.c
+++ linux-pm/drivers/pci/pci.c
@@ -1909,6 +1909,13 @@ int pci_enable_wake(struct pci_dev *dev,
 {
 	int ret = 0;
 
+	/*
+	 * Bridges can only signal wakeup on behalf of subordinate devices,
+	 * but that is set up elsewhere, so skip them.
+	 */
+	if (pci_has_subordinate(dev))
+		return 0;
+
 	/* Don't do the same thing twice in a row for one device. */
 	if (!!enable == !!dev->wakeup_prepared)
 		return 0;
Index: linux-pm/drivers/pci/pci-driver.c
===================================================================
--- linux-pm.orig/drivers/pci/pci-driver.c
+++ linux-pm/drivers/pci/pci-driver.c
@@ -642,9 +642,7 @@ static int pci_legacy_resume(struct devi
 static void pci_pm_default_resume(struct pci_dev *pci_dev)
 {
 	pci_fixup_device(pci_fixup_resume, pci_dev);
-
-	if (!pci_has_subordinate(pci_dev))
-		pci_enable_wake(pci_dev, PCI_D0, false);
+	pci_enable_wake(pci_dev, PCI_D0, false);
 }
 
 static void pci_pm_default_suspend(struct pci_dev *pci_dev)

