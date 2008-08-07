From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH] PCI PM: Export pci_pme_active to drivers
Date: Fri, 8 Aug 2008 00:14:24 +0200
Message-ID: <200808080014.25493.rjw__45611.825239803$1218147248$gmane$org@sisk.pl>
References: <200808051730.27599.alessandro.guido@gmail.com>
	<200808070947.37534.jbarnes@virtuousgeek.org>
	<200808080000.07156.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200808080000.07156.rjw@sisk.pl>
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
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: Alessandro Guido <alessandro.guido@gmail.com>, pm list <linux-pm@lists.linux-foundation.org>, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

PCI PM: Export pci_pme_active to drivers

Export pci_pme_active() to drivers, so that they can clear the
PME_status bit and disable PME# for their devices without involving
ACPI.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/pci/pci.c   |    3 ++-
 include/linux/pci.h |    1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

Index: linux-2.6/drivers/pci/pci.c
===================================================================
--- linux-2.6.orig/drivers/pci/pci.c
+++ linux-2.6/drivers/pci/pci.c
@@ -1060,7 +1060,7 @@ bool pci_pme_capable(struct pci_dev *dev
  * The caller must verify that the device is capable of generating PME# before
  * calling this function with @enable equal to 'true'.
  */
-static void pci_pme_active(struct pci_dev *dev, bool enable)
+void pci_pme_active(struct pci_dev *dev, bool enable)
 {
 	u16 pmcsr;
 
@@ -1941,6 +1941,7 @@ EXPORT_SYMBOL(pci_set_power_state);
 EXPORT_SYMBOL(pci_save_state);
 EXPORT_SYMBOL(pci_restore_state);
 EXPORT_SYMBOL(pci_pme_capable);
+EXPORT_SYMBOL(pci_pme_active);
 EXPORT_SYMBOL(pci_enable_wake);
 EXPORT_SYMBOL(pci_target_state);
 EXPORT_SYMBOL(pci_prepare_to_sleep);
Index: linux-2.6/include/linux/pci.h
===================================================================
--- linux-2.6.orig/include/linux/pci.h
+++ linux-2.6/include/linux/pci.h
@@ -641,6 +641,7 @@ int pci_restore_state(struct pci_dev *de
 int pci_set_power_state(struct pci_dev *dev, pci_power_t state);
 pci_power_t pci_choose_state(struct pci_dev *dev, pm_message_t state);
 bool pci_pme_capable(struct pci_dev *dev, pci_power_t state);
+void pci_pme_active(struct pci_dev *dev, bool enable);
 int pci_enable_wake(struct pci_dev *dev, pci_power_t state, int enable);
 pci_power_t pci_target_state(struct pci_dev *dev);
 int pci_prepare_to_sleep(struct pci_dev *dev);
