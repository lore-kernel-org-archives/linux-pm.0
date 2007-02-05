From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH 04/10] powermac: clean up PIC initialisation code
Date: Mon, 05 Feb 2007 19:30:31 +0100
Message-ID: <20070205185836.479588000@sipsolutions.net>
References: <20070205183026.989209000@sipsolutions.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline; filename=pic-cleanup.patch
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
Cc: Andrew Morton <akpm@osdl.org>, linux-pm@lists.osdl.org, Torrance <torrance123@gmail.com>
List-Id: linux-pm@vger.kernel.org

This patch cleans up the powermac PIC initialisation code so that for G5
powermacs we don't even compile the old pmac pic file.

Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
Cc: Andrew Morton <akpm@osdl.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>

---
Tested on powerbook and powermac, please apply to -mm.

--- mb-wireless.orig/arch/powerpc/platforms/powermac/Makefile	2007-02-05 14=
:24:06.054526864 +0100
+++ mb-wireless/arch/powerpc/platforms/powermac/Makefile	2007-02-05 14:24:3=
8.804526864 +0100
@@ -1,6 +1,6 @@
 CFLAGS_bootx_init.o  		+=3D -fPIC
 =

-obj-y				+=3D pic.o setup.o time.o feature.o pci.o \
+obj-y				+=3D setup.o time.o feature.o pci.o \
 				   sleep.o low_i2c.o cache.o pfunc_core.o \
 				   pfunc_base.o
 obj-$(CONFIG_PMAC_BACKLIGHT)	+=3D backlight.o
@@ -8,7 +8,7 @@ obj-$(CONFIG_CPU_FREQ_PMAC)	+=3D cpufreq_3
 obj-$(CONFIG_CPU_FREQ_PMAC64)	+=3D cpufreq_64.o
 obj-$(CONFIG_NVRAM)		+=3D nvram.o
 # ppc64 pmac doesn't define CONFIG_NVRAM but needs nvram stuff
