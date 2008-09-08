From: shaohua.li@intel.com
Subject: [RFC 3/5] pci wakeup handler
Date: Mon, 08 Sep 2008 17:19:29 +0800
Message-ID: <20080908092305.438330804__33405.6193045855$1220866148$gmane$org@sli10-desk.sh.intel.com>
References: <20080908091926.785882370@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline; filename=pci-wakeup-event.patch
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org, linux-acpi@vger.kernel.org
Cc: dbrownell@users.sourceforge.net
List-Id: linux-pm@vger.kernel.org

pci subsystem wakeup handler.
---
 drivers/pci/pci-driver.c |   46 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

Index: linux/drivers/pci/pci-driver.c
===================================================================
--- linux.orig/drivers/pci/pci-driver.c	2008-09-08 13:55:56.000000000 +0800
+++ linux/drivers/pci/pci-driver.c	2008-09-08 14:24:42.000000000 +0800
@@ -472,12 +472,57 @@ static int pci_pm_resume_noirq(struct de
 	return error;
 }
 
+/*
+ * Called when dev is suspected to invoke a wakeup event, return 0 if yes
+ * */
+static int pci_pm_wakeup_event(struct device *dev)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	int pme_pos = pci_find_capability(pdev, PCI_CAP_ID_PM);
+	struct pci_driver *drv = pdev->driver;
+	u16 reg16;
+	int spurious = 0;
+	int ret = -ENODEV;
+
+	if (pme_pos == 0) {
+		/*
+		 * Some USB devices haven't PME, but have specific registers to
+		 * control wakeup
+		 */
+		goto out;
+	}
+
+	/* clear PME status and disable PME to avoid interrupt flood */
+	pci_read_config_word(pdev, pme_pos + PCI_PM_CTRL, &reg16);
+	if (!(reg16 & PCI_PM_CTRL_PME_STATUS))
+		return -ENODEV;
+	/* I see spurious GPE here, just ignore it for now */
+	if (!(reg16 & PCI_PM_CTRL_PME_ENABLE))
+		spurious = 1;
+	reg16 &= ~PCI_PM_CTRL_PME_ENABLE;
+	reg16 |= PCI_PM_CTRL_PME_STATUS;
+	pci_write_config_word(pdev, pme_pos + PCI_PM_CTRL, reg16);
+
+	if (spurious)
+		return -ENODEV;
+	ret = 0;
+	/* This device invokes PME, gives driver a chance to do something */
+out:
+	if (drv && drv->pm && drv->pm->base.wakeup_event) {
+		if (!ret) /* ignore return value in this case */
+			drv->pm->base.wakeup_event(&pdev->dev);
+		else
+			return drv->pm->base.wakeup_event(&pdev->dev);
+	}
+	return ret;
+}
 #else /* !CONFIG_SUSPEND */
 
 #define pci_pm_suspend		NULL
 #define pci_pm_suspend_noirq	NULL
 #define pci_pm_resume		NULL
 #define pci_pm_resume_noirq	NULL
+#define pci_pm_wakeup_event	NULL
 
 #endif /* !CONFIG_SUSPEND */
 
@@ -651,6 +696,7 @@ struct pm_ext_ops pci_pm_ops = {
 		.thaw = pci_pm_thaw,
 		.poweroff = pci_pm_poweroff,
 		.restore = pci_pm_restore,
+		.wakeup_event = pci_pm_wakeup_event,
 	},
 	.suspend_noirq = pci_pm_suspend_noirq,
 	.resume_noirq = pci_pm_resume_noirq,

-- 
