From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] PCI / PM: Add dev_dbg() to print device suspend power states
Date: Sat, 30 Sep 2017 01:31:15 +0200
Message-ID: <8776535.A6PtrVU7Ea@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Bjorn Helgaas <bhelgaas@google.com>, Linux PCI <linux-pci@vger.kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

It sometimes is useful to know what power states the kernel thinks
it puts PCI devices into during system suspend, so add a dev_dbg()
statement for that.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/pci/pci-driver.c |    3 +++
 1 file changed, 3 insertions(+)

Index: linux-pm/drivers/pci/pci-driver.c
===================================================================
--- linux-pm.orig/drivers/pci/pci-driver.c
+++ linux-pm/drivers/pci/pci-driver.c
@@ -798,6 +798,9 @@ static int pci_pm_suspend_noirq(struct d
 			pci_prepare_to_sleep(pci_dev);
 	}
 
+	dev_dbg(dev, "PCI PM: Suspend power state: %s\n",
+		pci_power_name(pci_dev->current_state));
+
 	pci_pm_set_unknown_state(pci_dev);
 
 	/*
