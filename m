From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] ACPI/PCI: PM: Add missing wakeup.flags.valid checks
Date: Thu, 16 May 2019 12:42:20 +0200
Message-ID: <2091978.9z20bSIm3T@kreacher>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Linux PCI <linux-pci@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Both acpi_pci_need_resume() and acpi_dev_needs_resume() check if the
current ACPI wakeup configuration of the device matches what is
expected as far as system wakeup from sleep states is concerned, as
reflected by the device_may_wakeup() return value for the device.

However, they only should do that if wakeup.flags.valid is set for
the device's ACPI companion, because otherwise the wakeup.prepare_count
value for it is meaningless.

Add the missing wakeup.flags.valid checks to these functions.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/device_pm.c |    4 ++--
 drivers/pci/pci-acpi.c   |    3 ++-
 2 files changed, 4 insertions(+), 3 deletions(-)

Index: linux-pm/drivers/pci/pci-acpi.c
===================================================================
--- linux-pm.orig/drivers/pci/pci-acpi.c
+++ linux-pm/drivers/pci/pci-acpi.c
@@ -666,7 +666,8 @@ static bool acpi_pci_need_resume(struct
 	if (!adev || !acpi_device_power_manageable(adev))
 		return false;
 
-	if (device_may_wakeup(&dev->dev) != !!adev->wakeup.prepare_count)
+	if (adev->wakeup.flags.valid &&
+	    device_may_wakeup(&dev->dev) != !!adev->wakeup.prepare_count)
 		return true;
 
 	if (acpi_target_system_state() == ACPI_STATE_S0)
Index: linux-pm/drivers/acpi/device_pm.c
===================================================================
--- linux-pm.orig/drivers/acpi/device_pm.c
+++ linux-pm/drivers/acpi/device_pm.c
@@ -952,8 +952,8 @@ static bool acpi_dev_needs_resume(struct
 	u32 sys_target = acpi_target_system_state();
 	int ret, state;
 
-	if (!pm_runtime_suspended(dev) || !adev ||
-	    device_may_wakeup(dev) != !!adev->wakeup.prepare_count)
+	if (!pm_runtime_suspended(dev) || !adev || (adev->wakeup.flags.valid &&
+	    device_may_wakeup(dev) != !!adev->wakeup.prepare_count))
 		return true;
 
 	if (sys_target == ACPI_STATE_S0)
