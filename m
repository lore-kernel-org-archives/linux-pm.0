From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFC][PATCH 3/10] PCI / PM: Propagate wake-up enable for
	PCIe devices too
Date: Mon, 16 Nov 2009 00:51:20 +0100
Message-ID: <200911160051.20362.rjw__8037.63425578854$1258329608$gmane$org@sisk.pl>
References: <200911160047.46299.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200911160047.46299.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: pm list <linux-pm@lists.linux-foundation.org>
Cc: Linux PCI <linux-pci@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

Having read the PM part of the PCIe 2.0 specification more carefully
I think that it was a mistake to restrict the wake-up enable
propagation to non-PCIe devices, because if we do not request
control of the root ports' PME registers via OSC, PCIe PME is
supposed to be handled by the platform, just like the non-PCIe PME.
Even if we do that, the wake-up propagation is done to allow the
devices to wake up the system from sleep states which involves the
platform anyway, so it won't hurt.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/pci/pci-acpi.c |   10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

Index: linux-2.6/drivers/pci/pci-acpi.c
===================================================================
--- linux-2.6.orig/drivers/pci/pci-acpi.c
+++ linux-2.6/drivers/pci/pci-acpi.c
@@ -112,11 +112,7 @@ static bool acpi_pci_can_wakeup(struct p
 static void acpi_pci_propagate_wakeup_enable(struct pci_bus *bus, bool enable)
 {
 	while (bus->parent) {
-		struct pci_dev *bridge = bus->self;
-		int ret;
-
-		ret = acpi_pm_device_sleep_wake(&bridge->dev, enable);
-		if (!ret || bridge->is_pcie)
+		if (!acpi_pm_device_sleep_wake(&bus->self->dev, enable))
 			return;
 		bus = bus->parent;
 	}
@@ -131,9 +127,7 @@ static int acpi_pci_sleep_wake(struct pc
 	if (acpi_pci_can_wakeup(dev))
 		return acpi_pm_device_sleep_wake(&dev->dev, enable);
 
-	if (!dev->is_pcie)
-		acpi_pci_propagate_wakeup_enable(dev->bus, enable);
-
+	acpi_pci_propagate_wakeup_enable(dev->bus, enable);
 	return 0;
 }
 
