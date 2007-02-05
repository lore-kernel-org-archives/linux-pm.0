From: Johannes Berg <johannes@sipsolutions.net>
Subject: [RFC 06/10] powerpc: MPIC sys_device & suspend/resume
Date: Mon, 05 Feb 2007 19:30:33 +0100
Message-ID: <20070205185837.244398000@sipsolutions.net>
References: <20070205183026.989209000@sipsolutions.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline; filename=mpic-suspend.patch
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

This adds mpic to the system devices and implements suspend
and resume for them. This is necessary to get interrupts for
modules back to where they were before a suspend to disk.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>

---
The first hunk is just a tiny whitespace cleanup.

Without this patch, i2sbus (built as a module) for example
doesn't work properly across a suspend-to-disk/resume cycle,
with this patch it works fine.

I'm not entirely sure if there should be some wait logic
after I restore the MPIC registers, it works as-is for me.

--- mb-wireless.orig/arch/powerpc/sysdev/mpic.c	2007-02-05 14:24:05.7345268=
64 +0100
+++ mb-wireless/arch/powerpc/sysdev/mpic.c	2007-02-05 14:24:39.464526864 +0=
100
@@ -1123,7 +1123,7 @@ void __init mpic_init(struct mpic *mpic)
 	/* Do the HT PIC fixups on U3 broken mpic */
 	DBG("MPIC flags: %x\n", mpic->flags);
 	if ((mpic->flags & MPIC_BROKEN_U3) && (mpic->flags & MPIC_PRIMARY))
- 		mpic_scan_ht_pics(mpic);
+		mpic_scan_ht_pics(mpic);
 =

 	for (i =3D 0; i < mpic->num_sources; i++) {
 		/* start with vector =3D source number, and masked */
@@ -1147,6 +1147,12 @@ void __init mpic_init(struct mpic *mpic)
 =

 	/* Set current processor priority to 0 */
 	mpic_cpu_write(MPIC_INFO(CPU_CURRENT_TASK_PRI), 0);
+
+#ifdef CONFIG_PM
+	/* allocate memory to save mpic state */
+	mpic->save_data =3D alloc_bootmem(mpic->num_sources * sizeof(struct mpic_=
irq_save));
+	BUG_ON(mpic->save_data =3D=3D NULL);
+#endif
 }
 =

 void __init mpic_set_clk_ratio(struct mpic *mpic, u32 clock_ratio)
@@ -1376,3 +1382,61 @@ void smp_mpic_message_pass(int target, i
 	}
 }
 #endif /* CONFIG_SMP */
+
+#ifdef CONFIG_PM
+static int mpic_suspend(struct sys_device *dev, pm_message_t state)
+{
+	struct mpic *mpic =3D container_of(dev, struct mpic, sysdev);
+	int i;
+
+	for (i =3D 0; i < mpic->num_sources; i++) {
+		mpic->save_data[i].vecprio =3D
+			mpic_irq_read(i, MPIC_INFO(IRQ_VECTOR_PRI));
+		mpic->save_data[i].dest =3D
+			mpic_irq_read(i, MPIC_INFO(IRQ_DESTINATION));
+	}
+
+	return 0;
+}
+
+static int mpic_resume(struct sys_device *dev)
+{
+	struct mpic *mpic =3D container_of(dev, struct mpic, sysdev);
+	int i;
+
+	for (i =3D 0; i < mpic->num_sources; i++) {
+		mpic_irq_write(i, MPIC_INFO(IRQ_VECTOR_PRI),
+			       mpic->save_data[i].vecprio);
+		mpic_irq_write(i, MPIC_INFO(IRQ_DESTINATION),
+			       mpic->save_data[i].dest);
+	}
+
+	return 0;
+}
+#endif
+
+static struct sysdev_class mpic_sysclass =3D {
+#ifdef CONFIG_PM
+	.resume =3D mpic_resume,
+	.suspend =3D mpic_suspend,
+#endif
+	set_kset_name("mpic"),
+};
+
+static int mpic_init_sys(void)
+{
+	struct mpic *mpic =3D mpics;
+	int error, id =3D 0;
+
+	error =3D sysdev_class_register(&mpic_sysclass);
+
+	while (mpic && !error) {
+		mpic->sysdev.cls =3D &mpic_sysclass;
+		mpic->sysdev.id =3D id++;
+		error =3D sysdev_register(&mpic->sysdev);
+		mpic =3D mpic->next;
+	}
+	return error;
+}
+
+device_initcall(mpic_init_sys);
--- mb-wireless.orig/include/asm-powerpc/mpic.h	2007-02-05 14:24:05.7845268=
64 +0100
+++ mb-wireless/include/asm-powerpc/mpic.h	2007-02-05 14:24:39.464526864 +0=
100
@@ -3,6 +3,7 @@
 #ifdef __KERNEL__
 =

 #include <linux/irq.h>
+#include <linux/sysdev.h>
 #include <asm/dcr.h>
 =

 /*
@@ -243,6 +244,11 @@ struct mpic_reg_bank {
 #endif /* CONFIG_PPC_DCR */
 };
 =

+struct mpic_irq_save {
+	u32		vecprio,
+			dest;
+};
+
 /* The instance data of a given MPIC */
 struct mpic
 {
@@ -302,6 +308,12 @@ struct mpic
 =

 	/* link */
 	struct mpic		*next;
+
+	struct sys_device	sysdev;
+
+#ifdef CONFIG_PM
+	struct mpic_irq_save	*save_data;
+#endif
 };
 =

 /*

--
