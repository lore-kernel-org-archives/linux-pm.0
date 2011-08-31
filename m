From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: [PATCH 1/7] x86: Expand the x86_msi_ops to have a
	restore MSIs.
Date: Wed, 31 Aug 2011 14:31:18 -0400
Message-ID: <1314815484-4668-2-git-send-email-konrad.wilk__14850.9384984665$1314919362$gmane$org@oracle.com>
References: <1314815484-4668-1-git-send-email-konrad.wilk@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1314815484-4668-1-git-send-email-konrad.wilk@oracle.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: x86@kernel.org, tglx@linutronix.de, tboot-devel@lists.sourceforge.net, shane.wang@intel.com, linux-pm@lists.linux-foundation.org, linux-acpi@vger.kernel.org, len.brown@in
Cc: xen-devel@lists.xensource.com, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
List-Id: linux-pm@vger.kernel.org

The MSI restore function will become a function pointer in an
x86_msi_ops struct. It defaults to the implementation in the
io_apic.c and msi.c. We piggyback on the indirection mechanism
introduced by "x86: Introduce x86_msi_ops".

Cc: x86@kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
---
 arch/x86/include/asm/pci.h      |    9 +++++++++
 arch/x86/include/asm/x86_init.h |    1 +
 arch/x86/kernel/x86_init.c      |    1 +
 drivers/pci/msi.c               |   29 +++++++++++++++++++++++++++--
 4 files changed, 38 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/pci.h b/arch/x86/include/asm/pci.h
index d498943..df75d07 100644
--- a/arch/x86/include/asm/pci.h
+++ b/arch/x86/include/asm/pci.h
@@ -112,19 +112,28 @@ static inline void x86_teardown_msi_irq(unsigned int irq)
 {
 	x86_msi.teardown_msi_irq(irq);
 }
+static inline void x86_restore_msi_irqs(struct pci_dev *dev, int irq)
+{
+	x86_msi.restore_msi_irqs(dev, irq);
+}
 #define arch_setup_msi_irqs x86_setup_msi_irqs
 #define arch_teardown_msi_irqs x86_teardown_msi_irqs
 #define arch_teardown_msi_irq x86_teardown_msi_irq
+#define arch_restore_msi_irqs x86_restore_msi_irqs
 /* implemented in arch/x86/kernel/apic/io_apic. */
 int native_setup_msi_irqs(struct pci_dev *dev, int nvec, int type);
 void native_teardown_msi_irq(unsigned int irq);
+void native_restore_msi_irqs(struct pci_dev *dev, int irq);
 /* default to the implementation in drivers/lib/msi.c */
 #define HAVE_DEFAULT_MSI_TEARDOWN_IRQS
+#define HAVE_DEFAULT_MSI_RESTORE_IRQS
 void default_teardown_msi_irqs(struct pci_dev *dev);
+void default_restore_msi_irqs(struct pci_dev *dev, int irq);
 #else
 #define native_setup_msi_irqs		NULL
 #define native_teardown_msi_irq		NULL
 #define default_teardown_msi_irqs	NULL
+#define default_restore_msi_irqs	NULL
 #endif
 
 #define PCI_DMA_BUS_IS_PHYS (dma_ops->is_phys)
diff --git a/arch/x86/include/asm/x86_init.h b/arch/x86/include/asm/x86_init.h
index d3d8590..7af18be 100644
--- a/arch/x86/include/asm/x86_init.h
+++ b/arch/x86/include/asm/x86_init.h
@@ -174,6 +174,7 @@ struct x86_msi_ops {
 	int (*setup_msi_irqs)(struct pci_dev *dev, int nvec, int type);
 	void (*teardown_msi_irq)(unsigned int irq);
 	void (*teardown_msi_irqs)(struct pci_dev *dev);
+	void (*restore_msi_irqs)(struct pci_dev *dev, int irq);
 };
 
 extern struct x86_init_ops x86_init;
diff --git a/arch/x86/kernel/x86_init.c b/arch/x86/kernel/x86_init.c
index 6f164bd..bd1fe10 100644
--- a/arch/x86/kernel/x86_init.c
+++ b/arch/x86/kernel/x86_init.c
@@ -110,4 +110,5 @@ struct x86_msi_ops x86_msi = {
 	.setup_msi_irqs = native_setup_msi_irqs,
 	.teardown_msi_irq = native_teardown_msi_irq,
 	.teardown_msi_irqs = default_teardown_msi_irqs,
+	.restore_msi_irqs = default_restore_msi_irqs,
 };
diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 2f10328..f1fd801 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -85,6 +85,31 @@ void default_teardown_msi_irqs(struct pci_dev *dev)
 }
 #endif
 
+#ifndef arch_restore_msi_irqs
+# define arch_restore_msi_irqs default_restore_msi_irqs
+# define HAVE_DEFAULT_MSI_RESTORE_IRQS
+#endif
+
+#ifdef HAVE_DEFAULT_MSI_RESTORE_IRQS
+void default_restore_msi_irqs(struct pci_dev *dev, int irq)
+{
+	struct msi_desc *entry;
+
+	entry = NULL;
+	if (dev->msix_enabled) {
+		list_for_each_entry(entry, &dev->msi_list, list) {
+			if (irq == entry->irq)
+				break;
+		}
+	} else if (dev->msi_enabled)  {
+		entry = irq_get_msi_desc(irq);
+	}
+
+	if (entry)
+		write_msi_msg(irq, &entry->msg);
+}
+#endif
+
 static void msi_set_enable(struct pci_dev *dev, int pos, int enable)
 {
 	u16 control;
@@ -359,7 +384,7 @@ static void __pci_restore_msi_state(struct pci_dev *dev)
 
 	pci_intx_for_msi(dev, 0);
 	msi_set_enable(dev, pos, 0);
-	write_msi_msg(dev->irq, &entry->msg);
+	arch_restore_msi_irqs(dev, dev->irq);
 
 	pci_read_config_word(dev, pos + PCI_MSI_FLAGS, &control);
 	msi_mask_irq(entry, msi_capable_mask(control), entry->masked);
@@ -387,7 +412,7 @@ static void __pci_restore_msix_state(struct pci_dev *dev)
 	pci_write_config_word(dev, pos + PCI_MSIX_FLAGS, control);
 
 	list_for_each_entry(entry, &dev->msi_list, list) {
-		write_msi_msg(entry->irq, &entry->msg);
+		arch_restore_msi_irqs(dev, entry->irq);
 		msix_mask_irq(entry, entry->masked);
 	}
 
-- 
1.7.4.1
