From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v2 2/2] ata: ahci: Enable DEVSLP by default on x86 with SLP_S0
Date: Fri, 27 Jul 2018 13:47:03 -0700
Message-ID: <20180727204703.6505-3-srinivas.pandruvada@linux.intel.com>
References: <20180727204703.6505-1-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180727204703.6505-1-srinivas.pandruvada@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tj@kernel.org, hdegoede@redhat.com, rjw@rjwysocki.net
Cc: alan.cox@intel.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Mario.Limonciello@dell.com, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

One of the requirement for modern x86 system to enter lowest power mode
(SLP_S0) is SATA IP block to be off. This is true even during when
platform is suspended to idle and not only in opportunistic (runtime)
suspend.

Several of these system don't have traditional ACPI S3, so it is
important that they enter SLP_S0 state, to avoid draining battery even
during suspend. So it is important that out of the box Linux installation
reach this state.

SATA IP block doesn't get turned off till SATA is in DEVSLP mode. Here
user has to either use scsi-host sysfs or tools like powertop to set
the sata-host link_power_management_policy to min_power.

This change sets by default link power management policy to min_power
with partial (preferred) or slumber support on idle for some platforms.

To avoid regressions, the following conditions are used:
- User didn't override the policy from module parameter
- The kernel config is already set to use med_power_with_dipm or deeper
- System is a SLP_S0 capable using ACPI low power idle flag
This combination will make sure that systems are fairly recent and
since getting shipped with SLP_S0 support, the DEVSLP function
is already validated.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/ata/ahci.c | 38 +++++++++++++++++++++++++++++++++-----
 1 file changed, 33 insertions(+), 5 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 738fb22978dd..b14dccda0154 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -609,7 +609,7 @@ static int marvell_enable = 1;
 module_param(marvell_enable, int, 0644);
 MODULE_PARM_DESC(marvell_enable, "Marvell SATA via AHCI (1 = enabled)");
 
-static int mobile_lpm_policy = CONFIG_SATA_MOBILE_LPM_POLICY;
+static int mobile_lpm_policy = -1;
 module_param(mobile_lpm_policy, int, 0644);
 MODULE_PARM_DESC(mobile_lpm_policy, "Default LPM policy for mobile chipsets");
 
@@ -1550,6 +1550,37 @@ static int ahci_init_msi(struct pci_dev *pdev, unsigned int n_ports,
 	return pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_MSIX);
 }
 
+static void ahci_update_initial_lpm_policy(struct ata_port *ap,
+					   struct ahci_host_priv *hpriv)
+{
+	int policy = CONFIG_SATA_MOBILE_LPM_POLICY;
+
+
+	/* Ignore processing for non mobile platforms */
+	if (!(hpriv->flags & AHCI_HFLAG_IS_MOBILE))
+		return;
+
+	/* user modified policy via module param */
+	if (mobile_lpm_policy != -1) {
+		policy = mobile_lpm_policy;
+		goto update_policy;
+	}
+
+#ifdef CONFIG_ACPI
+	if (policy > ATA_LPM_MED_POWER &&
+	    (acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0)) {
+		if (hpriv->cap & HOST_CAP_PART)
+			policy = ATA_LPM_MIN_POWER_WITH_PARTIAL;
+		else if (hpriv->cap & HOST_CAP_SSC)
+			policy = ATA_LPM_MIN_POWER;
+	}
+#endif
+
+update_policy:
+	if (policy >= ATA_LPM_UNKNOWN && policy <= ATA_LPM_MIN_POWER)
+		ap->target_lpm_policy = policy;
+}
+
 static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	unsigned int board_id = ent->driver_data;
@@ -1747,10 +1778,7 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 		if (ap->flags & ATA_FLAG_EM)
 			ap->em_message_type = hpriv->em_msg_type;
 
-		if ((hpriv->flags & AHCI_HFLAG_IS_MOBILE) &&
-		    mobile_lpm_policy >= ATA_LPM_UNKNOWN &&
-		    mobile_lpm_policy <= ATA_LPM_MIN_POWER)
-			ap->target_lpm_policy = mobile_lpm_policy;
+		ahci_update_initial_lpm_policy(ap, hpriv);
 
 		/* disabled/not-implemented port */
 		if (!(hpriv->port_map & (1 << i)))
-- 
2.17.1
