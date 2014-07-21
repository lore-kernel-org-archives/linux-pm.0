From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] PCI / PM: Allow PCI devices to be put into D3cold during system suspend
Date: Mon, 21 Jul 2014 02:29:54 +0200
Message-ID: <3331155.XU3LgTaBr4@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pci-owner@vger.kernel.org>
Sender: linux-pci-owner@vger.kernel.org
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Linux PCI <linux-pci@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Commit 448bd857d48e (PCI/PM: add PCIe runtime D3cold support) added
a check to prevent PCI devices from being put into D3cold during
system suspend without giving any particular reason (which was
overlooked during review).

Also that check causes the "freeze" sleep state to draw more power
than it can potentially, so drop the check.

Fixes: 448bd857d48e (PCI/PM: add PCIe runtime D3cold support)
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/pci/pci.c |    4 ----
 1 file changed, 4 deletions(-)

Index: linux-pm/drivers/pci/pci.c
===================================================================
--- linux-pm.orig/drivers/pci/pci.c
+++ linux-pm/drivers/pci/pci.c
@@ -1907,10 +1907,6 @@ int pci_prepare_to_sleep(struct pci_dev
 	if (target_state == PCI_POWER_ERROR)
 		return -EIO;
 
-	/* D3cold during system suspend/hibernate is not supported */
-	if (target_state > PCI_D3hot)
-		target_state = PCI_D3hot;
-
 	pci_enable_wake(dev, target_state, device_may_wakeup(&dev->dev));
 
 	error = pci_set_power_state(dev, target_state);
