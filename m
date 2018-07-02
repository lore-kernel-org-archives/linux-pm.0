From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [RFC PATCH] ata: ahci: Enable DEVSLP by default on x86 modern standby platform
Date: Mon,  2 Jul 2018 12:08:45 -0700
Message-ID: <20180702190845.7456-1-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tj@kernel.org, hdegoede@redhat.com, rjw@rjwysocki.net
Cc: alan.cox@intel.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Mario.Limonciello@dell.com, Srinivas <srinivas.pandruvada@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

From: Srinivas <srinivas.pandruvada@linux.intel.com>

One of the requirement for modern x86 system to enter lowest power mode
(SLP_S0) is SATA IP block to be off. This is true even during when
platform is suspended to idle and not only in opportunistic (runtime)
suspend.

Several of these system don't have traditional ACPI S3, so it is
important that they enter SLP_S0 state, to avoid draining battery even
during suspend even with out of the box Linux installation.

SATA IP block doesn't get turned off till SATA is in DEVSLP mode. Here
user has to either use scsi-host sysfs or tools like powertop to set
the sata-host link_power_management_policy to min_power.

This change sets by default link power management policy to min_power
for some platforms.  To avoid regressions, the following conditions
are used:
- The kernel config is already set to use med_power_with_dipm or deeper
- System is a modern standby system using ACPI low power idle flag
- The platform is not blacklisted for Suspend to Idle and suspend
to idle is used instead of S3
This combination will make sure that systems are fairly recent and
since getting shipped with modern standby standby, the DEVSLP function
is already validated.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/ata/ahci.c     | 13 +++++++++++++
 kernel/power/suspend.c |  1 +
 2 files changed, 14 insertions(+)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 738fb22978dd..0b8bd1b6cf7c 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -43,6 +43,7 @@
 #include <linux/dmi.h>
 #include <linux/gfp.h>
 #include <linux/msi.h>
+#include <linux/suspend.h>
 #include <scsi/scsi_host.h>
 #include <scsi/scsi_cmnd.h>
 #include <linux/libata.h>
@@ -1550,6 +1551,16 @@ static int ahci_init_msi(struct pci_dev *pdev, unsigned int n_ports,
 	return pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_MSIX);
 }
 
+static void ahci_update_mobile_policy(void)
+{
+#ifdef CONFIG_ACPI
+	if (mobile_lpm_policy > ATA_LPM_MED_POWER &&
+	    (acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0) &&
+	    mem_sleep_current == PM_SUSPEND_TO_IDLE)
+		mobile_lpm_policy = ATA_LPM_MIN_POWER;
+#endif
+}
+
 static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	unsigned int board_id = ent->driver_data;
@@ -1736,6 +1747,8 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (pi.flags & ATA_FLAG_EM)
 		ahci_reset_em(host);
 
+	ahci_update_mobile_policy();
+
 	for (i = 0; i < host->n_ports; i++) {
 		struct ata_port *ap = host->ports[i];
 
diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index 87331565e505..969e67715cf7 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -49,6 +49,7 @@ static const char * const mem_sleep_labels[] = {
 const char *mem_sleep_states[PM_SUSPEND_MAX];
 
 suspend_state_t mem_sleep_current = PM_SUSPEND_TO_IDLE;
+EXPORT_SYMBOL_GPL(mem_sleep_current);
 suspend_state_t mem_sleep_default = PM_SUSPEND_MAX;
 suspend_state_t pm_suspend_target_state;
 EXPORT_SYMBOL_GPL(pm_suspend_target_state);
-- 
2.17.1
