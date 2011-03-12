From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 5/8] PCI / Intel IOMMU: Use syscore_ops instead
	of sysdev class and sysdev
Date: Sat, 12 Mar 2011 22:18:14 +0100
Message-ID: <201103122218.14832.rjw__47633.5209365518$1299965491$gmane$org@sisk.pl>
References: <201103100131.58206.rjw@sisk.pl> <201103122212.40828.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201103122212.40828.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: LKML <linux-kernel@vger.kernel.org>
Cc: Greg KH <gregkh@suse.de>, Jesse Barnes <jbarnes@virtuousgeek.org>, mingo@redhat.com, Avi Kivity <avi@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Kay Sievers <kay.sievers@suse.de>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, tglx@linutronix.de
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

The Intel IOMMU subsystem uses a sysdev class and a sysdev for
executing iommu_suspend() after interrupts have been turned off
on the boot CPU (during system suspend) and for executing
iommu_resume() before turning on interrupts on the boot CPU
(during system resume).  However, since both of these functions
ignore their arguments, the entire mechanism may be replaced with a
struct syscore_ops object which is simpler.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/pci/intel-iommu.c |   38 +++++++++-----------------------------
 1 file changed, 9 insertions(+), 29 deletions(-)

Index: linux-2.6/drivers/pci/intel-iommu.c
===================================================================
--- linux-2.6.orig/drivers/pci/intel-iommu.c
+++ linux-2.6/drivers/pci/intel-iommu.c
@@ -36,7 +36,7 @@
 #include <linux/iova.h>
 #include <linux/iommu.h>
 #include <linux/intel-iommu.h>
-#include <linux/sysdev.h>
+#include <linux/syscore_ops.h>
 #include <linux/tboot.h>
 #include <linux/dmi.h>
 #include <asm/cacheflush.h>
@@ -3135,7 +3135,7 @@ static void iommu_flush_all(void)
 	}
 }
 
-static int iommu_suspend(struct sys_device *dev, pm_message_t state)
+static int iommu_suspend(void)
 {
 	struct dmar_drhd_unit *drhd;
 	struct intel_iommu *iommu = NULL;
@@ -3175,7 +3175,7 @@ nomem:
 	return -ENOMEM;
 }
 
-static int iommu_resume(struct sys_device *dev)
+static void iommu_resume(void)
 {
 	struct dmar_drhd_unit *drhd;
 	struct intel_iommu *iommu = NULL;
@@ -3183,7 +3183,7 @@ static int iommu_resume(struct sys_devic
 
 	if (init_iommu_hw()) {
 		WARN(1, "IOMMU setup failed, DMAR can not resume!\n");
-		return -EIO;
+		return;
 	}
 
 	for_each_active_iommu(iommu, drhd) {
@@ -3204,40 +3204,20 @@ static int iommu_resume(struct sys_devic
 
 	for_each_active_iommu(iommu, drhd)
 		kfree(iommu->iommu_state);
-
-	return 0;
 }
 
-static struct sysdev_class iommu_sysclass = {
-	.name		= "iommu",
+static struct syscore_ops iommu_syscore_ops = {
 	.resume		= iommu_resume,
 	.suspend	= iommu_suspend,
 };
 
-static struct sys_device device_iommu = {
-	.cls	= &iommu_sysclass,
-};
-
-static int __init init_iommu_sysfs(void)
+static void __init init_iommu_pm_ops(void)
 {
-	int error;
-
-	error = sysdev_class_register(&iommu_sysclass);
-	if (error)
-		return error;
-
-	error = sysdev_register(&device_iommu);
-	if (error)
-		sysdev_class_unregister(&iommu_sysclass);
-
-	return error;
+	register_syscore_ops(&iommu_syscore_ops);
 }
 
 #else
-static int __init init_iommu_sysfs(void)
-{
-	return 0;
-}
+static inline int init_iommu_pm_ops(void) { }
 #endif	/* CONFIG_PM */
 
 /*
@@ -3320,7 +3300,7 @@ int __init intel_iommu_init(void)
 #endif
 	dma_ops = &intel_dma_ops;
 
-	init_iommu_sysfs();
+	init_iommu_pm_ops();
 
 	register_iommu(&intel_iommu_ops);
 
