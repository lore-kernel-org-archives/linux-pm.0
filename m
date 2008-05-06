From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 4/4] PCI ACPI: Drop the second argument of
	platform_pci_choose_state
Date: Tue, 6 May 2008 23:38:41 +0200
Message-ID: <200805062338.42587.rjw__28572.6971728311$1210110194$gmane$org@sisk.pl>
References: <200805062331.39454.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200805062331.39454.rjw@sisk.pl>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Len Brown <lenb@kernel.org>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Johannes Berg <johannes@sipsolutions.net>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

Since the second argument of acpi_pci_choose_state() and
platform_pci_choose_state() is never used, so remove it.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/pci/pci-acpi.c |    3 +--
 drivers/pci/pci.c      |    4 ++--
 drivers/pci/pci.h      |    3 +--
 3 files changed, 4 insertions(+), 6 deletions(-)

Index: linux-2.6/drivers/pci/pci-acpi.c
===================================================================
--- linux-2.6.orig/drivers/pci/pci-acpi.c
+++ linux-2.6/drivers/pci/pci-acpi.c
@@ -244,8 +244,7 @@ EXPORT_SYMBOL(pci_osc_control_set);
  * 	choose highest power _SxD or any lower power
  */
 
-static pci_power_t acpi_pci_choose_state(struct pci_dev *pdev,
-	pm_message_t state)
+static pci_power_t acpi_pci_choose_state(struct pci_dev *pdev)
 {
 	int acpi_state;
 
Index: linux-2.6/drivers/pci/pci.c
===================================================================
--- linux-2.6.orig/drivers/pci/pci.c
+++ linux-2.6/drivers/pci/pci.c
@@ -508,7 +508,7 @@ pci_set_power_state(struct pci_dev *dev,
 	return 0;
 }
 
-pci_power_t (*platform_pci_choose_state)(struct pci_dev *dev, pm_message_t state);
+pci_power_t (*platform_pci_choose_state)(struct pci_dev *dev);
  
 /**
  * pci_choose_state - Choose the power state of a PCI device
@@ -528,7 +528,7 @@ pci_power_t pci_choose_state(struct pci_
 		return PCI_D0;
 
 	if (platform_pci_choose_state) {
-		ret = platform_pci_choose_state(dev, state);
+		ret = platform_pci_choose_state(dev);
 		if (ret != PCI_POWER_ERROR)
 			return ret;
 	}
Index: linux-2.6/drivers/pci/pci.h
===================================================================
--- linux-2.6.orig/drivers/pci/pci.h
+++ linux-2.6/drivers/pci/pci.h
@@ -6,8 +6,7 @@ extern void pci_remove_sysfs_dev_files(s
 extern void pci_cleanup_rom(struct pci_dev *dev);
 
 /* Firmware callbacks */
-extern pci_power_t (*platform_pci_choose_state)(struct pci_dev *dev,
-						pm_message_t state);
+extern pci_power_t (*platform_pci_choose_state)(struct pci_dev *dev);
 extern int (*platform_pci_set_power_state)(struct pci_dev *dev,
 						pci_power_t state);
 
