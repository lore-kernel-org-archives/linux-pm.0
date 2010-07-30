From: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
Subject: [PATCH] portdrv: Don't take control of AER if not
	required
Date: Fri, 30 Jul 2010 17:47:20 +0900
Message-ID: <4C529198.1050904__26492.5678763122$1280479963$gmane$org@jp.fujitsu.com>
References: <201007282323.56351.rjw@sisk.pl>
	<20100728144358.5e2c12ce@virtuousgeek.org>
	<4C510B90.9070302@jp.fujitsu.com> <201007291745.39285.rjw@sisk.pl>
	<4C526A85.3070902@jp.fujitsu.com> <4C526E3E.3000600@jp.fujitsu.com>
	<4C526FDC.6050800@jp.fujitsu.com> <4C529086.9090600@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4C529086.9090600@jp.fujitsu.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Cc: linux-pci@vger.kernel.org, Jesse Barnes <jbarnes@virtuousgeek.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

OS cannot handle AER when:
 - !CONFIG_PCIEAER
 - option pci=noaer is specified
 - MSIs are globally disabled (by quirk for the chipset etc.)

In such cases don't request AER control via _OSC.

Signed-off-by: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
---
 drivers/pci/pci.h               |    2 ++
 drivers/pci/pcie/aer/aerdrv.c   |    9 ++++++---
 drivers/pci/pcie/portdrv_acpi.c |    5 ++++-
 drivers/pci/pcie/portdrv_core.c |    2 ++
 4 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index f8077b3..d09d4f3 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -130,8 +130,10 @@ static inline void pci_msi_init_pci_dev(struct pci_dev *dev) { }
 
 #ifdef CONFIG_PCIEAER
 void pci_no_aer(void);
+bool pci_aer_available(void);
 #else
 static inline void pci_no_aer(void) { }
+static inline bool pci_aer_available(void) { return false; }
 #endif
 
 static inline int pci_no_d1d2(struct pci_dev *dev)
diff --git a/drivers/pci/pcie/aer/aerdrv.c b/drivers/pci/pcie/aer/aerdrv.c
index 484cc55..4fbec91 100644
--- a/drivers/pci/pcie/aer/aerdrv.c
+++ b/drivers/pci/pcie/aer/aerdrv.c
@@ -67,6 +67,11 @@ static struct pcie_port_service_driver aerdriver = {
 
 static int pcie_aer_disable;
 
+bool pci_aer_available(void)
+{
+	return !pcie_aer_disable && pci_msi_enabled();
+}
+
 void pci_no_aer(void)
 {
 	pcie_aer_disable = 1;	/* has priority over 'forceload' */
@@ -411,9 +416,7 @@ static void aer_error_resume(struct pci_dev *dev)
  */
 static int __init aer_service_init(void)
 {
-	if (pcie_aer_disable)
-		return -ENXIO;
-	if (!pci_msi_enabled())
+	if (!pci_aer_available())
 		return -ENXIO;
 	return pcie_port_service_register(&aerdriver);
 }
diff --git a/drivers/pci/pcie/portdrv_acpi.c b/drivers/pci/pcie/portdrv_acpi.c
index a957de2..c8814b9 100644
--- a/drivers/pci/pcie/portdrv_acpi.c
+++ b/drivers/pci/pcie/portdrv_acpi.c
@@ -16,6 +16,7 @@
 #include <linux/pcieport_if.h>
 
 #include "aer/aerdrv.h"
+#include "../pci.h"
 
 /**
  * pcie_port_acpi_setup - Request the BIOS to release control of PCIe services.
@@ -48,7 +49,9 @@ int pcie_port_acpi_setup(struct pci_dev *port, int *srv_mask)
 		   OSC_PCI_EXPRESS_PME_CONTROL |
 		   OSC_PCI_EXPRESS_AER_CONTROL);
 
-	if (pcie_aer_get_firmware_first(port)) {
+	if (!pci_aer_available()) {
+		request &= ~OSC_PCI_EXPRESS_AER_CONTROL;
+	} else if (pcie_aer_get_firmware_first(port)) {
 		dev_dbg(&port->dev, "PCIe errors handled by BIOS.\n");
 		request &= ~OSC_PCI_EXPRESS_AER_CONTROL;
 	}
diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
index 8e96bd4..8e26025 100644
--- a/drivers/pci/pcie/portdrv_core.c
+++ b/drivers/pci/pcie/portdrv_core.c
@@ -246,6 +246,8 @@ static int get_port_device_capability(struct pci_dev *dev)
 			return 0;
 	} else {
 		cap_mask = PCIE_PORT_SERVICE_MASK;
+		if (!pci_aer_available())
+			cap_mask &= ~PCIE_PORT_SERVICE_AER;
 	}
 
 	pos = pci_pcie_cap(dev);
-- 
1.7.2
