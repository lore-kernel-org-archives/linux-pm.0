From: Johannes Berg <johannes@sipsolutions.net>
Subject: [RFC 08/10] powerpc: dart iommu suspend
Date: Mon, 05 Feb 2007 19:30:35 +0100
Message-ID: <20070205185838.029827000@sipsolutions.net>
References: <20070205183026.989209000@sipsolutions.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline; filename=dart-suspend.patch
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: linuxppc-dev@ozlabs.org
Cc: linux-pm@lists.osdl.org, Torrance <torrance123@gmail.com>
List-Id: linux-pm@vger.kernel.org

This implements suspend and resume code for the dart iommu.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>

---
Just come to think of it, I made it conditional on
CONFIG_SOFTWARE_SUSPEND but could imagine that it should
instead depend on CONFIG_PM... There is no lowlevel suspend
to RAM code yet which would call this so for now it's
probably fine.

--- mb-wireless.orig/arch/powerpc/sysdev/dart_iommu.c	2007-02-05 14:24:04.8=
34526864 +0100
+++ mb-wireless/arch/powerpc/sysdev/dart_iommu.c	2007-02-05 14:24:40.684526=
864 +0100
@@ -54,6 +54,9 @@ static unsigned long dart_tablesize;
 =

 /* Virtual base address of the DART table */
 static u32 *dart_vbase;
+#ifdef CONFIG_SOFTWARE_SUSPEND
+static u32 *dart_copy;
+#endif
 =

 /* Mapped base address for the dart */
 static unsigned int __iomem *dart;
@@ -346,6 +349,52 @@ void iommu_init_early_dart(void)
 	pci_dma_ops =3D &dma_direct_ops;
 }
 =

+#ifdef CONFIG_SOFTWARE_SUSPEND
+static int iommu_init_late_dart(void)
+{
+	unsigned long i;
+	struct page *p;
+
+	/* this 16MB area is left unmapped because of caching
+	 * considerations. that happens early so we can't mark
+	 * it there, do it now instead */
+	for (i =3D 0; i < (1<<24); i+=3D PAGE_SIZE)
+		SetPageNosave(virt_to_page((void*)((unsigned long)dart_tablebase + i)));
+
+	/* if no dart table exists then we don't need to save it */
+	if (!dart_tablebase)
+		return 0;
+
+	/* For suspend we need to copy the dart contents because
+	 * it is not part of the regular mapping (see above) and
+	 * thus not saved automatically. The memory for this copy
+	 * must be allocated early because we need 2 MB. */
+	p =3D alloc_pages(GFP_KERNEL, 21 - PAGE_SHIFT);
+	BUG_ON(!p);
+	dart_copy =3D page_address(p);
+
+	return 0;
+}
+
+late_initcall(iommu_init_late_dart);
+
+void iommu_dart_save(void)
+{
+	if (!dart_tablebase)
+		return;
+
+	memcpy(dart_copy, dart_vbase, 2*1024*1024);
+}
+
+void iommu_dart_restore(void)
+{
+	if (!dart_tablebase)
+		return;
+
+	memcpy(dart_vbase, dart_copy, 2*1024*1024);
+	dart_tlb_invalidate_all();
+}
+#endif
 =

 void __init alloc_dart_table(void)
 {
--- mb-wireless.orig/include/asm-powerpc/iommu.h	2007-02-05 14:24:05.014526=
864 +0100
+++ mb-wireless/include/asm-powerpc/iommu.h	2007-02-05 14:24:40.684526864 +=
0100
@@ -108,6 +108,10 @@ static inline void pci_iommu_init(void) =

 #endif
 =

 extern void alloc_dart_table(void);
+#if defined(CONFIG_SOFTWARE_SUSPEND) && defined(CONFIG_U3_DART)
+extern void iommu_dart_save(void);
+extern void iommu_dart_restore(void);
+#endif
 =

 #endif /* __KERNEL__ */
 #endif /* _ASM_IOMMU_H */

--