-obj-$(CONFIG_PPC64)		+=3D nvram.o
-obj-$(CONFIG_PPC32)		+=3D bootx_init.o
+obj-$(CONFIG_PPC64)		+=3D nvram.o mpic.o
+obj-$(CONFIG_PPC32)		+=3D bootx_init.o pic.o mpic.o
 obj-$(CONFIG_SMP)		+=3D smp.o
 obj-$(CONFIG_PPC_MERGE)		+=3D udbg_scc.o udbg_adb.o
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ mb-wireless/arch/powerpc/platforms/powermac/mpic.c	2007-02-05 14:24:38.=
804526864 +0100
@@ -0,0 +1,143 @@
+/*
+ *  OpenPIC initialisation for PowerMacs.
+ *
+ *  Copyright (C) 1997 Paul Mackerras (paulus@samba.org)
+ *  Copyright (C) 2005 Benjamin Herrenschmidt (benh@kernel.crashing.org)
+ *                     IBM, Corp.
+ *
+ *  This program is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU General Public License
+ *  as published by the Free Software Foundation; either version
+ *  2 of the License, or (at your option) any later version.
+ *
+ */
+
+#include <asm/prom.h>
+#include <asm/pmac_feature.h>
+#include <asm/mpic.h>
+
+static void pmac_u3_cascade(unsigned int irq, struct irq_desc *desc)
+{
+	struct mpic *mpic =3D desc->handler_data;
+
+	unsigned int cascade_irq =3D mpic_get_one_irq(mpic);
+	if (cascade_irq !=3D NO_IRQ)
+		generic_handle_irq(cascade_irq);
+	desc->chip->eoi(irq);
+}
+
+static void __init pmac_pic_setup_mpic_nmi(struct mpic *mpic)
+{
+#if defined(CONFIG_XMON) && defined(CONFIG_PPC32)
+	struct device_node* pswitch;
+	int nmi_irq;
+
+	pswitch =3D of_find_node_by_name(NULL, "programmer-switch");
+	if (pswitch) {
+		nmi_irq =3D irq_of_parse_and_map(pswitch, 0);
+		if (nmi_irq !=3D NO_IRQ) {
+			mpic_irq_set_priority(nmi_irq, 9);
+			setup_irq(nmi_irq, &xmon_action);
+		}
+		of_node_put(pswitch);
+	}
+#endif	/* defined(CONFIG_XMON) && defined(CONFIG_PPC32) */
+}
+
+static struct mpic * __init pmac_setup_one_mpic(struct device_node *np,
+						int master)
+{
+	const char *name =3D master ? " MPIC 1   " : " MPIC 2   ";
+	struct resource r;
+	struct mpic *mpic;
+	unsigned int flags =3D master ? MPIC_PRIMARY : 0;
+	int rc;
+
+	rc =3D of_address_to_resource(np, 0, &r);
+	if (rc)
+		return NULL;
+
+	pmac_call_feature(PMAC_FTR_ENABLE_MPIC, np, 0, 0);
+
+	flags |=3D MPIC_WANTS_RESET;
+	if (get_property(np, "big-endian", NULL))
+		flags |=3D MPIC_BIG_ENDIAN;
+
+	/* Primary Big Endian means HT interrupts. This is quite dodgy
+	 * but works until I find a better way
+	 */
+	if (master && (flags & MPIC_BIG_ENDIAN))
+		flags |=3D MPIC_BROKEN_U3;
+
+	mpic =3D mpic_alloc(np, r.start, flags, 0, 0, name);
+	if (mpic =3D=3D NULL)
+		return NULL;
+
+	mpic_init(mpic);
+
+	return mpic;
+ }
+
+int __init pmac_pic_probe_mpic(void)
+{
+	struct mpic *mpic1, *mpic2;
+	struct device_node *np, *master =3D NULL, *slave =3D NULL;
+	unsigned int cascade;
+
+	/* We can have up to 2 MPICs cascaded */
+	for (np =3D NULL; (np =3D of_find_node_by_type(np, "open-pic"))
+		     !=3D NULL;) {
+		if (master =3D=3D NULL &&
+		    get_property(np, "interrupts", NULL) =3D=3D NULL)
+			master =3D of_node_get(np);
+		else if (slave =3D=3D NULL)
+			slave =3D of_node_get(np);
+		if (master && slave)
+			break;
+	}
+
+	/* Check for bogus setups */
+	if (master =3D=3D NULL && slave !=3D NULL) {
+		master =3D slave;
+		slave =3D NULL;
+	}
+
+	/* Not found, default to good old pmac pic */
+	if (master =3D=3D NULL)
+		return -ENODEV;
+
+	/* Set master handler */
+	ppc_md.get_irq =3D mpic_get_irq;
+
+	/* Setup master */
+	mpic1 =3D pmac_setup_one_mpic(master, 1);
+	BUG_ON(mpic1 =3D=3D NULL);
+
+	/* Install NMI if any */
+	pmac_pic_setup_mpic_nmi(mpic1);
+
+	of_node_put(master);
+
+	/* No slave, let's go out */
+	if (slave =3D=3D NULL)
+		return 0;
+
+	/* Get/Map slave interrupt */
+	cascade =3D irq_of_parse_and_map(slave, 0);
+	if (cascade =3D=3D NO_IRQ) {
+		printk(KERN_ERR "Failed to map cascade IRQ\n");
+		return 0;
+	}
+
+	mpic2 =3D pmac_setup_one_mpic(slave, 0);
+	if (mpic2 =3D=3D NULL) {
+		printk(KERN_ERR "Failed to setup slave MPIC\n");
+		of_node_put(slave);
+		return 0;
+	}
+	set_irq_data(cascade, mpic2);
+	set_irq_chained_handler(cascade, pmac_u3_cascade);
+
+	of_node_put(slave);
+	return 0;
+}
--- mb-wireless.orig/arch/powerpc/platforms/powermac/pic.c	2007-02-05 14:24=
:06.144526864 +0100
+++ mb-wireless/arch/powerpc/platforms/powermac/pic.c	2007-02-05 14:24:38.8=
04526864 +0100
@@ -15,25 +15,14 @@
  *
  */
 =

-#include <linux/stddef.h>
 #include <linux/init.h>
-#include <linux/sched.h>
-#include <linux/signal.h>
-#include <linux/pci.h>
-#include <linux/interrupt.h>
-#include <linux/sysdev.h>
 #include <linux/adb.h>
 #include <linux/pmu.h>
-#include <linux/module.h>
 =

-#include <asm/sections.h>
-#include <asm/io.h>
 #include <asm/smp.h>
 #include <asm/prom.h>
-#include <asm/pci-bridge.h>
 #include <asm/time.h>
 #include <asm/pmac_feature.h>
-#include <asm/mpic.h>
 =

 #include "pmac.h"
 =

@@ -44,7 +33,6 @@
  */
 extern irqreturn_t xmon_irq(int, void *);
 =

-#ifdef CONFIG_PPC32
 struct pmac_irq_hw {
         unsigned int    event;
         unsigned int    enable;
@@ -438,134 +426,6 @@ static void __init pmac_pic_probe_oldsty
 	setup_irq(irq_create_mapping(NULL, 20), &xmon_action);
 #endif
 }
