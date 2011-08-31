From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: [PATCH 4/7] xen: Utilize the restore_msi_irqs hook.
Date: Wed, 31 Aug 2011 14:31:21 -0400
Message-ID: <1314815484-4668-5-git-send-email-konrad.wilk__49559.7870824442$1314916922$gmane$org@oracle.com>
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

to make a hypercall to restore the vectors in the MSI/MSI-X
configuration space.

Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
---
 arch/x86/pci/xen.c              |   12 ++++++++++++
 include/xen/interface/physdev.h |    7 +++++++
 2 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/arch/x86/pci/xen.c b/arch/x86/pci/xen.c
index f567965..f140999 100644
--- a/arch/x86/pci/xen.c
+++ b/arch/x86/pci/xen.c
@@ -241,6 +241,17 @@ static int xen_initdom_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
 out:
 	return ret;
 }
+
+static void xen_initdom_restore_msi_irqs(struct pci_dev *dev, int irq)
+{
+	int ret = 0;
+	struct physdev_restore_msi restore;
+
+	restore.bus = dev->bus->number;
+	restore.devfn = dev->devfn;
+	ret = HYPERVISOR_physdev_op(PHYSDEVOP_restore_msi, &restore);
+	WARN(ret && ret != -ENOSYS, "restore_msi -> %d\n", ret);
+}
 #endif
 #endif
 
@@ -458,6 +469,7 @@ static int __init pci_xen_initial_domain(void)
 #ifdef CONFIG_PCI_MSI
 	x86_msi.setup_msi_irqs = xen_initdom_setup_msi_irqs;
 	x86_msi.teardown_msi_irq = xen_teardown_msi_irq;
+	x86_msi.restore_msi_irqs = xen_initdom_restore_msi_irqs;
 #endif
 	xen_setup_acpi_sci();
 	__acpi_register_gsi = acpi_register_gsi_xen;
diff --git a/include/xen/interface/physdev.h b/include/xen/interface/physdev.h
index 534cac8..44aefa9 100644
--- a/include/xen/interface/physdev.h
+++ b/include/xen/interface/physdev.h
@@ -144,6 +144,13 @@ struct physdev_manage_pci {
 	uint8_t devfn;
 };
 
+#define PHYSDEVOP_restore_msi            19
+struct physdev_restore_msi {
+	/* IN */
+	uint8_t bus;
+	uint8_t devfn;
+};
+
 #define PHYSDEVOP_manage_pci_add_ext	20
 struct physdev_manage_pci_ext {
 	/* IN */
-- 
1.7.4.1
