From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v2 1/2] ata: ahci: Support state with min power but Partial low power state
Date: Fri, 27 Jul 2018 13:47:02 -0700
Message-ID: <20180727204703.6505-2-srinivas.pandruvada@linux.intel.com>
References: <20180727204703.6505-1-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180727204703.6505-1-srinivas.pandruvada@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tj@kernel.org, hdegoede@redhat.com, rjw@rjwysocki.net
Cc: alan.cox@intel.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Mario.Limonciello@dell.com, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

Currently when min_power policy is selected, the partial low power state
is not entered and link will try aggressively enter to only slumber state.
Add a new policy which still enable DEVSLP but also try to enter partial
low power state. This policy is presented as "min_power_with_partial".

For information the difference between partial and slumber
Partial – PHY logic is powered up, and in a reduced power state. The link
PM exit latency to active state maximum is 10 ns.
Slumber – PHY logic is powered up, and in a reduced power state. The link
PM exit latency to active state maximum is 10 ms.
Devslp – PHY logic is powered down. The link PM exit latency from this
state to active state maximum is 20 ms, unless otherwise specified by
DETO.

Suggested-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/ata/libahci.c     | 5 ++++-
 drivers/ata/libata-core.c | 1 +
 drivers/ata/libata-scsi.c | 1 +
 include/linux/libata.h    | 3 ++-
 4 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index 4c49c7c2a42c..94dcec2a8a5b 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -800,6 +800,8 @@ static int ahci_set_lpm(struct ata_link *link, enum ata_lpm_policy policy,
 			cmd |= PORT_CMD_ALPE;
 			if (policy == ATA_LPM_MIN_POWER)
 				cmd |= PORT_CMD_ASP;
+			else if (policy == ATA_LPM_MIN_POWER_WITH_PARTIAL)
+				cmd &= ~PORT_CMD_ASP;
 
 			/* write out new cmd value */
 			writel(cmd, port_mmio + PORT_CMD);
@@ -810,7 +812,8 @@ static int ahci_set_lpm(struct ata_link *link, enum ata_lpm_policy policy,
 	if ((hpriv->cap2 & HOST_CAP2_SDS) &&
 	    (hpriv->cap2 & HOST_CAP2_SADM) &&
 	    (link->device->flags & ATA_DFLAG_DEVSLP)) {
-		if (policy == ATA_LPM_MIN_POWER)
+		if (policy == ATA_LPM_MIN_POWER ||
+		    policy == ATA_LPM_MIN_POWER_WITH_PARTIAL)
 			ahci_set_aggressive_devslp(ap, true);
 		else
 			ahci_set_aggressive_devslp(ap, false);
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 27d15ed7fa3d..773b5f8eed1e 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -3967,6 +3967,7 @@ int sata_link_scr_lpm(struct ata_link *link, enum ata_lpm_policy policy,
 		scontrol |= (0x6 << 8);
 		break;
 	case ATA_LPM_MED_POWER_WITH_DIPM:
+	case ATA_LPM_MIN_POWER_WITH_PARTIAL:
 	case ATA_LPM_MIN_POWER:
 		if (ata_link_nr_enabled(link) > 0)
 			/* no restrictions on LPM transitions */
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 6a91d04351d9..4648bd5cee15 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -110,6 +110,7 @@ static const char *ata_lpm_policy_names[] = {
 	[ATA_LPM_MAX_POWER]		= "max_performance",
 	[ATA_LPM_MED_POWER]		= "medium_power",
 	[ATA_LPM_MED_POWER_WITH_DIPM]	= "med_power_with_dipm",
+	[ATA_LPM_MIN_POWER_WITH_PARTIAL] = "min_power_with_partial",
 	[ATA_LPM_MIN_POWER]		= "min_power",
 };
 
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 8b8946dd63b9..975543f8c1ff 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -522,7 +522,8 @@ enum ata_lpm_policy {
 	ATA_LPM_MAX_POWER,
 	ATA_LPM_MED_POWER,
 	ATA_LPM_MED_POWER_WITH_DIPM, /* Med power + DIPM as win IRST does */
-	ATA_LPM_MIN_POWER,
+	ATA_LPM_MIN_POWER_WITH_PARTIAL, /* Min Power + partial and slumber */
+	ATA_LPM_MIN_POWER, /* Min power + no partial (slumber only) */
 };
 
 enum ata_lpm_hints {
-- 
2.17.1