-#endif /* CONFIG_PPC32 */
-
-static void pmac_u3_cascade(unsigned int irq, struct irq_desc *desc)
-{
-	struct mpic *mpic =3D desc->handler_data;
-
-	unsigned int cascade_irq =3D mpic_get_one_irq(mpic);
-	if (cascade_irq !=3D NO_IRQ)
-		generic_handle_irq(cascade_irq);
-	desc->chip->eoi(irq);
-}
-
-static void __init pmac_pic_setup_mpic_nmi(struct mpic *mpic)
-{
-#if defined(CONFIG_XMON) && defined(CONFIG_PPC32)
-	struct device_node* pswitch;
-	int nmi_irq;
-
-	pswitch =3D of_find_node_by_name(NULL, "programmer-switch");
-	if (pswitch) {
-		nmi_irq =3D irq_of_parse_and_map(pswitch, 0);
-		if (nmi_irq !=3D NO_IRQ) {
-			mpic_irq_set_priority(nmi_irq, 9);
-			setup_irq(nmi_irq, &xmon_action);
-		}
-		of_node_put(pswitch);
-	}
-#endif	/* defined(CONFIG_XMON) && defined(CONFIG_PPC32) */
-}
-
-static struct mpic * __init pmac_setup_one_mpic(struct device_node *np,
-						int master)
-{
-	const char *name =3D master ? " MPIC 1   " : " MPIC 2   ";
-	struct resource r;
-	struct mpic *mpic;
-	unsigned int flags =3D master ? MPIC_PRIMARY : 0;
-	int rc;
-
-	rc =3D of_address_to_resource(np, 0, &r);
-	if (rc)
-		return NULL;
-
-	pmac_call_feature(PMAC_FTR_ENABLE_MPIC, np, 0, 0);
-
-	flags |=3D MPIC_WANTS_RESET;
-	if (get_property(np, "big-endian", NULL))
-		flags |=3D MPIC_BIG_ENDIAN;
-
-	/* Primary Big Endian means HT interrupts. This is quite dodgy
-	 * but works until I find a better way
-	 */
-	if (master && (flags & MPIC_BIG_ENDIAN))
-		flags |=3D MPIC_BROKEN_U3;
-
-	mpic =3D mpic_alloc(np, r.start, flags, 0, 0, name);
-	if (mpic =3D=3D NULL)
-		return NULL;
-
-	mpic_init(mpic);
-
-	return mpic;
- }
-
-static int __init pmac_pic_probe_mpic(void)
-{
-	struct mpic *mpic1, *mpic2;
-	struct device_node *np, *master =3D NULL, *slave =3D NULL;
-	unsigned int cascade;
-
-	/* We can have up to 2 MPICs cascaded */
-	for (np =3D NULL; (np =3D of_find_node_by_type(np, "open-pic"))
-		     !=3D NULL;) {
-		if (master =3D=3D NULL &&
-		    get_property(np, "interrupts", NULL) =3D=3D NULL)
-			master =3D of_node_get(np);
-		else if (slave =3D=3D NULL)
-			slave =3D of_node_get(np);
-		if (master && slave)
-			break;
-	}
-
-	/* Check for bogus setups */
-	if (master =3D=3D NULL && slave !=3D NULL) {
-		master =3D slave;
-		slave =3D NULL;
-	}
-
-	/* Not found, default to good old pmac pic */
-	if (master =3D=3D NULL)
-		return -ENODEV;
-
-	/* Set master handler */
-	ppc_md.get_irq =3D mpic_get_irq;
-
-	/* Setup master */
-	mpic1 =3D pmac_setup_one_mpic(master, 1);
-	BUG_ON(mpic1 =3D=3D NULL);
-
-	/* Install NMI if any */
-	pmac_pic_setup_mpic_nmi(mpic1);
-
-	of_node_put(master);
-
-	/* No slave, let's go out */
-	if (slave =3D=3D NULL)
-		return 0;
-
-	/* Get/Map slave interrupt */
-	cascade =3D irq_of_parse_and_map(slave, 0);
-	if (cascade =3D=3D NO_IRQ) {
-		printk(KERN_ERR "Failed to map cascade IRQ\n");
-		return 0;
-	}
-
-	mpic2 =3D pmac_setup_one_mpic(slave, 0);
-	if (mpic2 =3D=3D NULL) {
-		printk(KERN_ERR "Failed to setup slave MPIC\n");
-		of_node_put(slave);
-		return 0;
-	}
-	set_irq_data(cascade, mpic2);
-	set_irq_chained_handler(cascade, pmac_u3_cascade);
-
-	of_node_put(slave);
-	return 0;
-}
-
 =

 void __init pmac_pic_init(void)
 {
@@ -574,27 +434,17 @@ void __init pmac_pic_init(void)
 	/* We configure the OF parsing based on our oldworld vs. newworld
 	 * platform type and wether we were booted by BootX.
 	 */
-#ifdef CONFIG_PPC32
 	if (!pmac_newworld)
 		flags |=3D OF_IMAP_OLDWORLD_MAC;
 	if (get_property(of_chosen, "linux,bootx", NULL) !=3D NULL)
 		flags |=3D OF_IMAP_NO_PHANDLE;
-#endif /* CONFIG_PPC_32 */
 =

 	of_irq_map_init(flags);
 =

-	/* We first try to detect Apple's new Core99 chipset, since mac-io
-	 * is quite different on those machines and contains an IBM MPIC2.
-	 */
-	if (pmac_pic_probe_mpic() =3D=3D 0)
-		return;
-
-#ifdef CONFIG_PPC32
 	pmac_pic_probe_oldstyle();
-#endif
 }
 =

