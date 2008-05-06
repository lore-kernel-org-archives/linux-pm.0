From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 2/2] PCI PM: Introduce pci_preferred_state
Date: Tue, 6 May 2008 23:49:17 +0200
Message-ID: <200805062349.18683.rjw__2762.77186717397$1210110761$gmane$org@sisk.pl>
References: <200805062342.42789.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200805062342.42789.rjw@sisk.pl>
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
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Jesse Barnes <jbarnes@virtuousgeek.org>
List-Id: linux-pm@vger.kernel.org

[Well, this essentially is a PCI patch, but it modifies include/linux/pm.h too.]
---
From: Rafael J. Wysocki <rjw@sisk.pl>

The new suspend and hibernation callbacks introduced with
'struct pm_ops' and 'struct pm_ext_ops' do not take a
pm_message_t argument, so the drivers using them will not be able
to use pci_choose_state() in its present form.  For this reason,
introduce the new function pci_preferred_state() playing the role
of pci_choose_state(), but taking only a pointer to the device
object.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/pci/pci.c   |   33 ++++++++++++++++++++++++++++++++-
 include/linux/pci.h |    1 +
 include/linux/pm.h  |   10 ++++++++++
 3 files changed, 43 insertions(+), 1 deletion(-)

Index: linux-2.6/drivers/pci/pci.c
===================================================================
--- linux-2.6.orig/drivers/pci/pci.c
+++ linux-2.6/drivers/pci/pci.c
@@ -509,7 +509,38 @@ pci_set_power_state(struct pci_dev *dev,
 }
 
 pci_power_t (*platform_pci_choose_state)(struct pci_dev *dev);
- 
+
+/**
+ * pci_preferred_state - Choose the preferred power state of a PCI device
+ * @dev: PCI device to be put into the low power state
+ * @sp: Information aboutabout what the driver would prefer to do with
+ *	the device if there were no platform-implemeted policy.
+ *
+ * Returns PCI power state suitable for given device and given suspend policy.
+ * The policy, however, is only used if platform_pci_choose_state() fails or is
+ * not present.  Otherwise, it is assumed that platform_pci_choose_state()
+ * implements the right policy.
+ */
+
+pci_power_t pci_preferred_state(struct pci_dev *dev, enum suspend_policy sp)
+{
+	pci_power_t ret;
+
+	if (!pci_find_capability(dev, PCI_CAP_ID_PM))
+		return PCI_D0;
+
+	ret = (sp == SP_TURN_OFF) ? PCI_D3hot : PCI_D0;
+	if (platform_pci_choose_state) {
+		pci_power_t platform_ret = platform_pci_choose_state(dev);
+
+		if (platform_ret != PCI_POWER_ERROR)
+			ret = platform_ret;
+	}
+	return ret;
+}
+
+EXPORT_SYMBOL(pci_preferred_state);
+
 /**
  * pci_choose_state - Choose the power state of a PCI device
  * @dev: PCI device to be suspended
Index: linux-2.6/include/linux/pci.h
===================================================================
--- linux-2.6.orig/include/linux/pci.h
+++ linux-2.6/include/linux/pci.h
@@ -615,6 +615,7 @@ size_t pci_get_rom_size(void __iomem *ro
 int pci_save_state(struct pci_dev *dev);
 int pci_restore_state(struct pci_dev *dev);
 int pci_set_power_state(struct pci_dev *dev, pci_power_t state);
+pci_power_t pci_preferred_state(struct pci_dev *dev, enum suspend_policy sp);
 pci_power_t pci_choose_state(struct pci_dev *dev, pm_message_t state);
 int pci_enable_wake(struct pci_dev *dev, pci_power_t state, int enable);
 
Index: linux-2.6/include/linux/pm.h
===================================================================
--- linux-2.6.orig/include/linux/pm.h
+++ linux-2.6/include/linux/pm.h
@@ -391,6 +391,16 @@ struct dev_pm_info {
 };
 
 /*
+ * Used to pass the information about what the driver would prefer to do with
+ * its device before the system in put into a sleep state, if there were no
+ * platform-implemeted policy.
+ */
+enum suspend_policy {
+	SP_TURN_ON,
+	SP_TURN_OFF,
+};
+
+/*
  * The PM_EVENT_ messages are also used by drivers implementing the legacy
  * suspend framework, based on the ->suspend() and ->resume() callbacks common
  * for suspend and hibernation transitions, according to the rules below.