-#if defined(CONFIG_PM) && defined(CONFIG_PPC32)
+#ifdef CONFIG_PM
 /*
  * These procedures are used in implementing sleep on the powerbooks.
  * sleep_save_intrs() saves the states of all interrupt enables
@@ -662,7 +512,7 @@ static int pmacpic_resume(struct sys_dev
 	return 0;
 }
 =

-#endif /* CONFIG_PM && CONFIG_PPC32 */
+#endif /* CONFIG_PM */
 =

 static struct sysdev_class pmacpic_sysclass =3D {
 	set_kset_name("pmac_pic"),
@@ -674,18 +524,17 @@ static struct sys_device device_pmacpic =

 };
 =

 static struct sysdev_driver driver_pmacpic =3D {
-#if defined(CONFIG_PM) && defined(CONFIG_PPC32)
+#ifdef CONFIG_PM
 	.suspend	=3D &pmacpic_suspend,
 	.resume		=3D &pmacpic_resume,
-#endif /* CONFIG_PM && CONFIG_PPC32 */
+#endif /* CONFIG_PM */
 };
 =

 static int __init init_pmacpic_sysfs(void)
 {
-#ifdef CONFIG_PPC32
 	if (max_irqs =3D=3D 0)
 		return -ENODEV;
-#endif
+
 	printk(KERN_DEBUG "Registering pmac pic with sysfs...\n");
 	sysdev_class_register(&pmacpic_sysclass);
 	sysdev_register(&device_pmacpic);
--- mb-wireless.orig/arch/powerpc/platforms/powermac/pmac.h	2007-02-05 14:2=
4:06.164526864 +0100
+++ mb-wireless/arch/powerpc/platforms/powermac/pmac.h	2007-02-05 14:24:38.=
804526864 +0100
@@ -44,6 +44,9 @@ extern void pmac_ide_init_hwif_ports(hw_
 	unsigned long data_port, unsigned long ctrl_port, int *irq);
 =

 extern int pmac_nvram_init(void);
+#ifdef CONFIG_PPC32
 extern void pmac_pic_init(void);
+#endif
+extern int pmac_pic_probe_mpic(void);
 =

 #endif /* __PMAC_H__ */
--- mb-wireless.orig/arch/powerpc/platforms/powermac/setup.c	2007-02-05 14:=
24:06.194526864 +0100
+++ mb-wireless/arch/powerpc/platforms/powermac/setup.c	2007-02-05 14:24:38=
.814526864 +0100
@@ -718,13 +718,28 @@ static int pmac_pci_probe_mode(struct pc
 }
 #endif
 =

+static void __init pmac_init_irq(void)
+{
+	int ret;
+
+	/* We first try to detect Apple's new Core99 chipset, since mac-io
+	 * is quite different on those machines and contains an IBM MPIC2.
+	 */
+	ret =3D pmac_pic_probe_mpic();
+
+#ifdef CONFIG_PPC32
+	if (ret !=3D 0)
+		pmac_pic_init();
+#endif
+}
+
 define_machine(powermac) {
 	.name			=3D "PowerMac",
 	.probe			=3D pmac_probe,
 	.setup_arch		=3D pmac_setup_arch,
 	.init_early		=3D pmac_init_early,
 	.show_cpuinfo		=3D pmac_show_cpuinfo,
-	.init_IRQ		=3D pmac_pic_init,
+	.init_IRQ		=3D pmac_init_irq,
 	.get_irq		=3D NULL,	/* changed later */
 	.pci_irq_fixup		=3D pmac_pci_irq_fixup,
 	.restart		=3D pmac_restart,

--
